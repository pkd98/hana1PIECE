package com.hana1piece.trading.service;

import com.hana1piece.trading.model.mapper.ExecutionMapper;
import com.hana1piece.trading.model.mapper.OrderBookMapper;
import com.hana1piece.trading.model.mapper.StoOrdersMapper;
import com.hana1piece.trading.model.vo.ExecutionVO;
import com.hana1piece.trading.model.vo.OrderBookVO;
import com.hana1piece.trading.model.vo.StoOrdersVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;

@Service
@Transactional
public class OrderMatchingServiceImpl implements OrderMatchingService {

    private final OrderBookMapper orderBookMapper;
    private final ExecutionMapper executionMapper;
    private final StoOrdersMapper stoOrdersMapper;

    @Autowired
    public OrderMatchingServiceImpl(OrderBookMapper orderBookMapper, ExecutionMapper executionMapper, StoOrdersMapper stoOrdersMapper) {
        this.orderBookMapper = orderBookMapper;
        this.executionMapper = executionMapper;
        this.stoOrdersMapper = stoOrdersMapper;
    }

    @Override
    public void processOrder(StoOrdersVO order) {
        // 주문 유형 확인
        if (order.getOrderType().equals("BUY")) {
            matchBuyOrder(order);
        } else {
            matchSellOrder(order);
        }
    }

    /**
     * [매수 주문 체결 로직]
     * 1. 주문 등록
     * 2. 매칭 가능한 매도 호가 조회 : 매도 가격이 가장 낮은 순서부터 조회
     * 3. 해당 호가의 매도 주문을 조회 : 오래된 순서대로 체결
     * 4. 체결된 경우 체결 테이블 등록
     * 5. 체결된 매수/매도 주문 상태 및 체결 수량 업데이트
     * 6. 호가창에 수량 반영
     *
     * -> 미체결 매수 주문의 경우, 미체결 수량만큼 호가창 반영
     */
    private void matchBuyOrder(StoOrdersVO order) {
        // 1. 주문 등록
        stoOrdersMapper.insertOrder(order);
        int orderId = stoOrdersMapper.getOrderSeqCrrval();
        order.setOrderId(orderId);

        // 2. 체결 가능한 매도 호가 조회 [가격 순으로 오름차순 정렬된 데이터]
        List<OrderBookVO> sellOrders = orderBookMapper.findSellOrderBookListByLN(order.getListingNumber());
        Collections.reverse(sellOrders);

        for (OrderBookVO sellOrder : sellOrders) {
            // 체결 가능한 매도 호가
            if (sellOrder.getPrice() <= order.getAmount()) {

                // 3. 해당 호가의 모든 매도 주문을 조회 [오래된 주문 순서대로 체결]
                List<StoOrdersVO> sellOrderDetails = stoOrdersMapper.findSellOrderDetailByAmountAndLN(sellOrder.getPrice(), order.getListingNumber());

                for (StoOrdersVO sellOrderDetail : sellOrderDetails) {
                    // 체결 수량
                    int executedQuantity = Math.min(order.getQuantity() - order.getExecutedQuantity(), sellOrderDetail.getQuantity() - sellOrderDetail.getExecutedQuantity());

                    // 체결 가능한 경우
                    if (executedQuantity > 0) {
                        // 4. 체결 정보 생성 및 등록
                        ExecutionVO execution = new ExecutionVO();
                        execution.setBuyOrderId(order.getOrderId());
                        execution.setSellOrderId(sellOrderDetail.getOrderId());
                        execution.setExecutedPrice(sellOrder.getPrice());
                        execution.setExecutedQuantity(executedQuantity);
                        executionMapper.insertExecution(execution);

                        // 5. 체결된 주문(매수) 및 매칭된 주문(매도) 업데이트
                        // 주문 체결 평균 가격 계산
                        int orderExecutedPriceAvg = (executedQuantity * sellOrder.getPrice() + order.getExecutedPriceAvg() * order.getExecutedQuantity()) / (executedQuantity + order.getExecutedQuantity());
                        order.setExecutedPriceAvg(orderExecutedPriceAvg);
                        order.setExecutedQuantity(order.getExecutedQuantity() + executedQuantity);
                        updateOrderStatus(order);
                        stoOrdersMapper.updateOrder(order);

                        // 매칭된 주문 평균 가격 계산
                        int sellOrderDetailExecutedPriceAvg = (executedQuantity * sellOrder.getPrice() + sellOrderDetail.getExecutedPriceAvg() * sellOrderDetail.getExecutedQuantity()) / (sellOrderDetail.getExecutedQuantity() + executedQuantity);
                        sellOrderDetail.setExecutedPriceAvg(sellOrderDetailExecutedPriceAvg);
                        sellOrderDetail.setExecutedQuantity(sellOrderDetail.getExecutedQuantity() + executedQuantity);
                        updateOrderStatus(sellOrderDetail);
                        stoOrdersMapper.updateOrder(sellOrderDetail); // 매도 주문도 업데이트

                        // 6. 호가창 업데이트 반영
                        sellOrder.setAmount(-executedQuantity);
                        orderBookMapper.updateAmount(sellOrder);

                        // 모든 주문이 체결되면 종료
                        if (order.getQuantity() <= order.getExecutedQuantity()) {
                            break;
                        }
                    }
                }
            }
        }

        // [미체결된 주문 처리]
        // 체결되지 않은 수량 계산
        int unexecutedQuantity = order.getQuantity() - order.getExecutedQuantity();

        // 미체결 주문에 대한 매수 호가 수량 업데이트
        if (unexecutedQuantity > 0) {
            OrderBookVO existingBuyOrder = orderBookMapper.findOrderBookByLNAndPriceAndType(order.getListingNumber(), order.getAmount(), "BUY");

            if (existingBuyOrder != null) {
                // 이미 해당 가격의 매수 호가가 존재하면 수량 업데이트
                existingBuyOrder.setAmount(unexecutedQuantity);
                orderBookMapper.updateAmount(existingBuyOrder);
            } else {
                // 해당 가격의 매수 호가가 존재하지 않으면 새로운 호가 추가
                OrderBookVO orderBookVO = new OrderBookVO();
                orderBookVO.setListingNumber(order.getListingNumber());
                orderBookVO.setType("BUY");
                orderBookVO.setPrice(order.getAmount());
                orderBookVO.setAmount(unexecutedQuantity);

                orderBookMapper.insertOrderBook(orderBookVO);
            }
        }
    }

    /**
     * [매도 주문 체결 로직]
     * 1. 주문 등록
     * 2. 매칭 가능한 매수 호가 조회 : 매수 가격이 가장 낮은 순서부터 조회
     * 3. 해당 호가의 매수 주문을 조회 : 오래된 순서대로 체결
     * 4. 체결된 경우 체결 테이블 등록
     * 5. 체결된 매수/매도 주문 상태 및 체결 수량 업데이트
     * 6. 호가창에 수량 반영
     *
     * -> 미체결 매수 주문의 경우, 미체결 수량만큼 호가창 반영
     */
    private void matchSellOrder(StoOrdersVO order) {
        // 1. 주문 등록
        stoOrdersMapper.insertOrder(order);
        int orderId = stoOrdersMapper.getOrderSeqCrrval();
        order.setOrderId(orderId);

        // 2. 체결 가능한 매수 호가 조회 [가격 순으로 내림차순 정렬된 데이터]
        List<OrderBookVO> buyOrders = orderBookMapper.findBuyOrderBookListByLN(order.getListingNumber());

        for (OrderBookVO buyOrder : buyOrders) {
            // 체결 가능한 매수 호가
            if (buyOrder.getPrice() >= order.getAmount()) {

                // 3. 해당 호가의 모든 매수 주문을 조회 [오래된 주문 순서대로 체결]
                List<StoOrdersVO> buyOrderDetails = stoOrdersMapper.findBuyOrderDetailByAmountAndLN(buyOrder.getPrice(), order.getListingNumber());

                for (StoOrdersVO buyOrderDetail : buyOrderDetails) {
                    // 체결 수량
                    int executedQuantity = Math.min(order.getQuantity() - order.getExecutedQuantity(), buyOrderDetail.getQuantity() - buyOrderDetail.getExecutedQuantity());

                    System.out.println(executedQuantity);
                    // 체결 가능한 경우
                    if (executedQuantity > 0) {
                        // 4. 체결 정보 생성 및 등록
                        ExecutionVO execution = new ExecutionVO();
                        execution.setSellOrderId(order.getOrderId());
                        execution.setBuyOrderId(buyOrderDetail.getOrderId());
                        execution.setExecutedPrice(buyOrder.getPrice());
                        execution.setExecutedQuantity(executedQuantity);
                        executionMapper.insertExecution(execution);

                        // 5. 체결된 주문(매도) 및 매칭된 주문(매수) 업데이트
                        // 주문 체결 평균 가격 계산
                        int orderExecutedPriceAvg = (executedQuantity * buyOrder.getPrice() + order.getExecutedPriceAvg() * order.getExecutedQuantity()) / (executedQuantity + order.getExecutedQuantity());
                        order.setExecutedPriceAvg(orderExecutedPriceAvg);
                        order.setExecutedQuantity(order.getExecutedQuantity() + executedQuantity);
                        updateOrderStatus(order);
                        stoOrdersMapper.updateOrder(order);

                        // 매칭된 주문 평균 가격 계산
                        int sellOrderDetailExecutedPriceAvg = (executedQuantity * buyOrder.getPrice() + buyOrderDetail.getExecutedPriceAvg() * buyOrderDetail.getExecutedQuantity()) / (buyOrderDetail.getExecutedQuantity() + executedQuantity);
                        buyOrderDetail.setExecutedPriceAvg(sellOrderDetailExecutedPriceAvg);
                        buyOrderDetail.setExecutedQuantity(buyOrderDetail.getExecutedQuantity() + executedQuantity);
                        updateOrderStatus(buyOrderDetail);
                        stoOrdersMapper.updateOrder(buyOrderDetail); // 매수 주문도 업데이트

                        // 6. 호가창 업데이트 반영
                        buyOrder.setAmount(-executedQuantity);
                        orderBookMapper.updateAmount(buyOrder);

                        // 모든 주문이 체결되면 종료
                        if (order.getQuantity() <= order.getExecutedQuantity()) {
                            break;
                        }
                    }
                }
            }
        }

        // [미체결된 주문 처리]
        // 체결되지 않은 수량 계산
        int unexecutedQuantity = order.getQuantity() - order.getExecutedQuantity();

        // 미체결 주문에 대한 매도 호가 수량 업데이트
        if (unexecutedQuantity > 0) {
            OrderBookVO existingSellOrder = orderBookMapper.findOrderBookByLNAndPriceAndType(order.getListingNumber(), order.getAmount(), "SELL");

            if (existingSellOrder != null) {
                // 이미 해당 가격의 매수 호가가 존재하면 수량 업데이트
                existingSellOrder.setAmount(unexecutedQuantity);
                orderBookMapper.updateAmount(existingSellOrder);
            } else {
                // 해당 가격의 매수 호가가 존재하지 않으면 새로운 호가 추가
                OrderBookVO orderBookVO = new OrderBookVO();
                orderBookVO.setListingNumber(order.getListingNumber());
                orderBookVO.setType("SELL");
                orderBookVO.setPrice(order.getAmount());
                orderBookVO.setAmount(unexecutedQuantity);
                orderBookMapper.insertOrderBook(orderBookVO);
            }
        }
    }


    /**
     * 주문 상태 업데이트 메서드
     */
    private void updateOrderStatus(StoOrdersVO order) {
        int unexecutedQuantity = order.getQuantity() - order.getExecutedQuantity();
        if (unexecutedQuantity == 0) {
            order.setStatus("C");
        } else if (unexecutedQuantity == order.getQuantity()) {
            order.setStatus("N");
        } else {
            order.setStatus("P");
        }
    }

}

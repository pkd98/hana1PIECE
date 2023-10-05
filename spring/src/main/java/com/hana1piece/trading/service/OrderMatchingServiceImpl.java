package com.hana1piece.trading.service;

import com.hana1piece.estate.model.mapper.EstateMapper;
import com.hana1piece.estate.model.vo.RealEstateSaleVO;
import com.hana1piece.trading.model.mapper.ExecutionMapper;
import com.hana1piece.trading.model.mapper.OrderBookMapper;
import com.hana1piece.trading.model.mapper.StoOrdersMapper;
import com.hana1piece.trading.model.vo.ExecutionVO;
import com.hana1piece.trading.model.vo.OrderBookVO;
import com.hana1piece.trading.model.vo.StoOrdersVO;
import com.hana1piece.wallet.model.vo.StosVO;
import com.hana1piece.wallet.model.vo.WalletTransactionVO;
import com.hana1piece.wallet.model.vo.WalletVO;
import com.hana1piece.wallet.service.StosService;
import com.hana1piece.wallet.service.WalletService;
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
    private final StosService stosService;
    private final WalletService walletService;
    private final EstateMapper estateMapper;

    @Autowired
    public OrderMatchingServiceImpl(OrderBookMapper orderBookMapper, ExecutionMapper executionMapper, StoOrdersMapper stoOrdersMapper, StosService stosService, WalletService walletService, EstateMapper estateMapper) {
        this.orderBookMapper = orderBookMapper;
        this.executionMapper = executionMapper;
        this.stoOrdersMapper = stoOrdersMapper;
        this.stosService = stosService;
        this.walletService = walletService;
        this.estateMapper = estateMapper;
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
     * <p>
     * [바로 체결된 경우]
     * - (1) 체결 테이블 등록,
     * - (2) 매수자 금액 차감 및 토큰 지급,
     * - (3) 매도자 금액 지급
     * - (4) 체결된 매수/매도 주문 상태 및 체결 수량 업데이트
     * - (5) 호가창에 수량 반영
     * - (6) 토큰 가격 시세 반영
     * <p>
     * [미체결 매수 주문]
     * - (1) 미체결 예수금 차감
     * - (2) 미체결 수량만큼 호가창 반영
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

                        // 매수자 금액 차감
                        WalletVO walletVO = walletService.findWalletByWN(order.getWalletNumber());
                        walletVO.setBalance(walletVO.getBalance() - (sellOrder.getPrice() * executedQuantity));
                        WalletTransactionVO walletTransactionVO = new WalletTransactionVO();
                        walletTransactionVO.setWalletNumber(walletVO.getWalletNumber());
                        walletTransactionVO.setClassification("OUT");
                        walletTransactionVO.setName(order.getListingNumber() + " 구매");
                        walletTransactionVO.setAmount(-(sellOrder.getPrice() * executedQuantity));
                        walletTransactionVO.setBalance(walletVO.getBalance() - (sellOrder.getPrice() * executedQuantity));
                        walletService.updateWalletBalance(walletVO, walletTransactionVO);

                        System.out.println(walletTransactionVO);
                        System.out.println(walletVO);

                        // 매수자 토큰 지급
                        StosVO stos = stosService.findStosByWalletNumberAndListingNumber(order.getWalletNumber(), order.getListingNumber());

                        if (stos != null) {
                            stos.setAmount(stos.getAmount() + executedQuantity);
                            stosService.updateAmount(stos);
                        } else {
                            StosVO newStos = new StosVO();
                            newStos.setListingNumber(order.getListingNumber());
                            newStos.setWalletNumber(order.getWalletNumber());
                            newStos.setAmount(executedQuantity);
                            stosService.insertStos(newStos);
                        }

                        // 매도자 금액 지급
                        WalletVO sellerWallet = walletService.findWalletByWN(sellOrderDetail.getWalletNumber());
                        sellerWallet.setBalance(sellerWallet.getBalance() + (sellOrder.getPrice() * executedQuantity));
                        WalletTransactionVO sellerWalletTransactionVO = new WalletTransactionVO();
                        sellerWalletTransactionVO.setWalletNumber(sellerWallet.getWalletNumber());
                        sellerWalletTransactionVO.setClassification("IN");
                        sellerWalletTransactionVO.setName(order.getListingNumber() + " 판매");
                        sellerWalletTransactionVO.setAmount(sellOrder.getPrice() * executedQuantity);
                        sellerWalletTransactionVO.setBalance(sellerWallet.getBalance() + (sellOrder.getPrice() * executedQuantity));
                        walletService.updateWalletBalance(sellerWallet, sellerWalletTransactionVO);

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

                        // Real Estate Sale 가격 반영
                        RealEstateSaleVO estate = estateMapper.findRealEstateSaleByLN(order.getListingNumber());
                        estate.setPrice(sellOrder.getPrice());
                        estateMapper.updateRealEstateSale(estate);

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

        if (unexecutedQuantity > 0) {
            // 미체결 예수금 차감
            WalletVO walletVO = walletService.findWalletByWN(order.getWalletNumber());
            walletVO.setBalance(walletVO.getBalance() - (order.getAmount() * unexecutedQuantity));
            WalletTransactionVO walletTransactionVO = new WalletTransactionVO();
            walletTransactionVO.setWalletNumber(walletVO.getWalletNumber());
            walletTransactionVO.setClassification("OUT");
            walletTransactionVO.setName(order.getListingNumber() + " 구매");
            walletTransactionVO.setAmount(-(order.getAmount() * unexecutedQuantity));
            walletTransactionVO.setBalance(walletVO.getBalance() - (order.getAmount() * unexecutedQuantity));
            walletService.updateWalletBalance(walletVO, walletTransactionVO);

            // 미체결 주문에 대한 매수 호가 수량 업데이트
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
     * <p>
     * [바로 체결된 경우]
     * - (1) 체결 테이블 등록,
     * - (2) 매도자 금액 지급 및 토큰 차감,
     * - (3) 매수자 금액 지급
     * - (4) 체결된 매수/매도 주문 상태 및 체결 수량 업데이트
     * - (5) 호가창에 수량 반영
     * <p>
     * [미체결 매수 주문]
     * - (1) 미체결 토큰 차감
     * - (2) 미체결 수량만큼 호가창 반영
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

                        // 매도자 토큰 차감
                        StosVO stos = stosService.findStosByWalletNumberAndListingNumber(order.getWalletNumber(), order.getListingNumber());
                        System.out.println(stos.toString());
                        stos.setAmount(stos.getAmount() - executedQuantity);
                        System.out.println(stos.toString());
                        stosService.updateAmount(stos);

                        // 매도자 금액 지급
                        WalletVO sellerWallet = walletService.findWalletByWN(order.getWalletNumber());
                        sellerWallet.setBalance(sellerWallet.getBalance() + (buyOrder.getPrice() * executedQuantity));
                        WalletTransactionVO sellerWalletTransactionVO = new WalletTransactionVO();
                        sellerWalletTransactionVO.setWalletNumber(sellerWallet.getWalletNumber());
                        sellerWalletTransactionVO.setClassification("IN");
                        sellerWalletTransactionVO.setName(order.getListingNumber() + " 판매");
                        sellerWalletTransactionVO.setAmount(buyOrder.getPrice() * executedQuantity);
                        sellerWalletTransactionVO.setBalance(sellerWallet.getBalance() + (buyOrder.getPrice() * executedQuantity));
                        walletService.updateWalletBalance(sellerWallet, sellerWalletTransactionVO);

                        // 매수자 토큰 지급
                        StosVO buyerStos = stosService.findStosByWalletNumberAndListingNumber(order.getWalletNumber(), order.getListingNumber());

                        if (buyerStos != null) {
                            buyerStos.setAmount(buyerStos.getAmount() + executedQuantity);
                            stosService.updateAmount(buyerStos);
                        } else {
                            StosVO newStos = new StosVO();
                            newStos.setListingNumber(buyOrderDetail.getListingNumber());
                            newStos.setWalletNumber(buyOrderDetail.getWalletNumber());
                            newStos.setAmount(executedQuantity);
                            stosService.insertStos(newStos);
                        }

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

                        // Real Estate Sale 가격 반영
                        RealEstateSaleVO estate = estateMapper.findRealEstateSaleByLN(order.getListingNumber());
                        estate.setPrice(buyOrder.getPrice());
                        estateMapper.updateRealEstateSale(estate);

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

        // 미체결 주문
        if (unexecutedQuantity > 0) {
            // 매도자 미체결량 토큰 차감
            StosVO stos = stosService.findStosByWalletNumberAndListingNumber(order.getWalletNumber(), order.getListingNumber());
            stos.setAmount(stos.getAmount() - unexecutedQuantity);
            stosService.updateAmount(stos);

            // 미체결량 매도 호가 수량 업데이트
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

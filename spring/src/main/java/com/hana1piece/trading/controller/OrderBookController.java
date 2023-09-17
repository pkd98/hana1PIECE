package com.hana1piece.trading.controller;

import com.hana1piece.trading.model.dto.OrderBookWrapperDTO;
import com.hana1piece.trading.model.vo.OrderBookVO;
import com.hana1piece.trading.service.OrderBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
public class OrderBookController {

    private final OrderBookService orderBookService;
    private final SimpMessagingTemplate messagingTemplate;
    private Map<String, Integer> userLNMap;

    @Autowired
    public OrderBookController(OrderBookService orderBookService, SimpMessagingTemplate messagingTemplate) {
        this.orderBookService = orderBookService;
        this.messagingTemplate = messagingTemplate;
        this.userLNMap = new ConcurrentHashMap<>();
    }

    /**
     * 웹소켓 요청을 받아 Listing Number 값을 저장
     */
    @MessageMapping("/orderBook/{LN}")
    public void startSendingOrderBook(@DestinationVariable int LN, SimpMessageHeaderAccessor headerAccessor) {
        String sessionId = headerAccessor.getSessionId();
        userLNMap.put(sessionId, LN);
    }

    /**
     * 1초에 한번씩 웹소켓 연결된 클라이언트에 해당 호가 데이터 전송
     */
    @Scheduled(fixedRate = 1000)
    public void sendOrderBookUpdates() {
        for (Map.Entry<String, Integer> entry : userLNMap.entrySet()) {
            List<OrderBookVO> sellOrderBooks = orderBookService.findSellOrderBookListByLN(entry.getValue());
            List<OrderBookVO> buyOrderBooks = orderBookService.findBuyOrderBookListByLN(entry.getValue());

            OrderBookWrapperDTO orderBookWrapper = new OrderBookWrapperDTO();
            orderBookWrapper.setSellOrderBooks(sellOrderBooks);
            orderBookWrapper.setBuyOrderBooks(buyOrderBooks);
            messagingTemplate.convertAndSend("/topic/orderBook/" + entry.getValue(), orderBookWrapper);
        }
    }

    /**
     * 연결이 끊어진 사용자 Listing Number 값 제거
     */
    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        String sessionId = event.getSessionId();
        userLNMap.remove(sessionId);
    }

}

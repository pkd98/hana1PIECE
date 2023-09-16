package com.hana1piece;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

/**
 *  웹소켓 활성화 및 STOMP 메시지 사용 설정
 */
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketBrokerConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry){
        // 스프링이 제공하는 내장 브로커 사용
        // "/prefix" 붙은 메시지 송신되었을 때 그 메시지를 브로커가 구독자들에게 전달함.
        registry.enableSimpleBroker("/topic");

        // 메시지 가공 처리가 필요할 때 핸들러로 라우팅되도록 설정
        // "/app"이 붙어있는 경로로 발신되면 해당 경로를 처리하는 핸들러로 전달
        registry.setApplicationDestinationPrefixes("/app");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry){
        registry.addEndpoint("/gs-guide-websocket").withSockJS();;
    }
}

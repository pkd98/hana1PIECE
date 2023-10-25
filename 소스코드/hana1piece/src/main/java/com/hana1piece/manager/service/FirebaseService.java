package com.hana1piece.manager.service;

import com.hana1piece.manager.model.dto.AppNotificationDTO;
import com.hana1piece.manager.model.dto.PushNotificationDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class FirebaseService {

    private final String FIREBASE_API_URL = "https://fcm.googleapis.com/fcm/send";

    @Value("${fcm.server.key}")
    private String SERVER_KEY;

    private final RestTemplate restTemplate;

    @Autowired
    public FirebaseService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    /**
     * FCM을 통해 알림 메시지를 전송합니다.
     *
     * @param appNotificationDTO 전송할 알림의 제목과 본문을 포함하는 객체
     */
    public void transmitPushAppNotification(AppNotificationDTO appNotificationDTO) {

        // HTTP 요청 헤더를 설정합니다.
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "key=" + SERVER_KEY);
        headers.set("Content-Type", "application/json");

        // 푸시 알림 데이터를 설정합니다.
        PushNotificationDTO pushNotification = new PushNotificationDTO();
        pushNotification.setNotification(appNotificationDTO);
        pushNotification.setTo("/topics/all");

        // HTTP 요청 엔터티를 생성합니다.
        HttpEntity<PushNotificationDTO> entity = new HttpEntity<>(pushNotification, headers);

        // FCM에 푸시 알림 요청을 보냅니다.
        ResponseEntity<String> response = restTemplate.exchange(
                FIREBASE_API_URL,
                HttpMethod.POST,
                entity,
                String.class
        );

        // 요청 본문을 출력합니다.
        System.out.println(pushNotification);
    }
}

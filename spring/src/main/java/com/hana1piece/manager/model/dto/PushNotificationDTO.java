package com.hana1piece.manager.model.dto;

import com.google.firebase.messaging.Notification;
import lombok.Data;


@Data
public class PushNotificationDTO {
    private AppNotificationDTO notification;
    private String to;
}

package com.hana1piece.announcement.model.vo;

import lombok.Data;

@Data
public class AnnouncementVO {
    private int id;
    private String title;
    private String content;
    private String writeDate;
    private int count;
}
package com.hana1piece.announcement.service;

import com.hana1piece.announcement.model.vo.AnnouncementVO;

import java.util.List;

public interface AnnouncementService {

    List<AnnouncementVO> findAll();
    List<AnnouncementVO> findByPageNo(int pageNo);

    int getTotalAnnouncement();

    AnnouncementVO viewDetailAnnouncement(int id);

    void writeAnnouncement(AnnouncementVO announcementVO);

    void deleteAnnouncementById(int id);

    void updateAnnouncement(AnnouncementVO announcementVO);

}

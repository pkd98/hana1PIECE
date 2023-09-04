package com.hana1piece.announcement.model.mapper;

import com.hana1piece.announcement.model.vo.AnnouncementVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AnnouncementMapper {
    List<AnnouncementVO> findAll();

    List<AnnouncementVO> findByPageNo(int pageNo);

    int getTotalAnnouncement();

    AnnouncementVO findById(int id);

    void insertAnnouncement(AnnouncementVO announcementVO);

    void deleteById(int id);

    void updateAnnouncement(AnnouncementVO announcementVO);

    void increaseAnnouncementCountById(int id);
}

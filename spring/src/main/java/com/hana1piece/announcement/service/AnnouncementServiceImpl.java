package com.hana1piece.announcement.service;

import com.hana1piece.announcement.model.mapper.AnnouncementMapper;
import com.hana1piece.announcement.model.vo.AnnouncementVO;
import com.hana1piece.logger.service.LoggerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AnnouncementServiceImpl implements AnnouncementService {

    private final AnnouncementMapper announcementMapper;
    private final LoggerService loggerService;

    @Autowired
    public AnnouncementServiceImpl(AnnouncementMapper announcementMapper, LoggerService loggerService) {
        this.announcementMapper = announcementMapper;
        this.loggerService = loggerService;
    }

    @Override
    public List<AnnouncementVO> findAll() {
        return announcementMapper.findAll();
    }

    @Override
    public List<AnnouncementVO> findByPageNo(int pageNo) {
        return announcementMapper.findByPageNo(pageNo);
    }

    @Override
    public int getTotalAnnouncement() {
        return announcementMapper.getTotalAnnouncement();
    }

    @Override
    public AnnouncementVO viewDetailAnnouncement(int id) {
        try {
            announcementMapper.increaseAnnouncementCountById(id);
            return announcementMapper.findById(id);
        } catch (Exception e) {
            e.printStackTrace();
            loggerService.logException("ERR:VDA", "viewDetailAnnouncement", e.getMessage(), "");
            return null;
        }
    }

    @Override
    public void writeAnnouncement(AnnouncementVO announcementVO) {
        try {
            announcementMapper.insertAnnouncement(announcementVO);
        } catch (Exception e) {
            e.printStackTrace();
            loggerService.logException("ERR:WA", "writeAnnouncement", e.getMessage(), "");
        }
    }

    @Override
    public void deleteAnnouncementById(int id) {
        try {
            announcementMapper.deleteById(id);
        } catch (Exception e) {
            e.printStackTrace();
            loggerService.logException("ERR:DA", "deleteAnnouncementById", e.getMessage(), "");
        }
    }

    @Override
    public void updateAnnouncement(AnnouncementVO announcementVO) {
        try {
            announcementMapper.updateAnnouncement(announcementVO);
        } catch (Exception e) {
            e.printStackTrace();
            loggerService.logException("ERR:UA", "updateAnnouncement", e.getMessage(), "");
        }
    }
}

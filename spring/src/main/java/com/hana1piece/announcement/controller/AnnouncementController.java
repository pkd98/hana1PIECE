package com.hana1piece.announcement.controller;

import com.hana1piece.announcement.model.vo.AnnouncementVO;
import com.hana1piece.announcement.service.AnnouncementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class AnnouncementController {
    private final AnnouncementService announcementService;

    @Autowired
    public AnnouncementController(AnnouncementService announcementService) {
        this.announcementService = announcementService;
    }

    /**
     * 전체 공지사항 보기 ( 페이지네이션 구현 )
     * @param pageNo
     * @return
     */
    @GetMapping("/announcement")
    public ModelAndView announcement(@RequestParam(value = "pageNo", defaultValue = "1") int pageNo) {
        List<AnnouncementVO> announcements = announcementService.findByPageNo(pageNo);
        int totalCount = announcementService.getTotalAnnouncement();
        int totalPages = (totalCount + 9) / 10;  // Round up

        ModelAndView mav = new ModelAndView("announcement");
        mav.addObject("announcementList", announcements);
        mav.addObject("totalPages", totalPages);
        mav.addObject("currentPage", pageNo);
        return mav;
    }

    /**
     * 상세 공지사항 내용 보기
     * @param id
     * @return
     */
    @GetMapping("/announcement/{id}")
    public ModelAndView announcementDetail(@PathVariable("id") int id) {
        ModelAndView mav = new ModelAndView("announcement-detail");
        mav.addObject("announcement", announcementService.viewDetailAnnouncement(id));
        return mav;
    }

}

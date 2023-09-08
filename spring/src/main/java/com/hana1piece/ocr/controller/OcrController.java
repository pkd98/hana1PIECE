package com.hana1piece.tesseract_ocr.controller;

import com.hana1piece.tesseract_ocr.service.OcrService;
import net.sourceforge.tess4j.TesseractException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller
public class OcrController {

    private final OcrService ocrService;

    public OcrController(OcrService ocrService) {
        this.ocrService = ocrService;
    }

    /**
     *  신분증 이미지 OCR 판독
     */
    @PostMapping("/upload/ocr")
    public ResponseEntity registrationCardOcr(@RequestParam("file") MultipartFile file) {
        try {
            if (!file.isEmpty()) {
                String contentType = file.getContentType(); // 파일 타입

                //  이미지인 경우만 처리
                if (contentType != null && contentType.startsWith("image")) {
                    ocrService.getReadRegistrationCard(file);
                } else {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid File");
                }

                // 판독된 주민등록번호 리턴
                return ResponseEntity.ok().body(null);
            } else {
                // 빈 파일 업로드
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid File");
            }


        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("error");
        }
    }


}

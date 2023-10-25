package com.hana1piece.ocr.controller;

import com.hana1piece.ocr.model.OcrDTO;
import com.hana1piece.ocr.service.OcrService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@Controller
public class OcrController {
    @Value("${ocrImgFilePath}")
    private String filePath;
    private final OcrService ocrService;

    public OcrController(OcrService ocrService) {
        this.ocrService = ocrService;
    }

    /**
     * 신분증 이미지 OCR 판독
     */
    @PostMapping("/upload/ocr")
    public ResponseEntity registrationCardOcr(@RequestParam("file") MultipartFile multipartFile) {
        try {
            if (!multipartFile.isEmpty()) {
                String contentType = multipartFile.getContentType(); // 파일 타입

                //  이미지인 경우만 처리
                if (contentType != null && contentType.startsWith("image")) {
                    OcrDTO ocrDTO = ocrService.getReadRegistrationCard(multipartFile);
                    // 판독된 OcrDTO - 주민등록번호 리턴
                    return ResponseEntity.ok().body(ocrDTO);
                } else {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid File");
                }
            } else {
                // 빈 파일 업로드
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid File");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("error");
        }
    }
}

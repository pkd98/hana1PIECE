package com.hana1piece.tesseract_ocr.model;

import lombok.Data;
@Data
public class OcrDTO {
    private String filePath; // 파일 경로
    private String fileName; // 파일명
    private String registrationNumber1; // OCR 결과 텍스트
    private String registrationNumber2; // OCR 결과 텍스트
}

package com.hana1piece.tesseract_ocr.service;

import com.hana1piece.tesseract_ocr.model.OcrDTO;
import net.sourceforge.tess4j.ITesseract;
import net.sourceforge.tess4j.Tesseract;
import net.sourceforge.tess4j.TesseractException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@Service
public class OcrService {

    @Value("${imgFilePath}")
    private String imgFilePath;

    /**
     * MultipartFile 타입에서 File 타입으로 변환
     */
    public File convertMultiPartToFile(MultipartFile multipartFile) throws IOException {
        File file = new File(imgFilePath + "/tmpImg.jpg"); // 임시 파일을 저장할 경로 및 이름 설정
        multipartFile.transferTo(file); // MultipartFile의 내용을 파일로 복사
        return file;
    }

    /**
     *  Tessact OCR 이용 주민등록번호 검출
     */
    public OcrDTO getReadRegistrationCard(MultipartFile file) throws IOException, TesseractException {
        OcrDTO ocrDTO = new OcrDTO();
        // 업로드한 이미지파일
        File imgFile = convertMultiPartToFile(file);

        //테서렉트 OCR 객체
        ITesseract tesseract = new Tesseract();

        // OCR 분석에 필요한 기준 데이터, 저장 경로는 물리 경로를 사용
        tesseract.setDatapath(imgFilePath);
        tesseract.setLanguage("eng");

        // 이미지 파일로부터 텍스트 읽기
        String result = tesseract.doOCR(imgFile);
        System.out.println(result);

        return null;
    }

}

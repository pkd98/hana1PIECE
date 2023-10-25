package com.hana1piece.ocr.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hana1piece.ocr.model.OcrDTO;
import net.sourceforge.tess4j.TesseractException;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Iterator;
import java.util.UUID;

@Service
public class OcrService {

    @Value("${ocrImgFilePath}")
    private String imgFilePath;

    @Value("${clavaocr.api.secret}")
    private String clovaSecret;

    @Value("${clovaocr.api.url}")
    private String clovaApiUrl;

    @Value("${clovaocr.template.id}")
    private int templateId;

    /**
     * MultipartFile 타입에서 File 타입으로 변환
     */
    public File convertMultiPartToFile(MultipartFile multipartFile) throws IOException {
        File file = new File(imgFilePath + multipartFile.getOriginalFilename()); // 임시 파일을 저장할 경로 및 이름 설정
        multipartFile.transferTo(file); // MultipartFile의 내용을 파일로 복사
        return file;
    }

    /**
     * Clova OCR 이용 주민등록번호 검출
     */
    public OcrDTO getReadRegistrationCard(MultipartFile multipartFile) throws IOException {
        OcrDTO ocrDTO = new OcrDTO();

        // 업로드한 이미지파일
        File file = convertMultiPartToFile(multipartFile);
        // 해당 이미지 Clova OCR 이용 문자 json string 추출
        String fileOCR = fileOCR(multipartFile.getOriginalFilename());
        // 신분증 이미지 삭제
        file.delete();

        ObjectMapper objectMapper = new ObjectMapper();
        try {
            JsonNode rootNode = objectMapper.readTree(fileOCR);
            JsonNode imagesNode = rootNode.get("images");
            JsonNode fieldsNode = imagesNode.get(0).get("fields");

            JsonNode residentNumber1Node = findInferTextByFieldName(fieldsNode, "RESIDENT_NUMBER1");
            JsonNode residentNumber2Node = findInferTextByFieldName(fieldsNode, "RESIDENT_NUMBER2");

            ocrDTO.setRegistrationNumber1(residentNumber1Node.asText());
            ocrDTO.setRegistrationNumber2(residentNumber2Node.asText());

            // 결과 출력
            System.out.println("{");
            System.out.println(" \"RESIDENT_NUMBER1\":\"" + residentNumber1Node.asText() + "\",");
            System.out.println(" \"RESIDENT_NUMBER2\":\"" + residentNumber2Node.asText() + "\"");
            System.out.println("}");
        } catch (IOException e) {
            e.printStackTrace();
            throw e;
        }
        return ocrDTO;
    }

    /**
     * Clova OCR (template)을 사용하여 이미지에서 주민등록번호를 검출하는 메서드
     *
     * @return 검출된 주민등록번호 또는 실패 메시지
     */
    public String fileOCR(String fileName) {
        // API 요청을 위한 이미지 파일 경로 설정
        String imageFile = imgFilePath + fileName;
        System.out.println(imageFile);
        try {
            // API 연결 설정
            URL url = new URL(clovaApiUrl);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setUseCaches(false);
            con.setDoInput(true);
            con.setDoOutput(true);
            con.setReadTimeout(30000);
            con.setRequestMethod("POST");
            String boundary = "----" + UUID.randomUUID().toString().replaceAll("-", "");
            con.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
            con.setRequestProperty("X-OCR-SECRET", clovaSecret);

            // JSON 요청 메시지 생성
            JSONObject json = new JSONObject();
            json.put("version", "V2");
            json.put("requestId", UUID.randomUUID().toString());
            json.put("timestamp", System.currentTimeMillis());
            JSONObject image = new JSONObject();
            image.put("format", "png");
            image.put("name", "demo");
            JSONArray templateIds = new JSONArray();
            templateIds.put(templateId);
            image.put("templateIds", templateIds);
            JSONArray images = new JSONArray();
            images.put(image);
            json.put("images", images);
            String postParams = json.toString();

            // API 연결 및 요청 전송
            con.connect();
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            File file = new File(imageFile);
            writeMultiPart(wr, postParams, file, boundary);
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) {
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            // API 응답 처리
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            String result = response.toString();

            return result;
        } catch (Exception e) {
            // 예외 처리
            System.out.println("API 요청 중 예외 발생: " + e.getMessage());
        }
        return "실패"; // 예외 발생 시 실패 메시지 반환
    }

    /**
     * 멀티파트(form-data) 요청을 작성하는 유틸리티 메서드
     *
     * @param out         출력 스트림
     * @param jsonMessage JSON 형식의 요청 메시지
     * @param file        업로드할 이미지 파일
     * @param boundary    멀티파트 경계 문자열
     * @throws IOException 입출력 예외 발생 시
     */
    private static void writeMultiPart(OutputStream out, String jsonMessage, File file, String boundary) throws IOException {
        // JSON 요청 메시지 업로드
        StringBuilder sb = new StringBuilder();
        sb.append("--").append(boundary).append("\r\n");
        sb.append("Content-Disposition:form-data; name=\"message\"\r\n\r\n");
        sb.append(jsonMessage);
        sb.append("\r\n");
        out.write(sb.toString().getBytes("UTF-8"));
        out.flush();

        // 이미지 파일 업로드
        if (file != null && file.isFile()) {
            out.write(("--" + boundary + "\r\n").getBytes("UTF-8"));
            StringBuilder fileString = new StringBuilder();
            fileString.append("Content-Disposition:form-data; name=\"file\"; filename=");
            fileString.append("\"" + file.getName() + "\"\r\n");
            fileString.append("Content-Type: application/octet-stream\r\n\r\n");
            out.write(fileString.toString().getBytes("UTF-8"));
            out.flush();

            try (FileInputStream fis = new FileInputStream(file)) {
                byte[] buffer = new byte[8192];
                int count;
                while ((count = fis.read(buffer)) != -1) {
                    out.write(buffer, 0, count);
                }
                out.write("\r\n".getBytes());
            }

            out.write(("--" + boundary + "--\r\n").getBytes("UTF-8"));
        }
        out.flush();
    }

    private static JsonNode findInferTextByFieldName(JsonNode fieldsNode, String fieldName) {
        Iterator<JsonNode> elements = fieldsNode.elements();
        while (elements.hasNext()) {
            JsonNode fieldNode = elements.next();
            if (fieldNode.get("name").asText().equals(fieldName)) {
                return fieldNode.get("inferText");
            }
        }
        return null;  // 해당 name을 가진 field가 없으면 null 반환
    }

        /*
        //테서렉트 OCR 객체
        ITesseract tesseract = new Tesseract();

        // OCR 분석에 필요한 기준 데이터, 저장 경로는 물리 경로를 사용
        tesseract.setDatapath(imgFilePath);
        tesseract.setLanguage("eng");

        // 이미지 파일로부터 텍스트 읽기
        String result = tesseract.doOCR(imgFile);
        System.out.println(result);
        */
}

package com.hana1piece.member.service;

import com.google.gson.Gson;
import com.hana1piece.logger.service.LoggerService;
import com.hana1piece.member.model.dto.*;
import com.hana1piece.member.model.mapper.MemberMapper;
import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.wallet.model.dto.AccountAndWalletOpeningDTO;
import com.hana1piece.wallet.model.dto.AccountOpeningDTO;
import com.hana1piece.wallet.model.dto.WalletOpeningDTO;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Random;



@Service
@Transactional
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;
    private final LoggerService loggerService;

    @Value("${coolsms.api.key}")
    private String smsApiKey;
    @Value("${coolsms.api.secret}")
    private String smsApiSecret;
    @Value("${myphone}")
    private String myPhone;
    @Value("${hanabank.server.url}")
    private String bankServerUrl;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper, LoggerService loggerService) {
        this.memberMapper = memberMapper;
        this.loggerService = loggerService;
    }

    /**
     * 회원가입
     */
    @Override
    @Transactional
    public void signup(SignupDTO signupDTO) {
        try {
            OneMembersVO oneMembersVO = new OneMembersVO();
            oneMembersVO.setName(signupDTO.getName());
            oneMembersVO.setId(signupDTO.getId());
            oneMembersVO.setPhone(signupDTO.getPhone());
            oneMembersVO.setEmail(signupDTO.getEmail());
            oneMembersVO.setPassword(signupDTO.getPassword());
            oneMembersVO.setReferralCode(memberMapper.getReferralCode());
            memberMapper.insertMember(oneMembersVO);
        } catch (Exception e) {
            loggerService.logException("ERR", "signup", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * 로그인
     */
    @Override
    public boolean login(LoginDTO loginDTO, HttpSession session) {
        try {
            OneMembersVO member = memberMapper.login(loginDTO);
            // 로그인 실패
            if (member == null) {
                return false;
            } else { // 로그인 성공
                System.out.println("login 성공");
                session.setAttribute("member", member);
                return true;
            }
        } catch (Exception e) {
            // 예기치 못한 에러
            loggerService.logException("ERR", "login", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * SMS 인증번호 요청 (CoolSMS 이용)
     */
    @Override
    public void getSmsCertificationNumber(String phoneNumber, HttpSession session) throws CoolsmsException {
        try {
            Random random = new Random();
            Message coolsms = new Message(smsApiKey, smsApiSecret);

            // 인증번호 생성
            String numStr = "";
            for (int i = 0; i < 5; i++) {
                numStr += Integer.toString(random.nextInt(10));
            }

            HashMap<String, String> params = new HashMap<String, String>();
            params.put("to", phoneNumber); // 수신 전화번호
            params.put("from", myPhone); // 발신 전화번호
            params.put("type", "sms");
            params.put("text", "[하나1PIECE] \n인증번호는 [" + numStr + "] 입니다.");
            //coolsms.send(params);

            // 세션에 인증번호 저장 (유효기간 3분)
            session.setAttribute("smsCertificationNumber", numStr);
            session.setMaxInactiveInterval(180);

            System.out.println(numStr);
            System.out.println(session.getAttribute("smsCertificationNumber"));

        } catch (Exception e) {
            loggerService.logException("ERR", "getSmsCertificationNumber", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

    /**
     *  인증번호 확인 검사
     */
    @Override
    public boolean isVerifySms(String userInput, HttpSession session) {
        // 세션에서 인증번호 가져옴
        System.out.println(session.getAttribute("smsCertificationNumber"));
        String smsData = (String) session.getAttribute("smsCertificationNumber");
        if (smsData != null) {
            if (userInput.equals(smsData)) {
                // 사용자가 올바른 인증번호를 입력한 경우
                return true;
            }
        }
        return false;
    }

    /**
     *  계좌 개설 및 지갑 연동 프로세스
     * @param member
     * @param accountAndWalletOpeningDTO
     */
    @Override
    @Transactional
    public void accountAndWalletOpening(OneMembersVO member, AccountAndWalletOpeningDTO accountAndWalletOpeningDTO) {
        try {
            AccountOpeningDTO accountOpeningDTO = new AccountOpeningDTO();
            accountOpeningDTO.setName(member.getName());
            accountOpeningDTO.setPassword(accountAndWalletOpeningDTO.getAccountPassword());
            accountOpeningDTO.setResidentNumber1(accountAndWalletOpeningDTO.getRegistrationNumber1());
            accountOpeningDTO.setResidentNumber2(accountAndWalletOpeningDTO.getRegistrationNumber2());
            String accountNumber = accountOpening(accountOpeningDTO);

            WalletOpeningDTO walletOpeningDTO = new WalletOpeningDTO();
            walletOpeningDTO.setAccountNumber(accountNumber); // 생성한 계좌번호
            walletOpeningDTO.setMemberId(member.getId());
            walletOpeningDTO.setPassword(accountAndWalletOpeningDTO.getWalletPassword());
            walletOpening(walletOpeningDTO);
        } catch (Exception e){
            loggerService.logException("ERR", "accountAndWalletOpening", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * 하나은행 모듈에 계좌 개설 요청
     * @param accountOpeningDTO
     * @return
     */
    @Override
    @Transactional
    public String accountOpening(AccountOpeningDTO accountOpeningDTO) {
        System.out.println(accountOpeningDTO.toString());
        OkHttpClient client = new OkHttpClient();
        Gson gson = new Gson();

        // AccountOpeningDTO 객체를 JSON 문자열로 직렬화
        String jsonInputString = gson.toJson(accountOpeningDTO);

        // JSON 요청 데이터
        MediaType mediaType = MediaType.parse("application/json");
        RequestBody body = RequestBody.create(mediaType, jsonInputString);

        Request request = new Request.Builder()
                .url(bankServerUrl + "account/opening")
                .post(body)
                .addHeader("Content-Type", "application/json")
                .build();
        try {
            Response response = client.newCall(request).execute();
            String accountNumber = response.body().string();
            System.out.println("응답 코드: " + response.code());
            System.out.println("응답 본문: " + accountNumber);
            return accountNumber;

        } catch (Exception e) {
            loggerService.logException("ERR", "accountAndWalletOpening", e.getMessage(), "");
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 지갑 개설
     * @param walletOpeningDTO
     */
    @Override
    @Transactional
    public void walletOpening(WalletOpeningDTO walletOpeningDTO) {
        memberMapper.insertWallet(walletOpeningDTO);
    }

    /**
     * 추천인 이벤트: 추천인 추천자 5000원 지급
     * @param memberId
     * @param referralCode
     * @return
     */
    @Override
    @Transactional
    public boolean event(String memberId, String referralCode) {
        return false;
    }


}

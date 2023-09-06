package com.hana1piece.member.service;

import com.hana1piece.logger.service.LoggerService;
import com.hana1piece.member.model.dto.LoginDTO;
import com.hana1piece.member.model.dto.SignupDTO;
import com.hana1piece.member.model.mapper.MemberMapper;
import com.hana1piece.member.model.vo.OneMembersVO;
import net.nurigo.java_sdk.Coolsms;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper, LoggerService loggerService) {
        this.memberMapper = memberMapper;
        this.loggerService = loggerService;
    }

    /**
     * 회원가입
     */
    @Override
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
    public void getSmsCertificationNumber(String phoneNumber) throws CoolsmsException {
        try {
            Random random = new Random();
            Message coolsms = new Message(smsApiKey, smsApiSecret);

            String numStr = "";
            for (int i = 0; i < 5; i++) {
                numStr += Integer.toString(random.nextInt(10));
            }

            HashMap<String, String> params = new HashMap<String, String>();
            params.put("to", phoneNumber); // 수신 전화번호
            params.put("from", myPhone); // 발신 전화번호
            params.put("type", "sms");
            params.put("text", "[하나1PIECE] \n인증번호는 [" + numStr + "] 입니다.");
            coolsms.send(params);

            System.out.println(numStr);

        } catch (Exception e) {
            loggerService.logException("ERR", "getSmsCertificationNumber", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

}

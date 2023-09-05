package com.hana1piece.member.service;

import com.hana1piece.logger.service.LoggerService;
import com.hana1piece.member.model.dto.SignupDTO;
import com.hana1piece.member.model.mapper.MemberMapper;
import com.hana1piece.member.model.vo.OneMembersVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;
    private final LoggerService loggerService;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper, LoggerService loggerService) {
        this.memberMapper = memberMapper;
        this.loggerService = loggerService;
    }

    /**
     *  회원가입
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
}

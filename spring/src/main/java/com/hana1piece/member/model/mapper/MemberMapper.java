package com.hana1piece.member.model.mapper;

import com.hana1piece.member.model.dto.SignupDTO;
import com.hana1piece.member.model.vo.OneMembersVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MemberMapper {

    List<OneMembersVO> findMemberAll();

    OneMembersVO findMemberById(String id);

    String getReferralCode();

    void insertMember(OneMembersVO oneMembersVO);


}

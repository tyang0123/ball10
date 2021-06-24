package com.ball.mapper;

import com.ball.vo.Criteria;
import com.ball.vo.GroupJoinVO;
import com.ball.vo.GroupMessageVO;
import com.ball.vo.GroupVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GroupMapper {
    public Long insertGroup(GroupVO vo);
    public GroupVO groupRead(Long group_id); //하나만
    public List<GroupVO> selectGroupList(Criteria cri); // 그룹 리스트 조회
    public int groupUpdate(GroupVO vo);
    public int groupDelete(Long group_id);  //그룹 테이블 삭제
    public int joinDelete(Long group_id);  //relation 테이블 삭제
    public int joinOneDelete(@Param("group_id") Long group_id, @Param("user_id") String user_id);  //그룹 탈퇴(한 명씩)

    public void joinGroup(GroupJoinVO vo);
//    public List<GroupJoinVO> joinAllRead(Long group_id);    //그룹 가입된 user 전체 조회
    public int joinAllRead(@Param("group_id") Long group_id,@Param("user_id") String user_id); //가입된 유저 숫자로 확인
    public String passwordCheck(@Param("group_id") Long group_id);

}

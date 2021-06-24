package com.ball.service;

import com.ball.vo.Criteria;
import com.ball.vo.GroupJoinVO;
import com.ball.vo.GroupVO;

import java.util.List;

public interface GroupService {
    public GroupVO register (GroupVO group, String user_id);   //insert
    public GroupVO oneRead(Long group_id);        //하나만 조회
    public List<GroupVO> allRead(Criteria cri);    //전체 가져오기
    public void modify (GroupVO group);     //수정
    public int groupRemove(Long group_id);      //그룹 파괴
    public int userRemove(Long group_id,String user_id);   //유저 탈퇴

    public void joinGroup(GroupJoinVO join);
    public int joinAllRead(Long group_id, String user_id);
    public String passwordCheck(Long group_id);



}

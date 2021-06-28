package com.ball.service;

import com.ball.vo.GroupVO;
import com.ball.vo.UserVO;

import java.util.List;

public interface UserService {
    //user create
    public void userCreate(UserVO vo);

    //user modify
    public void userModify(UserVO vo);

    //user read
    public UserVO userRead(String userID);

    //login check
    public boolean userLoginCheck(String userId, String userPassword);

    //get user nickname
    public String getUserNickname(String userID);

    //유저가 가입한 그룹 조회
    public List<GroupVO> userJoinGroupList(String userID);

    //get userID by email
    public String getUserId(String userEmail);

    //get userPassword by userID,email
    public String getUserPassword(String userId,String userEmail);

    //get Admin Email and password
    public UserVO getAdminEmailAndPW();

    //id check
    public boolean idCheck(String userId);

    //email check
    public boolean emailCheck(String user_id,String userEmail);
}

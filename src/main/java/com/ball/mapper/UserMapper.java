package com.ball.mapper;

import com.ball.vo.GroupVO;
import com.ball.vo.UserVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    public int insertUser(UserVO vo);//유저 데이터 생성(회원등록)

    //유저 1명 정보 조회, 로그인시 사용
    public UserVO selectByIdAndPassword(@Param("user_id") String userId, @Param("user_password") String userPassword);

    //유저 정보 수정
    public int updateUser(UserVO vo);

    //유저 닉네임 조회
    public String selectUserNickNameByID(@Param("user_id") String userId);

    //유저가 가입한 그룹 조회
    public List<GroupVO> userJoinGroup(String userId);

    //유저 ID 조회
    public String selectUserIDByEmail(@Param("user_email") String userEmail);

    //이메일 관리자 정보 조회
    public UserVO selectEmailAdmin();
}

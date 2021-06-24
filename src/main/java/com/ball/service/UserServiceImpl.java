package com.ball.service;

import com.ball.mail.service.MailService;
import com.ball.mapper.UserMapper;
import com.ball.vo.GroupVO;
import com.ball.vo.UserVO;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{

    @Setter(onMethod_=@Autowired)
    private UserMapper userMapper;

    @Override
    public boolean userLoginCheck(String userId, String userPassword) {
        UserVO vo = userMapper.selectByIdAndPassword(userId, userPassword);
        if(vo != null)
            return true;
        return false;
    }

    @Override
    public String getUserNickname(String userID) {
        return userMapper.selectUserNickNameByID(userID);
    }

    @Override
    public List<GroupVO> userJoinGroupList(String userID) {
        return userMapper.userJoinGroup(userID);
    }

    public String getUserId(String userEmail) {return userMapper.selectUserIDByEmail(userEmail); }

    @Override
    public UserVO getAdminEmailAndPW() {return userMapper.selectEmailAdmin(); }
}

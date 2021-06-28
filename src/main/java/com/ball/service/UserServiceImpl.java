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
    public void userCreate(UserVO vo) {
        userMapper.insertUser(vo);
    }

    @Override
    public void userModify(UserVO vo) {
        userMapper.updateUser(vo);
    }

    @Override
    public UserVO userRead(String userID) {
        return userMapper.getUser(userID);
    }

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
    public String getUserPassword(String userId, String userEmail) {
        return userMapper.selectUserPasswordByIdAndEmail(userId,userEmail);
    }

    @Override
    public UserVO getAdminEmailAndPW() {return userMapper.selectEmailAdmin(); }

    @Override
    public boolean idCheck(String userId) {
        String user_id = userMapper.selectIdCheck(userId);
        if(user_id != null)
            return false;
        return true;
    }

    @Override
    public boolean emailCheck(String user_id,String userEmail) {
        String user_email = userMapper.selectEmailCheck(user_id,userEmail);
        if(user_email != null)
            return false;
        return true;
    }
}

package com.ball.mapper;

import com.ball.vo.UserVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.List;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration( "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class UserMapperTests {
    @Setter(onMethod_=@Autowired)
    private UserMapper mapper;

    @Test
    public void testAutowired(){
        System.out.println("============================");
        System.out.println(mapper);
    }

    @Test
    public void testInsert(){
        UserVO vo = new UserVO();
        vo.setUser_id("testmapper4");
        vo.setUser_password("1234");
        vo.setUser_email("abc@naver.com");
        vo.setUser_nickname("테스트유저");
        mapper.insertUser(vo);
    }

    @Test
    public void testSelectByIdAndPassword(){
        UserVO vo = mapper.selectByIdAndPassword("user1", "1234");

        System.out.println("============================");
        System.out.println(vo);
    }

    @Test
    public void testUpdateUser(){
        UserVO vo = new UserVO();
        vo.setUser_id("testmapper2");
        vo.setUser_password("1111");
        vo.setUser_email("abc@naver.com");
        vo.setUser_nickname("테스트유저수정2");

        mapper.updateUser(vo);
    }

    @Test

    public void testUserJoinGroup(){
        mapper.userJoinGroup("user1").forEach(i -> System.out.println(i));
    }

    @Test
    public void testSelectUserNickname(){
        System.out.println(mapper.selectUserNickNameByID("user1"));
    }

    @Test
    public void testSelectUserID(){
        System.out.println(mapper.selectUserIDByEmail("userE00@naver.com"));
    }

    @Test
    public void testSelectEmailAdmin(){
        System.out.println(mapper.selectEmailAdmin());
    }
}

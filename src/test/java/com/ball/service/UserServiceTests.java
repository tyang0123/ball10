package com.ball.service;

import com.ball.vo.UserVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.nio.charset.Charset;
import java.util.Random;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class UserServiceTests {
    @Setter(onMethod_ = @Autowired)
    private UserService service;
    @Test
    public void testCreate(){
        UserVO vo = new UserVO();
        vo.setUser_id("yoojung");
        vo.setUser_password("1234");
        vo.setUser_email("abc@naver.com");
        vo.setUser_nickname("유정가입테스트😘");
        service.userCreate(vo);
    }

    @Test
    public void testRead(){
        System.out.println(service.userRead("yoojung"));
    }

    @Test
    public void testModify(){
        UserVO vo = service.userRead("yoojung");
        vo.setUser_password("1234");
        vo.setUser_email("abc@naver.com");
        vo.setUser_nickname("유정가입테스트🥳");
        service.userModify(vo);
    }

    @Test
    public void testUserJoinGroupList(){
        service.userJoinGroupList("user1").forEach(i -> System.out.println(i));
    }

//    @Test
//    public void testSelectUserPassword(){
//        System.out.println(service.getUserPassword("user1","a@naver.com"));
//    }

    @Test
    public void testIdCheck(){
        System.out.println(service.idCheck("user1"));
    }

    @Test
    public void testEmailCheck(){
        System.out.println(service.emailCheck("user1","a@naver.com"));
    }

    @Test
    public void testRandomString(){
        int leftLimit = 48; // numeral '0'
        int rightLimit = 122; // letter 'z'
        int targetStringLength = 12;
        Random random = new Random();

        String generatedString = random.ints(leftLimit, rightLimit + 1)
                .filter(i -> i <= 57 || i >= 97)
                .limit(targetStringLength)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();

        System.out.println(generatedString);
    }
}

package com.ball.mapper;

import com.ball.vo.UserVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class UserMapperTests {
    @Setter(onMethod_=@Autowired)
    private UserMapper mapper;

    @Test
    public void testInsert(){
        UserVO vo = new UserVO();
        vo.setUser_id("yoojung1234");
        mapper.insertUser(vo);
    }
    @Test
    public void print(){
        System.out.println("출력");
    }
}

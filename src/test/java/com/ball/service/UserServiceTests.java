package com.ball.service;

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
public class UserServiceTests {
    @Setter(onMethod_ = @Autowired)
    private UserService service;

    @Test
    public void testUserJoinGroupList(){
        service.userJoinGroupList("user1").forEach(i -> System.out.println(i));
    }
}

package com.ball.service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class GroupServiceTests {

    @Setter(onMethod_ =@Autowired)
    private GroupService service;

    @Test
    public void getUserJoinedTest(){
        String user_id = "user1";
        service.getUserJoinedGroupId(user_id);
        System.out.println(service.getUserJoinedGroupId(user_id));
    }

}

package com.ball.service;

import com.ball.vo.Criteria;
import com.ball.vo.GroupMessageVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;

@RunWith(SpringJUnit4ClassRunner.class)
@Slf4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class GroupMessageServiceTests {

    @Setter(onMethod_=@Autowired)
    private GroupMessageService service;

    @Test
    public void testGroupMessageRead(){
        service.groupMessageRead(1L);
    }

    @Test
    public void testGroupMessageInsert(){
        GroupMessageVO vo = new GroupMessageVO();

        vo.setGroup_id(1L);
        vo.setUser_id("user1");
        vo.setGroup_message_content("테스트로 넣습니다.");

        System.out.println(service.groupMessageInsert(vo));
    }

    @Test
    public void testGroupMessageDelete(){
        //group_message_id 있는지 확인
        service.groupMessageDelete(1L);
    }

    @Test
    public void testGroupMessageMoreRead(){
        Criteria cri = new Criteria();
        cri.setCriterionNumber(1L);

        service.groupMessageMoreRead(cri,1L);
    }

    @Test
    public void testFirstGroupMessageId(){
        System.out.println(service.getFirstGroupMessageId(2L));
    }
}

package com.ball.service;

import com.ball.vo.AlarmVO;
import com.ball.vo.Criteria;
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
public class AlarmServiceTests {
    @Setter(onMethod_=@Autowired)
    private AlarmService service;

    @Test
    public void testRegister(){
        AlarmVO vo = new AlarmVO();
        vo.setUser_id("user1");
        vo.setAlarm_message_content("열공합시다~~!!");
        vo.setAlarm_message_is_new((byte)1);
        service.register(vo);
    }
    @Test
    public void testGet(){
        AlarmVO vo = service.get(100L);
        System.out.println(vo);
    }
    @Test
    public void testTotal()
    {
        System.out.println(service.getFirstCriterionNumber("user100"));
    }
    @Test
    public void testModify(){
        AlarmVO vo = service.get(103L);
        service.modify(vo.getAlarm_message_id());
    }
    @Test
    public void testAlarmCount(){
        System.out.println(service.alarmCount("user1"));
    }

    @Test
    public void testGetListWithPage(){
        Long pageID = 0L;
        Criteria cri = new Criteria(pageID,20);
        service.getListWithPage(cri,"user1").forEach(i -> System.out.println(i));
    }
}

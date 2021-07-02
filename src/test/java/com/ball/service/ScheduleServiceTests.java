package com.ball.service;

import com.ball.vo.ScheduleVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.time.LocalDate;
import java.time.LocalTime;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ScheduleServiceTests {
    @Setter(onMethod_=@Autowired)
    private ScheduleService service;

    @Test
    public void testInsert(){
        ScheduleVO vo = new ScheduleVO();
        vo.setUser_id("user2");
        vo.setSchedule_date(LocalDate.now());
        vo.setSchedule_time(LocalTime.now());
        vo.setSchedule_content("프로젝트 시작2");
        System.out.println(service.addSchedule(vo)+"  "+vo.getSchedule_id());
    }
}
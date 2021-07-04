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
import java.time.format.DateTimeFormatter;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ScheduleServiceTests {
    @Setter(onMethod_=@Autowired)
    private ScheduleService service;

    @Test
    public void testInsert(){
        ScheduleVO vo = new ScheduleVO();
        vo.setUser_id("user11");
        LocalDate scheduleDate = LocalDate.parse("2021-07-06", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        vo.setSchedule_date(scheduleDate);
        LocalTime scheduleTime = LocalTime.parse(("03" + ":" + "10" + ":00"), DateTimeFormatter.ofPattern("kk:mm:ss"));
        vo.setSchedule_time(scheduleTime);
        vo.setSchedule_content("방청소");
        System.out.println(service.insertSchedule(vo));
    }


}

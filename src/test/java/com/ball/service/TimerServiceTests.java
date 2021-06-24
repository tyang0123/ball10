package com.ball.service;

import com.ball.vo.TimerVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class TimerServiceTests {

    @Setter(onMethod_=@Autowired )
    private TimerService timerService;


    @Test
    public void timeTest(){

        Calendar cal = Calendar.getInstance();

        cal.set(Calendar.DATE, 30);
        System.out.println(cal);
        cal.add(Calendar.DATE, 1);
        System.out.println(cal);

        System.out.println(cal.get(Calendar.HOUR_OF_DAY));
        System.out.println(cal.get(Calendar.HOUR));
        Date now = cal.getTime();

        cal.add(Calendar.DATE, 1);
        cal.set(Calendar.HOUR, 3);
        Date tomorrowDawn = cal.getTime();

        long diff = tomorrowDawn.getTime() - now.getTime();
        System.out.println(diff/(1000*60*60));
//        System.out.println( cal.get(Calendar.DATE)+" "+cal.get(Calendar.HOUR) +" "+cal.get(Calendar.MINUTE));

    }

    @Test
    public void testTimeFormat(){
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");
        LocalTime timer_time = LocalTime.parse("12:10:20", dtf);

        System.out.println(timer_time.toString());
    }

    @Test
    public void testModifyTimerPlayState(){
        TimerVO vo = new TimerVO();

        vo.setTimer_id(120L);
        vo.setUser_id("testmapper");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");
//        System.out.println(timerService.modifyTimerPlayState(vo).getTimer_accumulated_day().format(dtf));
        System.out.println(timerService.modifyTimerPlayState(vo));
    }

    @Test
    public void testGetListTodayUserTimerbyGroupID(){
        for (TimerVO timerVO : timerService.getListTodayUserTimerbyGroupID(9L)) {
            System.out.println(timerVO);
        }
    }
}

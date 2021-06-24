package com.ball.mapper;


import com.ball.vo.TimerVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.time.LocalTime;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class TimerMapperTests {
    @Setter(onMethod_= @Autowired)
    private TimerMapper mapper;


    @Test
    public void testAutowired(){
        System.out.println("---------------------------------");
        System.out.println(mapper);
    }

    @Test
    public void testInsertTimer(){
        TimerVO vo = new TimerVO();
        vo.setUser_id("testmapper");


        System.out.println(mapper.insertTodayTimer(vo));
        System.out.println(vo);
    }

    @Test
    public void testSelectTodayTimer(){
        TimerVO vo = new TimerVO();
        vo.setUser_id("testmapper");
        vo = mapper.selectTodayTimerByUserID(vo);
        System.out.println(vo);
        System.out.println(vo.getTimer_accumulated_day().toString());

        vo.setUser_id("user20");
        System.out.println(mapper.selectTodayTimerByUserID(vo));
    }

    @Test
    public void testUpdateAccumulatedTime(){
        TimerVO vo = new TimerVO();
        vo.setUser_id("testmapper");
        vo.setTimer_id(125L);
        vo.setTimer_accumulated_day(LocalTime.of(10,20,10));

        System.out.println(mapper.updateAccumulatedTimeAndState(vo));
    }

    @Test
    public void testUpdateTimerPlayState(){
        TimerVO vo = new TimerVO();
        vo.setUser_id("testmapper");
        vo.setTimer_id(125L);

        System.out.println(mapper.updateAccumulatedTimeAndState(vo));

        System.out.println(mapper.selectTimerByTimerID(vo.getTimer_id()));
    }

    @Test
    public void testSelectListTodayUserTimerbyGroupID(){
        for (TimerVO timerVO : mapper.selectListTodayUserTimerbyGroupID(8L)) {
            System.out.println(timerVO);
        }
    }

}

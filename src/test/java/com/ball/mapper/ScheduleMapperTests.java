package com.ball.mapper;

import com.ball.vo.ScheduleVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.stream.IntStream;
import java.util.stream.LongStream;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration( "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ScheduleMapperTests {
    @Setter(onMethod_=@Autowired)
    private ScheduleMapper mapper;

    @Test
    public void testAutowired(){
        System.out.println("============================");
        System.out.println(mapper);
    }

    @Test
    public void testParse(){
        LocalDate temp = LocalDate.parse("2021-07-10", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        System.out.println(temp.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일")));

        LocalTime timeTemp = LocalTime.parse(("20:30:00"), DateTimeFormatter.ofPattern("kk:mm:ss"));
        System.out.println(timeTemp.format(DateTimeFormatter.ofPattern("a hh시 mm분 ss초")));
    }

    @Test
    public void testInsert(){

        IntStream.rangeClosed(2,99).forEach(i->{
            System.out.println("user1"+((int)Math.floor(i/10)));
            ScheduleVO vo = new ScheduleVO();
            vo.setUser_id("user1"+((int)Math.floor(i/10)));
            vo.setSchedule_date(LocalDate.parse("2021-07-"+(i%20+10), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            vo.setSchedule_time(LocalTime.parse(( (i%10+12)+":00:00"), DateTimeFormatter.ofPattern("kk:mm:ss")));
            vo.setSchedule_content("테스트2차"+i);
            System.out.println(mapper.addSchedule(vo)+"  "+vo.getSchedule_id());
        });
    }

    @Test
    public void testInsert2(){

        IntStream.rangeClosed(2,99).forEach(i->{
            ScheduleVO vo = new ScheduleVO();
            vo.setUser_id("user11");
            vo.setSchedule_date(LocalDate.parse("2021-07-1"+(i%9), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            vo.setSchedule_time(LocalTime.parse(( (i%6+12)+":20:00"), DateTimeFormatter.ofPattern("kk:mm:ss")));
            vo.setSchedule_content("테스트3차"+i);
            System.out.println(mapper.addSchedule(vo)+"  "+vo.getSchedule_id());
        });
    }

    @Test
    public void testSelectScheduleByScheduleID(){
        System.out.println(mapper.selectScheduleByScheduleID(10L));
    }

    @Test
    public void testSelectScheduleByDateAndUserID(){
        mapper.selectScheduleByDateAndUserID(LocalDate.now().plusDays(10L), "user11").forEach(i-> System.out.println(i));
    }

    @Test
    public void testSelectScheduleCountByMonthAndUserID(){
        mapper.selectScheduleCountByYearAndMonthAndUserID(LocalDate.parse("2021-07-01", DateTimeFormatter.ofPattern("yyyy-MM-dd")), "user11").forEach(i-> System.out.println(i));
    }

    @Test
    public void testUpdateSchedule(){
        ScheduleVO vo = new ScheduleVO();
        vo.setSchedule_id(1L);
        vo.setUser_id("user1");
        vo.setSchedule_date(LocalDate.parse("2021-07-10", DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        vo.setSchedule_time(LocalTime.parse(("10:00:00"), DateTimeFormatter.ofPattern("kk:mm:ss")));
        vo.setSchedule_content("테스트로 수정함");

        mapper.updateSchedule(vo);
    }

    @Test
    public void testDeleteSchedule(){
        mapper.deleteSchedule(19L);
    }

    @Test
    public void testUpdateChecked(){
        mapper.updateScheduleChecked(163L);
    }

}
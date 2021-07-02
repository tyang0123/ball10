package com.ball.controller;

import com.ball.service.ScheduleService;
import com.ball.vo.Criteria;
import com.ball.vo.ScheduleVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;

@Slf4j
@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/ajax/schedule")
public class ScheduleAjaxController {
    @Setter(onMethod_=@Autowired)
    private ScheduleService scheduleService;

    @GetMapping("/count")
    public ResponseEntity<HashMap<String, Object>> scheduleCountByMonth(String date, HttpSession session) throws Exception {
        //date는 "yyyy-MM-dd"패턴으로 string 형태로 가져온다
        String userID = String.valueOf(session.getAttribute("userID"));
        HashMap<String, Object> result = new HashMap<>();

        LocalDate firstDayOfMonth = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));


//        result.put("count",scheduleService.readScheduleCountByYearAndMonthAndUserID(firstDayOfMonth,userID));
        return ResponseEntity.ok(result);
    }

    @PostMapping("/list")
    public ResponseEntity<HashMap<String, Object>> scheduleList(String date, HttpSession session) throws Exception {
        String userID = String.valueOf(session.getAttribute("userID"));
        HashMap<String, Object> result = new HashMap<>();

//        result.put("list",scheduleService.readScheduleDate(date,userID));
//        result.put("count",scheduleService.readScheduleDateCount(date,userID));
        return ResponseEntity.ok(result);
    }

    @PostMapping("/add")
    public ResponseEntity<HashMap<String, Object>> scheduleAdd(String hour,String minute,String schedule_content,String date, HttpSession session) throws Exception {
        String userID = String.valueOf(session.getAttribute("userID"));
        System.out.println("session에서 가져온 값 : "+userID);
        System.out.println("날짜 가져온 값 : "+date);
        System.out.println("시 가져온 값 : "+hour);
        System.out.println("분 가져온 값 : "+minute);
        System.out.println("내용 가져온 값 : "+schedule_content);

        HashMap<String, Object> result = new HashMap<>();

        ScheduleVO vo = new ScheduleVO();
        vo.setUser_id(userID);
//        vo.setSchedule_date(date);
//        vo.setSchedule_time(hour+":"+minute);
        vo.setSchedule_content(schedule_content);

//        scheduleService.insertSchedule(vo);
        Long schedule_id = vo.getSchedule_id();
        System.out.println("반환된 키값 "+schedule_id);
        result.put("id",schedule_id);
        result.put("vo",vo);
//        result.put("count",scheduleService.readScheduleDateCount(date,userID));
        return ResponseEntity.ok(result);
    }
}

package com.ball.controller;

import com.ball.service.ScheduleService;
import com.ball.vo.ScheduleVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;

@Slf4j
@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/ajax/schedule")
public class ScheduleAjaxController {
    @Setter(onMethod_=@Autowired)
    private ScheduleService scheduleService;

    @PostMapping("/count")
    public ResponseEntity<HashMap<String, Object>> scheduleCount(String date, HttpSession session) throws Exception {
        String userID = String.valueOf(session.getAttribute("userID"));
        HashMap<String, Object> result = new HashMap<>();

        LocalDate scheduleDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        result.put("list",scheduleService.scheduleCountByYearAndMonthAndUserID(scheduleDate,userID));
        return ResponseEntity.ok(result);
    }

    @PostMapping("/list")
    public ResponseEntity<HashMap<String, Object>> scheduleList(String date, HttpSession session) throws Exception {
        String userID = String.valueOf(session.getAttribute("userID"));
        HashMap<String, Object> result = new HashMap<>();

        LocalDate scheduleDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        result.put("list",scheduleService.readScheduleDate(scheduleDate,userID));
        return ResponseEntity.ok(result);
    }

    @PostMapping("/add")
    public ResponseEntity<HashMap<String, Object>> scheduleAdd(String hour,String minute,String schedule_content,String date, HttpSession session) throws Exception {
        String userID = String.valueOf(session.getAttribute("userID"));

        HashMap<String, Object> result = new HashMap<>();

        ScheduleVO vo = new ScheduleVO();
        vo.setUser_id(userID);
        LocalDate scheduleDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        vo.setSchedule_date(scheduleDate);
        LocalTime scheduleTime = LocalTime.parse((hour + ":" + minute + ":00"), DateTimeFormatter.ofPattern("kk:mm:ss"));
        vo.setSchedule_time(scheduleTime);
        vo.setSchedule_content(schedule_content);

        scheduleService.insertSchedule(vo);
        result.put("date",date);
        result.put("id",vo.getSchedule_id());
        result.put("schedule_content",schedule_content);
        result.put("schedule_time",(hour + "," + minute));
        return ResponseEntity.ok(result);
    }

    @PostMapping("/read")
    public ResponseEntity<HashMap<String, Object>> scheduleRead(Long sheduleID) throws Exception {
        HashMap<String, Object> result = new HashMap<>();

        result.put("vo",scheduleService.readSchedule(sheduleID));
        return ResponseEntity.ok(result);
    }

    @PostMapping("/modify")
    public ResponseEntity<HashMap<String, Object>> scheduleModify(String hour,String minute,String schedule_content,String schedule_date,Long schedule_id) throws Exception {
        HashMap<String, Object> result = new HashMap<>();

        ScheduleVO vo = scheduleService.readSchedule(schedule_id);
        LocalTime scheduleTime = LocalTime.parse((hour + ":" + minute + ":00"), DateTimeFormatter.ofPattern("kk:mm:ss"));
        vo.setSchedule_time(scheduleTime);
        vo.setSchedule_content(schedule_content);
        scheduleService.modifySchedule(vo);
        result.put("date",schedule_date);
        return ResponseEntity.ok(result);
    }

    @PostMapping("/delete")
    public ResponseEntity<HashMap<String, Object>> scheduleDelete(Long schedule_id,String schedule_date) throws Exception {
        HashMap<String, Object> result = new HashMap<>();

        scheduleService.removeSchedule(schedule_id);
        result.put("date",schedule_date);
        return ResponseEntity.ok(result);
    }

    @PostMapping("/todo")
    public ResponseEntity<HashMap<String, Object>> scheduleDelete(Long scheduleID)throws Exception {
        HashMap<String, Object> result = new HashMap<>();

        scheduleService.todoScheduleChecked(scheduleID);
        result.put("success","success");
        return ResponseEntity.ok(result);
    }
}

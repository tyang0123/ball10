package com.ball.controller;

import com.ball.service.TimerService;
import com.ball.vo.TimerVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;


@CrossOrigin(origins = "*")
@Controller
@RequestMapping("/ajax/timer/*")
@Slf4j
public class TimerAjaxController {
    @Setter(onMethod_=@Autowired )
    private TimerService timerService;


    @PutMapping(value = "/putstart/{timer_id}")
    public ResponseEntity<String> timerStartUpdate(@PathVariable(value = "timer_id") Long timer_id
            , HttpSession session){

        TimerVO vo = new TimerVO();

        vo.setTimer_id(timer_id);
        vo.setUser_id(String.valueOf(session.getAttribute("userID")));
        vo.setTimer_is_play(1);

        return timerService.modifyTimerPlayState(vo) == 1?
            new ResponseEntity<String>("success", HttpStatus.OK)
            : new ResponseEntity<String>("db error", HttpStatus.INTERNAL_SERVER_ERROR);

    }

    @PutMapping(value = "/putstop/{timer_id}")
    public ResponseEntity<String> timerStopUpdate(@PathVariable(value = "timer_id") Long timer_id
            , @RequestBody String timer_date
            , HttpSession session){

        try{
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");
            LocalTime timer_time = LocalTime.parse(timer_date, dtf);

            TimerVO vo = new TimerVO();
            vo.setTimer_id(timer_id);
            vo.setTimer_accumulated_day(timer_time);
            vo.setUser_id(String.valueOf(session.getAttribute("userID")));
            vo.setTimer_is_play(0);

            return timerService.modifyTimerAccumulatedDayTimeAndStopState(vo) == 1?
                    new ResponseEntity<String>("success", HttpStatus.OK)
                    : new ResponseEntity<String>("db error", HttpStatus.INTERNAL_SERVER_ERROR);
        }catch (Exception e){
            return new ResponseEntity<String>("parsing error", HttpStatus.EXPECTATION_FAILED);
        }
    }

    @GetMapping("/gettimers/{group_id}")
    public ResponseEntity<List<TimerVO>> readUserTimersByGroup(@PathVariable("group_id") Long group_id){
        log.info("timerAjax readUserTimersByGroup............................");
        return new ResponseEntity<>(timerService.getListTodayUserTimerbyGroupID(group_id), HttpStatus.OK);
    }
}

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
import java.util.Map;


@CrossOrigin(origins = "*")
@Controller
@RequestMapping("/ajax/timer/*")
@Slf4j
public class TimerAjaxController {
    @Setter(onMethod_=@Autowired )
    private TimerService timerService;

    @PutMapping(value = "/{timer_id}")
    public ResponseEntity<String> timerStateUpdate(@PathVariable(value = "timer_id") Long timer_id
            , @RequestBody Map<String, String> param
            , HttpSession session){
        log.info("TimerAjaxController timerStateUpdate........................................");

        try{
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");
            LocalTime timer_time = LocalTime.parse(param.get("accumulatedTime"), dtf);

            TimerVO vo = new TimerVO();
            vo.setTimer_id(timer_id);
            vo.setTimer_accumulated_day(timer_time);
            vo.setUser_id(String.valueOf(session.getAttribute("userID")));
            vo.setTimer_is_play(Integer.valueOf(param.get("timerIsPlay")));
            vo.setTimer_is_on_site(Integer.valueOf(param.get("timerIsOnSite")));

            return timerService.modifyTimerAccumulatedDayTimeAndStopState(vo) == 1?
                    new ResponseEntity<String>("success", HttpStatus.OK)
                    : new ResponseEntity<String>("db error", HttpStatus.INTERNAL_SERVER_ERROR);
        }catch (Exception e){
            System.out.println(e.getMessage());
            return new ResponseEntity<String>("parsing error", HttpStatus.EXPECTATION_FAILED);
        }
    }

    ///////////////////추후 아래 삭제
    @PutMapping(value = "/{timer_id}/{timer_is_play}")
    public ResponseEntity<String> timerStateUpdateBeforeTuning(@PathVariable(value = "timer_id") Long timer_id
            , @PathVariable(value = "timer_is_play") Integer timer_is_play
            , @RequestBody String timer_date
            , HttpSession session){
        log.info("TimerAjaxController timerStateUpdate........................................");
        log.info(timer_id+" "+ timer_is_play+" "+ timer_date);
        try{
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");
            LocalTime timer_time = LocalTime.parse(timer_date, dtf);

            TimerVO vo = new TimerVO();
            vo.setTimer_id(timer_id);
            vo.setTimer_accumulated_day(timer_time);
            vo.setUser_id(String.valueOf(session.getAttribute("userID")));
            vo.setTimer_is_play(timer_is_play);

            return timerService.modifyTimerAccumulatedDayTimeAndStopState(vo) == 1?
                    new ResponseEntity<String>("success", HttpStatus.OK)
                    : new ResponseEntity<String>("db error", HttpStatus.INTERNAL_SERVER_ERROR);
        }catch (Exception e){
            System.out.println(e.getMessage());
            return new ResponseEntity<String>("parsing error", HttpStatus.EXPECTATION_FAILED);
        }
    }


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
        log.info("TimerAjaxController timerStopUpdate........................................");
        log.info(timer_id+" "+ timer_date);
        try{
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");
            LocalTime timer_time = LocalTime.parse(timer_date, dtf);

            log.info(timer_id+" "+ timer_date);
            TimerVO vo = new TimerVO();
            vo.setTimer_id(timer_id);
            vo.setTimer_accumulated_day(timer_time);
            vo.setUser_id(String.valueOf(session.getAttribute("userID")));
            vo.setTimer_is_play(0);

            return timerService.modifyTimerAccumulatedDayTimeAndStopState(vo) == 1?
                    new ResponseEntity<String>("success", HttpStatus.OK)
                    : new ResponseEntity<String>("db error", HttpStatus.INTERNAL_SERVER_ERROR);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<String>("parsing error", HttpStatus.EXPECTATION_FAILED);
        }
    }
/////////////////////여기까지 삭제

    @GetMapping("/gettimers/{group_id}")
    public ResponseEntity<List<TimerVO>> readUserTimersByGroup(@PathVariable("group_id") Long group_id){
        log.info("timerAjax readUserTimersByGroup............................");
        return new ResponseEntity<>(timerService.getListTodayUserTimerbyGroupID(group_id), HttpStatus.OK);
    }
}

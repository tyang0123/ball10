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
import java.time.LocalDate;
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
        log.info("TimerAjaxController timerStateUpdate........................................"+session.getAttribute("userID"));

        try{
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");
            LocalTime timer_time = LocalTime.parse(param.get("accumulatedTime"), dtf);

            TimerVO vo = new TimerVO();
            vo.setTimer_id(timer_id);
            vo.setTimer_accumulated_day(timer_time);
            vo.setUser_id(String.valueOf(session.getAttribute("userID")));
            vo.setTimer_is_play(Integer.valueOf(param.get("timerIsPlay")));
            vo.setTimer_is_on_site(Integer.valueOf(param.get("timerIsOnSite")));
            vo.setTimer_is_use_apple(Integer.valueOf(param.get("timerIsUseApple")));

            return timerService.modifyTimerAccumulatedDayTimeAndStopState(vo) == 1?
                    new ResponseEntity<String>("success", HttpStatus.OK)
                    : new ResponseEntity<String>("db error", HttpStatus.INTERNAL_SERVER_ERROR);
        }catch (Exception e){
            log.warn(e.getMessage());
            return new ResponseEntity<String>("parsing error", HttpStatus.EXPECTATION_FAILED);
        }
    }

    @GetMapping("/gettimers/{group_id}")
    public ResponseEntity<List<TimerVO>> readUserTimersByGroup(@PathVariable("group_id") Long group_id){
        log.info("timerAjax readUserTimersByGroup............................");
        return new ResponseEntity<>(timerService.getListTodayUserTimerbyGroupID(group_id), HttpStatus.OK);
    }

    @GetMapping("/getseconds")
    public ResponseEntity<List<Map<String, Object>>> readUserTimerSecondsByWeek(@RequestParam String date, HttpSession session){
        log.info("timerAjax readUserTimerSecondsByWeek............................", date);
        LocalDate mondayDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        String userID = String.valueOf(session.getAttribute("userID"));
        return new ResponseEntity<>(timerService.getTimerSecondsListByDateWeekAndUser(mondayDate, userID), HttpStatus.OK);
    }
}

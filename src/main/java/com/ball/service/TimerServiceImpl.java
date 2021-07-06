package com.ball.service;

import com.ball.mapper.TimerMapper;
import com.ball.vo.TimerVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class TimerServiceImpl implements TimerService{
    @Setter(onMethod_= @Autowired)
    private TimerMapper timerMapper;

    @Transactional
    @Override
    public TimerVO addNewTimerToDataBaseIfNotExist(String user_id) {
        TimerVO timerVO = new TimerVO();
        timerVO.setUser_id(user_id);

        TimerVO readVO = timerMapper.selectTodayTimerByUserID(timerVO);
        if(readVO != null){
            log.info(readVO.toString());
            return readVO;
        }

        timerMapper.insertTodayTimer(timerVO);
        return timerVO;
    }

//    @Transactional
//    @Override
//    public int modifyTimerPlayState(TimerVO vo) {
//        TimerVO resultVO = timerMapper.selectTimerByTimerID(vo.getTimer_id());
//        resultVO.setTimer_is_play(1);
//        return timerMapper.updateAccumulatedTimeAndState(resultVO);
//    }

    @Override
    public int modifyTimerAccumulatedDayTimeAndStopState(TimerVO vo) {
        return timerMapper.updateAccumulatedTimeAndState(vo);
    }

    @Override
    public List<TimerVO> getListTodayUserTimerbyGroupID(Long group_id) {
        return timerMapper.selectListTodayUserTimerbyGroupID(group_id);
    }

    @Override
    public List<Map<String, Object>> getTimerSecondsListByDateWeekAndUser(LocalDate date, String user_id) {
        return timerMapper.selectTimerSecondsByDateWeekAndUser(date, user_id);
    }
}

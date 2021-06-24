package com.ball.service;

import com.ball.vo.TimerVO;

import java.util.List;

public interface TimerService {
    //NewTimer 생성 (쿠키가 생성될때)
    public TimerVO addNewTimerToDataBaseIfNotExist(String user_id);

    //UpdateTimer Play 타이머를 재생할때 재생 상태 업데이트 및 최신 accumulateDate가져오기
    public int modifyTimerPlayState(TimerVO vo);
    
    //UpdateTimer 누적 시간을 업데이트 할때
    public int modifyTimerAccumulatedDayTimeAndStopState(TimerVO vo);

    public List<TimerVO> getListTodayUserTimerbyGroupID(Long group_id);
}

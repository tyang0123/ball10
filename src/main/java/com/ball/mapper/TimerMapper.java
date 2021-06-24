package com.ball.mapper;

import com.ball.vo.Criteria;
import com.ball.vo.GroupVO;
import com.ball.vo.TimerVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TimerMapper {
    public Long insertTodayTimer(TimerVO vo);//login+cookie 생성시 새로운 타이머 data생성
    public TimerVO selectTodayTimerByUserID(TimerVO vo); // user의 오늘 생성된 타이머 데이터 가져오기
    public TimerVO selectTimerByTimerID(Long timer_id);
    public int updateAccumulatedTimeAndState(TimerVO vo);
    public List<TimerVO> selectListTodayUserTimerbyGroupID(Long group_id);
}

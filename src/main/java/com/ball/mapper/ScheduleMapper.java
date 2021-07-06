package com.ball.mapper;

import com.ball.vo.ScheduleVO;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ScheduleMapper {
    //스케쥴 하나 조회
    public ScheduleVO selectScheduleByScheduleID(Long schedule_id);

    //날짜별 스케쥴 리스트
    public List<ScheduleVO> selectScheduleByDateAndUserID(@Param("schedule_date") LocalDate date, @Param("user_id") String user_id);

    //매달 스케쥴 갯수 확인
    public List<Map<Integer, Long>> selectScheduleCountByYearAndMonthAndUserID(@Param("schedule_date") LocalDate date, @Param("user_id") String user_id);

    //스케쥴 추가하기
    public Long addSchedule(ScheduleVO vo);

    //스케쥴 수정하기
    public void updateSchedule(ScheduleVO vo);

    //스케쥴 삭제
    public void deleteSchedule(Long schedule_id);

    //스케쥴 todoList 처리
    public void updateScheduleChecked(Long schedule_id);
}

package com.ball.service;

import com.ball.vo.ScheduleVO;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface ScheduleService {
    public ScheduleVO readSchedule(Long schedule_id);
    public List<ScheduleVO> readScheduleDate(LocalDate date, String user_id);
//    public int readScheduleDateCount(String date,String user_id);
    public List<Map<Integer, Long>> scheduleCountByYearAndMonthAndUserID(@Param("schedule_date") LocalDate date, @Param("user_id") String user_id);
    public Long insertSchedule(ScheduleVO vo);
    public void modifySchedule(ScheduleVO vo);
    public void removeSchedule(Long schedule_id);
}

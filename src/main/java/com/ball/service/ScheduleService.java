package com.ball.service;

import com.ball.vo.ScheduleVO;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public interface ScheduleService {
    public ScheduleVO readSchedule(Long schedule_id);
    public List<ScheduleVO> readScheduleUser(String user_id);
    public List<ScheduleVO> readScheduleByDateAndUserID(LocalDate date, String user_id);

    public int addSchedule(ScheduleVO vo);
    public int modifySchedule(ScheduleVO vo);
    public int removeSchedule(Long schedule_id);
}

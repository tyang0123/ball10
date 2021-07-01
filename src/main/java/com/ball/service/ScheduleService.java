package com.ball.service;

import com.ball.vo.ScheduleVO;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface ScheduleService {
    public ScheduleVO readSchedule(Long schedule_id);
    public List<ScheduleVO> readScheduleUser(String user_id);
    public List<ScheduleVO> readScheduleDate(Date date,String user_id);
    public String readScheduleDateCount(Date date,String user_id);
    public void insertSchedule(ScheduleVO vo);
    public void modifySchedule(ScheduleVO vo);
    public void removeSchedule(Long schedule_id);
}

package com.ball.service;

import com.ball.mapper.ScheduleMapper;
import com.ball.vo.ScheduleVO;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ScheduleServiceImpl implements ScheduleService{
    @Setter(onMethod_=@Autowired)
    private ScheduleMapper mapper;

    @Override
    public ScheduleVO readSchedule(Long schedule_id) {
        return mapper.getSchedule(schedule_id);
    }

    @Override
    public List<ScheduleVO> readScheduleUser(String user_id) {
        return mapper.getScheduleUser(user_id);
    }

    @Override
    public List<ScheduleVO> readScheduleDate(Date date, String user_id) {
        return mapper.getScheduleDate(date,user_id);
    }

    @Override
    public String readScheduleDateCount(Date date, String user_id) {
        return mapper.getScheduleDateCount(date,user_id);
    }

    @Override
    public void insertSchedule(ScheduleVO vo) {
        mapper.addSchedule(vo);
    }

    @Override
    public void modifySchedule(ScheduleVO vo) {
        mapper.updateSchedule(vo);
    }

    @Override
    public void removeSchedule(Long schedule_id) {
        mapper.deleteSchedule(schedule_id);
    }
}

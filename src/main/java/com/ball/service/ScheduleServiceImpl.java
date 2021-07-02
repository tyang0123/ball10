package com.ball.service;

import com.ball.mapper.ScheduleMapper;
import com.ball.vo.ScheduleVO;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Service
public class ScheduleServiceImpl implements ScheduleService{
    @Setter(onMethod_=@Autowired)
    private ScheduleMapper mapper;

    @Override
    public ScheduleVO readSchedule(Long schedule_id) { return mapper.selectScheduleByScheduleID(schedule_id);}

    @Override
    public List<ScheduleVO> readScheduleUser(String user_id) { return mapper.selectScheduleByUserID(user_id);}

    @Override
    public List<ScheduleVO> readScheduleByDateAndUserID(LocalDate date, String user_id) {
        return mapper.selectScheduleByDateAndUserID(date,user_id);
    }

    @Override
    public int addSchedule(ScheduleVO vo) {
        return mapper.insertSchedule(vo);
    }

    @Override
    public int modifySchedule(ScheduleVO vo) {
        return mapper.updateSchedule(vo);
    }

    @Override
    public int removeSchedule(Long schedule_id) {
        return mapper.deleteSchedule(schedule_id);
    }
}

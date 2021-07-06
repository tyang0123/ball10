package com.ball.service;

import com.ball.mapper.ScheduleMapper;
import com.ball.vo.ScheduleVO;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Service
public class ScheduleServiceImpl implements ScheduleService{
    @Setter(onMethod_=@Autowired)
    private ScheduleMapper mapper;

    @Override
    public ScheduleVO readSchedule(Long schedule_id) {
        return mapper.selectScheduleByScheduleID(schedule_id);
    }

    @Override
    public List<ScheduleVO> readScheduleDate(LocalDate date, String user_id) {
        return mapper.selectScheduleByDateAndUserID(date,user_id);
    }

    @Override
    public List<Map<Integer, Long>> scheduleCountByYearAndMonthAndUserID(LocalDate date, String user_id) {
        return mapper.selectScheduleCountByYearAndMonthAndUserID(date,user_id);
    }

    @Override
    public Long insertSchedule(ScheduleVO vo) {
        return mapper.addSchedule(vo);
    }

    @Override
    public void modifySchedule(ScheduleVO vo) {
        mapper.updateSchedule(vo);
    }

    @Override
    public void removeSchedule(Long schedule_id) {
        mapper.deleteSchedule(schedule_id);
    }

    @Override
    public void todoScheduleChecked(Long schedule_id) {
        mapper.updateScheduleChecked(schedule_id);
    }
}

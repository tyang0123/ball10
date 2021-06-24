package com.ball.service;

import com.ball.mapper.AlarmMapper;
import com.ball.vo.AlarmVO;
import com.ball.vo.Criteria;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AlarmServiceImpl implements AlarmService{
    @Setter(onMethod_=@Autowired)
    private AlarmMapper mapper;

    @Override
    public void register(AlarmVO alarm) {
        mapper.insert(alarm);
    }

    @Override
    public AlarmVO get(Long alarm_message_id) {
        return mapper.read(alarm_message_id);
    }

    @Override
    public Long getFirstCriterionNumber(String user_id) {
        return mapper.getNewID(user_id);
    }

    @Override
    public void modify(Long alarm_message_id) {
        AlarmVO vo = mapper.read(alarm_message_id);
        mapper.update(vo.getAlarm_message_id());
    }

    @Override
    public String alarmCount(String user_id) {
        return mapper.count(user_id);
    }

    @Override
    public List<AlarmVO> getListWithPage(Criteria cri, String user_id) {
        return mapper.getListWithPaging(cri, user_id);
    }
}

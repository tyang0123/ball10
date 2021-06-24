package com.ball.service;

import com.ball.vo.AlarmVO;
import com.ball.vo.Criteria;

import java.util.List;

public interface AlarmService {
    public void register(AlarmVO alarm);
    public AlarmVO get(Long alarm_message_id);
    public Long getFirstCriterionNumber(String user_id);
    public void modify(Long alarm_message_id);
    public String alarmCount(String user_id);
    public List<AlarmVO> getListWithPage(Criteria cri,String user_id);
}

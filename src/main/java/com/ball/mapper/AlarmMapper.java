package com.ball.mapper;

import com.ball.vo.AlarmVO;
import com.ball.vo.Criteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AlarmMapper {
    public void insert(AlarmVO alarm); //알람생성
    public AlarmVO read(Long alarm_message_id); //읽음 처리를 하기위한 하나를 불러온다
    public Long getNewID(String user_id); //유저아이디로 그 사람의 알람리스트중 최신 알람id를 가져온다
    public void update(Long alarm_message_id); //읽음처리
    public String count(String user_id);//안읽은 알람갯수 확인

    //페이징처리
    public List<AlarmVO> getListWithPaging(@Param("cri") Criteria cri,@Param("user_id") String user_id);
}

package com.ball.mapper;

import com.ball.vo.ScheduleVO;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface ScheduleMapper {
    //스케쥴 하나 조회
    public ScheduleVO getSchedule(Long schedule_id);

    //유저별 전체 스케쥴 리스트
    public List<ScheduleVO> getScheduleUser(String user_id);

    //날짜별 스케쥴 리스트
    public List<ScheduleVO> getScheduleDate(@Param("schedule_date") Date date, @Param("user_id") String user_id);

    //날짜별 스케쥴 갯수 확인
    public String getScheduleDateCount(@Param("schedule_date") Date date, @Param("user_id") String user_id);

    //스케쥴 추가하기
    public void addSchedule(ScheduleVO vo);

    //스케쥴 수정하기
    public void updateSchedule(ScheduleVO vo);

    //스케쥴 삭제
    public void deleteSchedule(Long schedule_id);
}

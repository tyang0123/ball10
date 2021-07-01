package com.ball.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleVO {
    private Long schedule_id;
    private String user_id;
    private Date schedule_date;
    private String schedule_time;
    private String schedule_content;
}

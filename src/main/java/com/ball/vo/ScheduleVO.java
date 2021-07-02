package com.ball.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleVO {
    private Long schedule_id;
    private String user_id;
    private LocalDate schedule_date;
    private LocalTime schedule_time;
    private String schedule_content;
    private LocalDateTime schedule_reg_date;
    private LocalDateTime schedule_mod_date;
}

package com.ball.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.time.LocalTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TimerVO {
    private Long timer_id;
    private String user_id;
    private String user_nickname;
    private LocalDateTime timer_date;
    private LocalTime timer_accumulated_day;
    private int timer_is_play;
    private LocalDateTime timer_reg_date;
    private LocalDateTime timer_mod_date;
}

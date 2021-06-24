package com.ball.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Setter
@Getter
@ToString
public class AlarmVO {
    private Long alarm_message_id;
    private String user_id;
    private String alarm_message_content;
    private Byte alarm_message_is_new;
    private Date alarm_message_reg_date;
    private Date alarm_message_mod_date;
}

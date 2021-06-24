package com.ball.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class GroupMessageVO {
    private Long group_message_id;
    private Long group_id;

    private String user_id;
    private String user_nickname;

    private String group_message_content;
    private LocalDateTime group_message_reg_date;
    private LocalDateTime group_message_mod_date;
}

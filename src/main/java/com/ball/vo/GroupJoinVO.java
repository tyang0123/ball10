package com.ball.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;
@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class GroupJoinVO {
    private Long group_user_relationship_id;
    private Long group_id;
    private String user_id;
    private LocalDateTime group_user_relationship_reg_date;
    private LocalDateTime group_user_relationship_mod_date;
}

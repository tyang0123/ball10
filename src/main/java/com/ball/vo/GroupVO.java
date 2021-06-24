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
public class GroupVO {
//    private String user_id;
    private Long group_id;

    private String user_id_group_header;
    private String user_nickname_group_header;

    private String group_name;
    private String group_category;
    private int group_is_secret;
    private String group_password;

    private int group_join_person_number;
    private int group_person_count;

    private String group_content;

    private LocalDateTime group_reg_date;
    private LocalDateTime group_mod_date;
}

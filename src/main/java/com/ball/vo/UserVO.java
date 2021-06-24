package com.ball.vo;

import lombok.*;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UserVO {
    private String user_id;
    private String user_password;
    private String user_nickname;
    private String user_email;
    private LocalDateTime user_reg_date;
    private LocalDateTime user_mod_date;
}
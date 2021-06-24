package com.ball.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class NoticeVO {
    private Long notice_id;
    private String notice_content;
    private Date notice_reg_date;
    private Date notice_mod_date;
}

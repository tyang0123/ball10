package com.ball.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
public class Criteria {
    //검색을 위해 기준이 되는 내용을 담는 클래스

    private String keyword; //검색을 위한 키워드
    private String category; //그룹 검색시 category
    private Long criterionNumber; //마지막으로 조회된 id값(group, groupMessage, notice, alarmMessage)
    private int amount; //한번에 조회될 list값

    public Criteria(){
        this(0L, 20);
    }
    public Criteria(Long criterionNumber, int amount){
        this.criterionNumber = criterionNumber;
        this.amount = amount;
    }

}

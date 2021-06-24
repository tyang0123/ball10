package com.ball.controller;

import com.ball.service.GroupMessageService;
import com.ball.vo.Criteria;
import com.ball.vo.GroupMessageVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

//가장 마지막 주소에 group_id 가 들어옵니다!
@RestController
@RequestMapping("/group/read/ajax/*")
@Slf4j
public class GroupMessageAjaxController {

    @Setter(onMethod_ = @Autowired)
    private GroupMessageService messageService;

    //메세지(댓글) 목록 확인
    @GetMapping("/list")
    public ResponseEntity<HashMap<String,Object>> readMessage(@RequestParam("group_id") Long group_id, Long criterionNumber, Model model){
        System.out.println("메세지 목록 확인: "+criterionNumber);

        Criteria cri = new Criteria();
        cri.setCriterionNumber(criterionNumber);

        HashMap<String,Object> hashMap = new HashMap<>();
        hashMap.put("list",messageService.groupMessageMoreRead(cri,group_id));

        return ResponseEntity.ok(hashMap);
    }

    @PostMapping("/new")
    public ResponseEntity<String> insert(@RequestParam("group_id") Long group_id,@RequestBody GroupMessageVO vo){
        System.out.println("들어오는지 확인");
        log.info("ReplyVO: "+vo);
        vo.setGroup_id(group_id);

        int insertCount = messageService.groupMessageInsert(vo);
        return insertCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    //메세지(댓글) 삭제
    @DeleteMapping("/delete")
    public ResponseEntity<String> deleteMessage(@RequestParam("group_message_id") Long group_message_id){
        System.out.println("메세지 삭제 확인 : "+group_message_id);

        return messageService.groupMessageDelete(group_message_id) == 1
                ? new ResponseEntity<>("success",HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
}

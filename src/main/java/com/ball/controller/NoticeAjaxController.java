package com.ball.controller;

import com.ball.service.NoticeService;
import com.ball.vo.Criteria;
import com.ball.vo.GroupMessageVO;
import com.ball.vo.NoticeVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@Slf4j
@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/ajax/notice")
public class NoticeAjaxController {

    @Setter(onMethod_=@Autowired)
    private NoticeService noticeService;


    @PostMapping("/list")
    public ResponseEntity<HashMap<String, Object>> noticeList(Long criterionNumber,String userID) throws Exception {

        Criteria cri = new Criteria(criterionNumber,10);
        HashMap<String, Object> result = new HashMap<>();
        // 공지 화면 출력
        result.put("userID",userID);
        result.put("list", noticeService.getListWithPage(cri));
        return ResponseEntity.ok(result);
    }
    @PostMapping("/add")
    public ResponseEntity<String> insert(Long notice_id, @RequestBody NoticeVO vo){
        System.out.println("들어오는지 확인");
        log.info("ReplyVO: "+vo);
        vo.setNotice_id(notice_id);

        int insertCount = noticeService.insertNotice(vo);
        return insertCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

}

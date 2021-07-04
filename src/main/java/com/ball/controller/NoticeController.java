package com.ball.controller;

import com.ball.service.NoticeService;
import com.ball.vo.Criteria;
import com.ball.vo.NoticeVO;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;


@Slf4j
@Controller
@RequestMapping("/notice/*")
public class NoticeController {

    @Setter(onMethod_=@Autowired)
    private NoticeService noticeService;

    @GetMapping("/list")
    public String list(HttpSession session, Long notice_id, Model model){
        //세션에서 userID 값 가져오기
        String userID = String.valueOf(session.getAttribute("userID"));
        System.out.println("session에서 가져온 값 : "+userID);

        Long criterionNumber = noticeService.noticeNewId();
        model.addAttribute("firstCriterionNumber", criterionNumber==null? 0: criterionNumber+1);
        model.addAttribute("userID",userID);
        model.addAttribute("notice", noticeService.readNotice(notice_id));
        return "notice/noticelist";
    }


}

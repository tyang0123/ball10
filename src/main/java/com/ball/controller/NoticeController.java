package com.ball.controller;

import com.ball.service.NoticeService;
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
import java.util.List;

@Controller
@Slf4j
@RequestMapping("/notice/*")
public class NoticeController {

    @Setter(onMethod_=@Autowired)
    private NoticeService service;

    @GetMapping("/list")
    //userCookie(userId), HttpSession
    public String list(HttpSession session, Model model){
        //세션에서 userID 값 가져오기
        String userID = String.valueOf(session.getAttribute("userID"));
        System.out.println("session에서 가져온 값 : "+userID);
//        System.out.println("cookei에서 가져온 값 : "+userId.getValue());

        model.addAttribute("noticeCount",service.getNoticeCount());
        model.addAttribute("userID",userID);
        model.addAttribute("list",service.readListNotice());
        return "notice/noticelist";
    }

    @ResponseBody
    @PostMapping("/add")
    public ResponseEntity<String> addNotice(@RequestBody NoticeVO vo){
        System.out.println("/notice/add 들어오는지 확인");
        log.info("NoticeVO: "+vo);

        int insertCount = service.insertNotice(vo);
        return insertCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
}

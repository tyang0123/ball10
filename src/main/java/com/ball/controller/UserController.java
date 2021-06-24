package com.ball.controller;

import com.ball.mail.service.MailService;
import com.ball.mail.vo.MailVO;
import com.ball.service.AlarmService;
import com.ball.service.TimerService;
import com.ball.service.UserService;
import com.ball.vo.Criteria;
import com.ball.vo.TimerVO;
import com.ball.vo.UserVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

@Controller
@Slf4j
@RequestMapping("/user/*")
public class UserController {
    @Setter(onMethod_=@Autowired)
    private AlarmService alarmService;

    @Setter(onMethod_= @Autowired)
    private UserService userService;

    @Setter(onMethod_=@Autowired )
    private TimerService timerService;

    @Setter(onMethod_=@Autowired )
    private MailService mailService;

    private String adminEmail;
    private String adminEmailPW;

    @GetMapping("/login")
    public String loginGet(){
        log.info("login get...............................");
        return "user/login";
    }

    private int remainSecondsFrom3AM(){
        Calendar cal = Calendar.getInstance();
        Date now = cal.getTime();

        if(cal.get(Calendar.HOUR_OF_DAY)>3) {
            cal.add(Calendar.DATE, 1);
        }
        cal.set(Calendar.HOUR_OF_DAY, 3);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        Date tomorrowDawn = cal.getTime();

        long diff = tomorrowDawn.getTime() - now.getTime();
        return (int)(diff/1000);
    }

    @PostMapping("/login")
    public String loginPost(UserVO userVO, boolean user_remember
            , RedirectAttributes rAttr, HttpSession session
            ,@CookieValue(name = "userCookie", required = false) Cookie userCookie
            ,@CookieValue(name = "JSESSIONID", required = false) Cookie JSESSIONID
            , HttpServletResponse res){
        log.info("login post..............................."+user_remember);
        //login-password DB check
        boolean checkLoginResult = userService.userLoginCheck(userVO.getUser_id(), userVO.getUser_password());

        if(! checkLoginResult){// id, password 불일치시 다시 login
            log.info("...........redirect fail");
            rAttr.addFlashAttribute("errorMessage", "fail");
            return "redirect:/user/login";
        }
        //add user info to session
        session.setAttribute("userID", userVO.getUser_id());


        //add user cookie
        if(userCookie!=null){
            userCookie.setMaxAge(0);
            res.addCookie(userCookie);
        }
        userCookie = new Cookie("userCookie", userVO.getUser_id());
//        userCookie.setSecure(true); 다른 엔트포인트에 쿠키전달이 안되서 true를 하면 안됨
        userCookie.setPath("/");
        userCookie.setMaxAge(60*60*24);

        //session id를 cookie에 저장(브라우저 종료후에도 유지되게)
        if(JSESSIONID!=null){
            JSESSIONID.setMaxAge(0);
            res.addCookie(JSESSIONID);
        }
        JSESSIONID = new Cookie("JSESSIONID",session.getId());
        JSESSIONID.setPath("/");
        JSESSIONID.setHttpOnly(true);
        JSESSIONID.setSecure(true);

        if(user_remember) { //로그인 상태 유지하면 userid를 쿠키에 저장함
            //보안을 위해 추후에 db에 세션ID와 userid를 DB에 저장하여 DB에서도 일치하는 여부를 따져봐야함
            userCookie.setMaxAge(60*60*24*365*10); //set cookie 10 years
            JSESSIONID.setMaxAge(60*60*24*180);

            session.setMaxInactiveInterval(60*60*24*180); // session은 6개월로  기본 세션 시간은 24시간 (web.xml 에 기술함)
        }
        res.addCookie(userCookie);
        res.addCookie(JSESSIONID);

        rAttr.addFlashAttribute("successLogin", "success");
        return "redirect:/user/login";
    }

    @GetMapping("/create")
    public String temp(){
        return "user/create";
    }

    @GetMapping("/user")
    public String userGet(HttpServletResponse response, HttpServletRequest request
            , @CookieValue(name = "timerCookie", required = false) Cookie timerCookie
            , Model model){
        log.info("userget........................................................");

        /// alarm 작성 부분
        String userID = String.valueOf(request.getSession().getAttribute("userID"));
        model.addAttribute("alarmCount",alarmService.alarmCount(userID));
        Long criterionNumber = alarmService.getFirstCriterionNumber(userID);
        model.addAttribute("firstCriterionNumber", criterionNumber==null? 0: criterionNumber+1);
        model.addAttribute("userID",userID);
        model.addAttribute("userJoinGroupList",userService.userJoinGroupList(userID));
        model.addAttribute("nickName",userService.getUserNickname(userID));

        //add timer cookie
        if(timerCookie != null) {
            timerCookie.setMaxAge(0);
        }
        timerCookie = new Cookie("timerCookie", "");
        timerCookie.setMaxAge(remainSecondsFrom3AM());
        timerCookie.setSecure(false);
        timerCookie.setPath("/");
        TimerVO timerVO = timerService.addNewTimerToDataBaseIfNotExist(userID);

        if(timerVO != null && timerVO.getTimer_accumulated_day() != null){ //오늘 2번이상 접속해서 timer정보가 있는 경우
            timerCookie.setValue(timerVO.getTimer_id()+"-"+timerVO.getTimer_is_play()+"-"
                    +timerVO.getTimer_accumulated_day().format(DateTimeFormatter.ofPattern("HH:mm:ss")));
        }else{ //오늘 처음 접속해서 타이머 정보가 없는 경우
            timerCookie.setValue(timerVO.getTimer_id()+"-0-00:00:00");
        }
        response.addCookie(timerCookie);

        return "user/user";
    }


    @GetMapping("/findID")
    public void findIDGet(){}

    @GetMapping("/findPassword")
    public void findPasswordGet(){}

    private boolean prepareSendingAdminEmail(){
        UserVO emailVO = userService.getAdminEmailAndPW();
        if(emailVO == null) return false;
        adminEmail = emailVO.getUser_email();
        adminEmailPW = emailVO.getUser_password();
        mailService.setSendEmailID(adminEmail,adminEmailPW);
        return true;
    }

    @PostMapping("/findID")
    public String findIDPostSendEmailID(String user_email
            , RedirectAttributes rAttr){
        log.info("user findIDPostSendEmailID..................................."+user_email);

        String userID = userService.getUserId(user_email);

        if(userID == null){
            rAttr.addFlashAttribute("sendID", "등록된 이메일이 없습니다. 확인 후 다시 입력하여 주세요.");
            return "redirect:/user/findID";
        }

        ///// 매칭되면 ID값을 이메일로 보내기
        if(adminEmail == null){
            log.info("admin email Setting..................");
            if(!prepareSendingAdminEmail()){
                rAttr.addFlashAttribute("sendID", "오류가 발생했습니다. 관리자에게 문의해주세요. 1");
                return "redirect:/user/findID";
            }
        }

        MailVO vo = new MailVO();
        vo.setReceive(user_email);
        vo.setSubject("10-0사이트의 회원님의 ID를 전달합니다.");
        vo.setContent("회원님의 ID는 < "+userID+" >입니다. 10-0에서 로그인을 해주시길 바랍니다.\n https://10-0.imweb.me/");

        if(!mailService.sendEmail(vo)){
            rAttr.addFlashAttribute("sendID", "오류가 발생했습니다. 관리자에게 문의해주세요. 2");
            return "redirect:/user/findID";
        };

        rAttr.addFlashAttribute("sendID", "이메일로 ID를 전송하였습니다.");
        return "redirect:/user/login";
    }

}

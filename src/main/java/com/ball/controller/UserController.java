package com.ball.controller;

import com.ball.mail.service.MailService;
import com.ball.mail.vo.MailVO;
import com.ball.service.AlarmService;
import com.ball.service.TimerService;
import com.ball.service.UserService;
import com.ball.vo.AlarmVO;
import com.ball.vo.TimerVO;
import com.ball.vo.UserVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

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

        if(cal.get(Calendar.HOUR_OF_DAY)>=3 && cal.get(Calendar.SECOND)>=1) {
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

    @GetMapping("/logout")
    public String loginPost(HttpSession session
            , @CookieValue(name = "userCookie", required = false) Cookie userCookie
            , @CookieValue(name = "JSESSIONID", required = false) Cookie JSESSIONID
            , @CookieValue(name = "timerCookie", required = false) Cookie timerCookie
            , HttpServletResponse res) {

        if(JSESSIONID != null) {
            JSESSIONID = new Cookie("JSESSIONID", null);
            JSESSIONID.setMaxAge(0);
            JSESSIONID.setSecure(true);
            JSESSIONID.setHttpOnly(true);
            JSESSIONID.setPath("/");

            res.addCookie(JSESSIONID);
        }
        if(userCookie != null) {
            userCookie = new Cookie("userCookie", null);
            userCookie.setMaxAge(0);
            userCookie.setSecure(true);
            userCookie.setHttpOnly(true);
            userCookie.setPath("/");

            res.addCookie(userCookie);
        }
        if(timerCookie != null){
            timerCookie = new Cookie("timerCookie", null);
            timerCookie.setMaxAge(0);
            timerCookie.setSecure(true);
            timerCookie.setHttpOnly(true);
            timerCookie.setPath("/");

            res.addCookie(timerCookie);
        }
        session.setMaxInactiveInterval(1);
        return "redirect:/";
    }
    @GetMapping("/create")
    public String tempCreate(){
        return "user/create";
    }
    @PostMapping("/create")
    public String create(UserVO vo, RedirectAttributes rAttr){

        //아이디 중복 조회
        boolean Idcheck = userService.idCheck(vo.getUser_id());
        if(! Idcheck){// id가 존재할때 다시 회원가입 페이지로
            rAttr.addFlashAttribute("idFail", "fail");
            rAttr.addFlashAttribute("writing", vo);
            return "redirect:/user/create";
        }

        //이메일 중복 조회
        boolean emailcheck = userService.emailCheck(null,vo.getUser_email());
        if(! emailcheck){// 이메일이 존재할때 다시 회원가입 페이지로
            rAttr.addFlashAttribute("emailFail", "fail");
            rAttr.addFlashAttribute("writing", vo);
            return "redirect:/user/create";
        }

        rAttr.addFlashAttribute("successCreate", "success");

        AlarmVO alarmMessageVO = new AlarmVO();
        alarmMessageVO.setUser_id(vo.getUser_id());
        alarmMessageVO.setAlarm_message_is_new((byte)1);
        alarmMessageVO.setAlarm_message_content("10-0에 합류한 것에 감사드립니다. 저희와 함께 <열공>하여 꿈을 이루시길 바랍니다. 😘");
        //////////////////////.//////
        userService.userCreate(vo, alarmMessageVO);
        return "redirect:/user/login";
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


        try {
            TimerVO timerVO = timerService.addNewTimerToDataBaseIfNotExist(userID);



            Boolean resetCookie = true;
            //add timer cookie
            if (timerCookie != null && timerCookie.getValue() != null) {
                // cookie값이 있고, timer_id값이 동일하고, accumulate값이 크면 db값을 반영하지 않는다.
                String[] cookieContent = timerCookie.getValue().split("-");
                Long cookieTimerId = Long.valueOf(cookieContent[0]);
                LocalTime cookieTimerAccumulatedTime = LocalTime.parse(cookieContent[2]);


//                System.out.println(timerVO.getTimer_id() +" "+ cookieTimerId);
//                System.out.println(!timerVO.getTimer_accumulated_day().isAfter(cookieTimerAccumulatedTime));
                //타이머 id가 다르거나, db누적시간이 타이머 시간보다 많을 경우 cookie를 db누적시간을 리셋한다.
                if(timerVO.getTimer_id().equals(cookieTimerId)
                        && !timerVO.getTimer_accumulated_day().isAfter(cookieTimerAccumulatedTime)){
                    resetCookie = false;
                }
            }

            if(resetCookie) {
                if(timerCookie != null){
                    timerCookie.setMaxAge(0);
                }
                System.out.println("cookie reset");
                timerCookie = new Cookie("timerCookie", "");
                timerCookie.setMaxAge(remainSecondsFrom3AM());
                timerCookie.setSecure(false);
                timerCookie.setPath("/");

                if (timerVO != null && timerVO.getTimer_accumulated_day() != null) { //오늘 2번이상 접속해서 timer정보가 있는 경우
                    timerCookie.setValue(timerVO.getTimer_id() + "-" + timerVO.getTimer_is_play() + "-"
                            + timerVO.getTimer_accumulated_day().format(DateTimeFormatter.ofPattern("HH:mm:ss")));
                } else { //오늘 처음 접속해서 타이머 정보가 없는 경우
                    timerCookie.setValue(timerVO.getTimer_id() + "-0-00:00:00");
                }
                response.addCookie(timerCookie);
            }
        }catch (Exception e){
            log.warn(e.getMessage());
            return "redirect:/user/login";
        }

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
            rAttr.addFlashAttribute("sendID", "등록되어 있지 않은 이메일입니다.");
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

    private String getRandomStringForPassword(){
        // small letter and numeral
        int leftLimit = 48; // numeral '0'
        int rightLimit = 122; // letter 'z'
        int targetStringLength = 12;
        Random random = new Random();

        String generatedString = random.ints(leftLimit, rightLimit + 1)
                .filter(i -> i <= 57 || i >= 97)
                .limit(targetStringLength)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();

        return generatedString;
    }

    @PostMapping("/findPassword")
    public String findPasswordPostSendEmailID(String user_id
            ,String user_email
            , RedirectAttributes rAttr){
        log.info("user findIDPostSendEmailID..................................."+user_id+" "+user_email);


        if(userService.emailCheck(user_id,user_email)){ // 일치하는 정보가 있으면 false가 리턴됨
            rAttr.addFlashAttribute("sendID", "등록된 정보가 없습니다. 확인 후 다시 입력하여 주세요.");
            return "redirect:/user/findPassword";
        }

        ///// 매칭되면 Password랜덤으로 만들어서 이메일 전송  전송 성공하면 db에 업데이트
        if(adminEmail == null){
            log.info("admin email Setting..................");
            if(!prepareSendingAdminEmail()){
                rAttr.addFlashAttribute("sendID", "오류가 발생했습니다. 관리자에게 문의해주세요. 1");
                return "redirect:/user/findPassword";
            }
        }

        String newPassword = getRandomStringForPassword();

        MailVO vo = new MailVO();
        vo.setReceive(user_email);
        vo.setSubject("10-0사이트의 회원님의 비밀번호를 전달합니다.");
        vo.setContent("회원님의 ID는 < "+newPassword+" >입니다. 10-0에서 로그인을 해주시길 바랍니다.\n" +
                "로그인 후 비밀번호를 수정해 주세요.\n https://10-0.imweb.me/");

        if(!mailService.sendEmail(vo) || !userService.resetPasswordToDbByUserID(user_id, newPassword)){
            rAttr.addFlashAttribute("sendID", "오류가 발생했습니다. 관리자에게 문의해주세요. 2");
            return "redirect:/user/findPassword";
        }
        rAttr.addFlashAttribute("sendID", "이메일로 비밀번호를 전송하였습니다.");
        return "redirect:/user/login";
    }

    @GetMapping("/modify")
    public String tempModify(Model model, HttpServletRequest request){
        String userID = String.valueOf(request.getSession().getAttribute("userID"));
        model.addAttribute("userInfo",userService.userRead(userID));
        return "user/modify";
    }

    @PostMapping("/modify")
    public String modify(UserVO vo, RedirectAttributes rAttr){

        //이메일 중복 조회
        boolean emailcheck = userService.emailCheck(vo.getUser_id(),vo.getUser_email());
        if(! emailcheck){// 이메일이 존재할때 다시 회원 수정 페이지로
            rAttr.addFlashAttribute("emailFail", "fail");
            return "redirect:/user/modify";
        }

        rAttr.addFlashAttribute("successModify", "success");
        userService.userModify(vo);
        return "redirect:/user/user";
    }

    @GetMapping("/calendar")
    public void userCalendar(){}
}

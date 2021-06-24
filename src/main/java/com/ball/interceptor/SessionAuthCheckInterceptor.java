package com.ball.interceptor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Slf4j
public class SessionAuthCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response
            , Object handler) throws Exception {

        log.info("SessionAuthCheckInterceptor preHandle+++++++++++++++++++++++++++++++++++++++++++++");
        HttpSession session = request.getSession(false);

        if(session != null) {
            // get user session
            Object obj = session.getAttribute("userID");
            String sessionID = session.getId();
            log.info("sessionID : "+sessionID);
            Cookie[] cookies = request.getCookies();

            if(obj != null && cookies !=null && cookies.length >0){
                log.info("userid session && cookies 2 :"+ obj);
                // Auth관련 cookie가져오기
                Cookie userCookie = null;
                Cookie JSESSIONID = null;
                for (Cookie c : cookies) {
                    System.out.println(c.getName()+" "+c.getValue());
                    if ("userCookie".equals(c.getName())){
                        userCookie = c;
                    }
                    if ("JSESSIONID".equals(c.getName())){
                        JSESSIONID = c;
                    }
                }
                System.out.println(userCookie + "---"+JSESSIONID);
                // JSESSIONID 의 값이 session ID와 일치하고, 
                // session의 user_id와 cookie의 user_id가 일치하면
                // auth는 통과
                if( JSESSIONID != null && userCookie !=null) {
                    log.info("JSESSIONID - session.getId :"+ JSESSIONID.getValue() + " "+session.getId());
                    log.info("userCookie - obj :"+ userCookie.getValue() + " "+String.valueOf(obj));
                    System.out.println(  userCookie.getValue().equals( String.valueOf(obj) ) );
                    System.out.println(  JSESSIONID.getValue().equals(session.getId() ) );
                    if (userCookie.getValue().equals(String.valueOf(obj))
                            && JSESSIONID.getValue().equals(session.getId() )) {
                        log.info("user Session is existed.............");
                        return true;
                    }
                }
            }
        }

        // not session and cookie => /home /login이 경로인지 확인
        String reqURI = request.getRequestURI();
        System.out.println("false"+reqURI);

        response.sendRedirect(request.getContextPath() + "/user/login");
        return false;
    }
}

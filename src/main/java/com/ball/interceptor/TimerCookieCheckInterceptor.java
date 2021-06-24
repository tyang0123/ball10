package com.ball.interceptor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Enumeration;

@Slf4j
public class TimerCookieCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {

        log.info("TimerCookieInterceptor preHandle+++++++++++++++++++++++++++++++++++++++++++++");

        Cookie[] cookies = request.getCookies();
        log.info("cookie number: "+ ((cookies !=null) ? cookies.length:null ));

        if(cookies !=null && cookies.length >0) {
            // get timer cookie
            Cookie timerCookie = null;
            if (cookies != null) {
                for (Cookie c : cookies) {
                    System.out.println(c.getName()+" "+c.getValue());
                    if ("timerCookie".equals(c.getName())) {
                        timerCookie = c;
                        break;
                    }
                }
                if(timerCookie != null){
                    log.info("user Timer is existed.............");
                    return true;
                }
            }
        }

        // not session and cookie => /home /login이 경로인지 확인
        String reqURI = request.getRequestURI();

        System.out.println("false"+reqURI);
        response.sendRedirect(request.getContextPath() + "/user/user");
        return false;
    }
}

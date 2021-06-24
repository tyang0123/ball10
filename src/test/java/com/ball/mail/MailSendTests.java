package com.ball.mail;

import com.ball.mail.service.MailService;
import com.ball.mail.vo.MailVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MailSendTests {
    @Setter(onMethod_=@Autowired)
    private MailService mailService;

    @Test
    public void testAutowired(){
        System.out.println(mailService);
    }

    @Test
    public void testSendEmail(){
        MailVO mailVO = new MailVO();
        mailVO.setReceive("romi115@naver.com");
        mailVO.setSubject("java test 입니다.");
        mailVO.setContent("test ~~~~~~~~~~~~~~~~~~~~~~~ 성공할까나??????");

        mailService.setSendEmailID("tenball2021pjt@gmail.com", "123ball2021");
        mailService.sendEmail(mailVO);
    }
}

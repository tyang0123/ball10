package com.ball.mail.service;

import com.ball.mail.vo.MailVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@Slf4j
@Service
public class MailServiceImpl implements MailService{

    @Setter(onMethod_= @Autowired)
    private JavaMailSender mailSender;

    @Override
    public boolean sendEmail(MailVO mailVO) {
        if(((JavaMailSenderImpl)mailSender).getUsername() == null){
            return false;
        }
        MimeMessage msg = mailSender.createMimeMessage();
        try{
            msg.setSubject(mailVO.getSubject());
            msg.setText(mailVO.getContent());
            msg.setFrom(new InternetAddress(((JavaMailSenderImpl)mailSender).getUsername()));
            msg.setRecipients(MimeMessage.RecipientType.TO
                    , InternetAddress.parse(mailVO.getReceive()));
        } catch (MessagingException e) {
            log.error("make Message Exception");
            e.printStackTrace();
            return false;
        }

        try{
            log.info("send mail.......................................................");
            mailSender.send(msg);
        }catch (MailException e){
            log.error("send mail exception");
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public void setSendEmailID(String username, String password) {
        //db에서 조회한 메일주소와 패스워드를 입력함
        ((JavaMailSenderImpl)mailSender).setUsername(username);
        ((JavaMailSenderImpl)mailSender).setPassword(password);
    }
}

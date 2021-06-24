package com.ball.mail.service;

import com.ball.mail.vo.MailVO;

public interface MailService {
    public boolean sendEmail(MailVO mailVO);

    public void setSendEmailID(String username, String password);
}

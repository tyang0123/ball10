package com.ball.service;

import com.ball.vo.NoticeVO;
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
public class NoticeServiceTests {
    @Setter(onMethod_ = @Autowired)
    private NoticeService service;

    @Test
    public void testInsertNotice(){
        NoticeVO noticeVO = new NoticeVO();
        noticeVO.setNotice_content("서비스에서 테스트");

        service.insertNotice(noticeVO);
        System.out.println("서비스에서 insert 확인 : "+noticeVO);
    }

    @Test
    public void testReadListNotice(){
        service.readListNotice().forEach(notice -> System.out.println(notice));
    }

    @Test
    public void testReadNotice(){
        System.out.println(service.readNotice(2L));
    }

    @Test
    public void testDeleteNotice(){
        service.deleteNotice(2L);
    }

    @Test
    public void testUpdateNotice(){
        NoticeVO noticeVO = new NoticeVO();
        noticeVO.setNotice_id(3L);
        noticeVO.setNotice_content("서비스에서 업데이트 테스트");
        service.updateNotice(noticeVO);
        System.out.println(noticeVO);
    }

    @Test
    public void testGetNoticeCount(){
        System.out.println(service.getNoticeCount());
    }
}

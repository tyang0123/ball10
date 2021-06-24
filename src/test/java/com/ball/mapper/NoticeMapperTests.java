package com.ball.mapper;

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
public class NoticeMapperTests {
    @Setter(onMethod_=@Autowired)
    private NoticeMapper mapper;

    @Test
    public void testNoticeReadList(){
        System.out.println(mapper.noticeReadList());
    }
    @Test
    public void testNoticeInsert(){
        NoticeVO noticeVO = new NoticeVO();
        noticeVO.setNotice_content("tytestnotice4");
        mapper.noticeInsert(noticeVO);
        System.out.println(noticeVO);
    }

    @Test
    public void testNoticeRead(){
        NoticeVO noticeVO = mapper.noticeRead(1L);
        System.out.println(noticeVO);
    }

    @Test
    public void testNoticeDelete(){
        System.out.println("삭제됨 : "+mapper.noticeDelete(1L));
    }

    @Test
    public void testNoticeUpdate(){
        NoticeVO noticeVO = new NoticeVO();
        noticeVO.setNotice_id(2L);
        noticeVO.setNotice_content("TYnotice Update");
        mapper.noticeUpdate(noticeVO);
        System.out.println("업데이트 : "+noticeVO);
    }

    @Test
    public void testNoticeCount(){
        System.out.println(mapper.noticeCount());
    }
}

package com.ball.mapper;

import com.ball.vo.Criteria;
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
    public void testNoticeReadNew(){
        System.out.println(mapper.noticeReadNew());
    }

    @Test
    public void testGetListWithPaging(){
        Criteria cri = new Criteria();
        cri.setCriterionNumber(5L);
        mapper.getListWithPaging(cri).forEach(i -> System.out.println(i));
    }

    @Test
    public void testNoticeInsert(){
        NoticeVO noticeVO = new NoticeVO();
        noticeVO.setNotice_content("날짜 수정 notice");
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
        System.out.println("삭제됨 : "+mapper.noticeDelete(6L));
    }

    @Test
    public void testNoticeUpdate(){
        NoticeVO noticeVO = new NoticeVO();
        noticeVO.setNotice_id(7L);
        noticeVO.setNotice_content("수정이 되나");
        mapper.noticeUpdate(noticeVO);
        System.out.println("업데이트 : "+noticeVO);
    }

}

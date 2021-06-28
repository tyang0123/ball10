package com.ball.service;

import com.ball.vo.AlarmVO;
import com.ball.vo.Criteria;
import com.ball.vo.NoticeVO;

import java.util.List;

public interface NoticeService {
    public int insertNotice(NoticeVO noticeVO);
    public NoticeVO readNotice(Long notice_id);
    public void updateNotice(NoticeVO noticeVO); //update, delete 는 책에서 boolean 으로 해줬지만 void 로 진행하겠습니다.
    public void deleteNotice(Long notice_id);
    public Long noticeNewId(); //최신 공지사항id를 가져온다
    public List<NoticeVO> getListWithPage(Criteria cri);//notice 페이지에 보여줄 리스트
}

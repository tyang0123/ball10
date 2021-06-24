package com.ball.service;

import com.ball.vo.NoticeVO;

import java.util.List;

public interface NoticeService {
    public int insertNotice(NoticeVO noticeVO);
    public NoticeVO readNotice(Long notice_id); //게시글 클릭하면 모달창 뜨는 부분
    public void updateNotice(NoticeVO noticeVO); //update, delete 는 책에서 boolean 으로 해줬지만 void 로 진행하겠습니다.
    public void deleteNotice(Long notice_id);
    public List<NoticeVO> readListNotice(); //notice 페이지에 보여줄 리스트

    public int getNoticeCount();
}

package com.ball.service;

import com.ball.mapper.NoticeMapper;
import com.ball.vo.NoticeVO;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService{

    @Setter(onMethod_ = @Autowired)
    private NoticeMapper mapper;

    @Override
    public int insertNotice(NoticeVO noticeVO) {
        return mapper.noticeInsert(noticeVO);
    }

    @Override
    public NoticeVO readNotice(Long notice_id) {
        return mapper.noticeRead(notice_id);
    }

    @Override
    public void updateNotice(NoticeVO noticeVO) {
        mapper.noticeUpdate(noticeVO);
    }

    @Override
    public void deleteNotice(Long notice_id) {
        mapper.noticeDelete(notice_id);
    }

    @Override
    public List<NoticeVO> readListNotice() {
        return mapper.noticeReadList();
    }

    @Override
    public int getNoticeCount() {
        return mapper.noticeCount();
    }
}

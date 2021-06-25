package com.ball.mapper;

import com.ball.vo.AlarmVO;
import com.ball.vo.Criteria;
import com.ball.vo.NoticeVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NoticeMapper {
    public Long noticeReadNew(); //최신 공지사항id를 가져온다
    public int noticeInsert(NoticeVO notice); //공지추가 (이후 admin 만 추가 할 수 있도록 설정)
    public NoticeVO noticeRead(Long notice_id); //공지 제목 클릭하면 모달로 보이게 하기
    public int noticeDelete(Long notice_id); //공지삭제 (이후 admin 만 삭제 할 수 있도록 설정) + 모달창 내에서 할 수 있도록
    public void noticeUpdate(NoticeVO noticeVO); //공지수정 (이후 admin 만 수정 할 수 있도록 설정) + 모달창 내에서 할 수 있도록

    //페이징처리
    public List<NoticeVO> getListWithPaging(@Param("cri") Criteria cri);
}

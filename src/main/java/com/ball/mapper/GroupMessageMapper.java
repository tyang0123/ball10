package com.ball.mapper;

import com.ball.vo.Criteria;
import com.ball.vo.GroupMessageVO;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

public interface GroupMessageMapper {
    public int insertGroupMessage(GroupMessageVO vo); //그룹 메세지 입력
    public int deleteGroupMessage(Long group_message_id); //해당 그룹 메세지만 삭제 할 수 있도록
    public List<GroupMessageVO> readGroupMessage(Long group_id); //처음에 보일 그룹 메세지

    //페이징처리
    public List<GroupMessageVO> readGroupMessagePaging(@Param("limit") int limit, @Param("group_id") Long group_id);
    //작성한 댓글 카운트
    public int countGroupMessage(Long group_id);
}

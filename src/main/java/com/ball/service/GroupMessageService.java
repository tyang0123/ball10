package com.ball.service;

import com.ball.vo.Criteria;
import com.ball.vo.GroupMessageVO;

import java.util.HashMap;
import java.util.List;

public interface GroupMessageService {
    public int groupMessageInsert(GroupMessageVO vo);
    public int groupMessageDelete(Long group_message_id);
    public List<GroupMessageVO> groupMessageRead(Long group_id);

    public List<GroupMessageVO> groupMessageMoreRead(int limit, Long group_id);
    public int getGroupMessageCnt(Long group_id);
}

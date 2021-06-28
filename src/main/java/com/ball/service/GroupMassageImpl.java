package com.ball.service;

import com.ball.mapper.GroupMessageMapper;
import com.ball.vo.Criteria;
import com.ball.vo.GroupMessageVO;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class GroupMassageImpl implements GroupMessageService{
    @Setter(onMethod_=@Autowired)
    private GroupMessageMapper mapper;

    @Override
    public int groupMessageInsert(GroupMessageVO vo) {
        return mapper.insertGroupMessage(vo);
    }

    @Override
    public int groupMessageDelete(Long group_message_id) {
        return mapper.deleteGroupMessage(group_message_id);
    }

    @Override
    public List<GroupMessageVO> groupMessageRead(Long group_id) {
        return mapper.readGroupMessage(group_id);
    }

    @Override
    public List<GroupMessageVO> groupMessageMoreRead(int limit, Long group_id) {
        return mapper.readGroupMessagePaging(limit,group_id);
    }

}

package com.ball.service;

import com.ball.mapper.AlarmMapper;
import com.ball.mapper.GroupMapper;
import com.ball.mapper.GroupMessageMapper;
import com.ball.mapper.UserMapper;
import com.ball.vo.*;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class GroupServiceImpl implements GroupService{
    @Setter(onMethod_=@Autowired)
    private GroupMapper mapper;

    @Setter(onMethod_=@Autowired)
    private GroupMessageMapper messageMapper;

    @Setter(onMethod_ = @Autowired)
    private UserMapper userMapper;

    @Setter(onMethod_ = @Autowired)
    private AlarmMapper alarmMapper;

    @Transactional
    @Override
    public GroupVO register(GroupVO group, String user_id) {
        mapper.insertGroup(group);
        GroupJoinVO vo = new GroupJoinVO();
        vo.setUser_id(user_id);
        vo.setGroup_id(group.getGroup_id());
        mapper.joinGroup(vo);
        return group;
    }

    @Override
    public GroupVO oneRead(Long group_id) {
        return mapper.groupRead(group_id);
    }

    @Override
    public List<GroupVO> allRead(Criteria cri) {
        return mapper.selectGroupList(cri);
    }

    @Override
    public void modify(GroupVO group) {
        mapper.groupUpdate(group);
    }

    @Transactional
    @Override
    public int groupRemove(Long group_id, String groupDestroyMessage) {
        alarmMapper.insertMessagesGroupDestroyToUsers(group_id, groupDestroyMessage);
        messageMapper.deleteGroupMessageByGroupID(group_id);
        mapper.joinDelete(group_id);
        return mapper.groupDelete(group_id);
    }

    @Override
    @Transactional
    public int userRemove(Long group_id, String user_id, AlarmVO alarmVO, AlarmVO alarmVOjoin) {

        GroupVO groupVO = mapper.groupRead(group_id);
        UserVO leaveUserVO = userMapper.getUser(user_id);

        alarmVO.setUser_id(groupVO.getUser_id_group_header());
        alarmVO.setAlarm_message_is_new((byte)1);
        alarmVO.setAlarm_message_content(leaveUserVO.getUser_nickname()+"????????? "+groupVO.getGroup_name()
                +" ????????? ?????????????????????.???? ????????? ?????? Keep Going ?????????????????? ");

        alarmVOjoin.setUser_id(user_id);
        alarmVOjoin.setAlarm_message_is_new((byte)1);
        alarmVOjoin.setAlarm_message_content(groupVO.getGroup_name()
                +" ???????????? ?????????????????????.????");

        alarmMapper.insert(alarmVO);
        alarmMapper.insert(alarmVOjoin);
        return mapper.joinOneDelete(group_id, user_id);
    }

    @Override
    @Transactional
    public void joinGroup(GroupJoinVO join, AlarmVO alarmVO, AlarmVO alarmVOjoin) {
        GroupVO groupVO = mapper.groupRead(join.getGroup_id());
        UserVO newUserVO = userMapper.getUser(join.getUser_id());

        alarmVO.setUser_id(groupVO.getUser_id_group_header());
        alarmVO.setAlarm_message_is_new((byte)1);
        alarmVO.setAlarm_message_content(newUserVO.getUser_nickname()+"????????? "+groupVO.getGroup_name()
                +" ????????? ?????????????????????.???? ????????? ???????????? ???????????????! ????");

        alarmVOjoin.setUser_id(join.getUser_id());
        alarmVOjoin.setAlarm_message_is_new((byte)1);
        alarmVOjoin.setAlarm_message_content(groupVO.getGroup_name()
                +" ????????? ?????????????????????.???? ????????? ??????!??????! ????");

        mapper.joinGroup(join);
        alarmMapper.insert(alarmVO);
        alarmMapper.insert(alarmVOjoin);
    }

//    @Override
//    public int getTotal(Criteria cri) {
//        System.out.println("??????????????? ??? ????????? ????????? : "+ cri);
//        return 0;
//    }

    @Override
    public int joinAllRead(Long group_id, String user_id) {

        return mapper.joinAllRead(group_id, user_id);
    }

    @Override
    public String passwordCheck(Long group_id) {
        return mapper.passwordCheck(group_id);
    }

    @Override
    public List<Integer> getUserJoinedGroupId(String user_id) {
        return mapper.userJoinedGroupId(user_id);
    }


}

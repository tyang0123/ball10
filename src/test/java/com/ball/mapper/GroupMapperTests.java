package com.ball.mapper;


import com.ball.vo.Criteria;
import com.ball.vo.GroupJoinVO;
import com.ball.vo.GroupVO;
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
public class GroupMapperTests {

    @Setter(onMethod_ =@Autowired)
    private GroupMapper mapper;

    @Test
    public void testAutowired(){
        System.out.println("-----------------------------");
        System.out.println(mapper);
    }

    @Test
    public void testInsertGroup(){
        GroupVO vo = new GroupVO();

        vo.setUser_id_group_header("user10");
        vo.setGroup_name("테스트 그룹 이름");
        vo.setGroup_category("입시");
        vo.setGroup_is_secret(0);
        vo.setGroup_person_count(10);
        vo.setGroup_content("테스트 그룹을 생성합니다. 카테고리는 입시입니다. 테스트합니다. 테스트!!!!!!!!!!!!!!");

        mapper.insertGroup(vo);
    }
    @Test
    public void testRead(){
        GroupVO vo = mapper.groupRead(24L);
        System.out.println("===================");
        System.out.println(vo);
    }


    @Test
    public void testSelectGroupList(){
        Criteria cri = new Criteria();

        for (GroupVO groupVO : mapper.selectGroupList(cri)) {
            System.out.println(groupVO);
        }

        System.out.println("++++++++++++++++++++++++++++++++++++++++++");
        cri.setCriterionNumber(11L);
        cri.setAmount(5);
        for (GroupVO groupVO : mapper.selectGroupList(cri)) {
            System.out.println(groupVO);
        }

        System.out.println("++++++++++++++++++++++++++++++++++++++++++");
        System.out.println("카테고리에 들어오나");
        cri.setCategory("자격증");
        for (GroupVO groupVO : mapper.selectGroupList(cri)) {
            System.out.println(groupVO);
        }

        System.out.println("++++++++++++++++++++++++++++++++++++++++++");
        cri.setKeyword("댕댕");
        cri.setCategory("취업");
        for (GroupVO groupVO : mapper.selectGroupList(cri)) {
            System.out.println(groupVO);
        }
    }

    @Test
    public void testUpdateUser(){
        GroupVO vo = new GroupVO();
        vo.setGroup_id(2L);
        vo.setGroup_name("테스트 그룹 이름");
        vo.setGroup_category("공부카테고리");
        vo.setGroup_is_secret(0);
//        vo.setGroup_password("1234");
        vo.setGroup_person_count(7);
        vo.setGroup_content("수정이 되나");

        mapper.groupUpdate(vo);
    }

    @Test
    public void testDelete(){
        mapper.groupDelete(27L);
        System.out.println("========== 삭제 되었습니다 ==========");
    }

    @Test
    public void testJoin(){
        GroupJoinVO vo = new GroupJoinVO();
        vo.setGroup_id(3L);
        vo.setUser_id("user5");
        mapper.joinGroup(vo);
        System.out.println("==== 유저 5번이 3번방에 들어갔나 ====");
    }

    @Test
    public void testCount() {
        Criteria cri = new Criteria();
    }


    @Test
    public void testGroupCheck(){

        System.out.println(mapper.joinAllRead(24L,"user7"));
        System.out.println("전체 갯수는 ? :");
    }

    @Test
    public void password(){
        System.out.println(mapper.passwordCheck(40L));
    }

}

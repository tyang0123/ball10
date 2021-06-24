package com.ball.controller;


import com.ball.service.GroupService;
import com.ball.vo.Criteria;
import com.ball.vo.GroupVO;
import com.ball.service.UserService;
import com.ball.vo.*;
import lombok.AllArgsConstructor;
import lombok.Setter;
import com.ball.service.GroupMessageService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/group/*")
@Slf4j
@AllArgsConstructor
public class GroupController {

//    private GroupMessageService messageService;
    @Setter(onMethod_=@Autowired)
    private GroupService groupService;

    @Setter(onMethod_=@Autowired)
    private GroupMessageService messageService;

    @GetMapping("/list")
    public String groupList(Long group_id , Criteria cri,  Model model) {
        System.out.println("컨트롤러 그룹 전체 목록 조회");
//        model.addAttribute("list",messageService.groupMessageRead(1L));
//        HashMap<String,Object> hashMap = new HashMap<>();
//        hashMap.put("criterionNumber",cri);
//        hashMap.put("group_id",group_id);
//        model.addAttribute("list",messageService.groupMessageRead(hashMap));
        model.addAttribute("list", groupService.allRead(cri));

        System.out.println("컨트롤러에 cri가 들어오나 " +cri);
        System.out.println("검색어가 들어오나 "+ cri.getKeyword());
        System.out.println("카테고리가 들어오나 "+ cri.getCategory());


        return "group/groupList";
    }

    @GetMapping("/create")
    public String register(HttpServletRequest request, Model model){
        System.out.println("그룹 생성 GetMapping에 들어오나");
        String userID = String.valueOf(request.getSession().getAttribute("userID"));
        System.out.println("유저 아이디의 값이 들어오나 : "+userID);
        model.addAttribute("user_id",userID);

        return "group/groupCreate";
    }
    @PostMapping("/create")
    public String register(GroupVO group, Long group_id, GroupJoinVO join, HttpServletRequest request, RedirectAttributes rttr){

        String userID = String.valueOf(request.getSession().getAttribute("userID"));
        groupService.register(group, userID);
        System.out.println("컨트롤러에 레지스터 값이 들어오나?"+group.getGroup_category());
        rttr.addFlashAttribute("result", group.getGroup_id());
        join.setGroup_id(group_id);
        join.setUser_id(userID);
        return "redirect:/group/list";

    }
    @GetMapping("/modify")
    public String modify(Long group_id, Model model, @ModelAttribute("cri") Criteria cri){
        System.out.println("게시글 컨트롤러에서 데이터 하나 수정 / ");
        model.addAttribute("group", groupService.oneRead(group_id));
        return "group/groupModify";
    }

    @GetMapping("/read")
    public String oneRead(Long group_id, HttpServletRequest request, Model model){
        model.addAttribute("group", groupService.oneRead(group_id));
        String userID = String.valueOf(request.getSession().getAttribute("userID"));
        System.out.println("리드에서 유저 아이디의 값이 들어오나 : "+userID);
        model.addAttribute("user_id",userID);
        model.addAttribute("join", groupService.joinAllRead(group_id,userID));
//        groupService.remove(group_id);

        model.addAttribute("firstCriNumber",messageService.getFirstGroupMessageId(group_id));
//        model.addAttribute("firstCriNumber",5);
        return "group/groupRead";
    }
    @PostMapping("/read")
    public String oneRead(Long group_id, GroupJoinVO join, HttpServletRequest request){
        String userID = String.valueOf(request.getSession().getAttribute("userID"));
        join.setGroup_id(group_id);
        join.setUser_id(userID);
        groupService.joinGroup(join);
        System.out.println("==========" + join);

        return "redirect:/group/list";
    }


    @PostMapping({"/list","/modify"})
    public String modify(GroupVO group, RedirectAttributes rttr, @ModelAttribute ("cri") Criteria cri){
        System.out.println("컨트롤러에서 수정이 들어오나 : "+ group);
        groupService.modify(group);
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("criterionNumber", cri.getCriterionNumber());
        rttr.addAttribute("category", cri.getCategory());
        rttr.addAttribute("keyword", cri.getKeyword());
        return "redirect:/group/list";
    }
    @PostMapping("/groupRemove")
    public String groupRemove (Long group_id){
        groupService.groupRemove(group_id);
        return "redirect:/group/list";
    }
    @PostMapping("/userRemove")
    public String userRemove (@Param("group_id") Long group_id, HttpServletRequest request){
        String userID = String.valueOf(request.getSession().getAttribute("userID"));
        System.out.println("유저 아이디랑, 그룹 아이다가 들어오나 "+ group_id + userID);
        groupService.userRemove(group_id, userID);
        return "redirect:/group/list";
    }
}

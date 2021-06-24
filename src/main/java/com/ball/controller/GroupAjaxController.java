package main.java.com.ball.controller;

import com.ball.service.GroupService;
import com.ball.vo.Criteria;
import com.ball.vo.GroupVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@RestController
@Controller
@RequestMapping("/group/list/ajax/*")
@Slf4j
public class GroupAjaxController {
    @Setter(onMethod_=@Autowired)
    private GroupService groupService;

    @GetMapping(value = "/list")
    public ResponseEntity<List<GroupVO>> getPassword (Criteria cri){
        System.out.println("아작스 컨트롤러에 진입이 되나");
//        model.addAttribute("check",groupService.passwordCheck(group_id));
        return new ResponseEntity<>(groupService.allRead(cri), HttpStatus.OK);


    }



}

package com.ball.controller;

import com.ball.service.GroupService;
import com.ball.vo.Criteria;
import com.ball.vo.GroupVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@RestController
@RequestMapping("/ajax/*")
@Slf4j
public class GroupAjaxController {
    @Setter(onMethod_ = @Autowired)
    private GroupService groupService;

    @PostMapping(value = "/list/{group_id}") //
    public ResponseEntity<HashMap<String, Object>> getPassword (@PathVariable Long group_id) throws Exception{
        System.out.println("아작스 컨트롤러에 진입이 되나");
        HashMap<String, Object> result = new HashMap<>();
        result.put("password", groupService.passwordCheck(group_id));
        System.out.println("result 값은? "+result);
        return ResponseEntity.ok(result);
    }
    @PostMapping(value = "/addList")
    public ResponseEntity<HashMap<String, Object>> getList (Criteria cri) throws Exception{
        System.out.println("리스트 더보기 아작스컨트롤러에 진입이 되나");
        HashMap<String, Object> result = new HashMap<>();
        result.put("criNumber", groupService.allRead(cri));
        System.out.println("리스트 더보기 result 값은 : "+ result);

        return ResponseEntity.ok(result);
    }

}

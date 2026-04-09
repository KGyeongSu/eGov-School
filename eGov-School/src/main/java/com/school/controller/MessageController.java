package com.school.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.school.dto.MessageVO;
import com.school.dto.UserVO;
import com.school.service.MessageService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/user")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @GetMapping("/receivedList")
    public List<MessageVO> receivedList(HttpSession session) throws SQLException {
        // 세션에서 loginUser 객체를 꺼냅니다.
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        if (loginUser == null) {
            System.out.println("로그인 세션(loginUser)이 없습니다.");
            return null;
        }

        String userNum = loginUser.getUserNum();

        return messageService.getReceivedList(userNum);
    }

    @GetMapping("/unreadCount")
    public int unreadCount(HttpSession session) throws SQLException {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return 0;
        return messageService.getUnreadCount(loginUser.getUserNum());
    }

    @PostMapping("/detail")
    public MessageVO messageDetail(@RequestParam("msNum") String msNum) throws SQLException {
        return messageService.getMessageUserDetail(msNum);
    }


}

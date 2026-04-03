package com.school.controller;

import java.util.List;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.school.dto.UserVO;
import com.school.dto.TestVO;
import com.school.service.TestService;

@Controller
@RequestMapping("/user") // 1순위 경로: /user
public class ExamController {

    @Autowired
    private TestService testService;

    // [수정] value를 "/exam"으로 바꿔서 localhost/user/exam 주소를 완성합니다.
    @RequestMapping(value = "/exam", method = RequestMethod.GET) 
    public String examList(HttpSession session, Model model) throws Exception {
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        if (loginUser == null) {
            return "redirect:/login/loginForm"; 
        }

        String userNum = loginUser.getUserNum();

        List<TestVO> pendingList = testService.getPendingTestList(userNum);
        List<TestVO> completedList = testService.getCompletedTestList(userNum);

        model.addAttribute("pendingList", pendingList);
        model.addAttribute("completedList", completedList);

        // 실제 파일: /WEB-INF/views/user/exam.jsp
        return "user/exam"; 
    }
}
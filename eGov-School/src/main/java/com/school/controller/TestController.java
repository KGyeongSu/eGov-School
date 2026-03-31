package com.school.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.school.cmd.TestAnswerCommand;
import com.school.dto.ExamResultVO;
import com.school.dto.QuestionVO;
import com.school.dto.UserVO;
import com.school.service.TestService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/test")
public class TestController {

    @Autowired
    private TestService testService;

    
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String testMain(@RequestParam(name="tetNum") String tetNum, Model model) throws Exception {
       
        List<QuestionVO> questionList = testService.getTestPaper(tetNum);
        
        model.addAttribute("questionList", questionList);
        model.addAttribute("tetNum", tetNum);
        
        return "user/test"; 
    }

    
    @RequestMapping(value = "/evaluate", method = RequestMethod.POST)
    public String evaluate(TestAnswerCommand answerCmd, HttpSession session, Model model) throws Exception {
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        String userNum = loginUser.getUserNum();
        
        
        ExamResultVO result = testService.evaluateTest(
            answerCmd.getUserAnswers(), 
            userNum, 
            answerCmd.getTetNum()
        );
        
        model.addAttribute("result", result);
        
        return "test/result"; // 결과 화면으로 이동
    }
}
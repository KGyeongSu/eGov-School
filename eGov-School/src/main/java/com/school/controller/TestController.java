package com.school.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.school.cmd.TestAnswerCommand;
import com.school.dto.ExamResultVO;
import com.school.dto.QuestionVO;
import com.school.dto.TestVO;
import com.school.dto.UserVO;
import com.school.service.TestService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class TestController {

    @Autowired
    private TestService testService;

    
    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public String testMain(@RequestParam(name="tetNum") String tetNum, Model model) throws Exception {
       //문제
        List<QuestionVO> questionList = testService.getTestPaper(tetNum);
        
        TestVO testVO = testService.getTestDetail(tetNum);
        
        model.addAttribute("questionList", questionList);
        model.addAttribute("test",testVO);
        model.addAttribute("tetNum", tetNum);
        
        return "user/test"; 
    }

    
@ResponseBody
@RequestMapping(value="/evaluate", method = RequestMethod.POST)
public ExamResultVO evaluate(@RequestBody TestAnswerCommand answerCmd, HttpSession session)throws Exception{
	


	UserVO loginUser = (UserVO) session.getAttribute("loginUser");
	String userNum = loginUser.getUserNum();
	
	ExamResultVO result = testService.evaluateTest(
		answerCmd.getUserAnswers(),
		userNum,
		answerCmd.getTetNum()
	);
	
	return result;
}
@PostMapping("/submitTest")
@ResponseBody
public String submitTest(@RequestBody List<QuestionVO> userAnswers, 
                         @RequestParam String tetNum, 
                         HttpSession session) throws SQLException {
    
    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
    // 서비스에서 채점하고 DB(EXAM_RESULT)에 저장하지만, 결과 객체를 화면에 바로 띄우지는 않음
    testService.evaluateTest(userAnswers, loginUser.getUserNum(), tetNum);
    
    // 저장 완료 후 목록 페이지로 가라는 신호만 보냄
    return "success"; 
}

}
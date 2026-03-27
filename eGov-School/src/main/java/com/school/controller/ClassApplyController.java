package com.school.controller;

import java.sql.SQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.school.cmd.ClassApplyListCommand;
import com.school.cmd.PageMaker;
import com.school.dto.UserVO;
import com.school.service.ClassApplyService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class ClassApplyController {
	
	@Autowired
	private ClassApplyService classApplyService;
	
	@RequestMapping("/myKang")
	public String list(PageMaker pageMaker, HttpSession session, Model model) throws SQLException {
	    String url = "user/myKang";
	    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
	    String userNum = "rudtn778";

	    // 1. 서비스에서 리스트와 '계산된' PageMaker를 받아옵니다.
	    ClassApplyListCommand result = classApplyService.getClassApplyList(userNum, pageMaker);
	    
	    // 2. 만약 result.getPageMaker()가 내부에서 계산을 안 했다면 여기서 수동으로 호출해야 할 수도 있습니다.
	    // 보통 서비스에서 totalCount를 세팅하면 자동으로 계산되도록 짜여있을 겁니다.
	    
	    model.addAttribute("result", result);
	    model.addAttribute("pageMaker", result.getPageMaker());
	    
	    return url;
	}
	
}
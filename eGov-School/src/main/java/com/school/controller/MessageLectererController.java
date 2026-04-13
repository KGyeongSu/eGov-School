package com.school.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.school.cmd.PageMaker;
import com.school.dto.ReputationVO;
import com.school.dto.UserVO;
import com.school.service.ReputationService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/lecterer")
public class MessageLectererController {
	
	private final ReputationService reputationService;
	
	public MessageLectererController(ReputationService reputationService) {

		this.reputationService = reputationService;
		
	}

	@GetMapping("/reputationHome")
	public String messageHome (HttpSession session, PageMaker pageMaker, Model model) throws Exception {
		
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		if (loginUser == null) return "redirect:/commons/login";
		
		String userNum = loginUser.getUserNum();
		
		List<ReputationVO> reputationList = reputationService.selectReputationListByLecturer(pageMaker, userNum);
		
		// 모델에 담아서 보여주기
		model.addAttribute("loginUser", loginUser);
		model.addAttribute("reputationList", reputationList);
		
		return "lecterer/reputationHome";
		
	}
	
	@GetMapping("/reputationDetail")
	public String messageDetail(@RequestParam("repNum") String repNum, Model model) throws Exception {
		
		// 메시지 읽음 처리
		reputationService.updateReputationCheck(repNum);
		
		// 해당 피드백 클릭 시
		ReputationVO rdetail = reputationService.selectReputationDetailByRepNum(repNum);
		
		// 모델로 보여주기
		model.addAttribute("rdetail", rdetail);
		
		return "lecterer/reputationDetail";
		
	}
	
	// 메시지 알람
	@ResponseBody
	@GetMapping("/reputationAlarm")
	public int messageAlarm (HttpSession session) throws SQLException {
		
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		String userNum = loginUser.getUserNum();
		
	    return reputationService.selectUnreadReputationCount(userNum);
		
	}
	
}

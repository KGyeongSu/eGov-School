package com.school.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.school.dto.ReputationVO;
import com.school.dto.UserVO;
import com.school.service.ReputationService;
import com.school.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminLectererReputationController {
	
	private final UserService userService;
	private final ReputationService reputationService;	
	
	public AdminLectererReputationController(UserService userService, ReputationService reputationService) {

		this.userService = userService;
		this.reputationService = reputationService;
		
	}



	@GetMapping("/feedback")
	public String feedBack (HttpSession session, Model model) throws Exception {
		
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		if (loginUser == null ) return "redirect:/commons/login";
		
		List<UserVO> lectererList = userService.getlectererList();
		
		model.addAttribute("loginUser", loginUser);
		model.addAttribute("lectererList", lectererList);
		
		return "admin/feedback";
		
	}
	
	@GetMapping("/getLRep")
	@ResponseBody 
	public List<ReputationVO> getLRep(String userNum) throws Exception {

		return reputationService.selectLClassRep(userNum);
	    
	}
	
	@PostMapping("/insertFeedback")
	@ResponseBody
	public String goRep (@RequestBody ReputationVO reputation) throws Exception {
		
		try {
	        
			reputationService.insertReputation(reputation);
	        return "success";
	        
	    } catch (Exception e) {
	       
	    	e.printStackTrace();
	        return "fail";
	        
	    }
		
	}

}

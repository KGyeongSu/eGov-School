package com.school.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.school.dto.UserVO;
import com.school.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	
	@GetMapping("/commons/join")
	public String joinForm() {
		return "commons/join";
	}
	
	//회원가입
	@PostMapping("/commons/join")
	public String regist(UserVO user) throws SQLException{
		userService.regist(user);
		
		return "commons/login";
	}
	
	// 강사 프로필 폼 접근
	@GetMapping("/inLearning/lecterer/profile")
	public String profileForm (Model model, HttpSession session) {
		
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		model.addAttribute("loginUser", loginUser);
		
		return "inLearning/lecterer/profile";
		
	}
	
	// 강사 프로필 등록
	@PostMapping("/inLearning/lecterer/profile")
	public String updateLectererProfile(@ModelAttribute UserVO user, Model model) throws SQLException {
		
		boolean success = userService.updateLectererProfile(user);
		
		if  (success) {
			
			model.addAttribute("msg", "프로필 업데이트가 완료되었습니다.");
			
		} else {
			
			model.addAttribute("msg", "서버 장애로 인해 프로필 업데이트가 실패했습니다.");
			
		}
		
		return "lecterer/profile";
		
	}
	
}
  
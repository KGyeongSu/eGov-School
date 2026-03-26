package com.school.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.school.dto.UserVO;
import com.school.service.UserService;

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
	
}
  
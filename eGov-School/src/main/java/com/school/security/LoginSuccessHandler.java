package com.school.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, 
										HttpServletResponse response,
										Authentication auth) 
								throws IOException, ServletException {
	
		// 로그인 성공 → 메인페이지로 이동
	    // 역할별 분기는 인러닝 버튼 클릭 시 처리
	    response.sendRedirect("/main");

	
	}
}

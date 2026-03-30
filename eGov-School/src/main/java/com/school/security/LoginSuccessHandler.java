package com.school.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
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
	
		// CustomAuthenticationProvider에서 만든 토큰에서
		// security 꺼내기
		UserDetails authUser = (UserDetails) auth.getDetails();
		// securityUser에서 권한 꺼내기
		// getAuthorities()는 ["ROLE_관리자"] 같은 리스트라서
		// 첫번째 값만 꺼내서 문자열로 변환
		String role = authUser.getAuthorities() 	
							  .iterator().next()	//첫번째 권한 꺼내기
							  .getAuthority();		//문자열로변환
							// -> "ROLE_관리자","ROLE_강사","ROLE_사용자"
		
		// 역할별 페이지 이동
		if ("ROLE_관리자".equals(role)) {
			response.sendRedirect("/admin/admin_main");
		} else if ("ROLE_강사".equals(role)) {
			response.sendRedirect("/lecterer/mainDashBoard");
		} else {
			response.sendRedirect("/user/dashBoard");
		}
	}	

	
}

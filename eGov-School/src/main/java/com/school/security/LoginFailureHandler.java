package com.school.security;

import java.io.IOException;

import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginFailureHandler implements AuthenticationFailureHandler{

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, 
										HttpServletResponse response,
										AuthenticationException e)
										throws IOException, ServletException {
		
		// 실패 메시지 담을 변수
		String message = "";
		
		// 4단계에서 던진 예외 종류별로 메시지 분기
		if (e instanceof UsernameNotFoundException) {
			// 이메일이 DB에 없는 경우
			message = "이메일이 존재하지 않습니다.";
		} else if (e instanceof BadCredentialsException) {
			// 비밀번호가 틀린 경우
			message = "비밀번호가 일치하지 않습니다.";
		} else if (e instanceof AuthenticationServiceException) {
			// 계정이 유효하지 않은 경우 (활성 아닌 경우)
			message = e.getMessage();
		}
		
		// 세션에 실패 메시지 저장 -> login.jsp에서 꺼내서 보여줄 예정
		HttpSession session = request.getSession();
		session.setAttribute("loginError", message);
		
		// 로그인 페이지로 다시 이동
		response.sendRedirect("/commons/login");
	}
	

}

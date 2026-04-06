package com.school.security;

import java.io.IOException;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class Custom403Handler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, 
						HttpServletResponse response,
						AccessDeniedException accessDeniedException) 
						throws IOException, ServletException {
		
		// 403 전용 페이지로 이동
		response.sendRedirect("/commons/accessDenied");
	}

}

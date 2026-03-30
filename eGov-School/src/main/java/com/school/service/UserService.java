package com.school.service;

import java.sql.SQLException;

import com.school.dto.UserVO;

public interface UserService {

	// 회원가입
	void regist(UserVO user) throws SQLException;
	
//	// 로그인 (이메일로 조회) Security가 검증하기에 login() 메서드는 지움. 
//	UserVO login(String userEmail, String userPwd) throws SQLException;
	
	// 이메일로 유저 조회 (security 로그인용)
	UserVO getUserByEmail(String userEmail) throws SQLException;
}

package com.school.service;

import java.sql.SQLException;

import com.school.dao.UserDAO;
import com.school.dto.UserVO;

public class UserServiceImpl implements UserService {
	
	private UserDAO userDAO;
	
	public UserServiceImpl(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	@Override
	public void regist(UserVO user) throws SQLException {
		// 1. 시퀀스 번호 받기
		String userNum = userDAO.selectUserSeqNext();
		// 2. VO에 세팅
		user.setUserNum(userNum);
		// 3. insert
		userDAO.insertUser(user);
	}

	@Override
	public UserVO login(String userEmail, String userPwd) throws SQLException {
		// 1. 이메일로 유저 조회dd
		UserVO user = userDAO.selectUserByEmail(userEmail);
		
		// 2. 유저가 없으면 null 리턴
		if (user == null) {
			return null;
		}
		
		// 3. 비밀번호 일치 확인
		if (!user.getUserPwd().equals(userPwd)) {
			// 실패 횟수 증가
			userDAO.updateFailCount(userEmail);
			return null;
		}
		
		// 4. 로그인 성공 → 실패 횟수 초기화
		userDAO.resetFailCount(userEmail);
		
		return user;
	}

}
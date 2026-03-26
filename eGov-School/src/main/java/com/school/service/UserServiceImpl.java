package com.school.service;

import java.sql.SQLException;

import com.school.dao.UserDAO;
import com.school.dto.UserVO;

public class UserServiceImpl implements UserService{
	
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

}

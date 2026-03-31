
package com.school.service;

import java.sql.SQLException;

import org.springframework.security.crypto.password.PasswordEncoder;

import com.school.dao.UserDAO;
import com.school.dto.UserVO;

public class UserServiceImpl implements UserService {
	
	private UserDAO userDAO;
	private PasswordEncoder encoder; // BCrypt 암호화용
	
	public UserServiceImpl(UserDAO userDAO, PasswordEncoder encoder) {
		this.userDAO = userDAO;
		this.encoder = encoder;
	}

	// 회원가입 -> 비밀번호 암호화해서 저장
	@Override
	public void regist(UserVO user) throws SQLException {
		// 1. 시퀀스 번호 받기
		String userNum = userDAO.selectUserSeqNext();
		// 2. VO에 세팅
		user.setUserNum(userNum);
		// 3. 암호화
		user.setUserPwd(encoder.encode(user.getUserPwd())); // 암호화 추가
		// 4. insert
		userDAO.insertUser(user);
	}
	
	// 이메일로 유저 조회 (Security 로그인용)
	@Override
	public UserVO getUserByEmail(String userEmail) throws SQLException{
		return userDAO.selectUserByEmail(userEmail);
	}
	
	// 비밀번호 변경 -> 암호화해서 저장
	@Override
	public void updateUserPwd(String userEmail, String newPwd) throws SQLException {
	    // BCrypt 암호화 후 UPDATE
	    UserVO user = new UserVO();
	    user.setUserEmail(userEmail);
	    user.setUserPwd(encoder.encode(newPwd)); // ← BCrypt 암호화!
	    userDAO.updateUserPwd(user);
	}
	
	@Override
	public boolean updateLectererProfile(UserVO user) throws SQLException {
		
		int updatedRows = userDAO.updateLectererProfile(user);
		
		return updatedRows > 0;
		
	}

}
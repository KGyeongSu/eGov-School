package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.UserVO;

public interface UserDAO {

	String selectUserSeqNext() throws SQLException;

	void insertUser(UserVO user) throws SQLException;

	UserVO selectUserByEmail(String userEmail) throws SQLException;

	UserVO selectUserByNum(String userNum) throws SQLException;

	void updateUser(UserVO user) throws SQLException;

	void updateUserPwd(UserVO user) throws SQLException;

	List<UserVO> selectUserList() throws SQLException;

	void updateUserStatus(UserVO user) throws SQLException;

	void updateFailCount(String userEmail) throws SQLException;

	void resetFailCount(String userEmail) throws SQLException;
	
	int updateLectererProfile (UserVO user) throws SQLException;
	
}

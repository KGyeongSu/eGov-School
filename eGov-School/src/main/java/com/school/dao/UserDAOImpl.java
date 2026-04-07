package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.UserVO;

public class UserDAOImpl implements UserDAO {

	private SqlSession session;

	public UserDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public String selectUserSeqNext() throws SQLException {
		return session.selectOne("User-Mapper.selectUserSeqNext");
	}

	@Override
	public void insertUser(UserVO user) throws SQLException {
		session.insert("User-Mapper.insertUser", user);
	}

	@Override
	public UserVO selectUserByEmail(String userEmail) throws SQLException {
		return session.selectOne("User-Mapper.selectUserByEmail", userEmail);
	}

	@Override
	public UserVO selectUserByNum(String userNum) throws SQLException {
		return session.selectOne("User-Mapper.selectUserByNum", userNum);
	}

	@Override
	public void updateUser(UserVO user) throws SQLException {
		session.update("User-Mapper.updateUser", user);
	}

	@Override
	public void updateUserPwd(UserVO user) throws SQLException {
		session.update("User-Mapper.updateUserPwd", user);
	}

	@Override
	public List<UserVO> selectUserList() throws SQLException {
		return session.selectList("User-Mapper.selectUserList");
	}

	@Override
	public void updateUserStatus(UserVO user) throws SQLException {
		session.update("User-Mapper.updateUserStatus", user);
	}

	@Override
	public void updateFailCount(String userEmail) throws SQLException {
		session.update("User-Mapper.updateFailCount", userEmail);
	}

	@Override
	public void resetFailCount(String userEmail) throws SQLException {
		session.update("User-Mapper.resetFailCount", userEmail);
	}

	@Override
	public int updateLectererProfile(UserVO user) throws SQLException {

		return session.update("User-Mapper.updateLectererProfile", user);
		
	}

	@Override
	public List<UserVO> getAdminList() throws SQLException {
		
		return session.selectList("User-Mapper.getAdminList");
		
	}
}


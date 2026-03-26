package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.ReputationVO;

public class ReputationDAOImpl implements ReputationDAO{
	
	private SqlSession session;
	
	public ReputationDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<ReputationVO> selectReputationList(String claNum) throws SQLException {
		
		return session.selectList("Reputation-Mapper.selectReputationList", claNum);
	}

	@Override
	public ReputationVO selectReputationCount(String claNum) throws SQLException {
		
		return session.selectOne("Reputation-Mapper.selectReputationCount",claNum);
	}

	@Override
	public void insertReputation(ReputationVO reputation) throws SQLException {
		session.insert("Reputation-Mapper.insertReputation", reputation);
		
	}

	@Override
	public void updateReputation(ReputationVO reputation) throws SQLException {
		session.update("Reputation-Mapper.updateReputation", reputation);
		
	}

	@Override
	public int selectReputaioneqNext() throws SQLException {
		
		return session.selectOne("Reputation-Mapper.selectReputaioneqNext");
	}

}

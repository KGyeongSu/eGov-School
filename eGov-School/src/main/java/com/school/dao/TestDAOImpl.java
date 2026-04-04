package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.TestVO;

public class TestDAOImpl implements TestDAO {

	private SqlSession session;
	
	public TestDAOImpl(SqlSession session) {
		this.session = session;
	}
	
	
	@Override
	public String selectTestSeqNext() throws SQLException {
		return session.selectOne("Test-Mapper.selectTestSeqNext");
	}


	@Override
	public TestVO selectTestByNum(String tetNum) throws SQLException {
		return session.selectOne("Test-Mapper.selectTestByNum", tetNum);
	}
	
	@Override
	public List<TestVO> selectPendingTestList(String userNum) throws SQLException {
		return session.selectList("Test-Mapper.selectPendingTestList", userNum);
	}

	@Override
	public List<TestVO> selectCompletedTestList(String userNum) throws SQLException {
		return session.selectList("Test-Mapper.selectCompletedTestList", userNum);
	}
	
	@Override
	public void insertTest(TestVO test) throws SQLException {
		session.insert("Test-Mapper.insertTest", test);
	}

	@Override
	public TestVO selectTestbyTetNum(String tetNum) throws SQLException {
		
		return session.selectOne("Test-Mapper.selectTestByNum", tetNum);
		
	}
	
	@Override
	public void updateTest(TestVO test) throws SQLException {
		session.update("Test-Mapper.updateTest", test);
	}



	@Override
	public TestVO selectTestCondition(String tetNum) throws SQLException {
		
		return session.selectOne("Test-Mapper.selectTestCondition",tetNum);
	}

}

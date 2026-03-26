package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.ExamResultVO;

public class ExamResultDAOImpl implements ExamResultDAO{

	private SqlSession session;
	public ExamResultDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public ExamResultVO selectExamResult(String erNum) throws SQLException {
		
		return session.selectOne("ExamResult-Mapper.selectExamResult",erNum);
	}

	@Override
	public List<ExamResultVO> selectExamResultByuserNum(String userNum) throws SQLException {
		
		return session.selectList("ExamResult-Mapper.selectExamResultByuserNum",userNum);
	}

	@Override
	public void insertExamResult(ExamResultVO examresult) throws SQLException {
		
		session.insert("ExamResult-Mapper.insertExamResult",examresult);
		
	}

	@Override
	public int selectExamResultSeqNext() throws SQLException {
		
		return session.selectOne("ExamResult-Mapper.selectExamResultSeqNext");
	}

}

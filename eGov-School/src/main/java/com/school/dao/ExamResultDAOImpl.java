package com.school.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.BonusStudentVO;
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

	@Override
	public ExamResultVO selectExamResultByTetAndUser(ExamResultVO examresult) throws SQLException {
		
		return session.selectOne("ExamResult-Mapper.selectExamResultByTetAndUser",examresult);
	}
	
	@Override
	public List<BonusStudentVO> getBStList(int offset, int limit) throws SQLException {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("offset", offset);
        paramMap.put("limit", limit);
		return session.selectList("ExamResult-Mapper.getBStList", paramMap);
	}
	
	@Override
	public int selectCount() throws SQLException {
		return session.selectOne("ExamResult-Mapper.selectCount");
	}

}

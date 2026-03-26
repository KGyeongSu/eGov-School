package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.ExamAnswerVO;


public class ExamAnswerDAOImpl implements ExamAnswerDAO{
	private SqlSession session;
	public ExamAnswerDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<ExamAnswerVO> selectExamAnswerResultDetails(String erNum) throws SQLException {
	
		return session.selectList("ExamAnswer-Mapper.selectExamAnswerResultDetails",erNum);
	}

	@Override
	public List<ExamAnswerVO> selectAnswersByResultNum(String erNum) throws SQLException {
		
		return session.selectList("ExamAnswer-Mapper.selectAnswersByResultNum",erNum);
	}

	@Override
	public void insertExamAnswer(ExamAnswerVO examanswer) throws SQLException {
		
		session.insert("ExamAnswer-Mapper.insertExamAnswer",examanswer);
		
	}

	@Override
	public void updateExamAnswer(ExamAnswerVO examanswer) throws SQLException {

		session.update("ExamAnswer-Mapper.updateExamAnswer",examanswer);
	}

	@Override
	public int selectExamAnswerSeqNext() throws SQLException {
		
		return session.selectOne("ExamAnswer-Mapper.selectExamAnswerSeqNext");
	}
	

}

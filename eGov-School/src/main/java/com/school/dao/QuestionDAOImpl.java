package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.QuestionVO;

public class QuestionDAOImpl implements QuestionDAO {
	
	private SqlSession session;

	public QuestionDAOImpl(SqlSession session) {

		this.session = session;
		
	}

	@Override
	public void insertQuestion(QuestionVO question) throws SQLException {

		session.insert("Question-Mapper.insertQuestion", question);
		
	}

	@Override
	public List<QuestionVO> selectQuestionList(QuestionVO question) throws SQLException {

		return session.selectList("Question-Mapper.selectQuestionList", question);
		
	}

	@Override
	public void updateQuestion(QuestionVO question) throws SQLException {

		session.update("Question-Mapper.updateQuestion", question);
		
	}

	@Override
	public List<QuestionVO> selectQuestionsByTetNum(String tetNum) throws SQLException {
		
		return session.selectList("Question-Mapper.selectQuestionsByTetNum", tetNum);
	}
	
	

}

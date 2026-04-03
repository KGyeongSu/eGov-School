package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.QuestionVO;

public interface QuestionDAO {
	
  // 강사
	String selectQuestionSeqNext () throws SQLException;
	
	void insertQuestion (QuestionVO question) throws SQLException;
	
	void updateQuestion (QuestionVO question) throws SQLException;
	
	List <QuestionVO> selectQuestionList (QuestionVO question) throws SQLException;
	
  // 사용자
	void updateQuestion (QuestionVO question) throws SQLException;
	
	List<QuestionVO> selectQuestionsByTetNum(String tetNum) throws SQLException;
}

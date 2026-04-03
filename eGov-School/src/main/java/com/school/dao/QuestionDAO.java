package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.QuestionVO;

public interface QuestionDAO {
	
	String selectQuestionSeqNext () throws SQLException;
	
	void insertQuestion (QuestionVO question) throws SQLException;
	
	void updateQuestion (QuestionVO question) throws SQLException;
	
	// 물어보고 삭제하기
	List <QuestionVO> selectQuestionList (QuestionVO question) throws SQLException;
	

}

package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.ExamAnswerVO;

public interface ExamAnswerDAO {
	
	List<ExamAnswerVO>selectExamAnswerResultDetails(String erNum)throws SQLException;
	List<ExamAnswerVO>selectAnswersByResultNum(String erNum)throws SQLException;
	
	
	void insertExamAnswer(ExamAnswerVO examanswer)throws SQLException;
	void updateExamAnswer(ExamAnswerVO examanswer)throws SQLException;
	
	int selectExamAnswerSeqNext()throws SQLException;
	
	

}

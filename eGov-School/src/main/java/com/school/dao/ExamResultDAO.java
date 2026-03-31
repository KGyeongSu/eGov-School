package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.ExamResultVO;

public interface ExamResultDAO {
	
	ExamResultVO selectExamResult(String erNum)throws SQLException;
	List<ExamResultVO> selectExamResultByuserNum(String userNum)throws SQLException;
	void insertExamResult(ExamResultVO examresult)throws SQLException;
	ExamResultVO selectExamResultByTetAndUser(ExamResultVO vo) throws SQLException;
	int selectExamResultSeqNext()throws SQLException;
	
}

package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.school.dto.BonusStudentVO;
import com.school.dto.ExamResultVO;

public interface ExamResultDAO {
	
	ExamResultVO selectExamResult(String erNum)throws SQLException;
	List<ExamResultVO> selectExamResultByuserNum(String userNum)throws SQLException;
	void insertExamResult(ExamResultVO examresult)throws SQLException;
	ExamResultVO selectExamResultByTetAndUser(ExamResultVO vo) throws SQLException;
	int selectExamResultSeqNext()throws SQLException;
	
	List<BonusStudentVO> getBStList(@Param("offset") int offset, @Param("limit") int limit) throws SQLException;
	int selectCount() throws SQLException;
}

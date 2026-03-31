package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.QuestionVO;
import com.school.dto.TestVO;

public interface TestDAO {

	String selectTestSeqNext() throws SQLException;
	
	void insertTest(TestVO test) throws SQLException;
	
	TestVO selectTestByNum(String tetNum) throws SQLException;
	
	void updateTest(TestVO test) throws SQLException;
	
	List<TestVO> selectPendingTestList(String userNum) throws SQLException;
	
	List<TestVO> selectCompletedTestList(String userNum) throws SQLException;
	

}

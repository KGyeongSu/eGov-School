package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.QuestionVO;
import com.school.dto.TestVO;

public interface TestDAO {

	String selectTestSeqNext() throws SQLException;
	
	TestVO selectTestByNum(String tetNum) throws SQLException;
	
	List<TestVO> selectPendingTestList(String userNum) throws SQLException;
	
	List<TestVO> selectCompletedTestList(String userNum) throws SQLException;
	
	TestVO selectTestCondition(String tetNum) throws SQLException;
	// 강사용
	// 등록
	void insertTest(TestVO test) throws SQLException;
	
	// 수정시 번호로 불러오기
	TestVO selectTestbyTetNum(String tetNum) throws SQLException;
	TestVO selectTestWithQuestions(String claNum) throws SQLException;
	
	// 수정
	void updateTest(TestVO test) throws SQLException;
	

}

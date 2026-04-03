package com.school.service;

import java.sql.SQLException;

import java.util.List;

import com.school.dto.ExamResultVO;
import com.school.dto.QuestionVO;
import com.school.dto.TestVO;

public interface TestService {
	
	// 강사
	// 테스트 등록
	void insertTest(TestVO test) throws SQLException;
	
	// 테스트 등록 시퀀스 받아오기
	String selectTestSeqNext() throws SQLException;
	
	// 수정 시 번호로 불러오기
	TestVO selectTestWithQuestions(String claNum) throws SQLException;
	
	// 수정
	void updateTest(TestVO test) throws SQLException;
	
  // 사용자
	public List<QuestionVO> getTestPaper(String tetNum)throws SQLException;
	
	public ExamResultVO evaluateTest(List<QuestionVO> userAnswers, String userNum,String tetNum)throws SQLException;
	
	public List<TestVO> getMyTestResults(String userNum)throws SQLException;
	
	public ExamResultVO getResultDetail(String erNum)throws SQLException;
	
	List<TestVO> getPendingTestList(String userNum) throws Exception;
	
	List<TestVO> getCompletedTestList(String userNum) throws Exception;
}

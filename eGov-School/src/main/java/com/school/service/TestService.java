package com.school.service;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.ExamResultVO;
import com.school.dto.QuestionVO;
import com.school.dto.TestVO;

public interface TestService {
	
	public List<QuestionVO> getTestPaper(String tetNum)throws SQLException;
	
	public ExamResultVO evaluateTest(List<QuestionVO> userAnswers, String userNum,String tetNum)throws SQLException;
	
	public List<TestVO> getMyTestResults(String userNum)throws SQLException;
	
	public ExamResultVO getResultDetail(String erNum)throws SQLException;
	
	List<TestVO> getPendingTestList(String userNum) throws Exception;
	
	List<TestVO> getCompletedTestList(String userNum) throws Exception;

	public TestVO getTestDetail(String tetNum) throws SQLException;

	public TestVO getTestCondition(String tetNum)throws SQLException;
}

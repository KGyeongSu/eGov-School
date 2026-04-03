package com.school.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.school.dao.ExamResultDAO;
import com.school.dao.QuestionDAO;
import com.school.dao.TestDAO;
import com.school.dto.ExamAnswerVO;
import com.school.dto.ExamResultVO;
import com.school.dto.QuestionVO;
import com.school.dto.TestVO;

public class TestServiceImpl implements TestService{
	
	private TestDAO testDAO;
	private QuestionDAO quesTionDAO;
	private ExamResultDAO examResultDAO;
	
	
	

	public TestServiceImpl(TestDAO testDAO, QuestionDAO quesTionDAO, ExamResultDAO examResultDAO) {
		
		this.testDAO = testDAO;
		this.quesTionDAO = quesTionDAO;
		this.examResultDAO = examResultDAO;
		
	}

	@Override
	public List<QuestionVO> getTestPaper(String tetNum) throws SQLException {
		
		return quesTionDAO.selectQuestionsByTetNum(tetNum);
	}

	@Override
	public ExamResultVO evaluateTest(List<QuestionVO> userAnswers, String userNum, String tetNum) throws SQLException {
	    
	    TestVO testCondition = testDAO.selectTestCondition(tetNum);
	    int passScore = 60;

	    if (testCondition != null && testCondition.getClaComplete() != null) {
	        String completeStr = testCondition.getClaComplete();
	     
	        java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("test\\s*(\\d+)");
	        java.util.regex.Matcher matcher = pattern.matcher(completeStr);
	        if (matcher.find()) {
	            passScore = Integer.parseInt(matcher.group(1));
	        }
	    }

	    List<QuestionVO> realQuestions = quesTionDAO.selectQuestionsByTetNum(tetNum);
	    int totalScore = 0;
	    List<ExamAnswerVO> answerList = new ArrayList<>();
	    
	    for(QuestionVO real : realQuestions) {
	        ExamAnswerVO answerDetail = new ExamAnswerVO();
	        answerDetail.setQueNum(real.getQueNum());
	        answerDetail.setQueText(real.getQueText());
	        answerDetail.setQueAnswer(real.getQueAnswer());
	        answerDetail.setQueDesc(real.getQueDesc());
	        
	        for(QuestionVO user : userAnswers) {
	            if(real.getQueNum().equals(user.getQueNum())) {
	                answerDetail.setEaSelected(user.getQueAnswer());
	                if(real.getQueAnswer().equals(user.getQueAnswer())) {
	                    totalScore += real.getQuePoint();
	                    answerDetail.setEaCorrect("Y");
	                } else {
	                    answerDetail.setEaCorrect("N");
	                }
	                break;
	            }
	        }
	        answerList.add(answerDetail);
	    }

	    String passYn = (totalScore >= passScore) ? "Y" : "N";
	    
	    ExamResultVO result = new ExamResultVO();
	    int nextSeq = examResultDAO.selectExamResultSeqNext();
	    
	    result.setErNum(String.valueOf(nextSeq));
	    result.setTetNum(tetNum);
	    result.setUserNum(userNum);
	    result.setErScore(totalScore);
	    result.setErPass(passYn);
	    result.setErAttempt(1);
	    result.setAnswerList(answerList);
	    
	    examResultDAO.insertExamResult(result);
	    
	    return result;
	}

	@Override
	public List<TestVO> getMyTestResults(String userNum) throws SQLException {
		
		return testDAO.selectCompletedTestList(userNum);
	}

	@Override
	public ExamResultVO getResultDetail(String erNum) throws SQLException {
		
		return examResultDAO.selectExamResult(erNum);
	}

	@Override
	public List<TestVO> getPendingTestList(String userNum) throws Exception {
		
		return testDAO.selectPendingTestList(userNum);
	}

	@Override
	public List<TestVO> getCompletedTestList(String userNum) throws Exception {
		
		return testDAO.selectCompletedTestList(userNum);
	}

	@Override
	public TestVO getTestDetail(String tetNum) throws SQLException {
		
		return testDAO.selectTestByNum(tetNum);
	}

	@Override
	public TestVO getTestCondition(String tetNum) throws SQLException {
		
		TestVO test = testDAO.selectTestCondition(tetNum);
		
		if (test == null) {
	        throw new SQLException("해당 시험 정보를 찾을 수 없습니다: " + tetNum);
	    }
		
		return test;
	}

}

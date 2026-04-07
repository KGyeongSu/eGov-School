package com.school.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import com.school.dao.ExamResultDAO;
import com.school.dao.QuestionDAO;
import com.school.dao.TestDAO;
import com.school.dto.ExamAnswerVO;
import com.school.dto.ExamResultVO;
import com.school.dto.QuestionVO;
import com.school.dto.TestVO;

public class TestServiceImpl implements TestService{
	
	private TestDAO testDAO;
	private QuestionDAO questionDAO;
	private ExamResultDAO examResultDAO;
	
	
	

	public TestServiceImpl(TestDAO testDAO, QuestionDAO quesTionDAO, ExamResultDAO examResultDAO) {
		
		this.testDAO = testDAO;
		this.questionDAO = quesTionDAO;
		this.examResultDAO = examResultDAO;
		
	}
  // 사용자 전용
	@Override
	public List<QuestionVO> getTestPaper(String tetNum) throws SQLException {
		
		return questionDAO.selectQuestionsByTetNum(tetNum);
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

	    List<QuestionVO> realQuestions = questionDAO.selectQuestionsByTetNum(tetNum);
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
  
   // 강사전용
	@Override
	@Transactional
	public void insertTest(TestVO test) throws SQLException {

		// 시험지 번호 세팅
		String tetNum = testDAO.selectTestSeqNext();
		test.setTetNum(tetNum);
		
		// 시험지 저장
		testDAO.insertTest(test);
		
		// 문제 꺼내기
		List <QuestionVO> questionList = test.getTestQuestionList();
		
		if (questionList != null && !questionList.isEmpty()) {
			
			// 테스트 안 문제 번호
			int queSeq =1;
			
			for (QuestionVO question : questionList) {
				
				//queNum 확인하기
				String queNum = questionDAO.selectQuestionSeqNext();
				
				question.setTetNum(tetNum);
				question.setQueNum(queNum);
				question.setQueSeq(queSeq++);
				question.setQuePoint(test.getQuePoint());
				
				// 문제 각각 저장
				questionDAO.insertQuestion(question);
				
			}
			
		}
		
	}

	@Override
	public String selectTestSeqNext() throws SQLException {

		return testDAO.selectTestSeqNext();
		
	}

	@Override
	public TestVO selectTestWithQuestions(String claNum) throws SQLException {

		return testDAO.selectTestWithQuestions(claNum);
		
	}

	@Override
	@Transactional
	public void updateTest(TestVO test) throws SQLException {
		
		
		// 시험지 기본정보 수정
		testDAO.updateTest(test);
		
		// 문제 수정
		List <QuestionVO> questionList = test.getTestQuestionList();
		
		if (questionList != null && !questionList.isEmpty()) {
			
			for (QuestionVO question : questionList) {
				
				// 각 문제 수정
				questionDAO.updateQuestion(question);
        
			}
			
		}
		
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

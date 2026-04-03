package com.school.service;

import java.sql.SQLException;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import com.school.dao.ExamResultDAO;
import com.school.dao.QuestionDAO;
import com.school.dao.TestDAO;
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
  // 사용자 전용
	@Override
	public List<QuestionVO> getTestPaper(String tetNum) throws SQLException {
		
		return quesTionDAO.selectQuestionsByTetNum(tetNum);
	}

	@Override
	public ExamResultVO evaluateTest(List<QuestionVO> userAnswers, String userNum, String tetNum) throws SQLException {
		
		List<QuestionVO>realQuestions = quesTionDAO.selectQuestionsByTetNum(tetNum);
		
		int totalScore  = 0;
		
		for(QuestionVO real : realQuestions) {
			for(QuestionVO user : userAnswers) {
				if(real.getQueNum().equals(user.getQueNum())) {
					if(real.getQueAnswer().equals(user.getQueAnswer())) {
						totalScore += real.getQuePoint();
					}
					break;
				}
			}
		}
		//합격여부
		String passYn = (totalScore >= 60) ? "Y":"N";
		
		//결과저장
		ExamResultVO result = new ExamResultVO();
		int nextSeq = examResultDAO.selectExamResultSeqNext();
		
		result.setErNum(String.valueOf(nextSeq));
		result.setTetNum(tetNum);
		result.setUserNum(userNum);
		result.setErScore(totalScore);
		result.setErPass(passYn);
		result.setErAttempt(1);
		
		
		//DB저장
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
		
		return testDAO.selectCompletedTestList(userNum);
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
		
		if (questionList != null) {
			
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

		return testDAO.selectTestbyTetNum(claNum);
		
	}

	@Override
	@Transactional
	public void updateTest(TestVO test) throws SQLException {
		
		// 시험지 기본정보 수정
		testDAO.updateTest(test);
		
		// 문제 수정
		List <QuestionVO> questionList = test.getTestQuestionList();
		
		if (test.getTestQuestionList() != null) {
			
			for (QuestionVO question : questionList) {
				
				questionDAO.updateQuestion(question);
        
			}
			
		}
		
	}

}

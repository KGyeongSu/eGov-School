package com.school.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.school.dao.QuestionDAO;
import com.school.dao.TestDAO;
import com.school.dto.QuestionVO;
import com.school.dto.TestVO;

public class TestServiceImpl implements TestService {
	
	private final TestDAO testDAO;
	private final QuestionDAO questionDAO;
	
	public TestServiceImpl(TestDAO testDAO, QuestionDAO questionDAO) {

		this.testDAO = testDAO;
		this.questionDAO = questionDAO;
		
	}

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

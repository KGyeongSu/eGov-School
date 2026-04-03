package com.school.service;

import java.sql.SQLException;

import com.school.dto.TestVO;

public interface TestService {
	
	// 강사
	// 테스트 등록
	void insertTest(TestVO test) throws SQLException;
	
	// 테스트 등록 시퀀스 받아오기
	String selectTestSeqNext() throws SQLException;
	
	// 수정 시 번호로 불러오기
	TestVO selectTestbyTetNum(String tetNum) throws SQLException;
	
	// 수정
	void updateTest(TestVO test) throws SQLException;
	
}

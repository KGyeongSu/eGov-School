package com.school.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.school.cmd.PageMaker;
import com.school.dto.ClassVO;
import com.school.dto.UserVO;

public interface ClassService {
	
  // 강사
	// 클래스 리스트 가져오기
	List <ClassVO> selectClassList (PageMaker pageMaker, String userNum) throws SQLException;
	
	List <ClassVO> selectTestClassList (PageMaker pageMaker, String userNum) throws SQLException;
	
	// 리스트 카운트(paging)
	int selectSearchClassListCount (PageMaker pageMaker, String userNum) throws SQLException;
	
	// 강의실 등록
	void insertClass (ClassVO classVO) throws SQLException;
	
	// 강의실 등록 시퀀스 번호 가져오기
	String selectClassSeqNext() throws SQLException;
	
	// detail & 조회수
	ClassVO selectClassByCla_num (String claNum) throws SQLException;
	
	void increaseViewCnt (String claNum) throws SQLException;
	
	// 해당 강좌 수강중인 학생 리스트
	List <UserVO> selectStdentListByClaNum (PageMaker pageMaker, String claNum) throws SQLException;
		
	// 수강중인 학생 수 세기
	int selectStudentListCount(PageMaker pageMaker, String claNum) throws SQLException;
	
	// 메시지 중복 발송 방지
	List <UserVO> selectUnsentStudentList (String claNum, String tetNum) throws SQLException;
	
	// 메인대시보드 출제 평가 리스트 응시율 뿌려주기 목적
	List <ClassVO> selectTestClassListForDashboard (@Param("userNum") String userNum) throws SQLException;
	
	// my 강의실 수강생 관리 주차별 진도율 뿌려주기 목적
	List<ClassVO> selectWeeklyAverageProgress(String claNum) throws SQLException;
	
	// my 강의실 수강생 관리 각 강의별 테스트 응시율 뿌려주기 목적
	double selectTestRateByClaNum (String claNum) throws SQLException;
	
	// 강의실 강의 등록률
	int selectRegiRate (String claNum) throws SQLException;

  
  // 사용자
	// 수강신청 페이지용 (승인완료 강좌)
	List<ClassVO> selectApprovedClassList(PageMaker pageMaker) throws SQLException;
	// PageMaker 페이지 계산할때 쓰임.
	int selectApprovedClassListCount(PageMaker pageMaker) throws SQLException;

}

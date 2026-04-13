package com.school.service;

import java.sql.SQLException;
import java.util.List;

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
  
  // 사용자
	// 수강신청 페이지용 (승인완료 강좌)
	List<ClassVO> selectApprovedClassList(PageMaker pageMaker) throws SQLException;
	// PageMaker 페이지 계산할때 쓰임.
	int selectApprovedClassListCount(PageMaker pageMaker) throws SQLException;
	

 // 관리자
	// 관리자용: 승인대기 강좌 목록
	List<ClassVO> selectPendingClassList(PageMaker pageMaker) throws SQLException;

	// 관리자용: 승인대기 강좌 개수 (페이징)
	int selectPendingClassListCount(PageMaker pageMaker) throws SQLException;

	// 관리자용: 강좌 승인 처리
	void approveClass(ClassVO classVO) throws SQLException;

}

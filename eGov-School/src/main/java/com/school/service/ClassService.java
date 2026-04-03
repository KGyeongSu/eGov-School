package com.school.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.school.cmd.PageMaker;
import com.school.dto.ClassVO;
import com.school.dto.UserVO;

public interface ClassService {
	
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

}

package com.school.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.school.cmd.PageMaker;
import com.school.dto.ClassVO;

public interface ClassService {
	
	// 클래스 리스트 가져오기
	List <ClassVO> selectClassList (PageMaker pageMaker, String userNum) throws SQLException;
	
	// 강사의 강좌 중 검색하면 나올 리스트
	List <ClassVO> selectSearchClassList (PageMaker pageMaker, String userNum) throws SQLException;
	
	// 리스트 카운트(paging)
	int selectSearchClassListCount (PageMaker pageMaker, String userNum) throws SQLException;
	
	// 강의실 등록
	void insertClass (ClassVO clas) throws SQLException;
	
	// 강의실 등록 시퀀스 번호 가져오기
	int selectClassSeqNext() throws SQLException;
	
	// detail & 조회수
	ClassVO selectClassByCla_num (String claNum) throws SQLException;
	
	void increaseViewCnt (String claNum) throws SQLException;

}

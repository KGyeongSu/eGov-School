package com.school.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.school.cmd.PageMaker;
import com.school.dto.ClassVO;
import com.school.dto.UserVO;

public interface ClassDAO {
	
	List <ClassVO> selectClassList (@Param("pageMaker") PageMaker pageMaker,
									@Param("userNum") String userNum, RowBounds rows) throws SQLException;
	
	List <ClassVO> selectSearchClassList (@Param("pageMaker") PageMaker pageMaker,
										  @Param("userNum") String userNum) throws SQLException;
	
	ClassVO selectClassByCla_num (String claNum) throws SQLException;
	
	int selectSearchClassListCount (@Param("pageMaker") PageMaker pageMaker,
			  						@Param("userNum") String userNum) throws SQLException;
	
	void insertClass (ClassVO clas) throws SQLException;
	
	void increaseViewCnt (String claNum) throws SQLException;
	
	String selectClassSeqNext() throws SQLException;
	
	// 수강중인 학생 리스트 뽑기
	List<UserVO> selectStudentListByClaNum(@Param("pageMaker") PageMaker pageMaker, @Param("claNum") String claNum, RowBounds rows) throws SQLException;
	
	// 수강중인 학생 수 세기
	int selectStudentListCount(@Param("pageMaker") PageMaker pageMaker, @Param("claNum") String claNum) throws SQLException;
	
	//수강신청 페이지용 (승인완료 강좌)
	List<ClassVO> selectApprovedClassList(@Param("pageMaker") PageMaker pageMaker) throws SQLException;
	// PageMaker 페이지 계산할때 쓰임.
	int selectApprovedClassListCount(@Param("pageMaker") PageMaker pageMaker) throws SQLException;

	void updateClassProgress(String userNum, String claNum, int progressPercent) throws SQLException;
	
	// 메시지 중복 발송 방지 학생 리스트
	List <UserVO> selectUnsentStudentList (@Param("claNum") String claNum, @Param("tetNum") String tetNum);
	
	// 메인대시보드 출제 평가 리스트 응시율 뿌려주기 목적
	List <ClassVO> selectTestClassListForDashboard (@Param("userNum") String userNum) throws SQLException;
	
	// my 강의실 수강생 관리 주차별 진도율 뿌려주기 목적
	List<ClassVO> selectWeeklyAverageProgress(String claNum) throws SQLException;
	
	// my 강의실 수강생 관리 각 강의별 테스트 응시율 뿌려주기 목적
	double selectTestRateByClaNum (String claNum) throws SQLException;
	
	// 강의실 강의 등록률
	int selectRegiRate (String claNum) throws SQLException;

}
 
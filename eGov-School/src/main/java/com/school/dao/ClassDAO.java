package com.school.dao;

import java.sql.SQLException;
import java.util.List;

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

}

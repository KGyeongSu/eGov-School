package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.school.cmd.PageMaker;
import com.school.dto.ClassVO;

public interface ClassDAO {
	
	List <ClassVO> selectClassList (@Param("pageMaker") PageMaker pageMaker,
									@Param("userNum") String userNum) throws SQLException;
	
	List <ClassVO> selectSearchClassList (@Param("pageMaker") PageMaker pageMaker,
										  @Param("userNum") String userNum) throws SQLException;
	
	ClassVO selectClassByCla_num (String claNum) throws SQLException;
	
	int selectSearchClassListCount (@Param("pageMaker") PageMaker pageMaker,
			  						@Param("userNum") String userNum) throws SQLException;
	
	void insertClass (ClassVO clas) throws SQLException;
	
	void increaseViewCnt (String claNum) throws SQLException;
	
	int selectClassSeqNext() throws SQLException;
	
	//수강신청 페이지용 (승인완료 강좌)
	List<ClassVO> selectApprovedClassList(@Param("pageMaker") PageMaker pageMaker) throws SQLException;
	// PageMaker 페이지 계산할때 쓰임.
	int selectApprovedClassListCount(@Param("pageMaker") PageMaker pageMaker) throws SQLException;

}
 
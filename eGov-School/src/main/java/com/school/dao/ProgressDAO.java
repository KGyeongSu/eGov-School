package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.school.dto.ProgressVO;

public interface ProgressDAO {

	
    List<ProgressVO> selectProgressList(@Param("userNum") String userNum, 
                                        @Param("claNum") String claNum) throws SQLException;
    	
    ProgressVO selectProgressCount(@Param("userNum") String userNum, 
                                   @Param("claNum") String claNum) throws SQLException;
	void insertProgress(ProgressVO progress)throws SQLException;
	
	void updateProgress(ProgressVO progress)throws SQLException;
	
	int selectProgresseqNext()throws SQLException;
	
	
	
}

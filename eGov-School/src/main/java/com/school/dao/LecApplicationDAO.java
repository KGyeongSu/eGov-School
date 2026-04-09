package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.PageMaker;
import com.school.dto.LecApplicationVO;

public interface LecApplicationDAO {
	
	List <LecApplicationVO> selectLecApplicationList (PageMaker pageMaker) throws SQLException;
	
	LecApplicationVO selectLecApplicationByLa_num (String la_num) throws SQLException;
	
	void insertLecApplication (LecApplicationVO lecApplication) throws SQLException;
	
	int selectLecApplicationSeqNext () throws SQLException;

}

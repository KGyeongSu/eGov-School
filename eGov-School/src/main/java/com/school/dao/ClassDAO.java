package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.PageMaker;
import com.school.dto.ClassVO;

public interface ClassDAO {
	
	List <ClassVO> selectClassList (PageMaker pageMaker) throws SQLException;
	
	List <ClassVO> selectSearchClassList (PageMaker pageMaker) throws SQLException;
	
	ClassVO selectClassByCla_num (String cla_num) throws SQLException;
	
	int selectSearchClassListCount (PageMaker pageMaker) throws SQLException;
	
	void insertClass (ClassVO clas) throws SQLException;
	
	void increaseViewCnt (String cla_num) throws SQLException;
	
	int selectClassSeqNext() throws SQLException;

}

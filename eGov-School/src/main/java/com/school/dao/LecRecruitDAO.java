package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.PageMaker;
import com.school.dto.LecRecruitVO;

public interface LecRecruitDAO {
	
	List <LecRecruitVO> selectLecRecruitList (PageMaker pageMaker) throws SQLException;
	
	List <LecRecruitVO> selectSearchLecRecruitList (PageMaker pageMaker) throws SQLException;
	
	int selectSearchLecRecruitListCount (PageMaker pageMaker) throws SQLException;
	
	LecRecruitVO selectLecRecruitByLt_num (String lt_num) throws SQLException;
	
	void insertLecRecruit (LecRecruitVO lecRecruit) throws SQLException;
	
	void updateLecRecruitStatus (LecRecruitVO lecRecruit) throws SQLException;
	
	void increaseViewCnt (String lt_num) throws SQLException;
	
	int selectLecRecruitSeqNext () throws SQLException;

}

package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.PageMaker;
import com.school.dto.ExamNoticeVO;

public interface ExamNoticeDAO {
	
	List <ExamNoticeVO> selectExamNoticeList (PageMaker pageMaker) throws SQLException;
	
	List <ExamNoticeVO> selectSearchExamNoticeList (PageMaker pageMaker) throws SQLException;
	
	int selectSearchExamNoticeListCount(PageMaker pageMaker) throws SQLException;
	
	ExamNoticeVO selectExamNoticeByEn_num (String en_num) throws SQLException;
	
	void insertExamNotice (ExamNoticeVO examNotice) throws SQLException;
	
	void increaseViewCnt (String en_num) throws SQLException;
	
	String selectExamNoticeSeqNext () throws SQLException;
	
}

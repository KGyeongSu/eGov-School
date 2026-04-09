package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.PageMaker;
import com.school.dto.JobNoticeVO;

public interface JobNoticeDAO {
	
	List <JobNoticeVO> selectJobNoticeList (PageMaker pageMaker) throws SQLException;
	
	List <JobNoticeVO> selectSearchJobNoticeList (PageMaker pageMaker) throws SQLException;
	
	int selectSearchJobNoticeListCount (PageMaker pageMaker) throws SQLException;
	
	JobNoticeVO selectJobListByJn_num (String jn_num) throws SQLException;
	
	void insertJobNotice (JobNoticeVO jobNotice) throws SQLException;
	
	void increaseViewCnt (String jn_num) throws SQLException;
	
	String selectJobNoticeSeqNext () throws SQLException;

}

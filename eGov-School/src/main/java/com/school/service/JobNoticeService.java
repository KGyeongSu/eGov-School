package com.school.service;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.PageMaker;
import com.school.dto.JobNoticeVO;

public interface JobNoticeService {

	List<JobNoticeVO> selectJobNoticeList(PageMaker pageMaker) throws SQLException;

    List<JobNoticeVO> selectSearchJobNoticeList(PageMaker pageMaker) throws SQLException;

    int selectSearchJobNoticeListCount(PageMaker pageMaker) throws SQLException;

    JobNoticeVO selectJobListByJn_num(String jnNum) throws SQLException;
    
    void insertJobNotice(JobNoticeVO vo) throws SQLException;
}

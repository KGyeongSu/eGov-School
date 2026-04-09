package com.school.service;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.PageMaker;
import com.school.dao.JobNoticeDAO;
import com.school.dto.JobNoticeVO;


public class JobNoticeServiceImpl implements JobNoticeService {

	private JobNoticeDAO jobNoticeDAO;

    public JobNoticeServiceImpl(JobNoticeDAO jobNoticeDAO) {
        this.jobNoticeDAO = jobNoticeDAO;
    }

    @Override
    public List<JobNoticeVO> selectJobNoticeList(PageMaker pageMaker) throws SQLException {
        return jobNoticeDAO.selectJobNoticeList(pageMaker);
    }

    @Override
    public List<JobNoticeVO> selectSearchJobNoticeList(PageMaker pageMaker) throws SQLException {
        return jobNoticeDAO.selectSearchJobNoticeList(pageMaker);
    }

    @Override
    public int selectSearchJobNoticeListCount(PageMaker pageMaker) throws SQLException {
        return jobNoticeDAO.selectSearchJobNoticeListCount(pageMaker);
    }

    @Override
    public JobNoticeVO selectJobListByJn_num(String jnNum) throws SQLException {
        return jobNoticeDAO.selectJobListByJn_num(jnNum);
    }

	@Override
	public void insertJobNotice(JobNoticeVO vo) throws SQLException {
		String jnNum = jobNoticeDAO.selectJobNoticeSeqNext();
        vo.setJnNum(String.valueOf(jnNum));
        jobNoticeDAO.insertJobNotice(vo);
	}

	
}

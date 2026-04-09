package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.school.cmd.PageMaker;
import com.school.dto.JobNoticeVO;

public class JobNoticeDAOImpl implements JobNoticeDAO {
	
	private final SqlSession session;

	public JobNoticeDAOImpl(SqlSession session) {

		this.session = session;
		
	}

	@Override
	public List<JobNoticeVO> selectJobNoticeList(PageMaker pageMaker) throws SQLException {
		
		int offset = pageMaker.getStartRow() - 1;
		int limit = pageMaker.getPerPageNum();
		RowBounds rows = new RowBounds (offset, limit);
		
		List <JobNoticeVO> jobNoticeList = session.selectList("JobNotice-Mapper.selectJobNoticeList", pageMaker, rows);
		
		return jobNoticeList;
		
	}

	@Override
	public List<JobNoticeVO> selectSearchJobNoticeList(PageMaker pageMaker) throws SQLException {
		
		int offset = pageMaker.getStartRow() - 1;
		int limit = pageMaker.getPerPageNum();
		RowBounds rows = new RowBounds(offset, limit);
		
		List <JobNoticeVO> searchJobNoticeList = session.selectList("JobNotice-Mapper.selectSearchJobNoticeList", pageMaker, rows);
		
		return searchJobNoticeList;
		
	}

	@Override
	public int selectSearchJobNoticeListCount(PageMaker pageMaker) throws SQLException {

		return session.selectOne("JobNotice-Mapper.selectSearchJobNoticeListCount", pageMaker);
		
	}

	@Override
	public JobNoticeVO selectJobListByJn_num(String jn_num) throws SQLException {

		return session.selectOne("JobNotice-Mapper.selectJobListByJn_num", jn_num);
		
	}

	@Override
	public void insertJobNotice(JobNoticeVO jobNotice) throws SQLException {

		session.insert("JobNotice-Mapper.insertJobNotice", jobNotice);
		
	}

	@Override
	public void increaseViewCnt(String jn_num) throws SQLException {

		session.update("JobNotice-Mapper.increaseViewCnt", jn_num);
		
	}

	@Override
	public String selectJobNoticeSeqNext() throws SQLException {

		return session.selectOne("JobNotice-Mapper.selectJobNoticeSeqNext");
		
	}
	
	

}

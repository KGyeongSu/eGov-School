package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.school.cmd.PageMaker;
import com.school.dto.ExamNoticeVO;

public class ExamNoticeDAOImpl implements ExamNoticeDAO {
	
	private final SqlSession session;

	public ExamNoticeDAOImpl(SqlSession session) {
		
		this.session = session;
		
	}

	@Override
	public List<ExamNoticeVO> selectExamNoticeList(PageMaker pageMaker) throws SQLException {
		
		int offset = pageMaker.getStartRow() -1;
		int limit = pageMaker.getPerPageNum();
		RowBounds rows = new RowBounds (offset, limit);
		
		List <ExamNoticeVO> examNoticeList = session.selectList("ExamNotice-Mapper.selectExamNoticeList", pageMaker, rows);
		
		return examNoticeList;
		
	}

	@Override
	public List<ExamNoticeVO> selectSearchExamNoticeList(PageMaker pageMaker) throws SQLException {
		
		int offset = pageMaker.getStartRow()-1;
		int limit = pageMaker.getPerPageNum();
		RowBounds rows = new RowBounds(offset, limit);
		
		List <ExamNoticeVO> searchExamNotice = session.selectList("ExamNotice-Mapper.selectSearchExamNoticeList", pageMaker, rows);
		
		return searchExamNotice;
		
	}

	@Override
	public int selectSearchExamNoticeListCount(PageMaker pageMaker) throws SQLException {

		return session.selectOne("ExamNotice-Mapper.selectSearchExamNoticeListCount", pageMaker);
		
	}

	@Override
	public ExamNoticeVO selectExamNoticeByEn_num(String en_num) throws SQLException {

		return session.selectOne("ExamNotice-Mapper.selectExamNoticeByEn_num", en_num);
		
	}

	@Override
	public void insertExamNotice(ExamNoticeVO examNotice) throws SQLException {

		session.insert("ExamNotice-Mapper.insertExamNotice", examNotice);
		
	}

	@Override
	public void increaseViewCnt(String en_num) throws SQLException {

		session.update("ExamNotice-Mapper.increaseViewCnt", en_num);
		
	}

	@Override
	public String selectExamNoticeSeqNext() throws SQLException {

		return session.selectOne("ExamNotice-Mapper.selectExamNoticeSeqNext");
		
	}
	
	

}

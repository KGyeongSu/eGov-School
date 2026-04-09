package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.school.cmd.PageMaker;
import com.school.dto.LecRecruitVO;

public class LecRecruitDAOImpl implements LecRecruitDAO {
	
	private final SqlSession session;

	public LecRecruitDAOImpl(SqlSession session) {
		
		this.session = session;
		
	}

	@Override
	public List<LecRecruitVO> selectLecRecruitList(PageMaker pageMaker) throws SQLException {
		
		int offset = pageMaker.getStartRow() - 1;
		int limit = pageMaker.getPerPageNum();
		RowBounds rows = new RowBounds(offset, limit);
		
		List <LecRecruitVO> lecRecruitList = session.selectList("LecRecruit-Mapper.selectLecRecruitList", pageMaker, rows);
		
		return lecRecruitList;
		
	}

	@Override
	public List<LecRecruitVO> selectSearchLecRecruitList(PageMaker pageMaker) throws SQLException {
		
		int offset = pageMaker.getStartRow() - 1;
		int limit = pageMaker.getPerPageNum();
		RowBounds rows = new RowBounds (offset, limit);
		
		List <LecRecruitVO> searchLecRecruitList = session.selectList("LecRecruit-Mapper.selectSearchLecRecruitList", pageMaker, rows);

		return searchLecRecruitList;
		
	}

	@Override
	public int selectSearchLecRecruitListCount(PageMaker pageMaker) throws SQLException {

		return session.selectOne("LecRecruit-Mapper.selectSearchLecRecruitListCount", pageMaker);
		
	}

	@Override
	public LecRecruitVO selectLecRecruitByLt_num(String lt_num) throws SQLException {
		
		return session.selectOne("LecRecruit-Mapper.selectLecRecruitByLt_num", lt_num);
		
	}

	@Override
	public void insertLecRecruit(LecRecruitVO lecRecruit) throws SQLException {

		session.insert("LecRecruit-Mapper.insertLecRecruit", lecRecruit);
		
	}

	@Override
	public void updateLecRecruitStatus(LecRecruitVO lecRecruit) throws SQLException {

		session.update("LecRecruit-Mapper.updateLecRecruitStatus", lecRecruit);
		
	}

	@Override
	public void increaseViewCnt(String lt_num) throws SQLException {

		session.update("LecRecruit-Mapper.increaseViewCnt", lt_num);
		
	}

	@Override
	public int selectLecRecruitSeqNext() throws SQLException {

		return session.selectOne("LecRecruit-Mapper.selectLecRecruitSeqNext");
		
	}
	
	

}

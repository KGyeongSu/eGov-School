package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.school.cmd.PageMaker;
import com.school.dto.LecApplicationVO;

public class LecApplicationDAOImpl implements LecApplicationDAO{
	
	private final SqlSession session;

	public LecApplicationDAOImpl(SqlSession session) {
		
		this.session = session;
		
	}

	@Override
	public List<LecApplicationVO> selectLecApplicationList(PageMaker pageMaker) throws SQLException {

		int offset = pageMaker.getStartRow() - 1;
		int limit = pageMaker.getPerPageNum();
		RowBounds rows = new RowBounds(offset, limit);
		
		List <LecApplicationVO> lecApplicationList = session.selectList("LecApplication-Mapper.selectLecApplicationList", pageMaker, rows);
		
		return lecApplicationList;
		
	}

	@Override
	public LecApplicationVO selectLecApplicationByLa_num(String la_num) throws SQLException {

		return session.selectOne("LecApplication-Mapper.selectLecApplicationByLa_num", la_num);
		
	}

	@Override
	public void insertLecApplication(LecApplicationVO lecApplication) throws SQLException {

		session.insert("LecApplication-Mapper.insertLecApplication", lecApplication);
		
	}

	@Override
	public int selectLecApplicationSeqNext() throws SQLException {

		return session.selectOne("LecApplication-Mapper.selectLecApplicationSeqNext");
		
	}
	
	

}

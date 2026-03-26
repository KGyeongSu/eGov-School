package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.school.cmd.PageMaker;
import com.school.dto.ClassVO;

public class ClassDAOImpl implements ClassDAO {
	
	private SqlSession session;

	public ClassDAOImpl(SqlSession session) {
		
		this.session = session;
		
	}

	@Override
	public List<ClassVO> selectClassList(PageMaker pageMaker) throws SQLException {
		
		int offset = pageMaker.getStartRow() -1;
		int limit = pageMaker.getPerpageNum();
		RowBounds rows = new RowBounds (offset, limit);
		
		List <ClassVO> classList = session.selectList("Class-Mapper.selectClassList", pageMaker, rows);
		
		return classList;
		
	}
	
	@Override
	public List<ClassVO> selectSearchClassList(PageMaker pageMaker) throws SQLException {
		
		int offset = pageMaker.getStartRow() -1;
		int limit = pageMaker.getPerpageNum();
		RowBounds rows = new RowBounds (offset, limit);
		
		List <ClassVO> classList = session.selectList("Class-Mapper.selectSearchClassList", pageMaker, rows);
		
		return classList;
		
	}

	@Override
	public ClassVO selectClassByCla_num(String cla_num) throws SQLException {
		
		return session.selectOne("Class-Mapper.selectClassByCla_num", cla_num);
		
	}
	
	@Override
	public int selectSearchClassListCount(PageMaker pageMaker) throws SQLException {
		
		return session.selectOne("Class-Mapper.selectSearchClassListCount", pageMaker);
		
	}

	@Override
	public void insertClass(ClassVO clas) throws SQLException {

		session.insert("Class-Mapper.insertClass", clas);
		
	}

	@Override
	public void increaseViewCnt(String cla_num) throws SQLException {
		
		session.update("Class-Mapper.increaseViewCnt", cla_num);
		
	}

	@Override
	public int selectClassSeqNext() throws SQLException {

		return session.selectOne("Class-Mapper.selectClassSeqNext");
		
	}

}

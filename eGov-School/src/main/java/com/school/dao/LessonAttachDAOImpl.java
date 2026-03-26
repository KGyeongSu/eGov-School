package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.LessonAttachVO;

public class LessonAttachDAOImpl implements LessonAttachDAO {

	private SqlSession session;

	public LessonAttachDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public String selectLessonAttachSeqNext() throws SQLException {
		return session.selectOne("LessonAttach-Mapper.selectLessonAttachSeqNext");
	}

	@Override
	public void insertLessonAttach(LessonAttachVO attach) throws SQLException {
		session.insert("LessonAttach-Mapper.insertLessonAttach", attach);
	}

	@Override
	public List<LessonAttachVO> selectLessonAttachList(String lsnNum) throws SQLException {
		return session.selectList("LessonAttach-Mapper.selectLessonAttachList", lsnNum);
	}

	@Override
	public void deleteLessonAttach(String laNum) throws SQLException {
		session.delete("LessonAttach-Mapper.deleteLessonAttach", laNum);
	}

	@Override
	public void deleteLessonAttachByParent(String lsnNum) throws SQLException {
		session.delete("LessonAttach-Mapper.deleteLessonAttachByParent", lsnNum);
	}
}

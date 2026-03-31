package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;

import com.school.dto.LessonVO;

public class LessonDAOImpl implements LessonDAO {

	private SqlSession session;

	public LessonDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public String selectLessonSeqNext() throws SQLException {
		return session.selectOne("Lesson-Mapper.selectLessonSeqNext");
	}

	@Override
	public void insertLesson(LessonVO lesson) throws SQLException {
		session.insert("Lesson-Mapper.insertLesson", lesson);
	}

	@Override
	public List<LessonVO> selectLessonList(String claNum) throws SQLException {
		return session.selectList("Lesson-Mapper.selectLessonList", claNum);
	}

	@Override
	public LessonVO selectLessonByNum(String lsnNum) throws SQLException {
		return session.selectOne("Lesson-Mapper.selectLessonByNum", lsnNum);
	}

	@Override
	public void updateLesson(LessonVO lesson) throws SQLException {
		session.update("Lesson-Mapper.updateLesson", lesson);
	}

	@Override
	public void deleteLesson(String lsnNum) throws SQLException {
		session.delete("Lesson-Mapper.deleteLesson", lsnNum);
	}

	@Override
	public int selectMaxLsnSeq(@Param("claNum") String claNum) throws SQLException {
		
		return session.selectOne("Lesson-Mapper.selectMaxLsnSeq", claNum);
		
	}
}
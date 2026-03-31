package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.LessonAttachVO;
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
	public LessonVO selectLessonByNum(LessonVO lesson) throws SQLException {
		return session.selectOne("Lesson-Mapper.selectLessonByNum", lesson);
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
	public String selectFirstLessonNum(String claNum) throws SQLException {
	    // 해당 강의의 차시 중 가장 작은 번호(첫 번째 강의)를 가져옴
	    return session.selectOne("Lesson-Mapper.selectFirstLessonNum", claNum);
	}

	@Override
	public String selectPrevLsnNum(LessonVO lesson) throws SQLException {
	    return session.selectOne("Lesson-Mapper.selectPrevLsnNum", lesson);
	}

	@Override
	public String selectNextLsnNum(LessonVO lesson) throws SQLException {
	    return session.selectOne("Lesson-Mapper.selectNextLsnNum", lesson);
	}
	@Override
	public int selectTotalLessonCount(String claNum) throws SQLException {
	    // 진도율 계산의 분모가 될 전체 차시 개수
	    return session.selectOne("Lesson-Mapper.selectTotalLessonCount", claNum);
	}

	@Override
	public List<LessonAttachVO> selectLessonFileList(String lsnNum) throws SQLException {
		
		return session.selectList("Lesson-Mapper.selectLessonFileList", lsnNum);
	}

	@Override
	public List<LessonVO> selectLessonListByClaNum(String claNum) throws SQLException {
	
		return session.selectList("Lesson-Mapper.selectLessonListByClaNum",claNum);
	}
}
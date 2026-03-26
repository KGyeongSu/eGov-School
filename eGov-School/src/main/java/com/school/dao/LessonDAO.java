package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.LessonVO;

public interface LessonDAO {

	String selectLessonSeqNext() throws SQLException;

	void insertLesson(LessonVO lesson) throws SQLException;

	List<LessonVO> selectLessonList(String claNum) throws SQLException;

	LessonVO selectLessonByNum(String lsnNum) throws SQLException;

	void updateLesson(LessonVO lesson) throws SQLException;

	void deleteLesson(String lsnNum) throws SQLException;
}
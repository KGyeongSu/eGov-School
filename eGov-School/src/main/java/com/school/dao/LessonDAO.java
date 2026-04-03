package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.school.cmd.PageMaker;
import com.school.dto.LessonVO;
import com.school.dto.UserVO;

public interface LessonDAO {

	String selectLessonSeqNext() throws SQLException;

	void insertLesson(LessonVO lesson) throws SQLException;

	List<LessonVO> selectLessonList(String claNum) throws SQLException;

	LessonVO selectLessonByLsnNum(String lsnNum) throws SQLException;

	void updateLesson(LessonVO lesson) throws SQLException;

	void deleteLesson(String lsnNum) throws SQLException;
	
	int selectMaxLsnSeq(@Param("claNum") String claNum) throws SQLException;
	
}
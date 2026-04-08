package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.LessonAttachVO;

public interface LessonAttachDAO {

	String selectLessonAttachSeqNext() throws SQLException;

	void insertLessonAttach(LessonAttachVO attach) throws SQLException;

	List<LessonAttachVO> selectLessonAttachList(String lsnNum) throws SQLException;

	void deleteLessonAttach(String laNum) throws SQLException;

	void deleteLessonAttachByParent(String lsnNum) throws SQLException;
	
	// 파일 수정 시 삭제
	void deleteLessonAttachBySaveName(String laSaveName) throws Exception;
	
	LessonAttachVO selectLessonAttachByLaNum(String laNum) throws SQLException;

	List<LessonAttachVO> selectLessonFileList(String lsnNum) throws SQLException;
}

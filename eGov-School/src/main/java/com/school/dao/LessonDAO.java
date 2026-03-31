package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.LessonAttachVO;
import com.school.dto.LessonVO;

public interface LessonDAO {

    String selectLessonSeqNext() throws SQLException;
    
    void insertLesson(LessonVO lesson) throws SQLException;
    
    List<LessonVO> selectLessonList(String claNum) throws SQLException;
    
    LessonVO selectLessonByNum(LessonVO lesson) throws SQLException;
    
    void updateLesson(LessonVO lesson) throws SQLException;
    
    void deleteLesson(String lsnNum) throws SQLException;
    
    String selectFirstLessonNum(String claNum) throws SQLException;

   
    String selectPrevLsnNum(LessonVO lesson) throws SQLException;


    String selectNextLsnNum(LessonVO lesson) throws SQLException;

   
    int selectTotalLessonCount(String claNum) throws SQLException;
    
    List<LessonAttachVO> selectLessonFileList(String lsnNum) throws SQLException;
    
	List<LessonVO> selectLessonListByClaNum(String claNum)throws SQLException;
}
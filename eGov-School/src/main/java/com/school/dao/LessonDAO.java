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

    /* 2. 이전 차시 번호 조회 (VO 사용) */
    String selectPrevLsnNum(LessonVO lesson) throws SQLException;

    /* 3. 다음 차시 번호 조회 (VO 사용) */
    String selectNextLsnNum(LessonVO lesson) throws SQLException;

    /* 4. 전체 차시 개수 조회 */
    int selectTotalLessonCount(String claNum) throws SQLException;
    
    List<LessonAttachVO> selectLessonFileList(String lsnNum) throws SQLException;
}
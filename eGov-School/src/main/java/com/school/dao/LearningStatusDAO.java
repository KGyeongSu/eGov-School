package com.school.dao;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Param;

import com.school.dto.LearningStatusVO;

public interface LearningStatusDAO {

    void updateLessonComplete(LearningStatusVO status) throws SQLException;

    int selectCompletedLessonCount(LearningStatusVO status) throws SQLException;

    void upsertLearningStatus(LearningStatusVO status) throws SQLException;

    LearningStatusVO selectLearningStatus(LearningStatusVO status) throws SQLException;

    int selectLastLearningSeq(LearningStatusVO status) throws SQLException;
    
    // 강의실 사용자관리 내 정보 입력
    LearningStatusVO selectStudentLearningStatusAtManage (@Param("userNum") String userNum, @Param("claNum") String claNum) throws SQLException;

}
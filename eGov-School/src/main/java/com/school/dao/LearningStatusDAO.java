package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.LearningStatusVO;

public interface LearningStatusDAO {

    void updateLessonComplete(LearningStatusVO status) throws SQLException;

    int selectCompletedLessonCount(LearningStatusVO status) throws SQLException;

    void upsertLearningStatus(LearningStatusVO status) throws SQLException;

    LearningStatusVO selectLearningStatus(LearningStatusVO status) throws SQLException;

    int selectLastLearningSeq(LearningStatusVO status) throws SQLException;
 // LearningStatusDAO.java
    List<LearningStatusVO> selectLearningStatusList(LearningStatusVO status) throws SQLException;

}
package com.school.dao;

import java.sql.SQLException;
import com.school.dto.LearningStatusVO;

public interface LearningStatusDAO {

    void updateLessonComplete(LearningStatusVO status) throws SQLException;

    int selectCompletedLessonCount(LearningStatusVO status) throws SQLException;

    void upsertLearningStatus(LearningStatusVO status) throws SQLException;

    LearningStatusVO selectLearningStatus(LearningStatusVO status) throws SQLException;



}
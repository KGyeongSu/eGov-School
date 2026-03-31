package com.school.dao;

import java.sql.SQLException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.school.dto.LearningStatusVO;


public class LearningStatusDAOImpl implements LearningStatusDAO {

	private final SqlSession session;

    // XML의 c:session-ref="sqlSession"이 이 생성자를 호출합니다.
    public LearningStatusDAOImpl(SqlSession session) {
        this.session = session;
    }

    @Override
    public void updateLessonComplete(LearningStatusVO status) throws SQLException {
        session.update("LearningStatus-Mapper.updateLessonComplete", status);
    }

    @Override
    public int selectCompletedLessonCount(LearningStatusVO status) throws SQLException {
        return session.selectOne("LearningStatus-Mapper.selectCompletedLessonCount", status);
    }

    @Override
    public void upsertLearningStatus(LearningStatusVO status) throws SQLException {
        session.update("LearningStatus-Mapper.upsertLearningStatus", status);
    }

    @Override
    public LearningStatusVO selectLearningStatus(LearningStatusVO status) throws SQLException {
        return session.selectOne("LearningStatus-Mapper.selectLearningStatus", status);
    }
}
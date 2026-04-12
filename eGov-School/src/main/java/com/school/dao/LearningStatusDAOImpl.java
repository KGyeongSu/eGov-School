package com.school.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

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

	@Override
	public int selectLastLearningSeq(LearningStatusVO status) throws SQLException {
		// 만약 데이터가 없으면 null이 반환될 수 있으므로 기본값을 처리
	    Integer lastSeq = session.selectOne("LearningStatus-Mapper.selectLastLearningSeq", status);
	    return (lastSeq == null) ? 1 : lastSeq;
	}

	@Override
	public LearningStatusVO selectStudentLearningStatusAtManage(String userNum, String claNum) throws SQLException {
		
		Map <String, Object> statusManage = new HashMap <> ();
		
		statusManage.put("userNum", userNum);
		statusManage.put("claNum", claNum);
		
		return session.selectOne("LearningStatus-Mapper.selectStudentLearningStatusAtManage", statusManage);
		
	}
}
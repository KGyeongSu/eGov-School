package com.school.dao;

import java.sql.SQLException;
import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.school.dto.LessonAttachVO;
import com.school.dto.LessonVO;

@Repository
public class LessonDAOImpl implements LessonDAO {

    private final SqlSession session;

    public LessonDAOImpl(SqlSession session) {
        this.session = session;
    }

    @Override
    public String selectLessonSeqNext() throws SQLException {
        return session.selectOne("Lesson-Mapper.selectLessonSeqNext");
    }

    @Override
    public void insertLesson(LessonVO lesson) throws SQLException {
        session.insert("Lesson-Mapper.insertLesson", lesson);
    }

    @Override
    public List<LessonVO> selectLessonList(String claNum) throws SQLException {
        return session.selectList("Lesson-Mapper.selectLessonList", claNum);
    }

    /**
     * 강의 상세 조회 (lsnNum 기준)
     * 파라미터 lesson 객체에 claNum과 lsnNum이 반드시 세팅되어 있어야 합니다.
     */
    @Override
    public LessonVO selectLessonByNum(LessonVO lesson) throws SQLException {
        return session.selectOne("Lesson-Mapper.selectLessonByNum", lesson);
    }

    @Override
    public void updateLesson(LessonVO lesson) throws SQLException {
        session.update("Lesson-Mapper.updateLesson", lesson);
    }

    @Override
    public void deleteLesson(String lsnNum) throws SQLException {
        session.delete("Lesson-Mapper.deleteLesson", lsnNum);
    }

    @Override
    public String selectFirstLessonNum(String claNum) throws SQLException {
        // 첫 번째 강의의 고유번호(lsnNum) 조회
        return session.selectOne("Lesson-Mapper.selectFirstLessonNum", claNum);
    }

    @Override
    public String selectPrevLsnNum(LessonVO lesson) throws SQLException {
        // 이전 강의의 고유번호(lsnNum) 조회
        return session.selectOne("Lesson-Mapper.selectPrevLsnNum", lesson);
    }

    @Override
    public String selectNextLsnNum(LessonVO lesson) throws SQLException {
        // 다음 강의의 고유번호(lsnNum) 조회
        return session.selectOne("Lesson-Mapper.selectNextLsnNum", lesson);
    }

    @Override
    public int selectTotalLessonCount(String claNum) throws SQLException {
        return session.selectOne("Lesson-Mapper.selectTotalLessonCount", claNum);
    }

    @Override
    public List<LessonAttachVO> selectLessonFileList(String lsnNum) throws SQLException {
        return session.selectList("Lesson-Mapper.selectLessonFileList", lsnNum);
    }//삭제대상
    
    
    @Override
    public List<LessonVO> selectLessonListByClaNum(String claNum) throws SQLException {
        return session.selectList("Lesson-Mapper.selectLessonListByClaNum", claNum);
    }

    @Override
    public int selectMaxLsnSeq(String claNum) throws SQLException {
        return session.selectOne("Lesson-Mapper.selectMaxLsnSeq", claNum);
    }

    @Override
    public LessonVO selectLessonByLsnNum(String lsnNum) throws SQLException {
        // 고유번호 하나로 차시 정보 단건 조회
        return session.selectOne("Lesson-Mapper.selectLessonByLsnNum", lsnNum);
    }

}
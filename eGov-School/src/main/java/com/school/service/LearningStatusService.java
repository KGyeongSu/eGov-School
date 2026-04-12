package com.school.service;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Param;

import com.school.dto.LearningStatusVO;

public interface LearningStatusService {

    /**
     * 1. 학습 상태 업데이트 (이어보기 시간 저장 및 완료 처리)
     * 이 메서드 내에서 전체 진도율(calculateProgress)을 계산하고 
     * CLASS_APPLY 테이블의 PROGRESS 컬럼까지 업데이트해야 합니다.
     */
    void updateLearningStatus(LearningStatusVO status) throws SQLException;

    /**
     * 2. 기존 학습 데이터 조회 (상세 페이지 진입 시 이어보기 위치 파악용)
     */
    LearningStatusVO getLearningStatus(LearningStatusVO status) throws SQLException;
    
    int getLastLearningSeq(LearningStatusVO status) throws SQLException;
    
    LearningStatusVO selectStudentLearningStatusAtManage (@Param("userNum") String userNum, @Param("claNum") String claNum) throws SQLException;
    
}
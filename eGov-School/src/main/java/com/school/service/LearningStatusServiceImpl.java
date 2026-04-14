package com.school.service;


import java.sql.SQLException;

import org.springframework.transaction.annotation.Transactional;

import com.school.dao.ClassApplyDAO;
import com.school.dao.LearningStatusDAO;
import com.school.dto.LearningStatusVO;


public class LearningStatusServiceImpl implements LearningStatusService {

    private final LearningStatusDAO learningStatusDAO;
    private final ClassApplyDAO classApplyDAO;

    public LearningStatusServiceImpl(ClassApplyDAO classApplyDAO, LearningStatusDAO learningStatusDAO) {
        this.classApplyDAO = classApplyDAO;
        this.learningStatusDAO = learningStatusDAO;
    }

    /**
     * 학습 상태 업데이트 (시청 시간 실시간 저장)
     * 이 메서드는 영상 시청 중 일정 간격으로 호출되어 watchTime을 저장합니다.
     */
    @Transactional
    @Override
    public void updateLearningStatus(LearningStatusVO status) throws SQLException {
        // 개별 차시의 시청 기록 또는 완료 여부 저장 (MERGE INTO 실행)
    	learningStatusDAO.updateLessonComplete(status);
    }

    /**
     * 이어보기 위치 및 완료 여부 조회
     * 영상을 다시 틀었을 때 마지막 시청 지점을 가져오기 위해 사용합니다.
     */
    @Override
    public LearningStatusVO getLearningStatus(LearningStatusVO status) throws SQLException {
        return learningStatusDAO.selectLearningStatus(status);
    }
    
    @Override
    public int getLastLearningSeq(LearningStatusVO status) throws SQLException {
        return learningStatusDAO.selectLastLearningSeq(status);
    }
    
    @Override
	public LearningStatusVO selectStudentLearningStatusAtManage(String userNum, String claNum) throws SQLException {
		
		LearningStatusVO statusManage = learningStatusDAO.selectStudentLearningStatusAtManage(userNum, claNum);
		
		// 신규 학생인 경우
		if (statusManage == null) {
			
	        statusManage = new LearningStatusVO();
	        statusManage.setProgress(0);
	        statusManage.setStatus("미접속");
	        
	        return statusManage;
	    }
		
		// 학습상태 확인
		if (statusManage.getPrgLastdate() != null) {
			
	        long currentTime = System.currentTimeMillis();
	        long lastTime = statusManage.getPrgLastdate().getTime();
	        
	        // 현재 시간 - 마지막 학습시간 < 10분(600,000ms)
	        if (currentTime - lastTime < 600000) {
	        	
	        	statusManage.setStatus("학습중");
	        	
	        } else {
	        	
	        	statusManage.setStatus("미접속");
	        	
	        }
	        
	    } else {
	    	
	    	statusManage.setStatus("미접속");
	    	
	    }
	    
	    return statusManage;
		
	}
}
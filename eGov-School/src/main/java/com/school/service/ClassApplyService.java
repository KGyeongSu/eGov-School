package com.school.service;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.ClassApplyListCommand;
import com.school.cmd.PageMaker;
import com.school.dto.ClassApplyVO;
import com.school.dto.LearningStatusVO;
import com.school.dto.LessonVO;
import com.school.dto.ReputationVO;

public interface ClassApplyService {
    
    void registClassApply(ClassApplyVO apply) throws SQLException;
    
    ClassApplyListCommand getClassApplyList(String userNum, PageMaker pageMaker) throws SQLException; //수강중인 강좌
    
    List<ClassApplyVO> getCompletedClassList(String userNum) throws SQLException; //종료된강좌

    LessonVO getLessonDetail(String userNum, String claNum, String lsnSeq) throws SQLException;

    
    Integer getResumeLsnSeq(String userNum, String claNum) throws SQLException;


	List<LessonVO> getLessonListByCoures(String claNum) throws SQLException;
	
	int checkDuplicate(String userNum, String claNum) throws SQLException;
	
	int checkFull(String claNum) throws SQLException;
	
	void registReputation(ReputationVO repo) throws SQLException; //피드백

	void updateLessonProgress(String userNum, String claNum, String lsnNum) throws SQLException;

	void refreshTotalProgress(String userNum, String claNum, String lsnNum) throws SQLException;
	
	List<LearningStatusVO> getUserProgressList(String userNum, String claNum) throws SQLException;
	
}
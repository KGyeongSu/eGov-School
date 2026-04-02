package com.school.service;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

import com.school.cmd.ClassApplyListCommand;
import com.school.cmd.PageMaker;
import com.school.dao.ClassApplyDAO;
import com.school.dao.LessonDAO;
import com.school.dao.LearningStatusDAO;
import com.school.dto.ClassApplyVO;
import com.school.dto.LessonVO;
import com.school.dto.LearningStatusVO;
import com.school.dto.LessonAttachVO;

public class ClassApplyServiceImpl implements ClassApplyService {

    private ClassApplyDAO classApplyDAO;
    private LessonDAO lessonDAO;
    private LearningStatusDAO learningStatusDAO;


    public ClassApplyServiceImpl(ClassApplyDAO classApplyDAO, LessonDAO lessonDAO, LearningStatusDAO learningStatusDAO) {
        this.classApplyDAO = classApplyDAO;
        this.lessonDAO = lessonDAO;
        this.learningStatusDAO = learningStatusDAO;
    }

    @Override
    public void registClassApply(ClassApplyVO apply) throws SQLException {
        classApplyDAO.insertClassApply(apply);
    }

    @Override
    public ClassApplyListCommand getClassApplyList(String userNum, PageMaker pageMaker) throws SQLException {
       
        List<ClassApplyVO> applyList = classApplyDAO.selectClassApply(userNum, pageMaker);
        

        if (applyList != null) {
            for (ClassApplyVO apply : applyList) {
               
                int totalLessons = lessonDAO.selectTotalLessonCount(apply.getClaNum());
                
            
                LearningStatusVO status = new LearningStatusVO();
                status.setUserNum(userNum);
                status.setClaNum(apply.getClaNum());
                int completedLessons = learningStatusDAO.selectCompletedLessonCount(status);
                
                // 진도율 계산
                double progressPercent = 0.0;
                if (totalLessons > 0) {
                    progressPercent = ((double) completedLessons / totalLessons) * 100;
                }
                
           
                apply.setProgress(progressPercent);
            }
        }

        ClassApplyListCommand command = new ClassApplyListCommand(applyList, pageMaker);
        return command;
    }

    @Override
    public LessonVO getLessonDetail(String userNum, String claNum, String lsnSeq) throws SQLException {
        
    
        if (lsnSeq == null || lsnSeq.trim().isEmpty() || lsnSeq.equals("0")) {
            int resumeSeq = this.getResumeLsnSeq(userNum, claNum);
            lsnSeq = String.valueOf(resumeSeq);
        } 

      
        LessonVO paramVO = new LessonVO();
        paramVO.setClaNum(claNum);
        try {
            paramVO.setLsnSeq(Integer.parseInt(lsnSeq));
        } catch (NumberFormatException e) {
            
            paramVO.setLsnSeq(1);
        }

    
        LessonVO lesson = lessonDAO.selectLessonByNum(paramVO);

        if (lesson != null) {
     
            List<LessonAttachVO> files = lessonDAO.selectLessonFileList(lesson.getLsnNum());

        
            lesson.setPrevLsnNum(String.valueOf(lesson.getLsnSeq() - 1));
            lesson.setNextLsnNum(String.valueOf(lesson.getLsnSeq() + 1));
        }

        return lesson;
    }

    @Override
    public void updateLessonProgress(String userNum, String claNum, int lsnSeq) throws SQLException {
        LearningStatusVO status = new LearningStatusVO();
        status.setUserNum(userNum);
        status.setClaNum(claNum);
        status.setLsnSeq(lsnSeq);
        status.setPrgComplete("Y");

        learningStatusDAO.updateLessonComplete(status);
        refreshTotalProgress(userNum, claNum);
    }

    @Override
    public void refreshTotalProgress(String userNum, String claNum) throws SQLException {
        int totalLessons = lessonDAO.selectTotalLessonCount(claNum);

        LearningStatusVO status = new LearningStatusVO();
        status.setUserNum(userNum);
        status.setClaNum(claNum);

        int completedLessons = learningStatusDAO.selectCompletedLessonCount(status);

        double progressPercent = 0.0;
        if (totalLessons > 0) {
            progressPercent = ((double) completedLessons / totalLessons * 100);
        }

        ClassApplyVO apply = new ClassApplyVO();
        apply.setUserNum(userNum);
        apply.setClaNum(claNum);
        apply.setProgress(progressPercent);

        classApplyDAO.updateClassProgress(apply);
    }

    @Override
    public Integer getResumeLsnSeq(String userNum, String claNum) throws SQLException {
        LessonVO searchVO = new LessonVO();
        searchVO.setUserNum(userNum);
        searchVO.setClaNum(claNum);

        Integer nextSeq = classApplyDAO.selectLastLsnSeq(searchVO);

        if (nextSeq == null || nextSeq == 0) {
            return 1;
        }

        return nextSeq;
    }

    @Override
    public List<LessonVO> getLessonListByCoures(String claNum) throws SQLException {
        return lessonDAO.selectLessonListByClaNum(claNum);
    }
}
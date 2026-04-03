package com.school.service;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.ClassApplyListCommand;
import com.school.cmd.PageMaker;
import com.school.dao.ClassApplyDAO;
import com.school.dao.LearningStatusDAO;
import com.school.dao.LessonAttachDAO;
import com.school.dao.LessonDAO;
import com.school.dto.ClassApplyVO;
import com.school.dto.LearningStatusVO;
import com.school.dto.LessonAttachVO;
import com.school.dto.LessonVO;

public class ClassApplyServiceImpl implements ClassApplyService {

    private ClassApplyDAO classApplyDAO;
    private LessonDAO lessonDAO;
    private LearningStatusDAO learningStatusDAO;
    private LessonAttachDAO lessonAttachDAO;


    public ClassApplyServiceImpl(ClassApplyDAO classApplyDAO, LessonDAO lessonDAO, LearningStatusDAO learningStatusDAO, LessonAttachDAO lessonAttachDAO) {
        this.classApplyDAO = classApplyDAO;
        this.lessonDAO = lessonDAO;
        this.learningStatusDAO = learningStatusDAO;
        this. lessonAttachDAO = lessonAttachDAO;
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
        
   
    	//차시 번호 , 이어보기 로직 
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

        //차시 기본 정보 조회
        LessonVO lesson = lessonDAO.selectLessonByNum(paramVO);
        
        
        if (lesson != null) {
        	//첨부파일 리스트로 조회
            List<LessonAttachVO> files = lessonAttachDAO.selectLessonAttachList(lesson.getLsnNum());
            lesson.setLessonFiles(files);

            if(files != null & !files.isEmpty()) {
            	lesson.setLessonFiles(files); //전체리스트 보관
            }
            
         // 비디오 확장자 패턴 정의 (mp4, avi, wmv, mov 등)
            String videoPattern = ".*\\.(mp4|avi|wmv|mov)$";

         // 서비스 클래스의 비디오 경로 조립 부분
            for (LessonAttachVO file : files) {
                if (file.getLaSaveName().toLowerCase().endsWith(".mp4")) {
                    // 1. ContextPath를 포함한 절대 경로 형태로 조립 (null 방지)
                    // 만약 DB의 laPath가 null이라면 기본 경로를 넣어줍니다.
                    String folderPath = (file.getLaPath() == null) ? "/resources/upload" : file.getLaPath();
                    
                    // 2. 경로의 시작은 항상 '/'로 시작하게 해서 상대경로가 되지 않도록 합니다.
                    if(!folderPath.startsWith("/")) {
                        folderPath = "/" + folderPath;
                    }

                    lesson.setLsnVideo(folderPath + "/" + file.getLaSaveName());
                    break;
                }
            }
            
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

	@Override
	public List<ClassApplyVO> getCompletedClassList(String userNum) throws SQLException {
		ClassApplyVO vo = new ClassApplyVO();
		vo.setUserNum(userNum);
		
		return classApplyDAO.selectCompletedClassList(vo);
	}
}
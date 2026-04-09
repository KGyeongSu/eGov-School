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
import com.school.dto.ReputationVO;

public class ClassApplyServiceImpl implements ClassApplyService {

    private ClassApplyDAO classApplyDAO;
    private LessonDAO lessonDAO;
    private LearningStatusDAO learningStatusDAO;
    private LessonAttachDAO lessonAttachDAO;

    public ClassApplyServiceImpl(ClassApplyDAO classApplyDAO, LessonDAO lessonDAO, LearningStatusDAO learningStatusDAO, LessonAttachDAO lessonAttachDAO) {
        this.classApplyDAO = classApplyDAO;
        this.lessonDAO = lessonDAO;
        this.learningStatusDAO = learningStatusDAO;
        this.lessonAttachDAO = lessonAttachDAO;
    }

    @Override
    public void registClassApply(ClassApplyVO apply) throws SQLException {
        classApplyDAO.insertClassApply(apply);
        String caNum = classApplyDAO.selectClassApplySeqNext();
        apply.setCaNum(caNum);
    }

    @Override
    public ClassApplyListCommand getClassApplyList(String userNum, PageMaker pageMaker) throws SQLException {
        
        pageMaker.setPerPageNum(6);
        pageMaker.setPage(pageMaker.getPage());
        
        int totalCount = classApplyDAO.selectClassApplyListCount(userNum, pageMaker);
        pageMaker.setTotalCount(totalCount);
      
        List<ClassApplyVO> applyList = classApplyDAO.selectClassApply(userNum, pageMaker);

        if (applyList != null) {
            for (ClassApplyVO apply : applyList) {
                // 1. 기존 진도율 로직
                int totalLessons = lessonDAO.selectTotalLessonCount(apply.getClaNum());
                LearningStatusVO status = new LearningStatusVO();
                status.setUserNum(userNum);
                status.setClaNum(apply.getClaNum());
                int completedLessons = learningStatusDAO.selectCompletedLessonCount(status);
                
                double progressPercent = 0.0;
                if (totalLessons > 0) {
                    progressPercent = ((double) completedLessons / totalLessons) * 100;
                }
                apply.setProgress(progressPercent);

                // 2. 썸네일 매칭 로직 호출
                setThumbnail(apply);
            }
        }

        return new ClassApplyListCommand(applyList, pageMaker);
    }

    @Override
    public List<ClassApplyVO> getCompletedClassList(String userNum) throws SQLException {
        ClassApplyVO vo = new ClassApplyVO();
        vo.setUserNum(userNum);
        
        List<ClassApplyVO> endList = classApplyDAO.selectCompletedClassList(vo);
        
        // 종료된 강좌 목록에도 썸네일 매칭 로직 적용
        if (endList != null) {
            for (ClassApplyVO apply : endList) {
                setThumbnail(apply);
            }
        }
        
        return endList;
    }

    /**
     * 공통 메서드: LessonAttachDAO를 활용하여 이미지 파일을 찾아 lsnThumb에 세팅
     */
    private void setThumbnail(ClassApplyVO apply) throws SQLException {
        List<LessonAttachVO> fileList = lessonAttachDAO.selectLessonAttachList(apply.getClaNum());
        
        if (fileList != null) {
            for (LessonAttachVO file : fileList) {
                String fileName = file.getLaSaveName().toLowerCase();
                if (fileName.endsWith(".jpg") || fileName.endsWith(".png") || fileName.endsWith(".jpeg") || fileName.endsWith(".gif")) {
                    apply.setLsnThumb(file.getLaSaveName());
                    break; 
                }
            }
        }
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
            List<LessonAttachVO> files = lessonAttachDAO.selectLessonAttachList(lesson.getLsnNum());
            lesson.setLessonFiles(files);

            if(files != null && !files.isEmpty()) {
                for (LessonAttachVO file : files) {
                    if (file.getLaSaveName().toLowerCase().endsWith(".mp4")) {
                        String folderPath = (file.getLaPath() == null) ? "/resources/upload" : file.getLaPath();
                        if(!folderPath.startsWith("/")) {
                            folderPath = "/" + folderPath;
                        }
                        lesson.setLsnVideo(folderPath + "/" + file.getLaSaveName());
                        break;
                    }
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
	public void registReputation(ReputationVO repo) throws SQLException {
		classApplyDAO.insertReputation(repo);
	}

	@Override
	public int checkDuplicate(String userNum, String claNum) throws SQLException {
		return classApplyDAO.checkDuplicate(userNum, claNum);
	}

	@Override
	public int checkFull(String claNum) throws SQLException {
		return classApplyDAO.checkFull(claNum);
	}
    
}
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
        String caNum = classApplyDAO.selectClassApplySeqNext();
        apply.setCaNum(caNum);
        classApplyDAO.insertClassApply(apply);
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
        
        if (endList != null) {
            for (ClassApplyVO apply : endList) {
                setThumbnail(apply);
            }
        }
        
        return endList;
    }

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
    public LessonVO getLessonDetail(String userNum, String claNum, String lsnNum) throws SQLException {
        // 1. lsnNum이 없거나 0이면 이어보기 로직 작동
        if (lsnNum == null || lsnNum.trim().isEmpty() || lsnNum.equals("0")) {
            LearningStatusVO status = new LearningStatusVO();
            status.setUserNum(userNum);
            status.setClaNum(claNum);
            
            // DB에서 마지막으로 학습한 순서(Seq)를 가져옴
            int lastSeq = learningStatusDAO.selectLastLearningSeq(status);
            
            LessonVO paramVO = new LessonVO();
            paramVO.setClaNum(claNum);
            paramVO.setLsnSeq(lastSeq);
            
            // 🚩 [중요] Seq로 lesson 정보를 가져옵니다.
            LessonVO lesson = lessonDAO.selectLessonByNum(paramVO);
            
            if (lesson != null) {
                System.out.println("이어보기로 찾은 강의 번호: " + lesson.getLsnNum());
  
            }

            return (lesson != null) ? getLessonFilesAndPath(lesson) : null;
        } 

        // 2. lsnNum이 직접 넘어온 경우
        LessonVO paramVO = new LessonVO();
        paramVO.setClaNum(claNum);
        paramVO.setLsnNum(lsnNum); 

        LessonVO lesson = lessonDAO.selectLessonByNum(paramVO);
        return (lesson != null) ? getLessonFilesAndPath(lesson) : null;
    }

    private LessonVO getLessonFilesAndPath(LessonVO lesson) throws SQLException {
        // 1. 파일 리스트 및 비디오 경로 세팅 (기존 로직)
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

   
        
        String prevLsnNum = lessonDAO.selectPrevLsnNum(lesson); // Mapper의 selectPrevLsnNum 호출
        String nextLsnNum = lessonDAO.selectNextLsnNum(lesson); // Mapper의 selectNextLsnNum 호출

        lesson.setPrevLsnNum(prevLsnNum);
        lesson.setNextLsnNum(nextLsnNum);

        return lesson;
    }

    @Override
    public void updateLessonProgress(String userNum, String claNum, String lsnNum) throws SQLException {
       
        LearningStatusVO status = new LearningStatusVO();
        status.setUserNum(userNum);
        status.setClaNum(claNum);
        status.setLsnNum(lsnNum); 
        status.setPrgComplete("Y");

        learningStatusDAO.updateLessonComplete(status);
        refreshTotalProgress(userNum, claNum,lsnNum);
    }

    @Override
    public void refreshTotalProgress(String userNum, String claNum, String lsnNum) throws SQLException {
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
        apply.setLsnNum(lsnNum);
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

	@Override
	public List<LearningStatusVO> getUserProgressList(String userNum, String claNum) throws SQLException {
		LearningStatusVO status = new LearningStatusVO();
	    status.setUserNum(userNum);
	    status.setClaNum(claNum);
	    // 이미 Mapper/DAO에 해당 강좌의 수강 내역을 가져오는 쿼리가 있을 것입니다.
	    return learningStatusDAO.selectLearningStatusList(status);
	}
        
}
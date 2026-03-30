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

    public ClassApplyServiceImpl() {}

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
        ClassApplyListCommand command = new ClassApplyListCommand(applyList, pageMaker);
        return command;
    }

    @Override
    public LessonVO getLessonDetail(String userNum, String claNum, String lsnSeq) throws SQLException {
        
        // 1. 파라미터가 없거나, 비어있거나, "0"인 경우에만 '이어하기' 로직 수행
        // 사용자가 리스트에서 차시를 직접 클릭하면 lsnSeq에 값이 들어오므로 이 if문을 건너뜁니다.
        if (lsnSeq == null || lsnSeq.trim().isEmpty() || lsnSeq.equals("0")) {
            int resumeSeq = this.getResumeLsnSeq(userNum, claNum);
            lsnSeq = String.valueOf(resumeSeq);
            System.out.println(">>> 이어하기 발동! 이동 차시: " + lsnSeq);
        } else {
            System.out.println(">>> 사용자가 선택한 차시: " + lsnSeq);
        }

        // 2. 파라미터 세팅
        LessonVO paramVO = new LessonVO();
        paramVO.setClaNum(claNum);
        try {
            paramVO.setLsnSeq(Integer.parseInt(lsnSeq));
        } catch (NumberFormatException e) {
            // 혹시라도 숫자가 아닌 값이 올 경우를 대비한 방어 코드 (기본 1차시)
            paramVO.setLsnSeq(1);
        }

        // 3. 해당 차시의 강의 정보 조회
        LessonVO lesson = lessonDAO.selectLessonByNum(paramVO);

        if (lesson != null) {
            // 4. 첨부파일 목록 조회
            List<LessonAttachVO> files = lessonDAO.selectLessonFileList(lesson.getLsnNum());
            lesson.setLessonFiles(files);

            // 5. 이전/다음 차시 번호 계산 (단순 연산)
            // 화면에서 '이전글/다음글' 버튼 만들 때 사용합니다.
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
}
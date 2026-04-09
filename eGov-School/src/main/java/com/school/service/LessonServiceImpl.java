package com.school.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.school.dao.LessonAttachDAO;
import com.school.dao.LessonDAO;
import com.school.dto.LessonAttachVO;
import com.school.dto.LessonVO;

public class LessonServiceImpl implements LessonService {
	
	private final LessonDAO lessonDAO;
	private final LessonAttachDAO lessonAttachDAO;
	
	public LessonServiceImpl (LessonDAO lessonDAO, LessonAttachDAO lessonAttachDAO) {
		this.lessonDAO = lessonDAO;
		this.lessonAttachDAO = lessonAttachDAO;
	}
	
	@Value("${savedPath.lesson.file}")
	private String lessonFilePath;

	@Override
	@Transactional
	public void insertLessonAndAttach(LessonVO lesson, List<LessonAttachVO> attachList) throws Exception {
		if (attachList == null || attachList.isEmpty()) {
			throw new Exception("강의 등록 시 동영상 파일은 필수입니다.");
		}

		String lsnNum = lessonDAO.selectLessonSeqNext();
		lesson.setLsnNum(lsnNum);

		int maxSeq = lessonDAO.selectMaxLsnSeq(lesson.getClaNum());
		lesson.setLsnSeq(maxSeq + 1);

		lessonDAO.insertLesson(lesson);

		for (LessonAttachVO attach : attachList) {
			String laNum = lessonAttachDAO.selectLessonAttachSeqNext();
			attach.setLaNum(laNum);
			attach.setLsnNum(lsnNum);
			lessonAttachDAO.insertLessonAttach(attach);
		}
	}

	@Override
	public List<LessonVO> selectLessonList(String claNum) throws Exception {
		return lessonDAO.selectLessonList(claNum);
	}

	@Override
	public LessonVO selectLessonByLsnNum(String lsnNum) throws Exception {
		LessonVO lesson = lessonDAO.selectLessonByLsnNum(lsnNum);
		
		if (lesson != null) {
			// 모든 첨부파일(비디오 포함)을 가져와서 lessonFiles에 담음
			List<LessonAttachVO> attachList = lessonAttachDAO.selectLessonAttachList(lsnNum);
			lesson.setLessonFiles(attachList);
			
			if (attachList != null) {
				for (LessonAttachVO attach : attachList) {
					String type = attach.getLaType();
					// DB의 LA_TYPE이 'VIDEO'인 것을 찾아 비디오 경로로 세팅
					if ("VIDEO".equalsIgnoreCase(type)) {
						lesson.setLsnVideo(attach.getLaSaveName());
						break;
					}
				}
			}
		}
		return lesson;
	}

	@Override
	@Transactional
	public void updateLesson(LessonVO lesson, List<LessonAttachVO> attachList, String deleteFiles) throws Exception {
		lessonDAO.updateLesson(lesson);
		
		if (deleteFiles != null && !deleteFiles.trim().isEmpty()) {
			String[] saveNames = deleteFiles.split(",");
			for (String saveName : saveNames) {
				File file = new File(lessonFilePath, saveName);
				if (file.exists()) file.delete();
				lessonAttachDAO.deleteLessonAttachBySaveName(saveName); 
			}
		}
		
		if (attachList != null && !attachList.isEmpty()) {
			for (LessonAttachVO attach : attachList) {
				String laNum = lessonAttachDAO.selectLessonAttachSeqNext();
				attach.setLaNum(laNum);
				attach.setLsnNum(lesson.getLsnNum());
				lessonAttachDAO.insertLessonAttach(attach);
			}
		}
	}

	@Override
	public LessonAttachVO getLessonAttachByLaNum(String laNum) throws Exception {
		return lessonAttachDAO.selectLessonAttachByLaNum(laNum);
	}

	// ⭐ 빨간 줄 해결 포인트: throws SQLException 대신 인터페이스와 맞게 throws Exception 사용
	@Override
	public List<LessonAttachVO> getLessonFileList(String lsnNum) throws Exception {
		return lessonAttachDAO.selectLessonFileList(lsnNum);
	}
}
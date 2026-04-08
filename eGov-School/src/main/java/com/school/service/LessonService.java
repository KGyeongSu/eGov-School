package com.school.service;

import java.util.List;

import com.school.dto.LessonAttachVO;
import com.school.dto.LessonVO;

public interface LessonService {
	
	// 강의실에 레슨 및 첨부파일 등록
	void insertLessonAndAttach( LessonVO lesson, List<LessonAttachVO> attachList ) throws Exception;
	
	// 강의실에 레슨 가져오기
	List <LessonVO> selectLessonList (String claNum) throws Exception;
	
	// 각 레슨 조회
	LessonVO selectLessonByLsnNum (String lsnNum) throws Exception;
	
	// 강의 수정
	void updateLesson (LessonVO lesson, List<LessonAttachVO> attachList, String deleteFiles) throws Exception;

	//파일 번호(laNum)로 첨부파일의 상세 정보 조회 (다운로드용)
    LessonAttachVO getLessonAttachByLaNum(String laNum) throws Exception;

	List<LessonAttachVO> getLessonFileList(String lsnNum) throws Exception;
}

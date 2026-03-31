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
	LessonVO selectLessonByNum (String lsnNum) throws Exception;
	
	// 강의 수정
	void updateLesson (LessonVO lesson, List<LessonAttachVO> attachList, String deleteFiles) throws Exception;
 
}

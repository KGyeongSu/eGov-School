
package com.school.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ClassVO {
	
	private String claNum;
	private String claTitle;
	private String claContent;
	private String claGoal;
	private String claCategory;
	private String claThumb;
	private String claSaveName;
	private String claSavePath;
	private String userNum;
	private Date claRegDate;
	private Date appDate;
	private String claStatus;
	private Integer claViews;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date claStartDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date claEndDate;
	
	private Integer claMaxStu;
	private String claComplete;
	private Integer claBonus;
	
	// 강사
	// 테스트 버튼 활성화 여부 목적
	private String tetNum;
	// class 안 lesson 들 리스트 보여주기
	private List<LessonVO> lessonList;
	// 수료증 존재 여부
	private String cerNum;
	// 강의 썸네일 받아두는 그릇
	private MultipartFile thumb;
	// 메인 대시보드에 평가 응시율 보여주는 목적
	private double testRate;
	// 강의실 수강생 관리 탭 > 진도율
	private String label;
	private double value;
	// 강의실 강좌 등록률
	private int regiRate;
  
	// 사용자
  // join문으로 가져오는 user정보를 담을 그릇
	private String userName;
	private String userPhoto;
	// 수강신청 인원수
	private Integer applyCnt;
	

}


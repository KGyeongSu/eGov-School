package com.school.dto;

import java.util.Date;
import java.util.List;

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
	private Integer userNum;
	private Date claRegDate;
	private Date appDate;
	private String claStatus;
	private Integer claViews;
	private Date claStartDate;
	private Date claEndDate;
	private Integer claMaxStu;
	private String claComplete;
	private Integer claBonus;
	
	// class 안 lesson 들 리스트 보여주기
	private List<LessonVO> lessonList;
	

}

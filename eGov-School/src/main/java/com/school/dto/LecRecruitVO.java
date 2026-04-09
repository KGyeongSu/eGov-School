package com.school.dto;

import java.util.Date;

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
public class LecRecruitVO {
	
	private String ltNum;
	private String ltTitle;
	private String ltContent;
	private Date ltRegDate;
	private Date ltStartDate;
	private Date ltEndDate;
	private String ltJobType;
	private String ltStatus;
	private Integer ltViews;
	private String userNum;
	
	// 첨부파일
	//private List <LecRecruitAttachVO> lecRecruitAttachList;
	
}

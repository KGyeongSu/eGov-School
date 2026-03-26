package com.school.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ClassApplyVO {

	private String caNum;
	private String userNum;
	private String claNum;
	private Date caDate;
	
	
	private String claTitle;   // JOIN으로 가져온 강의명
	private String claContent; // JOIN으로 가져온 강의내용
	private String erPass;     // JOIN으로 가져온 합격여부
	private int erScore;       // JOIN으로 가져온 시험점수
	private String repNum;
	
	private String claCategory;
	private Date claStartdate;
	private Date claEnddate;
	private int claMaxstu;
}

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
	private String lsnNum;
	
	
	private String claTitle;   // JOIN으로 가져온 강의명
	private String claContent; // JOIN으로 가져온 강의내용
	private String erPass;     // JOIN으로 가져온 합격여부
	private int erScore;       // JOIN으로 가져온 시험점수
	private String repNum;
	
	private String claCategory;
	private Date claStartdate;
	private Date claEnddate;
	private int claMaxstu;
	
	// ClassApplyVO.java에 추가
	private String claName; // JSP ${apply.claName} 매핑용
	private double progress;   // JSP ${apply.progress} 매핑용
	private String claThumb;    // DB의 cla_thumb 컬럼과 매핑
	private String claSaveName; // 실제 저장된 파일명 (예: uuid_thumb.jpg)
	private String claSavePath; // 파일 저장 경로 (예: /classDisplay)
	
	private String feedbackYN;//null인지 아닌지 담는그릇
	
	private String lsnThumb; // 썸네일 파일명 매핑용
}

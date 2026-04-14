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

public class ReputationVO {
	
	private String repNum;
	private String userNum;
	private String claNum;
	private String repContent;
	private Integer repSat;
	private Date repRegDate;
	private String repCheck;

	
	private int totalCount;    // 전체 후기 개수
    private int sumScore;      // 별점 총합 (정수)
    
    // 강사
    private String userRole;
    private String claTitle;
    private String userName;
    
    
    //관리자
    private String lecturerName; // ★ 강사 이름 (강의 개설자) 추가
    private String keyword;
}

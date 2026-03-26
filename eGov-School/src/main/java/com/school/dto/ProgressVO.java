package com.school.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ProgressVO {
	
	private String prgNum;
	private String userNum;
	private String claNum;
	private String lsnNum;
	private String prgComplete;
	private Date prgLastDate;
	
	private int totalCount;      // 전체 강의 수
    private int completedCount;  // 완료 강의 수
    private double progressRate; // (completed/total) * 100 계산 결과
}

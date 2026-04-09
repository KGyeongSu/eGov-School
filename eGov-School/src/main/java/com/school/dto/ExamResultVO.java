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
public class ExamResultVO {
	
private String	erNum;
private String	tetNum;
private String	userNum;
private Integer	erAttempt;
private Integer	erScore;
private String	erPass;
private Date	erDate;


//[추가] 각 문제의 응시 기록(정답, 제출답안, 해설 등) 리스트
private java.util.List<ExamAnswerVO> answerList;
}


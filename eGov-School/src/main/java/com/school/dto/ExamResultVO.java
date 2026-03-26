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
}


package com.school.dto;


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
public class QuestionVO {
	
	private String queNum;
	private String tetNum;
	private Integer queSeq;
	private String queText;
	private String queOpt1;
	private String queOpt2;
	private String queOpt3;
	private String queOpt4;
	private Integer queAnswer;
	private String queDesc;
	private Integer quePoint;
	

}

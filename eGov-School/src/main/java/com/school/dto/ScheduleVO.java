package com.school.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ScheduleVO {

	private String schNum; 
	private String schTitle;
	private Date schStart;
	private Date schEnd;
	private String schColor;
	private String userNum;
	private Date schRegDate;
	
}

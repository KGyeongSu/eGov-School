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
public class LecApplicationVO {
	
	private String laNum;
	private String userNum;
	private String ltNum;
	private String laIntro;
	private String laStatus;
	private Date laRegDate;

}

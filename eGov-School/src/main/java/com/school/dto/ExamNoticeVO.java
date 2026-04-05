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
public class ExamNoticeVO {
	
	private String enNum;
	private String enTitle;
	private String enContent;
	private Date enRegDate;
	private Integer enViews;
	private Integer userNum;

	private String userName;
}

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
public class JobNoticeVO {
	
	private String jnNum;
	private String jnTitle;
	private String jnContent;
	private Date jnRegDate;
	private Integer jnViews;
	private String userNum;
	
	
	private String userName;
}

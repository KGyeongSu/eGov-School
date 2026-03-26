package com.school.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ExamNoticeAttachVO {
	
    private String enaNum;
    private String enNum;
    private String enaName;
    private String enaType;
}
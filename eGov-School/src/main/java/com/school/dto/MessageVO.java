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
public class MessageVO {
	
    private String msNum;
    private String msContent;
    private Date msSenddate;
    private String msCheck;
    private String msSenderNum;
    private String msReceiverNum;
    
    private String msSenderName; //보낸사람 이름 	
}
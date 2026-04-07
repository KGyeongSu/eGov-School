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
public class MessageAttachVO {

	private String maNum;
    private String msNum;
    private String maName;
    private Long maSize;
    private String maType;
    private String maSaveName;
    private String maSavePath;
    private Date maRegDate;
}

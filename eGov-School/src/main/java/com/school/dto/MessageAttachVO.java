package com.school.dto;

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
    private String maType;
}

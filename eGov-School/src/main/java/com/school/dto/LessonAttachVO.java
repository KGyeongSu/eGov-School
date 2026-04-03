package com.school.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class LessonAttachVO {

	private String laNum;
    private String lsnNum;
    private String laName;
    private String laType;
    
    
 // DB의 LA_SAVE_NAME과 LA_PATH를 담기 위해 추가 필요
    private String laSaveName;  // 서버 저장 파일명 (예: JACOMO.mp4)
    private String laPath;      // 파일 저장 경로
    
}

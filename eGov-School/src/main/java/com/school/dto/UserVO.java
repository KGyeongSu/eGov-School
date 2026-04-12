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
public class UserVO {
	
    private String userNum;
    private String userPwd;
    private String userEmail;
    private String userName;
    private String userPhone;
    private String userRole;		// 단순 비교하기 위한 DB에서 꺼낸 값.(문자열)
    private String userJob;
    private String userPhoto;
    private Date userRegdate;
    private String userStatus;		// 계정상태(활성,잠금,탈퇴 등) 아직 구현x
    private Integer userFailCount;	// 로그인 실패 횟수
    
    // 강사 강의실 사용자 관리 jsp 뿌려주는 목적
    private int progress;          
    private String status;         
    private Date prgLastdate;
    
}

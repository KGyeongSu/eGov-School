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
    private String userRole;
    private String userJob;
    private String userPhoto;
    private Date userRegdate;
    private String userStatus;
    private Integer userFailCount;
    
}

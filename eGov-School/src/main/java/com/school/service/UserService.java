
package com.school.service;

import java.sql.SQLException;

import com.school.dto.UserVO;

public interface UserService {

	// userNum SeqNext 받기는 ServiceImpl 내부에서 알아서 처리하기때문에 안적어도 된다.
	
	
	// 회원가입
	void regist(UserVO user) throws SQLException;
	
	// 로그인 (이메일로 조회)
	UserVO login(String userEmail, String userPwd) throws SQLException;
	
	// 강사 프로필 업데이트 (회원가입 시 기본 정보 다 등록했음 -> 사진만 등록)
	boolean updateLectererProfile(UserVO user) throws SQLException;
	
}

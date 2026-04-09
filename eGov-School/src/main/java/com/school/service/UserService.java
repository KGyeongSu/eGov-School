
package com.school.service;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.UserVO;

public interface UserService {

	// userNum SeqNext 받기는 ServiceImpl 내부에서 알아서 처리하기때문에 안적어도 된다.
	
	
	// 회원가입
	void regist(UserVO user) throws SQLException;
	
//	// 로그인 (이메일로 조회) Security가 검증하기에 login() 메서드는 지움. 
//	UserVO login(String userEmail, String userPwd) throws SQLException;
	
	// 강사 프로필 업데이트 (회원가입 시 기본 정보 다 등록했음 -> 사진만 등록)
	boolean updateLectererProfile(UserVO user) throws SQLException;
	
	// 이메일로 유저 조회 (security 로그인용)
	UserVO getUserByEmail(String userEmail) throws SQLException;
	
	// 비밀번호 변경
	void updateUserPwd(String userEmail, String newPwd) throws SQLException;
	
	// 관리자 리스트 조회
	List <UserVO> getAdminList () throws SQLException;
}

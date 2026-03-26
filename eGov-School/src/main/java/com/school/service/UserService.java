package com.school.service;

import java.sql.SQLException;

import com.school.dto.UserVO;

public interface UserService {

	// userNum SeqNext 받기는 ServiceImpl 내부에서 알아서 처리하기때문에 안적어도 된다.
	
	
	// 회원가입
	void regist(UserVO user) throws SQLException;
	
}

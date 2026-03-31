package com.school.security;

import java.sql.SQLException;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.school.dto.UserVO;
import com.school.service.UserService;



public class CustomAuthenticationProvider implements AuthenticationProvider{
	
	// UserService -> DB에서 유저 조회할 때 필요
	// PasswordEncoder -> BCrypt 비밀번호 비교할 떄 필요
	private UserService userService;
	private PasswordEncoder encoder;
		
	// 생성자 (SpringSecurityConfig에서 2개의 파라미터를 넣어줄 예정)
	public CustomAuthenticationProvider(UserService userService, PasswordEncoder encoder) {
		this.userService = userService;
		this.encoder = encoder;
	}
	
	
	@Override
	public Authentication authenticate(Authentication auth) throws AuthenticationException {
		
		// 사용자가 입력한 이메일, 비밀번호 가져오기
		String inputEmail = (String) auth.getPrincipal();    // 입력한 이메일
        String inputPwd = (String) auth.getCredentials();    // 입력한 비밀번호
        
        // 1. DB에서 이메일로 유저 조회
        UserVO user = null;
        try {
        	user = userService.getUserByEmail(inputEmail);
        } catch(SQLException e) {
        	// DB 자체에 문제가 생긴 경우
        	throw new AuthenticationServiceException("서버 오류가 발생했습니다.");
        }
        
        // 2. 유저가 없으면 -> 이메일 불일치
        if (user == null) {
        	throw new UsernameNotFoundException("이메일이 존재하지 않습니다.");
        }
        
        // 3.  BCrypt로 비밀번호 비교
        //	   encoder.matches(입력한 비밀번호, DB에 저장된 암호화된 비밀번호)
        if (!encoder.matches(inputPwd, user.getUserPwd())) {
        	throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
        }
        
        // 4. SecurityUser로 포장 (UserVO를 security에 맞게끔)
        UserDetails authUser = new SecurityUser(user);
        
        // 5. 계정 상태 체크
        // 	SecurityUser의 메서드(상태 메서드) 등 호출
        boolean isValid = authUser.isEnabled()
        		&& authUser.isAccountNonLocked()
                && authUser.isAccountNonExpired()
                && authUser.isCredentialsNonExpired();
        
       if(!isValid) {
    	   throw new AuthenticationServiceException("계정이 유효하지 않습니다.");
       }
       
       // 6. 모두 통과 -> 인증 토큰 생성해서 리턴 -> LoginSuccessHandler로 이동
       UsernamePasswordAuthenticationToken result =
    		   new UsernamePasswordAuthenticationToken(
                       authUser.getUsername(),   // 이메일
                       authUser.getPassword(),   // 암호화된 비밀번호
                       authUser.getAuthorities() // 권한목록 ["ROLE_관리자"] 등
               );
       
       // 토큰에 SecurityUser 전체 정보 담기 (SuccessHandler에서 꺼내 쓸 수 있게)
       result.setDetails(authUser);
       
       return result;
	}
	
	// "나는 이메일+비밀번호 방식 로그인만 처리할게" 선언 
	@Override
	public boolean supports(Class<?> auth) {
		return auth.equals(UsernamePasswordAuthenticationToken.class);
	}
	
}

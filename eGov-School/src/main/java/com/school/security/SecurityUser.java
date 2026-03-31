package com.school.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.school.dto.UserVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class SecurityUser implements UserDetails {
	// UserDetails는 pom.xml에 추가한 security-web(라이브러리)에서 불러올수있는 interface
	// UserVO를 감싸서 security전용규격으로 포장하는 역할
	private UserVO user;

	// 1. 로그인 ID -> 우리는 email
	@Override
	public String getUsername() {
		return user.getUserEmail();
	}
	
	// 2. 비밀번호
	@Override
	public String getPassword() {
		return user.getUserPwd();
	}

	// 3. 권한 목록 -> if. userRole이 "관리자"라면 -> "ROLE_관리자" 로 변환.
	//  Security는 hasRole("관리자") 체크할 때
	//	자동으로 "ROLE_관리자" 를 찾기 때문에 ROLE_ 라는 접두사 필요함.
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> list = new ArrayList<>();
        list.add(new SimpleGrantedAuthority("ROLE_" + user.getUserRole()));
        return list;
	}

	// 4.계정 활성화 여부 -> "활성"이면 로그인 가능. (아직 구현x. default값 "활성")
	@Override
	public boolean isEnabled() {
		return "활성".equals(user.getUserStatus());
	}
	
	// 5. 장금 여부 -> 실패 5회 미만이면 해제상태 ( status에 아직 반영x)
	@Override
	public boolean isAccountNonLocked() {
		return true;
		// return user.getUserFailCount() < 5; 컬럼은 있지만 아직 구현x
	}
	
	// 6. 계정 만료여부 -> 우리는 해당x. 항상 true
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	
	// 7. 비밀번호 만료 여부 -> 우리는 해당x. 항상 true
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	
}

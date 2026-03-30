package com.school.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;

@Configuration // 설정 파일이라는 선언
@EnableWebSecurity // Spring Security를 활성화한다는 선언
public class SpringSecurityConfig {

	// security-context.xml 에서 등록한 bean들 가져오기
	@Autowired
	private AuthenticationProvider authenticationProvider; // 로그인 검사
	
	@Autowired
	private LoginSuccessHandler successHandler; // 로그인 성공 처리
	
	@Autowired
	private LoginFailureHandler failureHandler; // 로그인 실패 처리
	
	@Autowired
	private Custom403Handler custom403Handler; // 권한 없을 때 처리

	
	// security는 root-context에서 초기화되고,
	// MVC는 자식컨텍스트에서 초기화되므로
	// security가 MVC를 알 수 없어서
	// 중간다리 역할을 해주는 Bean이 필요함.
	@Bean(name = "mvcHandlerMappingIntrospector")
	public HandlerMappingIntrospector mvcHandlerMappingIntrospector() {
		return new HandlerMappingIntrospector();
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		
		http
				// 인증 방식 설정
				.authenticationManager(new ProviderManager(authenticationProvider))

				// CSRF 비활성화
				// (수업예제 방식 그대로, 나중에 필요하면 활성화)
				.csrf(config -> config.disable())

				// URL별 접근 권한 설정
				.authorizeHttpRequests(authorize -> authorize

						// 누구나 접근 가능 (로그인 안해도 됨)
						.requestMatchers("/commons/**").permitAll() // 로그인, 회원가입
						.requestMatchers("/resources/**").permitAll() // CSS, JS 등
						.requestMatchers("/main").permitAll() // 메인페이지
						.requestMatchers("/page/**").permitAll() // 공개 페이지

						// 관리자만 접근 가능
						.requestMatchers("/admin/**").hasRole("관리자")

						// 강사만 접근 가능
						.requestMatchers("/lecterer/**").hasRole("강사")

						// 로그인한 사람만 접근 가능
						.requestMatchers("/user/**").authenticated()

						// 나머지는 로그인 필요
						.anyRequest().authenticated())

				// 로그인 설정
				.formLogin(formLogin -> formLogin.loginPage("/commons/login") // 로그인 페이지 URL
						.loginProcessingUrl("/commons/login/post") // form action URL
						.usernameParameter("userEmail") // 이메일 파라미터명
						.passwordParameter("userPwd") // 비밀번호 파라미터명
						.successHandler(successHandler) // 성공 처리
						.failureHandler(failureHandler) // 실패 처리
				)

				// 로그아웃 설정
				.logout(logout -> logout.logoutUrl("/commons/logout") // 로그아웃 URL
						.logoutSuccessUrl("/commons/login") // 로그아웃 후 이동
						.deleteCookies("JSESSIONID") // 쿠키 삭제
						.invalidateHttpSession(true) // 세션 초기화
				)

				// 세션 관리
				.sessionManagement(session -> session.invalidSessionUrl("/commons/login") // 세션 만료시 이동
						.maximumSessions(1) // 중복 로그인 방지 (1개만)
						.expiredUrl("/commons/login") // 중복 로그인 감지시 이동
						.sessionRegistry(new SessionRegistryImpl()))

				// iframe 허용 (같은 도메인)
				.headers(headers -> headers.frameOptions(HeadersConfigurer.FrameOptionsConfig::sameOrigin));

		// 권한 없을 때 처리
		http.exceptionHandling(handler -> {
			handler.accessDeniedHandler(custom403Handler);
		});

		return http.build();
	}
}
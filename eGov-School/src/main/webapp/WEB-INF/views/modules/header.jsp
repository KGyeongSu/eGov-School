<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <!-- 헤더부분 -->
    <header>
        <div class="inner">
            <div class="logo">
                <a href="/main">
                    <img src="/resources/images/Logo.png" />
                </a>
            </div>
            <nav class="mainmenu">
                <ul class="menu"><a href="/inlearning">인러닝</a></ul>
                <ul class="menu"><a href="/page/cregist">수강신청</a></ul>
                <ul class="menu"><a href="#">공무원채용</a></ul>
                <ul class="menu"><a href="/page/l_recruit">강사채용</a></ul>
            </nav>

			<sec:authorize access="isAuthenticated()">
				<!-- 로그인 된 상태 -->
				<button class="btn_login" onclick="location.href='/commons/logout'">로그아웃</button>
			</sec:authorize>
			<sec:authorize access="isAnonymous()">
				<!-- 로그인 안된 상태 -->
				<button class="btn_login" onclick="location.href='/commons/login'">로그인</button>
			</sec:authorize>
			
		</div>
    </header>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/resources/css/MainPage/login.css">
    <link rel="stylesheet" href="/resources/css/MainPage/main.css">
</head>

<body>
<div class="login_wrap">

    <!-- 왼쪽 영역 -->
    <div class="login_left">
        <div class="login_content">
            <h2><strong>eGov-School</strong><br>지방공무원 선발 교육 시스템</h2>
            <p>공무원이 되기 전 직무 교육을 미리 온라인으로 학습하여, <br>선발에 유리한 위치를 만드세요.</p>
        </div>
    </div>

    <!-- 오른쪽 폼 영역 -->
    <div class="login_right">
        <div class="login_form">
            <h2>로그인</h2>
            <p class="lsub_text">eGov-School 계정으로 로그인하세요.</p>

				<c:if test="${not empty message}">
						<div
						style="color: green; font-size: 13px; margin-bottom: 10px; text-align: center;">
						${message}</div>
				</c:if>

				<!-- Security가 세션에 저장한 방식 -->
				<% String loginError = (String) session.getAttribute("loginError"); %>
				<% if (loginError != null) { %>
				<div
					style="color: red; font-size: 13px; margin-bottom: 10px; text-align: center;">
					<%=loginError%>
				</div>
				<% session.removeAttribute("loginError"); %>
				<% } %>

				<!-- Controller가 아니고 Security가 처리하는 url -->	
			<form id="loginform" action="/commons/login/post" method="post">
            <div class="linput_wrap">
                <label>이메일</label>
                <div class="linput_row">
                    <input type="text" name="userEmail" placeholder="example@email.com"
                    required>
                </div>
            </div>

            <div class="linput_wrap">
                <label>비밀번호</label>
                <input type="password" name="userPwd" placeholder="비밀번호를 입력하세요."
                required
                minlength="8"
                maxlength="20"
                pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,20}$"
                title="영문자와 숫자를 포함하여 8~20자로 입력해주세요.">
            </div>

            <div class="find_links">
                <a href="/commons/repwd">비밀번호 찾기</a>
            </div>
            <button type="submit" class="lbtn_submit">로그인</button>

	
			
        </form>

            <p class="join_p">아직 계정이 없으신가요?</p>
            <button class="lbtn_join" onclick="location.href='/commons/join'">회원가입</button>
            <button class="lbtn_main" onclick="location.href='/main'">메인페이지로 돌아가기</button>
        </div>
    </div>
		
</div>

</body>
</html>

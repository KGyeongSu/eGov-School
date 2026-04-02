<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="/resources/css/MainPage/repwd.css">
    <link rel="stylesheet" href="/resources/css/MainPage/main.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/resources/js/script.js"></script>
</head>

<body>
    <div class="repwd_wrap">

        <!-- 왼쪽 영역 -->
        <div class="repwd_left">
            <div class="repwd_content">
                <h2>비밀번호 찾기</h2>
                <p>이메일 인증을 통해 안전하게<br>새 비밀번호를 설정할 수 있습니다.</p>
                <div class="rstep_intro">
                    <div class="step_num">1</div>
                    <p>이메일 인증번호 발송</p>
                </div>
                <div class="rstep_intro">
                    <div class="step_num">2</div>
                    <p>인증번호 확인</p>
                </div>
                <div class="rstep_intro">
                    <div class="step_num">3</div>
                    <p>새 비밀번호 설정</p>
                </div>
            </div>
        </div>

        <!-- 오른쪽 폼 영역 -->
        <div class="repwd_right">
            <div class="repwd_form">
                <h2>비밀번호 찾기</h2>
                <p class="rsub_text">이메일 인증 후 새 비밀번호를 설정할 수 있습니다.</p>
                
            <form id="repwdform">

                <h3>이메일 인증</h3>
                <div class="rinput_wrap">
                    <div class="rinput_label">이메일</div>
                    <div class="rinput_row">
                        <input type="email" name="email" placeholder="인증용 이메일을 입력하세요" required>
                        <button type="button" class="rbtn_check">인증번호 발송</button>
                    </div>
                </div>

                <div class="rinput_wrap">
                    <div class="rinput_label">인증번호</div>
                    <input type="text" name="verifycode" placeholder="인증번호 6자리 입력" required maxlength="6"
                        pattern="[0-9]{6}" title="숫자 6자리를 입력해주세요.">
                </div>

                <h3>새 비밀번호 설정</h3>
                <div class="rinput_wrap">
                    <div class="rinput_label">새 비밀번호</div>
                    <input type="password" name="password" placeholder="8자 이상 20자 이하 (문자 + 숫자 조합)" required
                        minlength="8" maxlength="20"
                        pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,20}$"
                        title="영문자와 숫자를 포함하여 8~20자로 입력해주세요.">
                </div>
                <div class="rinput_wrap">
                    <div class="rinput_label">비밀번호 확인</div>
                    <input type="password" name="password_confirm" placeholder="비밀번호를 다시 입력하세요" required>
                </div>
                <button type="submit" class="rbtn_submit">비밀번호 변경</button>
            </form>


                <button class="rbtn_login" onclick="location.href='/commons/login'">로그인으로 돌아가기</button>
            </div>
        </div>
    </div>
</body>

</html>
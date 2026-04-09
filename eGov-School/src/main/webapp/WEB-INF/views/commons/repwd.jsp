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

            <form id="repwdform" action="/commons/repwd" method="post">

                <h3>이메일 인증</h3>

                <!-- ① 이메일 입력 + 인증번호 발송 버튼 -->
                <div class="rinput_wrap">
                    <div class="rinput_label">이메일</div>
                    <div class="rinput_row">
                        <input type="email" id="userEmail" name="userEmail"
                               placeholder="인증용 이메일을 입력하세요" required>
                        <button type="button" id="btnSendCode" class="rbtn_check">
                            인증번호 발송
                        </button>
                    </div>
                    <!-- 이메일 메시지 -->
                    <span id="emailMsg" style="font-size:12px; color:#999;"></span>
                </div>

                <!-- ② 인증번호 입력 + 확인 버튼 -->
                <div class="rinput_wrap">
                    <div class="rinput_label">인증번호</div>
                    <div class="rinput_row">
                        <input type="text" id="verifyCode" name="verifycode"
                               placeholder="인증번호 6자리 입력" maxlength="6"
                               pattern="[0-9]{6}" title="숫자 6자리를 입력해주세요." required>
                        <!-- 확인 버튼 추가! -->
                        <button type="button" id="btnVerifyCode" class="rbtn_check">
                          인증 확인
                        </button>
                    </div>
                    <!-- 인증번호 메시지 -->
                    <span id="codeMsg" style="font-size:12px; color:#999;"></span>
                </div>

                <h3>새 비밀번호 설정</h3>

                <!-- ③ 새 비밀번호 -->
                <div class="rinput_wrap">
                    <div class="rinput_label">새 비밀번호</div>
                    <input type="password" id="userPwd" name="userPwd"
                           placeholder="8자 이상 20자 이하 (문자 + 숫자 조합)"
                           minlength="8" maxlength="20"
                           pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,20}$"
                           title="영문자와 숫자를 포함하여 8~20자로 입력해주세요." required>
                </div>

                <!-- ④ 비밀번호 확인 -->
                <div class="rinput_wrap">
                    <div class="rinput_label">비밀번호 확인</div>
                    <input type="password" id="pwdConfirm" name="password_confirm"
                           placeholder="비밀번호를 다시 입력하세요" >
                    <!-- 비밀번호 불일치 메시지 -->
                    <span id="pwdMsg" style="font-size:12px; color:#999;"></span>
                </div>

                <!-- ⑤ 변경하기 버튼 → 처음엔 disabled -->
                <button type="submit" id="btnSubmit" class="rbtn_submit" disabled>
                    비밀번호 변경
                </button>

            </form>

                <button class="rbtn_login" onclick="location.href='/commons/login'">
                    로그인으로 돌아가기
                </button>
            </div>
        </div>
    </div>

<script>
$(document).ready(function() {

    var pwdVerified = false;

    // 변경하기 버튼 처음엔 비활성화
    $('.rbtn_submit').prop('disabled', true);

    // 1 인증번호 발송 버튼 클릭
    $('#btnSendCode').click(function() {
        var email = $('#userEmail').val();

        if (!email) {
            $('#emailMsg').css('color', 'red').text('이메일을 입력해주세요.');
            return;
        }

        $.ajax({
            url: '/commons/repwd/sendCode',
            type: 'POST',
            data: { userEmail: email },
            success: function(result) {
                if (result === 'success') {
                    $('#emailMsg').css('color', 'green').text('인증번호가 발송되었습니다.');
                    $('#btnSendCode').text('재발송');
                } else if (result === 'notFound') {
                    $('#emailMsg').css('color', 'red').text('존재하지 않는 이메일입니다.');
                } else {
                    $('#emailMsg').css('color', 'red').text('발송 실패. 다시 시도해주세요.');
                }
            }
        });
    });

    // 2 인증번호 확인 버튼 클릭
    $('#btnVerifyCode').click(function() {
        var code = $('#verifyCode').val();

        if (!code) {
            $('#codeMsg').css('color', 'red').text('인증번호를 입력해주세요.');
            return;
        }

        $.ajax({
            url: '/commons/verifyCode',
            type: 'POST',
            data: { code: code },
            success: function(result) {
                if (result === 'success') {
                    pwdVerified = true;
                    $('#codeMsg').css('color', 'green').text('인증되었습니다.');
                    // 인증 완료 → 변경하기 버튼 활성화
                    $('.rbtn_submit').prop('disabled', false);
                    // 이메일, 인증번호 입력 비활성화
                    $('#userEmail').prop('disabled', true);
                    $('#verifyCode').prop('disabled', true);
                    $('#btnSendCode').prop('disabled', true);
                    $('#btnVerifyCode').prop('disabled', true);
                } else if (result === 'expired') {
                    $('#codeMsg').css('color', 'red').text('만료되었습니다. 재발송해주세요.');
                } else {
                    $('#codeMsg').css('color', 'red').text('인증번호가 일치하지 않습니다.');
                }
            }
        });
    });

    // 3 비밀번호 확인 일치 여부 체크
    $('#pwdConfirm').on('input', function() {
        var pwd = $('input[name="userPwd"]').val();
        var confirm = $(this).val();

        if (pwd !== confirm) {
            $('#pwdMsg').css('color', 'red').text('비밀번호가 일치하지 않습니다.');
        } else {
            $('#pwdMsg').css('color', 'green').text('비밀번호가 일치합니다.');
        }
    });

    // 4 변경하기 버튼 클릭
    $('#repwdform').submit(function(e) {
        e.preventDefault();

        if (!pwdVerified) {
            alert('이메일 인증을 먼저 완료해주세요.');
            return;
        }

        var pwd = $('input[name="userPwd"]').val();
        var confirm = $('#pwdConfirm').val();
        if (pwd !== confirm) {
            alert('비밀번호가 일치하지 않습니다.');
            return;
        }

        $(this).off('submit').submit();
    });

});
</script>
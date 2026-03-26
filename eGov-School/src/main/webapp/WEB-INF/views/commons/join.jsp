<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="/resources/css/MainPage/join.css">
    <link rel="stylesheet" href="/resources/css/MainPage/main.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/resources/js/script.js"></script>

</head>

<body>
    <div class="join_wrap">

        <!-- 왼쪽 영역 -->
        <div class="join_left">
            <div class="join_content">

                <h2><strong>eGov-School</strong><br>회원가입</h2>
                <p>간단한 절차로 회원가입을 완료하세요.</p>
                <div class="jstep_intro">
                    <div class="step_num">1</div>
                    <p>이용약관 및 개인정보 수집 동의</p>
                </div>
                <div class="jstep_intro">
                    <div class="step_num">2</div>
                    <p>이메일 인증 절차 및 정보 입력</p>
                </div>
                <div class="jstep_intro">
                    <div class="step_num">3</div>
                    <p>회원가입 완료</p>
                </div>
            </div>
        </div>

        <!-- 오른쪽 폼 영역 -->
        <div class="join_right">
            <div class="join_form">
                <h2>회원가입</h2>
                <p class="jsub_text">eGov-School 계정을 만들어보세요.</p>
            
            <form id="joinform" action="/commons/join" method="post">
                <div class="terms">
                    <div class="terms_label" onclick="this.querySelector('input').click()">
                        <input type="checkbox" id="terms_agree" disabled>
                        <span> 이용약관 및 개인정보 수집에 동의합니다.</span>
                    </div>
                    <button type="button" class="terms_btn" onclick="openTermsModal()">이용약관 보기</button>
                </div>

                <h3>이메일 인증 및 비밀번호 설정</h3>

               
                    <div class="jinput_wrap">
                        <label>이메일<span style="color:red"> *</span></label>
                        <div class="jinput_row">
                            <input type="email" name="userEmail" placeholder="example@email.com" required>
                            <button type="button" class="jbtn_check">인증번호 발송</button>
                        </div>
                    </div>
                    <div class="jinput_wrap">
                        <label>인증번호<span style="color:red"> *</span></label>
                        <input type="text" name="verifycode" placeholder="인증번호 6자리 입력" required maxlength="6"
                            pattern="[0-9]{6}" title="숫자 6자리를 입력해주세요.">
                    </div>
                    <div class="jinput_wrap">
                        <label>비밀번호<span style="color:red"> *</span></label>
                        <input type="password" name="userPwd" placeholder="8자 이상 20자 이하 (문자 + 숫자 조합)" required
                            minlength="8" maxlength="20" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,20}$"
                            title="영문자와 숫자를 포함하여 8~20자로 입력해주세요.">
                    </div>
                    <div class="jinput_wrap">
                        <label>이름<span style="color:red"> *</span></label>
                        <input type="text" name="userName" placeholder="이름을 입력하세요." required minlength="2"
                            maxlength="10" pattern="[가-힣]{2,10}" title="한글 2~10자로 입력해주세요.">
                    </div>
                    <div class="jinput_wrap">
                        <label>전화번호<span style="color:red"> *</span></label>
                        <input type="tel" name="userPhone" placeholder="-는 생략하고 적어주세요." required maxlength="11"
                            pattern="01[016789][0-9]{7,8}" title="올바른 휴대폰 번호를 입력해주세요. (예: 01012345678)">
                    </div>
                    <button type="submit" class="jbtn_submit">회원가입 완료</button>

            </form>


                <button class="jbtn_login" onclick="location.href='/commons/login'">로그인으로 돌아가기</button>
                <button class="jbtn_main" onclick="location.href='/main'">메인페이지로 돌아가기</button>
            </div>
        </div>
    </div>
<!-- 이용약관 모달 -->
<div id="termsModal" class="modal_overlay" style="display:none;">
    <div class="modal_content">
        <div class="modal_header">
            <h3>이용약관 동의</h3>
            <button class="modal_close" onclick="closeTermsModal()">&times;</button>
        </div>
        <div class="modal_body">
            <!-- 전체 동의 -->
            <div class="agree_all" onclick="document.getElementById('agreeAll').click()">
                <input type="checkbox" id="agreeAll" onchange="toggleAll(this)">
                <span>전체 동의하기</span>
            </div>
            <hr>
            <!-- 개별 약관 1 -->
            <div class="terms_item">
                <div class="term_row" onclick="this.querySelector('input').click()">
                    <input type="checkbox" class="term_check" data-required="true" onchange="checkAgree()">
                    <span>[필수] 서비스 이용약관 동의</span>
                </div>
                <button type="button" class="view_detail" onclick="toggleDetail(this)">내용보기 ▼</button>
                <div class="term_detail" style="display:none;">
                    <p>제1조 (목적)<br>본 약관은 eGov-School 지방공무원 선발 교육 시스템의 이용 조건 및 절차에 관한 사항을 규정합니다...</p>
                </div>
            </div>
            <!-- 개별 약관 2 -->
            <div class="terms_item">
                <div class="term_row" onclick="this.querySelector('input').click()">
                    <input type="checkbox" class="term_check" data-required="true" onchange="checkAgree()">
                    <span>[필수] 개인정보 수집 및 이용 동의</span>
                </div>
                <button type="button" class="view_detail" onclick="toggleDetail(this)">내용보기 ▼</button>
                <div class="term_detail" style="display:none;">
                    <p>수집항목: 이메일, 이름, 전화번호<br>수집목적: 회원관리, 교육과정 제공<br>보유기간: 회원 탈퇴 시까지...</p>
                </div>
            </div>
            <!-- 개별 약관 3 -->
            <div class="terms_item">
                <div class="term_row" onclick="this.querySelector('input').click()">
                    <input type="checkbox" class="term_check" data-required="false" onchange="checkAgree()">
                    <span>[선택] 마케팅 정보 수신 동의</span>
                </div>
            </div>
        </div>
        <div class="modal_footer">
            <button type="button" id="agreeBtn" class="btn_agree" onclick="confirmAgree()" disabled>동의하고 계속하기</button>
        </div>
    </div>
</div>

</body>

</html>
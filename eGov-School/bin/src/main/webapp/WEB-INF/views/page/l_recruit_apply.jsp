<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강사 지원 - 이력서 작성 - eGov-School</title>
    <link rel="stylesheet" href="/resources/css/MainPage/style.css">
    <link rel="stylesheet" href="/resources/css/MainPage/l_recruit_apply.css">
    <style>
        
    </style>
</head>
<body>

<%@ include file="../modules/header.jsp" %>

<!-- 페이지 상단 -->
<div class="page-top">
    <div class="wrap-sm">
        <div class="path">홈 &gt; 강사채용 &gt; 공고 상세 &gt; 지원하기</div>
        <h2>강사채용 신청서 작성</h2>
    </div>
</div>

<div class="wrap-sm" style="padding-bottom: 40px;">

    <!-- 공고 요약 -->
    <div class="notice-summary">
        <strong>지원 공고 :</strong> 2026년 관세직 전문 강사 채용공고 &nbsp;|&nbsp;
        <strong>채용분야 :</strong> <span id="noticeJob">관세직</span> &nbsp;|&nbsp;
        <strong>접수기간 :</strong> 2026.03.10 ~ 2026.04.10
    </div>

    <!-- ① 인적사항 -->
    <div class="sec-bar">① 인적사항</div>
    <div style="margin-bottom: 6px;">
        <!-- 접수번호 -->
        <table class="form-table" style="width:100%; margin-bottom:0;">
            <tr class="receipt-row">
                <th>접수번호</th>
                <td colspan="2">
                    <input type="text" id="receiptNumber" disabled>
                </td>
            </tr>
        </table>
    </div>

    <!-- 사진 + 기본정보 -->
    <div class="photo-wrap">
        <div class="photo-box" onclick="document.getElementById('photoInput').click()">
            사진<br>클릭하여<br>업로드
            <input type="file" id="photoInput" accept="image/*"
                   style="display:none" onchange="previewPhoto(event)">
        </div>
        <div class="form-right">
            <table class="form-table" style="width:100%;">
                <tr>
                    <th>성명 *</th>
                    <td><input type="text" class="full" placeholder="홍길동"></td>
                    <th>생년월일 *</th>
                    <td><input type="date" class="full"></td>
                </tr>
                <tr>
                    <th>성별 *</th>
                    <td>
                        <label><input type="radio" name="gender" value="남"> 남</label> &nbsp;
                        <label><input type="radio" name="gender" value="여"> 여</label>
                    </td>
                    <th>주민등록번호</th>
                    <td><input type="text" class="full" placeholder="000000-*******"></td>
                </tr>
                <tr>
                    <th>연락처 *</th>
                    <td><input type="tel" class="full" placeholder="010-0000-0000"></td>
                    <th>이메일</th>
                    <td><input type="email" class="full" placeholder="example@email.com"></td>
                </tr>
                <tr>
                    <th>주소 *</th>
                    <td colspan="3">
                        <input type="text" style="width:120px;" placeholder="우편번호">
                        <button type="button" class="btn btn-blue btn-sm">주소검색</button>
                        <input type="text" class="full" style="margin-top:4px;" placeholder="상세주소">
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <!-- ② 관련 자격증 -->
    <div class="sec-bar" style="margin-top:16px;">② 지원 강좌 관련 자격증</div>
    <table class="form-table" id="certTable" style="width:100%;">
        <thead>
            <tr>
                <th style="text-align:center;">자격증명</th>
                <th style="text-align:center;">발급기관</th>
                <th style="text-align:center;">취득일</th>
                <th style="text-align:center;">등급/종류</th>
                <th style="text-align:center; width:60px;">삭제</th>
            </tr>
        </thead>
        <tbody id="certBody">
            <tr>
                <td><input type="text" class="full" placeholder="예) 관세사"></td>
                <td><input type="text" class="full" placeholder="예) 관세청"></td>
                <td><input type="date" class="full"></td>
                <td><input type="text" class="full" placeholder="예) 1급"></td>
                <td style="text-align:center;"><button type="button" class="btn-del" onclick="delRow(this,'certBody')">삭제</button></td>
            </tr>
        </tbody>
    </table>
    <button class="btn-add" onclick="addCertRow()">+ 자격증 추가</button>

    <!-- ③ 경력사항 -->
    <div class="sec-bar" style="margin-top:16px;">③ 경력사항</div>
    <table class="form-table" id="careerTable" style="width:100%;">
        <thead>
            <tr>
                <th style="text-align:center;">기관명</th>
                <th style="text-align:center;">시작일</th>
                <th style="text-align:center;">종료일</th>
                <th style="text-align:center;">담당업무</th>
                <th style="text-align:center;">비고</th>
                <th style="text-align:center; width:60px;">삭제</th>
            </tr>
        </thead>
        <tbody id="careerBody">
            <tr>
                <td><input type="text" class="full" placeholder="기관/회사명"></td>
                <td><input type="date" class="full"></td>
                <td><input type="date" class="full"></td>
                <td><input type="text" class="full" placeholder="담당업무"></td>
                <td><input type="text" class="full" placeholder="비고"></td>
                <td style="text-align:center;"><button type="button" class="btn-del" onclick="delRow(this,'careerBody')">삭제</button></td>
            </tr>
            <tr>
                <td><input type="text" class="full" placeholder="기관/회사명"></td>
                <td><input type="date" class="full"></td>
                <td><input type="date" class="full"></td>
                <td><input type="text" class="full" placeholder="담당업무"></td>
                <td><input type="text" class="full" placeholder="비고"></td>
                <td style="text-align:center;"><button type="button" class="btn-del" onclick="delRow(this,'careerBody')">삭제</button></td>
            </tr>
        </tbody>
    </table>
    <button class="btn-add" onclick="addCareerRow()">+ 경력 추가</button>

    <!-- ④ 학력사항 -->
    <div class="sec-bar" style="margin-top:16px;">④ 학력사항</div>
    <table class="form-table" style="width:100%;">
        <tr>
            <th>최종학력</th>
            <td>
                <select>
                    <option>학력 선택</option>
                    <option>고등학교 졸업</option>
                    <option>전문대학교 졸업</option>
                    <option>대학교 졸업</option>
                    <option>대학원(석사) 졸업</option>
                    <option>대학원(박사) 졸업</option>
                </select>
            </td>
            <th>졸업연도</th>
            <td><input type="text" placeholder="예) 2015.02" style="width:130px;"></td>
        </tr>
        <tr>
            <th>학교명</th>
            <td><input type="text" style="width:200px;" placeholder="학교명"></td>
            <th>전공</th>
            <td><input type="text" style="width:200px;" placeholder="전공"></td>
        </tr>
    </table>

    <!-- ⑤ 자기소개서 -->
    <div class="sec-bar" style="margin-top:16px;">⑤ 자기소개서</div>
    <table class="form-table" style="width:100%;">
        <tr>
            <th style="vertical-align:top; padding-top:10px;">지원동기 및<br>강의계획</th>
            <td>
                <textarea class="full" rows="5" maxlength="500"
                          placeholder="지원 동기, 강의 경험, 강의 계획 등을 작성해 주세요. (500자 이내)"
                          oninput="countChar(this,'cnt1')"></textarea>
                <div class="charcount"><span id="cnt1">0</span>/500자</div>
            </td>
        </tr>
        <tr>
            <th style="vertical-align:top; padding-top:10px;">전문성 및<br>역량</th>
            <td>
                <textarea class="full" rows="5" maxlength="500"
                          placeholder="해당 분야의 전문 지식, 경험, 역량에 대해 작성해 주세요. (500자 이내)"
                          oninput="countChar(this,'cnt2')"></textarea>
                <div class="charcount"><span id="cnt2">0</span>/500자</div>
            </td>
        </tr>
    </table>

    <!-- 개인정보 동의 -->
    <div class="agree-box">
        본 이력서에 기재된 개인정보는 강사 채용 심사 목적으로만 사용되며, 채용 결과 확정 후 파기됩니다.<br>
        「개인정보 보호법」 제15조에 의거, 아래 내용에 동의하셔야 지원이 가능합니다.<br><br>
        <label>
            <input type="checkbox" id="agreeCheck">
            &nbsp;위 개인정보 수집·이용에 동의합니다. (필수)
        </label>
    </div>

    <!-- 제출 버튼 -->
    <div class="submit-area">
        <button class="btn btn-lg" onclick="history.back()">취소</button>
        &nbsp;
        <button class="btn btn-blue btn-lg" onclick="submitForm()">지원하기</button>
    </div>

</div>

<%@ include file="../modules/footer.jsp" %>

<script>
//직무별 접수번호 앞자리
var JOB_PREFIX = {
    '관세직':    'd',
    '세무직':    't',
    '보건직':    'h',
    '행정직':    'a',
    '농촌지도사': 'r',
    '기술직':    'e',
    '교육직':    'ed',
    '사회복지직': 's'
};

// 접수번호 생성 (prefix + 3자리 숫자)
function makeReceiptNum(job) {
    var prefix = JOB_PREFIX[job] || 'x';
    var num    = String(Math.floor(Math.random() * 900) + 100);
    return prefix + num;
}

// 페이지 로드
window.onload = function() {
    var params  = new URLSearchParams(window.location.search);
    var job     = params.get('job') || '관세직';

    // 공고 직무명 표시
    var jobSpan = document.getElementById('noticeJob');
    if (jobSpan) jobSpan.textContent = job;

    // 접수번호 세팅 (비활성화)
    var input = document.getElementById('receiptNumber');
    if (input) {
        input.value    = makeReceiptNum(job);
        input.disabled = true;
    }
};

// 사진 미리보기
function previewPhoto(e) {
    var file = e.target.files[0];
    if (!file) return;
    var url = URL.createObjectURL(file);
    var box = document.querySelector('.photo-box');
    box.innerHTML = '<img src="' + url + '" style="width:100%;height:100%;object-fit:cover;">';
}

// 경력 행 추가
function addCareerRow() {
    var tbody = document.getElementById('careerBody');
    var tr = document.createElement('tr');
    tr.innerHTML =
        '<td><input type="text" class="full" placeholder="기관/회사명"></td>' +
        '<td><input type="date" class="full"></td>' +
        '<td><input type="date" class="full"></td>' +
        '<td><input type="text" class="full" placeholder="담당업무"></td>' +
        '<td><input type="text" class="full" placeholder="비고"></td>' +
        '<td style="text-align:center;"><button type="button" class="btn-del" onclick="delRow(this,\'careerBody\')">삭제</button></td>';
    tbody.appendChild(tr);
}

// 자격증 행 추가
function addCertRow() {
    var tbody = document.getElementById('certBody');
    var tr = document.createElement('tr');
    tr.innerHTML =
        '<td><input type="text" class="full" placeholder="예) 관세사"></td>' +
        '<td><input type="text" class="full" placeholder="예) 관세청"></td>' +
        '<td><input type="date" class="full"></td>' +
        '<td><input type="text" class="full" placeholder="예) 1급"></td>' +
        '<td style="text-align:center;"><button type="button" class="btn-del" onclick="delRow(this,\'certBody\')">삭제</button></td>';
    tbody.appendChild(tr);
}

// 행 삭제 (최소 1행 유지)
function delRow(btn, tbodyId) {
    var tbody = document.getElementById(tbodyId);
    if (tbody.rows.length <= 1) {
        alert('최소 1행은 남겨야 합니다.');
        return;
    }
    btn.closest('tr').remove();
}

// 글자수 카운트
function countChar(el, spanId) {
    document.getElementById(spanId).textContent = el.value.length;
}

// 지원 제출
function submitForm() {
    if (!document.getElementById('agreeCheck').checked) {
        alert('개인정보 수집·이용에 동의해 주세요.');
        return;
    }
    var receipt = document.getElementById('receiptNumber').value;
    if (confirm('접수번호 [' + receipt + ']로 지원서를 제출하시겠습니까?')) {
        alert('지원이 완료되었습니다.\n접수번호: ' + receipt + '\n심사 결과는 이메일로 안내드립니다.');
        location.href = 'instructor_recruit.html';
    }
}
</script>

</body>
</html>

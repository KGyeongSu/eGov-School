<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강사채용 상세 - eGov-School</title>
    <link rel="stylesheet" href="/resources/css/MainPage/style.css">
    <link rel="stylesheet" href="/resources/css/MainPage/l_recruit_detail.css">
    
    <style>
        
    </style>
</head>
<body>

<%@ include file="../modules/header.jsp" %>

<!-- 페이지 상단 -->
<div class="page-top">
    <div class="wrap-sm">
        <div class="path">홈 &gt; 강사채용 &gt; <span id="jobTitle">채용공고 상세</span></div>
        <h2>강사 채용 공고 상세</h2>
    </div>
</div>

<div class="wrap-sm" style="padding-bottom: 40px;">

    <!-- 공고 제목 -->
    <div class="notice-title-box">
        <h3>2026년 관세직 전문 강사 채용공고</h3>
        <div class="meta">
            <span>작성자: admin</span>
            <span>작성일: 2026.03.10</span>
            <span>조회수: 142</span>
            <span><span class="badge badge-on">진행중</span></span>
        </div>
    </div>

    <!-- 채용 기본 정보 -->
    <div style="margin-bottom: 14px;">
        <table class="form-table">
            <tr>
                <th>채용분야</th>
                <td>관세직 (관세법, 무역실무)</td>
                <th>모집인원</th>
                <td>0명 (심사 후 결정)</td>
            </tr>
            <tr>
                <th>접수기간</th>
                <td>2026.03.10 ~ 2026.04.10</td>
                <th>계약기간</th>
                <td>2026.05.01 ~ 2026.12.31</td>
            </tr>
            <tr>
                <th>보수</th>
                <td>시간당 80,000원 (협의 가능)</td>
                <th>근무형태</th>
                <td>비상주 (영상 촬영 및 온라인 강의)</td>
            </tr>
        </table>
    </div>

    <!-- 채용 안내 -->
    <div class="box">
        <div class="box-title">채용 안내 및 자격요건</div>
        <p style="font-size:13px; line-height:1.9; color:#333;">
            <strong>■ 지원 자격</strong><br>
            - 관세직 관련 분야 경력 3년 이상인 자<br>
            - 관련 자격증 보유자 우대 (관세사, 무역영어 등)<br>
            - 온라인 강의 제작 경험자 우대<br>
            <br>
            <strong>■ 제출 서류</strong><br>
            - 이력서 (자유 양식 또는 본 사이트 이력서)<br>
            - 경력증명서 1부<br>
            - 자격증 사본 (해당자에 한함)<br>
            <br>
            <strong>■ 전형 절차</strong><br>
            서류심사 → 면접심사 → 최종합격 → 계약체결<br>
            <br>
            <strong>■ 문의</strong><br>
            eGov-School 강사채용 담당 (02-1234-5678 / recruit@egovschool.go.kr)
        </p>
    </div>

    <!-- 지원하기 -->
    <div class="apply-box">
        <div class="apply-info">
            <strong>지원하기</strong><br>
            지원하기 버튼을 클릭하여 이력서를 작성하고 지원을 완료할 수 있습니다.<br>
            접수 마감: <strong>2026.04.10</strong>
        </div>
        <button class="btn btn-blue btn-lg" id="applyBtn">지원하기</button>
    </div>

    <!-- 이전/다음 -->
    <div style="margin-bottom: 14px;">
        <table class="nav-table" style="width:100%; border-collapse:collapse;">
            <tr>
                <th>다음글</th>
                <td>다음 공고가 없습니다.</td>
            </tr>
            <tr>
                <th>이전글</th>
                <td><a href="l_recruit_detail.html?job=세무직">2026년 세무직 관련 강사 지원 공고</a></td>
            </tr>
        </table>
    </div>

    <!-- 버튼 -->
    <div style="text-align: center;">
        <button class="btn" onclick="location.href='/page/l_recruit'">목록</button>
    </div>

</div>

<%@ include file="../modules/footer.jsp" %>

<script>
const params = new URLSearchParams(window.location.search);
const job = params.get('job') || '관세직';

document.getElementById('jobTitle').textContent = job + ' 채용공고';

document.getElementById('applyBtn').onclick = function() {
    location.href = 'l_recruit_apply?job=' + job;
};
</script>

</body>
</html>

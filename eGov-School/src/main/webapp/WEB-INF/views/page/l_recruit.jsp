<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강사채용 공고 - eGov-School</title>
    <link rel="stylesheet" href="/resources/css/MainPage/style.css">
	<link rel="stylesheet" href="/resources/css/MainPage/l_recruit.css">    
    <style>
       
    </style>
</head>
<body>

<%@ include file="../modules/header.jsp" %>

<!-- 페이지 상단 -->
<div class="page-top">
    <div class="wrap">
        <div class="path">홈 &gt; 강사채용 &gt; 강사지원공고</div>
        <h2>강사 채용 공고</h2>
    </div>
</div>

<div class="wrap" style="padding-bottom: 40px;">

    <!-- 검색/필터 -->
    <div class="search-bar">
        <label>강의직무</label>
        <select id="jobFilter">
            <option value="">전체</option>
            <option value="보건직">보건직</option>
            <option value="농촌지도사">농촌지도사</option>
            <option value="세무직">세무직</option>
            <option value="관세직">관세직</option>
            <option value="행정직">행정직</option>
            <option value="기술직">기술직</option>
        </select>

        <label>모집분야</label>
        <select id="fieldFilter">
            <option value="">전체</option>
            <option value="공개">공개채용</option>
            <option value="경력">경력채용</option>
            <option value="계약">계약직</option>
        </select>

        <input type="text" id="searchInput" placeholder="제목 검색">
        <button class="btn btn-blue btn-sm" onclick="doSearch()">검색</button>
        <button class="btn btn-sm" onclick="doReset()">초기화</button>
    </div>

    <!-- 관리자 알림 (관리자일 때만 표시) -->
    <div class="admin-bar" id="adminBar" style="display:none;">
        🔒 관리자 모드입니다. 새 글 등록이 가능합니다.
    </div>

    <!-- 게시판 상단 -->
    <div class="board-top">
        <span class="total">총 <strong id="totalCount">6</strong>건</span>
        <button class="btn btn-blue btn-sm" id="writeBtn" style="display:none;"
                onclick="location.href='instructor_write.html'">새글 등록</button>
    </div>

    <!-- 게시판 테이블 -->
    <table class="board-table">
        <thead>
            <tr>
                <th style="width:50px;">번호</th>
                <th>제목</th>
                <th style="width:110px;">작성일</th>
                <th style="width:100px;">강의직무</th>
                <th style="width:100px;">모집분야</th>
                <th style="width:80px;">상태</th>
            </tr>
        </thead>
        <tbody id="boardBody">
            <tr onclick="location.href='l_recruit_detail?job=관세직'">
                <td>6</td>
                <td class="title"><a href="l_recruit_detail?job=관세직">2026년 관세직 전문 강사 채용공고</a></td>
                <td>2026.03.10</td>
                <td>관세직</td>
                <td>공개채용</td>
                <td><span class="badge badge-on">진행중</span></td>
            </tr>
            <tr onclick="location.href='l_recruit_detail?job=세무직'">
                <td>5</td>
                <td class="title"><a href="l_recruit_detail?job=세무직">2026년 세무직 관련 강사 지원 공고</a></td>
                <td>2026.03.08</td>
                <td>세무직</td>
                <td>공개채용</td>
                <td><span class="badge badge-on">진행중</span></td>
            </tr>
            <tr onclick="location.href='l_recruit_detail?job=농촌지도사'">
                <td>4</td>
                <td class="title"><a href="l_recruit_detaill?job=농촌지도사">농촌지도사 강사 모집 안내 (계약직)</a></td>
                <td>2026.03.05</td>
                <td>농촌지도사</td>
                <td>계약직</td>
                <td><span class="badge badge-on">진행중</span></td>
            </tr>
            <tr onclick="location.href='l_recruit_detail?job=보건직'">
                <td>3</td>
                <td class="title"><a href="l_recruit_detail?job=보건직">보건직 관련 강사 채용공고</a></td>
                <td>2026.02.28</td>
                <td>보건직</td>
                <td>공개채용</td>
                <td><span class="badge badge-on">진행중</span></td>
            </tr>
            <tr onclick="location.href='l_recruit_detail?job=행정직'">
                <td>2</td>
                <td class="title"><a href="l_recruit_detail?job=행정직">행정직 강사 모집 안내</a></td>
                <td>2026.02.20</td>
                <td>행정직</td>
                <td>경력채용</td>
                <td><span class="badge badge-end">마감</span></td>
            </tr>
            <tr onclick="location.href='l_recruit_detail?job=기술직'">
                <td>1</td>
                <td class="title"><a href="l_recruit_detail?job=기술직">기술직 전문 강사 지원 공고</a></td>
                <td>2026.02.10</td>
                <td>기술직</td>
                <td>공개채용</td>
                <td><span class="badge badge-end">마감</span></td>
            </tr>
        </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div class="paging">
        <a href="#">&lt;</a>
        <span class="on">1</span>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">&gt;</a>
    </div>

</div>

<%@ include file="../modules/footer.jsp" %>

<script>
	

//관리자 여부 (실제 서비스에서는 서버 세션으로 처리)
var isAdmin = true;

window.onload = function() {
 if (isAdmin) {
     document.getElementById('adminBar').style.display = 'block';
     document.getElementById('writeBtn').style.display = 'inline-block';
 }
};

function doSearch() {
 var job     = document.getElementById('jobFilter').value;
 var field   = document.getElementById('fieldFilter').value;
 var keyword = document.getElementById('searchInput').value.trim();
 var rows    = document.querySelectorAll('#boardBody tr');
 var count   = 0;

 rows.forEach(function(row) {
     var cells    = row.querySelectorAll('td');
     var title    = cells[1].textContent;
     var jobTxt   = cells[4].textContent;
     var fieldTxt = cells[5].textContent;

     var ok = true;
     if (job     && jobTxt.indexOf(job)         === -1) ok = false;
     if (field   && fieldTxt.indexOf(field)     === -1) ok = false;
     if (keyword && title.indexOf(keyword)      === -1) ok = false;

     row.style.display = ok ? '' : 'none';
     if (ok) count++;
 });

 document.getElementById('totalCount').textContent = count;
}

function doReset() {
 document.getElementById('jobFilter').value   = '';
 document.getElementById('fieldFilter').value = '';
 document.getElementById('searchInput').value = '';

 var rows = document.querySelectorAll('#boardBody tr');
 rows.forEach(function(row) { row.style.display = ''; });
 document.getElementById('totalCount').textContent = rows.length;
}
	
</script>

</body>
</html>

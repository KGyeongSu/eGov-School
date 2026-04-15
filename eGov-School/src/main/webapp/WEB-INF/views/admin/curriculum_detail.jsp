<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강좌 커리큘럼 상세 - 관리자 대시보드</title>
    <link rel="stylesheet" href="/resources/css/admin/admin.css">
    <link rel="stylesheet" href="/resources/css/admin/adminCurriDetail.css">
    <script src="/resources/js/admin.js"></script>
</head>
<body>

<!-- ===== 헤더 ===== -->
<header>
    <div class="logo">
        <a href="/admin/main">
            <img src="/images/dashBoardLogo.png" alt="대전광역시 인재개발원">
        </a>
    </div>
    <div class="header-right">
        <span class="hd-user">${adminName} 님의 대시보드</span>
        <button class="btn-logout">로그아웃</button>
    </div>
</header>

<!-- ===== 전체 레이아웃 ===== -->
<div class="layout">

    <!-- 사이드바 -->
    <div class="sidebar">
        <div class="side-menu">
            <a href="/admin/main">공무원 선발 가산점</a>
            <a href="/admin/feedback">강사 피드백</a>
            <a href="/admin/cv">강사지원자 이력서 확인</a>
            <a href="/admin/curriculum" class="on">강좌 커리큘럼 확인</a>
        </div>
        <div class="side-bottom">
           <strong>${adminName}</strong>
            관리자
        </div>
    </div>

    <!-- 메인 -->
    <div class="main">
        <div class="page-title">강좌 커리큘럼 확인</div>
        <div class="page-sub">IN_learn / dash / admin / cur_check / detail</div>

        

        <!-- ===== 상단: 강좌 기본 정보 ===== -->
        <div class="section-box">
            <div class="section-head">강좌 커리큘럼 상세보기</div>
            <div class="section-body">

                <div class="detail-layout">

                    <!-- 왼쪽: 썸네일 + 강좌번호/강좌명 -->
                    <div class="detail-left">
                        <div class="course-thumb">
                            <c:choose>
                                <c:when test="${not empty classVO.claSaveName}">
                                    <img src="/classDisplay/${classVO.claSaveName}" alt="강좌 썸네일"
                                         style="width:100%; height:100%; object-fit:cover;">
                                </c:when>
                                <c:otherwise>
                                    강좌 썸네일
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <table class="form-table" style="margin-top:10px;">
                            <tr>
                                <th>강좌번호</th>
                                <td>
                                    <input type="text" class="full" value="${classVO.claNum}" readonly>
                                </td>
                            </tr>
                            <tr>
                                <th>강좌명</th>
                                <td>
                                    <input type="text" class="full" value="${classVO.claTitle}" readonly>
                                </td>
                            </tr>
                            <tr>
                                <th>카테고리</th>
                                <td>
                                    <input type="text" class="full" value="${classVO.claCategory}" readonly>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <!-- 오른쪽: 관리자 입력 영역 -->
                    <div class="detail-right">
                        <table class="form-table" style="width:100%;">
                            <tr>
                                <th>강사명</th>
                                <td>
                                    <input type="text" class="full" value="${classVO.userName}" readonly>
                                </td>
                                <th>수강 정원</th>
                                <td>
                                    <input type="number" id="maxStu" style="width:80px;" placeholder="정원" min="1"> 명
                                </td>
                            </tr>
                            <tr>
                                <th>교육 시작일</th>
                                <td>
                                    <input type="date" id="startDate">
                                </td>
                                <th>교육 종료일</th>
                                <td>
                                    <input type="date" id="endDate">
                                </td>
                            </tr>
                            <tr>
                                <th>가산점 기준</th>
                                <td colspan="3">
                                    <select id="bonusSelect" onchange="onBonusChange()">
                                        <option value="">-- 가산점 기준 선택 --</option>
                                        <c:forEach var="bonus" items="${bonusList}">
                                            <option value="${bonus.bcScore}" 
                                                    data-note="${bonus.bcNote}">
                                                ${bonus.bcContent} (${bonus.bcScore}점)
                                            </option>
                                        </c:forEach>
                                        <option value="direct">직접입력</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>가산점</th>
                                <td>
                                    <input type="number" id="bonusScore" style="width:80px;" readonly> 점
                                </td>
                                <th>수료조건</th>
                                <td>
                                    <input type="text" id="completeCondition" class="full" readonly>
                                </td>
                            </tr>
                        </table>
                    </div>

                </div>
            </div>
        </div>

        <!-- ===== 하단: 커리큘럼 + 학습목표 ===== -->
        <div class="detail-bottom">

            <!-- 왼쪽: 커리큘럼 목록 -->
            <div class="section-box" style="flex:1; margin-bottom:0;">
                <div class="section-head">커리큘럼</div>
                <div class="section-body" style="padding:10px;">
                    <table class="board-table">
                        <thead>
                            <tr>
                                <th style="width:50px;">차시</th>
                                <th>강의 제목</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty lessonList}">
                                    <c:forEach var="lesson" items="${lessonList}">
                                        <tr>
                                            <td>${lesson.lsnSeq}강</td>
                                            <td class="left">${lesson.lsnTitle}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="2" style="text-align:center; color:#999;">
                                            등록된 커리큘럼이 없습니다.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 오른쪽: 학습목표 -->
            <div class="right-col">
                <div class="section-box" style="margin-bottom:0;">
                    <div class="section-head">학습목표</div>
                    <div class="section-body">
                        <textarea class="full" rows="6" readonly>${classVO.claContent}</textarea>
                    </div>
                </div>
            </div>

        </div>

        <!-- 하단 버튼 -->
        <div style="text-align:center; margin-top:16px; display:flex; gap:10px; justify-content:center;">
            <button class="btn" onclick="location.href='/admin/curriculum'">목록으로</button>
            <button class="btn btn-blue" onclick="doApprove()">승인</button>
        </div>

    </div><!-- /.main -->
</div><!-- /.layout -->



<script>
    /* 가산점 기준 드롭다운 변경 시 */
    function onBonusChange() {
        var select = document.getElementById('bonusSelect');
        var scoreInput = document.getElementById('bonusScore');
        var completeInput = document.getElementById('completeCondition');

        if (select.value === 'direct') {
            scoreInput.readOnly = false;
            scoreInput.value = '';
            scoreInput.focus();
            completeInput.readOnly = false;
            completeInput.value = '';
        } else if (select.value === '') {
            scoreInput.readOnly = true;
            scoreInput.value = '';
            completeInput.readOnly = true;
            completeInput.value = '';
        } else {
            var selectedOption = select.options[select.selectedIndex];
            scoreInput.readOnly = true;
            scoreInput.value = select.value;
            completeInput.readOnly = true;
            completeInput.value = selectedOption.getAttribute('data-note');
        }
    }

    /* 승인 처리 */
    function doApprove() {
        var startDate = document.getElementById('startDate').value;
        var endDate = document.getElementById('endDate').value;
        var maxStu = document.getElementById('maxStu').value;
        var bonusScore = document.getElementById('bonusScore').value;
        var completeCondition = document.getElementById('completeCondition').value;

        // 유효성 검사
        if (!startDate) { alert('교육 시작일을 입력하세요.'); return; }
        if (!endDate) { alert('교육 종료일을 입력하세요.'); return; }
        if (startDate >= endDate) { alert('종료일은 시작일보다 이후여야 합니다.'); return; }
        if (!maxStu || maxStu <= 0) { alert('수강 정원을 입력하세요.'); return; }
        if (!bonusScore) { alert('가산점을 선택 또는 입력하세요.'); return; }
        if (!completeCondition) { alert('수료조건을 선택 또는 입력하세요.'); return; }

        if (!confirm('이 강좌를 승인하시겠습니까?')) return;

        // Ajax 요청
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/admin/approveClass', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.responseText === 'success') {
                    alert('승인이 완료되었습니다.');
                    location.href = '/admin/curriculum';
                } else {
                    alert('승인 처리 중 오류가 발생했습니다.');
                }
            }
        };
        xhr.send('claNum=${classVO.claNum}'
               + '&claStartDate=' + startDate
               + '&claEndDate=' + endDate
               + '&claMaxStu=' + maxStu
               + '&claBonus=' + bonusScore
               + '&claComplete=' + encodeURIComponent(completeCondition));
    }
</script>

</body>
</html>

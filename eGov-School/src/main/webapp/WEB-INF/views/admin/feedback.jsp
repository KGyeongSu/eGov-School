<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin 대시보드 - 강사 피드백</title>
    <link rel="stylesheet" href="/resources/css/admin/admin.css">
    <script src="/resources/js/admin.js"></script>
    <style>
        .score-low {
            color: #e74c3c !important;
            font-weight: bold;
        }
        .score-normal {
            color: #f39c12 !important;
            font-weight: bold;
        }
        .card-item {
            cursor: pointer;
            transition: background 0.2s;
        }
        .card-item:hover {
            background-color: #f8f9fa;
        }
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.6);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }
        .preview-area.score-box {
            display: inline-block;
            padding: 8px 15px;
            border-radius: 6px;
            background-color: #f1f3f5;
            font-size: 1.1rem;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<header>
    <div class="logo">
        <a href="/admin/main">
            <img src="/images/dashBoardLogo.png" alt="대전광역시 인재개발원">
        </a>
    </div>
    <div class="header-right">
        <span class="hd-user">${loginUser.userName} 님의 대시보드</span>
        <button class="btn-logout" onclick="location.href='/commons/logout'">로그아웃</button>
    </div>
</header>

<div class="layout">
    <div class="sidebar">
        <div class="side-menu">
            <a href="/admin/main">공무원 선발 가산점</a>
            <a href="/admin/feedback" class="on">강사 피드백</a>
            <a href="/admin/cv">강사지원자 이력서 확인</a>
            <a href="/admin/curriculum">강좌 커리큘럼 확인</a>
        </div>
        <div class="side-bottom">
            <strong>${loginUser.userName}</strong>
            관리자
        </div>
    </div>

    <div class="main">
        <div class="page-title">강사 피드백</div>
        <div class="page-sub">eschool / dash / adm / fb</div>

        <div class="tab-bar" data-group="fb">
            <a href="#" class="on" onclick="showTab('tab-fb-list', this)">수강생 피드백 확인</a>
            <a href="#" onclick="showTab('tab-fb-general', this)">강사 피드백 종합</a>
        </div>

        <div class="tab-content active" id="tab-fb-list" data-group="fb">
            <div class="cur-tab">수강생 피드백 확인</div>
            <div class="section-box">
                <div class="section-head">수강생 피드백 확인</div>
                <div class="section-body">
                    <form action="/admin/feedback" method="get">
                        <div class="search-bar">
                            <label>강사</label>
                            <select name="lecturerName" id="fbInstructor">
                                <option value="">전체</option>
                                <option value="김강사" ${searchVO.lecturerName == '김강사' ? 'selected' : ''}>김강사</option>
                                <option value="이강사" ${searchVO.lecturerName == '이강사' ? 'selected' : ''}>이강사</option>
                                <option value="박강사" ${searchVO.lecturerName == '박강사' ? 'selected' : ''}>박강사</option>
                            </select>
                            
                            <label>점수</label>
                            <select name="repSat" id="fbScoreSelect">
                                <option value="0">전체</option>
                                <option value="5" ${searchVO.repSat == 5 ? 'selected' : ''}>5점</option>
                                <option value="4" ${searchVO.repSat == 4 ? 'selected' : ''}>4점</option>
                                <option value="3" ${searchVO.repSat == 3 ? 'selected' : ''}>3점</option>
                                <option value="2" ${searchVO.repSat == 2 ? 'selected' : ''}>2점</option>
                                <option value="1" ${searchVO.repSat == 1 ? 'selected' : ''}>1점</option>
                            </select>

                            <input type="text" name="keyword" value="${searchVO.keyword}" placeholder="수강생명/강좌/내용 검색">
                            <button type="submit" class="btn btn-blue btn-sm">검색</button>
                            <button type="button" class="btn btn-sm" onclick="location.href='/admin/feedback'">초기화</button>
                        </div>
                    </form>

                    <div class="card-grid" id="fbGrid">
                        <c:forEach var="fb" items="${reputationList}">
                            <div class="card-item" 
                                 onclick="openFbModal('${fb.userName}','${fb.lecturerName}','${fb.claTitle}',`<c:out value="${fb.repContent}"/>`, '${fb.repSat}')">
                                <div class="card-thumb">피드백 카드</div>
                                <div class="card-info">
                                    ${fb.userName} | ${fb.claTitle}<br>
                                    강사: ${fb.lecturerName} 
                                    <span class="${fb.repSat <= 2 ? 'score-low' : 'score-normal'}">
                                        <c:forEach begin="1" end="${fb.repSat}">★</c:forEach>
                                        <c:forEach begin="${fb.repSat + 1}" end="5">☆</c:forEach>
                                    </span> ${fb.repSat}.0
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty reputationList}">
                            <div style="grid-column: 1/-1; text-align: center; padding: 50px; color: #999;">
                                검색 결과가 없습니다.
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <div class="tab-content" id="tab-fb-general" data-group="fb">
            <div class="cur-tab">강사 피드백 종합</div>
            <div class="three-col">
                <div class="section-box">
                    <div class="section-head">사용자 평가 요약</div>
                    <div class="section-body">
                        <span class="stat-num">4.2</span><span class="stat-label">평균 점수</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<footer>
    <strong>대전광역시 인재개발원</strong> | eGov-School 관리자 페이지
</footer>

<div class="modal-overlay" id="modal-fb" onclick="handleOverlayClick(event)">
    <div class="modal-box">
        <div class="modal-head">
            수강생 피드백 상세
            <div class="modal-btns">
                <button type="button" class="mbtn-cancel" onclick="closeFbModal()">닫기</button>
            </div>
        </div>
        <div class="modal-body">
            <div class="form-row">
                <label>수강생 / 강사 / 강좌</label>
                <div class="preview-area" id="fb-info"></div>
            </div>
            <div class="form-row">
                <label>피드백 내용</label>
                <div class="preview-area" id="fb-content" style="white-space: pre-wrap;"></div>
            </div>
            <div class="form-row">
                <label>평점</label>
                <div class="preview-area score-box" id="fb-score-val"></div>
            </div>
        </div>
    </div>
</div>

<script>
    function openFbModal(student, instructor, course, comment, score) {
        document.getElementById('fb-info').innerHTML = 
            '<b>수강생:</b> ' + student + ' | <b>강사:</b> ' + instructor + ' | <b>강좌:</b> ' + course;
        document.getElementById('fb-content').textContent = comment;
        
        const scoreVal = document.getElementById('fb-score-val');
        const numScore = parseInt(score);
        
        let stars = '';
        for(let i=1; i<=5; i++) {
            stars += (i <= numScore) ? '★' : '☆';
        }
        
        scoreVal.innerHTML = '<span>' + stars + '</span> ' + score + ' / 5.0';
        
        if (numScore <= 2) {
            scoreVal.className = 'preview-area score-box score-low';
        } else {
            scoreVal.className = 'preview-area score-box score-normal';
        }
        
        document.getElementById('modal-fb').style.display = 'flex';
    }

    function closeFbModal() {
        document.getElementById('modal-fb').style.display = 'none';
    }

    function handleOverlayClick(event) {
        if (event.target.id === 'modal-fb') {
            closeFbModal();
        }
    }

    function showTab(tabId, el) {
        var group = el.parentNode.getAttribute('data-group');
        document.querySelectorAll('.tab-content[data-group="'+group+'"]').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.tab-bar[data-group="'+group+'"] a').forEach(a => a.classList.remove('on'));
        document.getElementById(tabId).classList.add('active');
        el.classList.add('on');
    }
</script>
</body>
</html>
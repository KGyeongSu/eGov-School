<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강좌 커리큘럼 확인 - 관리자 대시보드</title>
    <link rel="stylesheet" href="/resources/css/admin/admin.css">
    <script src="/resources/js/admin.js"></script>
</head>
<body>


<header>
    <div class="logo">
        <a href="/admin/main">
            <img src="../../../resources/images/dashboardLogo.png" alt="대전광역시 인재개발원">
        </a>
    </div>
    <div class="header-right">
        <span class="hd-user">${adminName}님의 대시보드</span>
        <button class="btn-logout" onclick="location.href='/commons/logout'">로그아웃</button>
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
        <div class="page-sub">IN_learn / dash / admin / cur_check</div>

        <div class="section-box">
            <div class="section-head">강좌 커리큘럼 리스트</div>
            <div class="section-body">

                <!-- 검색 -->
                <div class="search-bar">
				    <form id="searchForm" action="/admin/curriculum" method="get" style="display:flex; gap:6px; align-items:center;">
				        <input type="text" name="keyword" id="searchInput" placeholder="강좌명, 강사명 검색" value="${pageMaker.keyword}">
				        <button type="submit" class="btn btn-blue btn-sm">검색</button>
				        <button type="button" class="btn btn-sm" onclick="location.href='/admin/curriculum'">초기화</button>
				    </form>
				</div>

                <!-- 커리큘럼 목록 테이블 (경수65~100) -->
                <table class="board-table">
                    <thead>
                        <tr>
                            <th style="width:90px;">강사명</th>
                            <th style="width:100px;">강좌번호</th>
                            <th>강좌명</th>
                            <th>학습내용</th>
                            <th style="width:70px;">더보기</th>
                        </tr>
                    </thead>
                    
                    <tbody id="curriculumBody">
					    <c:choose>
					        <c:when test="${not empty classList}">
					            <c:forEach var="cls" items="${classList}" varStatus="status">
					                <tr>
					                    <td>${cls.userName}</td>
					                    <td>${cls.claNum}</td>
					                    <td class="left">${cls.claTitle}</td>
					                    <td class="left">${cls.claContent}</td>
					                    <td>
					                        <a href="/admin/curriculum_detail?claNum=${cls.claNum}" class="btn btn-sm">상세보기</a>
					                    </td>
					                </tr>
					            </c:forEach>
					        </c:when>
					        <c:otherwise>
					            <tr>
					                <td colspan="5" style="text-align:center; padding:30px; color:#999;">
					                    승인대기 중인 강좌가 없습니다.
					                </td>
					            </tr>
					        </c:otherwise>
					    </c:choose>
					</tbody>
					
                </table>

                <!-- 페이지네이션 (경수105~116) -->
                <div class="paging">
				    <c:if test="${pageMaker.prev}">
				        <a href="/admin/curriculum?page=${pageMaker.startPage - 1}&keyword=${pageMaker.keyword}">&lt;</a>
				    </c:if>
				    <c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				        <a href="/admin/curriculum?page=${pageNum}&keyword=${pageMaker.keyword}"
				           class="${pageMaker.page == pageNum ? 'on' : ''}">${pageNum}</a>
				    </c:forEach>
				    <c:if test="${pageMaker.next}">
				        <a href="/admin/curriculum?page=${pageMaker.endPage + 1}&keyword=${pageMaker.keyword}">&gt;</a>
				    </c:if>
				</div>

            </div>
        </div>
    </div><!-- /.main -->
</div><!-- /.layout -->




</body>
</html>
    

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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

<!-- ===== 헤더 ===== -->
<header>
    <div class="logo">
        <a href="/admin/main">
            <img src="/images/dashboardLogo.png" alt="대전광역시 인재개발원">
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
        <div class="page-sub">IN_learn / dash / admin / cur_check</div>

        <div class="section-box">
            <div class="section-head">강좌 커리큘럼 리스트</div>
            <div class="section-body">

                <div class="search-bar">
                    <input type="text" id="searchInput" placeholder="강좌명, 강사명 검색">
                    <button class="btn btn-blue btn-sm" onclick="filterList()">검색</button>
                    <button class="btn btn-sm" onclick="resetList()">초기화</button>
                </div>

                <!-- 커리큘럼 목록 테이블 -->
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
                        <tr>
                            <td>김강사</td>
                            <td>C-2026-001</td>
                            <td class="left">공무원 행정법 기초 과정</td>
                            <td class="left">행정법 개요, 행정행위, 행정절차법 등</td>
                            <td><a href="/admin/curriculum_detail" class="btn btn-sm">상세보기</a></td>
                        </tr>
                        <tr>
                            <td>이강사</td>
                            <td>C-2026-002</td>
                            <td class="left">세무직 실무 완성 과정</td>
                            <td class="left">부가세, 소득세, 법인세 실무 처리</td>
                            <td><a href="/admin/curriculum/2" class="btn btn-sm">상세보기</a></td>
                        </tr>
                        <tr>
                            <td>김강사</td>
                            <td>C-2026-003</td>
                            <td class="left">관세법 핵심 정리</td>
                            <td class="left">관세법 체계, 수출입 통관, 관세 계산</td>
                            <td><a href="/admin/curriculum/3" class="btn btn-sm">상세보기</a></td>
                        </tr>
                        <tr>
                            <td>박강사</td>
                            <td>C-2026-004</td>
                            <td class="left">보건직 전문 과정</td>
                            <td class="left">공중보건, 역학, 보건행정 실무</td>
                            <td><a href="/admin/curriculum/4" class="btn btn-sm">상세보기</a></td>
                        </tr>
                        <tr>
                            <td>이강사</td>
                            <td>C-2026-005</td>
                            <td class="left">농촌지도사 실무 과정</td>
                            <td class="left">농업정책, 농촌개발, 현장 지도 실무</td>
                            <td><a href="/admin/curriculum/5" class="btn btn-sm">상세보기</a></td>
                        </tr>
                        <tr>
                            <td>박강사</td>
                            <td>C-2026-006</td>
                            <td class="left">기술직 입문 과정</td>
                            <td class="left">토목·건축 기초, 기술직 공무원 실무</td>
                            <td><a href="/admin/curriculum/6" class="btn btn-sm">상세보기</a></td>
                        </tr>
                        <tr>
                            <td>김강사</td>
                            <td>C-2026-007</td>
                            <td class="left">디지털 행정 기초</td>
                            <td class="left">전자정부, 정보보안, 디지털 문서 처리</td>
                            <td><a href="/admin/curriculum/7" class="btn btn-sm">상세보기</a></td>
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
        </div>
    </div><!-- /.main -->

</body>
</html>
    

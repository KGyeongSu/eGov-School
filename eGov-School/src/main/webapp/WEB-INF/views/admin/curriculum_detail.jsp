<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강좌 커리큘럼 상세 - 관리자 대시보드</title>
    <link rel="stylesheet" href="/resources/css/admin/admin.css">
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

        <!-- 인러닝에 게시하기 버튼 -->
        <div style="text-align:right; margin-bottom:12px;">
            <button class="btn btn-blue" onclick="publishToInlearning()">인러닝에 게시하기</button>
        </div>

        <!-- ===== 상단: 강좌 기본 정보 ===== -->
        <div class="section-box">
            <div class="section-head">강좌 커리큘럼 상세보기</div>
            <div class="section-body">

                <div class="detail-layout">

                    <!-- 왼쪽: 썸네일 + 강좌번호/강좌명 -->
                    <div class="detail-left">
                        <div class="course-thumb">강좌 썸네일</div>
                        <table class="form-table" style="margin-top:10px;">
                            <tr>
                                <th>강좌번호</th>
                                <td>
                                    <!--
                                        DB: SELECT course_no FROM courses WHERE id = ?
                                    -->
                                    <input type="text" id="courseNo" class="full" value="34" readonly>
                                </td>
                            </tr>
                            <tr>
                                <th>강좌명</th>
                                <td>
                                    <!-- DB: SELECT course_name FROM courses WHERE id = ? -->
                                    <input type="text" id="courseName" class="full" value="공무원 행정법 기초 과정" readonly>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <!-- 오른쪽: 상세 정보 입력 -->
                    <div class="detail-right">
                        <table class="form-table" style="width:100%;">
                            <tr>
                                <th>강사명</th>
                                <td>
                                    <!-- DB: SELECT i.name FROM instructors i JOIN courses c ON c.instructor_id = i.id WHERE c.id = ? -->
                                    <input type="text" id="instructorName" class="full" value="김강사" readonly>
                                </td>
                                <th>신청기간</th>
                                <td>
                                    <!--
                                        DB: SELECT apply_start, apply_end FROM courses WHERE id = ?
                                        관리자가 직접 입력 후 저장
                                    -->
                                    <input type="date" id="applyStart">
                                    ~
                                    <input type="date" id="applyEnd">
                                </td>
                            </tr>
                            <tr>
                                <th>교육기간</th>
                                <td>
                                    <!--
                                        DB: SELECT edu_start, edu_end FROM courses WHERE id = ?
                                        관리자가 직접 입력 후 저장
                                    -->
                                    <input type="date" id="eduStart">
                                    ~
                                    <input type="date" id="eduEnd">
                                </td>
                                <th>수강인원 / 현황</th>
                                <td>
                                    <!--
                                        DB: SELECT max_students, current_students FROM courses WHERE id = ?
                                    -->
                                    <input type="text" id="maxStudents" style="width:70px;" placeholder="정원" value="50">
                                    명 &nbsp;/&nbsp; 현재
                                    <input type="text" id="currentStudents" style="width:50px;" value="23" readonly>
                                    명
                                </td>
                            </tr>
                        </table>
                    </div>

                </div><!-- /.detail-layout -->

            </div>
        </div>

        <!-- ===== 하단: 커리큘럼 + 학습목표/수료조건 ===== -->
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
                                <th style="width:70px;">시간</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr><td>1강</td><td class="left">행정법 개요 및 체계</td><td>25분</td></tr>
                            <tr><td>2강</td><td class="left">행정행위의 성립요건</td><td>30분</td></tr>
                            <tr><td>3강</td><td class="left">행정절차법 핵심 정리</td><td>28분</td></tr>
                            <tr><td>4강</td><td class="left">행정심판 및 행정소송</td><td>32분</td></tr>
                            <tr><td>5강</td><td class="left">국가배상과 손실보상</td><td>27분</td></tr>
                            <tr><td>6강</td><td class="left">행정법 실전 문제풀이</td><td>35분</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 오른쪽: 학습목표 + 수료조건 -->
            <div class="right-col">

                <div class="section-box" style="margin-bottom:10px;">
                    <div class="section-head">학습목표</div>
                    <div class="section-body">
                        <textarea id="learnGoal" class="full" rows="4"
                                  placeholder="학습목표를 입력하세요.">행정법의 기본 원리와 체계를 이해하고
공무원으로서 행정업무에 적용할 수 있는
실무 능력을 배양한다.</textarea>
                    </div>
                </div>

                <div class="section-box" style="margin-bottom:0;">
                    <div class="section-head">수료조건</div>
                    <div class="section-body">
                        <!--
                            DB: SELECT complete_condition FROM courses WHERE id = ?
                            관리자가 수정 가능
                        -->
                        <textarea id="completeCondition" class="full" rows="4"
                                  placeholder="수료조건을 입력하세요.">진도율 80% 이상 달성
시험 점수 60점 이상
과제 제출 완료</textarea>
                    </div>
                </div>

            </div><!-- /.right-col -->

        </div><!-- /.detail-bottom -->

        <!-- 하단 버튼 -->
        <div style="text-align:center; margin-top:16px; display:flex; gap:10px; justify-content:center;">
            <button class="btn" onclick="location.href='/admin/curriculum'">목록으로</button>
            <button class="btn btn-blue" onclick="saveCurriculum()">저장</button>
            <button class="btn btn-blue" onclick="publishToInlearning()">인러닝에 게시하기</button>
        </div>

    </div><!-- /.main -->
</div><!-- /.layout -->

<!-- <footer>
    <strong>대전광역시 인재개발원</strong> | eGov-School 관리자 페이지 &nbsp;|&nbsp; Copyright &copy; 2026
</footer> -->


</body>
</html>

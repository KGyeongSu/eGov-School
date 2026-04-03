<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin 공무원 대시보드 - 강사 피드백</title>
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
        <span class="hd-user">김진아 님의 대시보드</span>
        <button class="btn-logout" onclick="doLogout()">로그아웃</button>
    </div>
</header>

<!-- ===== 레이아웃 ===== -->
<div class="layout">

    <!-- 사이드바 -->
    <div class="sidebar">
        <div class="side-menu">
            <a href="/admin/main">공무원 선발 가산점</a>
            <a href="/admin/feedback" class="on">강사 피드백</a>
            <a href="/admin/cv">강사지원자 이력서 확인</a>
            <a href="/admin/curriculum">강좌 커리큘럼 확인</a>
        </div>
        <div class="side-bottom">
            <strong>김진아</strong>
            관리자
        </div>
    </div>

    <!-- 메인 -->
    <div class="main">
        <div class="page-title">강사 피드백</div>
        <div class="page-sub">eschool / dash / adm / fb</div>

        <!-- 탭 (ES-A04-005, 007) -->
        <div class="tab-bar" data-group="fb">
            <a href="#" class="on" onclick="showTab('tab-fb-list', this)">수강생 피드백 확인</a>
            <a href="#" onclick="showTab('tab-fb-general', this)">강사 피드백 종합</a>
        </div>

        <!-- ===== 탭1: 수강생 피드백 확인 (ES-A04-005, 006) ===== -->
        <div class="tab-content active" id="tab-fb-list" data-group="fb">
            <div class="cur-tab">수강생 피드백 확인</div>

            <div class="section-box">
                <div class="section-head">수강생 피드백 확인</div>
                <div class="section-body">

                    <!-- 검색/필터 (ES-A04-006) -->
                    <div class="search-bar">
                        <label>강사</label>
                        <select id="fbInstructor">
                            <option value="">전체</option>
                            <option value="김강사">김강사</option>
                            <option value="이강사">이강사</option>
                            <option value="박강사">박강사</option>
                        </select>
                        <label>점수</label>
                        <select id="fbScore">
                            <option value="">전체</option>
                            <option value="높음">높음 (4~5)</option>
                            <option value="낮음">낮음 (1~3)</option>
                        </select>
                        <input type="text" id="fbKeyword" placeholder="수강자명 검색">
                        <button class="btn btn-blue btn-sm" onclick="filterFeedback()">검색</button>
                        <button class="btn btn-sm" onclick="resetFeedback()">초기화</button>
                    </div>

                    <!-- 피드백 카드 그리드 -->
                    <!--
                        DB 연결 시:
                        SELECT f.id, s.name, i.name as instructor, c.course_name, f.score, f.comment
                        FROM feedback f
                        JOIN students s ON f.student_id = s.id
                        JOIN instructors i ON f.instructor_id = i.id
                        JOIN courses c ON f.course_id = c.id
                    -->
                    <div class="card-grid" id="fbGrid">
                        <div class="card-item" data-instructor="김강사" data-score="높음" data-name="홍길동"
                             onclick="openFbModal('홍길동','김강사','행정법 기초','강의가 매우 유익했습니다.',4.5)">
                            <div class="card-thumb">피드백 카드</div>
                            <div class="card-info">홍길동 | 행정법 기초<br>강사: 김강사 ★★★★☆ 4.5</div>
                        </div>
                        <div class="card-item" data-instructor="이강사" data-score="높음" data-name="이영희"
                             onclick="openFbModal('이영희','이강사','세무직 실무','설명이 명확하고 이해하기 쉬웠습니다.',5.0)">
                            <div class="card-thumb">피드백 카드</div>
                            <div class="card-info">이영희 | 세무직 실무<br>강사: 이강사 ★★★★★ 5.0</div>
                        </div>
                        <div class="card-item" data-instructor="김강사" data-score="낮음" data-name="박민수"
                             onclick="openFbModal('박민수','김강사','관세법 정리','조금 어려웠지만 도움이 됐습니다.',3.0)">
                            <div class="card-thumb">피드백 카드</div>
                            <div class="card-info">박민수 | 관세법 정리<br>강사: 김강사 ★★★☆☆ 3.0</div>
                        </div>
                        <div class="card-item" data-instructor="이강사" data-score="높음" data-name="김지은"
                             onclick="openFbModal('김지은','이강사','보건직 과정','실무에 바로 적용할 수 있었습니다.',4.0)">
                            <div class="card-thumb">피드백 카드</div>
                            <div class="card-info">김지은 | 보건직 과정<br>강사: 이강사 ★★★★☆ 4.0</div>
                        </div>
                        <div class="card-item" data-instructor="박강사" data-score="낮음" data-name="최영준"
                             onclick="openFbModal('최영준','박강사','디지털 행정','내용이 너무 어려웠습니다.',2.5)">
                            <div class="card-thumb">피드백 카드</div>
                            <div class="card-info">최영준 | 디지털 행정<br>강사: 박강사 ★★☆☆☆ 2.5</div>
                        </div>
                        <div class="card-item" data-instructor="이강사" data-score="높음" data-name="정수현"
                             onclick="openFbModal('정수현','이강사','세무직 실무','최고의 강의였습니다.',4.8)">
                            <div class="card-thumb">피드백 카드</div>
                            <div class="card-info">정수현 | 세무직 실무<br>강사: 이강사 ★★★★★ 4.8</div>
                        </div>
                    </div>
                </div>
            </div>
        </div><!-- /#tab-fb-list -->

        <!-- ===== 탭2: 강사 피드백 종합 (ES-A04-007, 008) ===== -->
        <div class="tab-content" id="tab-fb-general" data-group="fb">
            <div class="cur-tab">강사 피드백 종합</div>

            <div class="three-col">

                <!-- 사용자 평가 및 테스트 결과 (ES-A04-007) -->
                <div class="section-box" style="margin-bottom:0;">
                    <div class="section-head">사용자 평가 및 테스트 결과</div>
                    <div class="section-body">
                        <span class="stat-num">4.2</span>
                        <span class="stat-label">평균 평가 점수</span>
                        <br>
                        <!-- DB: SELECT course_name, AVG(score) FROM feedback GROUP BY course_id -->
                        <table class="board-table" style="margin-top:10px;">
                            <thead><tr><th>강좌</th><th>평점</th></tr></thead>
                            <tbody>
                                <tr><td class="left">행정법 기초</td><td>4.5</td></tr>
                                <tr><td class="left">세무직 실무</td><td>4.9</td></tr>
                                <tr><td class="left">관세법 정리</td><td>3.8</td></tr>
                                <tr><td class="left">보건직 과정</td><td>4.0</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- 강좌 사용자 수 -->
                <div class="section-box" style="margin-bottom:0;">
                    <div class="section-head">강좌 사용자 수</div>
                    <div class="section-body">
                        <span class="stat-num">1,248</span>
                        <span class="stat-label">전체 수강생</span>
                        <br>
                        <!-- DB: SELECT course_name, COUNT(*) FROM enrollments GROUP BY course_id -->
                        <table class="board-table" style="margin-top:10px;">
                            <thead><tr><th>강좌</th><th>수강생</th></tr></thead>
                            <tbody>
                                <tr><td class="left">행정법 기초</td><td>312명</td></tr>
                                <tr><td class="left">세무직 실무</td><td>280명</td></tr>
                                <tr><td class="left">관세법 정리</td><td>198명</td></tr>
                                <tr><td class="left">보건직 과정</td><td>180명</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- 사용자 만족도 및 수강평 -->
                <div class="section-box" style="margin-bottom:0;">
                    <div class="section-head">사용자 만족도 및 수강평</div>
                    <div class="section-body">
                        <!-- DB: SELECT category, AVG(score) FROM satisfaction GROUP BY category -->
                        <table class="board-table">
                            <thead><tr><th>항목</th><th>점수</th></tr></thead>
                            <tbody>
                                <tr><td class="left">강의 내용</td><td>4.5</td></tr>
                                <tr><td class="left">강의 구성</td><td>4.2</td></tr>
                                <tr><td class="left">강사 전달력</td><td>4.8</td></tr>
                                <tr><td class="left">실무 활용도</td><td>4.0</td></tr>
                                <tr><td class="left">전반적 만족</td><td>4.3</td></tr>
                            </tbody>
                        </table>
                        <!-- 알림 전송 버튼 (ES-A04-008) -->
                        <div style="text-align:right; margin-top:10px;">
                            <button class="btn btn-blue btn-sm" onclick="openModal('modal-send')">
                                강좌 피드백 알림 전송
                            </button>
                        </div>
                    </div>
                </div>

            </div><!-- /.three-col -->
        </div><!-- /#tab-fb-general -->

    </div><!-- /.main -->
</div><!-- /.layout -->

<footer>
    <strong>대전광역시 인재개발원</strong> | eGov-School 관리자 페이지 &nbsp;|&nbsp; Copyright &copy; 2026
</footer>

<!-- ===== 모달: 수강생 피드백 상세 (ES-A04-006) ===== -->
<div class="modal-overlay" id="modal-fb">
    <div class="modal-box">
        <div class="modal-head">
            수강생 피드백 상세
            <div class="modal-btns">
                <button class="mbtn-cancel" onclick="closeModal('modal-fb')">닫기</button>
            </div>
        </div>
        <div class="modal-body">
            <div class="form-row">
                <label>수강생 / 강사 / 강좌</label>
                <div class="preview-area" id="fb-info"></div>
            </div>
            <div class="form-row">
                <label>피드백 내용</label>
                <div class="preview-area" id="fb-content"></div>
            </div>
            <div class="form-row">
                <label>평점</label>
                <div class="preview-area" id="fb-score"></div>
            </div>
        </div>
    </div>
</div>

<!-- ===== 모달: 강좌 피드백 알림 전송 (ES-A04-008) ===== -->
<div class="modal-overlay" id="modal-send">
    <div class="modal-box">
        <div class="modal-head">
            강좌 피드백 알림 전송
            <div class="modal-btns">
                <button class="mbtn-ok" onclick="doSend()">전송</button>
                <button class="mbtn-cancel" onclick="closeModal('modal-send')">취소</button>
            </div>
        </div>
        <div class="modal-body">
            <!-- DB: SELECT course_name FROM courses / SELECT AVG(score) FROM feedback WHERE course_id=? -->
            <div class="form-row">
                <label>강좌명</label>
                <select id="send-course" class="full">
                    <option>공무원 행정법 기초</option>
                    <option>세무직 실무 완성</option>
                    <option>관세법 핵심 정리</option>
                    <option>보건직 전문 과정</option>
                </select>
            </div>
            <div class="form-row">
                <label>사용자 피드백 (만족도 및 수강평)</label>
                <div class="preview-area">만족도: ★★★★☆ 4.2 &nbsp;|&nbsp; 수강평: 강의가 유익합니다.</div>
            </div>
            <div class="form-row">
                <label>강좌 이용자 수</label>
                <div class="preview-area">수강생 312명</div>
            </div>
        </div>
    </div>
</div>


<script>
    /* 피드백 모달 열기 */
    function openFbModal(student, instructor, course, comment, score) {
        document.getElementById('fb-info').textContent =
            '수강생: ' + student + '  |  강사: ' + instructor + '  |  강좌: ' + course;
        document.getElementById('fb-content').textContent = comment;
        document.getElementById('fb-score').textContent   = '평점: ' + score + '점';
        openModal('modal-fb');
    }

    /* 피드백 필터 */
    function filterFeedback() {
        var instructor = document.getElementById('fbInstructor').value;
        var score      = document.getElementById('fbScore').value;
        var keyword    = document.getElementById('fbKeyword').value.trim();
        var cards      = document.querySelectorAll('#fbGrid .card-item');

        for (var i = 0; i < cards.length; i++) {
            var c = cards[i];
            var ok = true;
            if (instructor && c.getAttribute('data-instructor') !== instructor) ok = false;
            if (score      && c.getAttribute('data-score')      !== score)      ok = false;
            if (keyword    && c.getAttribute('data-name').indexOf(keyword) === -1) ok = false;
            c.style.display = ok ? '' : 'none';
        }
    }

    function resetFeedback() {
        document.getElementById('fbInstructor').value = '';
        document.getElementById('fbScore').value      = '';
        document.getElementById('fbKeyword').value    = '';
        var cards = document.querySelectorAll('#fbGrid .card-item');
        for (var i = 0; i < cards.length; i++) { cards[i].style.display = ''; }
    }

    /* 피드백 알림 전송 */
    function doSend() {
        /* 실제 서비스: fetch('/api/feedback/send', {method:'POST', body: ...}) */
        alert('피드백 알림이 강사에게 전송되었습니다.');
        closeModal('modal-send');
    }
</script>
</body>
</html>
    
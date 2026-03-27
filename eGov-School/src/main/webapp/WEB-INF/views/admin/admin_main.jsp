<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin 공무원 대시보드 - 공무원 선발 가산점</title>
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
        <button class="btn-logout">로그아웃</button>
    </div>
</header>

<!-- ===== 전체 레이아웃 ===== -->
<div class="layout">

    <!-- 사이드바 -->
    <div class="sidebar">
        <div class="side-menu">
            <a href="/admin/main" class="on">공무원 선발 가산점</a>
            <a href="/admin/feedback">강사 피드백</a>
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
        <div class="page-title">공무원 선발 가산점</div>

        <!-- 탭 (ES-A04-001~004) -->
        <div class="tab-bar" data-group="main">
            <a href="#" class="on" onclick="showTab('tab-gen', this)">가산점 기준 생성</a>
            <a href="#" onclick="showTab('tab-list', this)">가산점 기준 리스트 확인</a>
            <a href="#" onclick="showTab('tab-check', this)">수강생 별 가산점 현황 조회</a>
        </div>

        <!-- ===== 탭1: 가산점 기준 생성 (ES-A04-001, 002) ===== -->
        <div class="tab-content active" id="tab-gen" data-group="main">
            <div class="cur-tab">가산점 기준 생성</div>

            <!-- 강좌 카드 그리드 -->
            <div class="section-box">
                <div class="section-head">
                    가산점 기준 생성
                    <button class="btn btn-sm" style="color:#fff; border-color:#4a8fac; background:none;"
                            onclick="deleteSelected('courseGrid')">삭제</button>
                </div>
                <div class="section-body">
                    <!--
                        DB 연결 시:
                        while($row = $stmt->fetch()) {
                            echo '<div class="card-item" ...>' . $row['course_name'] . '</div>';
                        }
                    -->
                    <div class="card-grid" id="courseGrid">
                        <div class="card-item" onclick="openGenModal('공무원 행정법 기초', 1)">
                            <div class="card-thumb">썸네일</div>
                            <div class="card-info">행정직 | 수강 | 15강<br>공무원 행정법 기초</div>
                        </div>
                        <div class="card-item" onclick="openGenModal('세무직 실무 완성', 2)">
                            <div class="card-thumb">썸네일</div>
                            <div class="card-info">세무직 | 수강 | 20강<br>세무직 실무 완성</div>
                        </div>
                        <div class="card-item" onclick="openGenModal('관세법 핵심 정리', 3)">
                            <div class="card-thumb">썸네일</div>
                            <div class="card-info">관세직 | 수강 | 18강<br>관세법 핵심 정리</div>
                        </div>
                        <div class="card-item" onclick="openGenModal('보건직 전문 과정', 4)">
                            <div class="card-thumb">
                                <img src="/images/2.jpg" alt="보건직썸네일"></div>
                            <div class="card-info">보건직 | 수강 | 12강<br>보건직 전문 과정</div>
                        </div>
                        <div class="card-item" onclick="openGenModal('디지털 행정 기초', 5)">
                            <div class="card-thumb">
                                <img src="/images/1.jpg" alt="강좌썸네일"></div>
                            <div class="card-info">공통 | 수강 | 10강<br>디지털 행정 기초</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 2단: 리스트 미리보기 + 수강생별 현황 미리보기 -->
            <div class="two-col">
                <div class="section-box" style="margin-bottom:0;">
                    <div class="section-head">
                        가산점 기준 리스트 확인
                        <button class="btn btn-sm" style="color:#fff;border-color:#4a8fac;background:none;"
                                onclick="showTab('tab-list', document.querySelectorAll('.tab-bar a')[1])">더보기</button>
                    </div>
                    <div class="section-body">
                        <table class="board-table">
                            <thead>
                                <tr>
                                    <th>강좌명</th>
                                    <th style="width:80px;">가산점</th>
                                    <th style="width:60px;">비고</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- DB: SELECT course_name, score, note FROM bonus_criteria -->
                                <tr><td class="left">공무원 행정법 기초</td><td>5점</td><td>-</td></tr>
                                <tr><td class="left">세무직 실무 완성</td><td>8점</td><td>필수</td></tr>
                                <tr><td class="left">관세법 핵심 정리</td><td>6점</td><td>-</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="section-box" style="margin-bottom:0;">
                    <div class="section-head">
                        수강생 별 가산점 현황 조회
                        <button class="btn btn-sm" onclick="showTab('tab-check', document.querySelectorAll('.tab-bar a')[2])">더보기</button>
                    </div>
                    <div class="section-body">
                        <table class="board-table">
                            <thead>
                                <tr>
                                    <th style="width:80px;">성명</th>
                                    <th>수강강좌</th>
                                    <th style="width:70px;">가산점</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- DB: SELECT s.name, c.course_name, b.score FROM students s ... -->
                                <tr><td>홍길동</td><td class="left">행정법 기초</td><td>5점</td></tr>
                                <tr><td>이영희</td><td class="left">세무직 실무</td><td>8점</td></tr>
                                <tr><td>박민수</td><td class="left">관세법 정리</td><td>6점</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div><!-- /#tab-gen -->

        <!-- ===== 탭2: 가산점 기준 리스트 확인 (ES-A04-003) ===== -->
        <div class="tab-content" id="tab-list" data-group="main">
            <div class="cur-tab">가산점 기준 리스트 확인</div>
            <div class="section-box">
                <div class="section-head">
                    가산점 기준 리스트 확인
                    <button class="btn btn-sm" style="color:#fff;border-color:#4a8fac;background:none;"
                            onclick="deleteSelected('listBody')">🗑 삭제</button>
                </div>
                <div class="section-body">
                    <table class="board-table">
                        <thead>
                            <tr>
                                <th style="width:40px;"><input type="checkbox" onclick="toggleAll(this,'listBody')"></th>
                                <th>강좌명</th>
                                <th style="width:200px;">가산점 상세내용</th>
                                <th style="width:70px;">비고</th>
                            </tr>
                        </thead>
                        <tbody id="listBody">
                            <!-- DB: SELECT id, course_name, detail, note FROM bonus_criteria -->
                            <tr onclick="openDetailModal('공무원 행정법 기초', '수강 완료 시 5점 부여. 행정직 응시자 대상.')">
                                <td onclick="event.stopPropagation()"><input type="checkbox"></td>
                                <td class="left">공무원 행정법 기초</td>
                                <td>수강 완료 시 5점</td>
                                <td>-</td>
                            </tr>
                            <tr onclick="openDetailModal('세무직 실무 완성', '수강 완료 시 8점 부여. 세무직 필수 과정.')">
                                <td onclick="event.stopPropagation()"><input type="checkbox"></td>
                                <td class="left">세무직 실무 완성</td>
                                <td>수강 완료 시 8점</td>
                                <td>필수</td>
                            </tr>
                            <tr onclick="openDetailModal('관세법 핵심 정리', '수강 완료 시 6점 부여. 관세직 응시자 대상.')">
                                <td onclick="event.stopPropagation()"><input type="checkbox"></td>
                                <td class="left">관세법 핵심 정리</td>
                                <td>수강 완료 시 6점</td>
                                <td>-</td>
                            </tr>
                            <tr onclick="openDetailModal('보건직 전문 과정', '수강 완료 시 7점 부여.')">
                                <td onclick="event.stopPropagation()"><input type="checkbox"></td>
                                <td class="left">보건직 전문 과정</td>
                                <td>수강 완료 시 7점</td>
                                <td>-</td>
                            </tr>
                            <tr onclick="openDetailModal('디지털 행정 기초', '수강 완료 시 3점 부여. 전직종 공통.')">
                                <td onclick="event.stopPropagation()"><input type="checkbox"></td>
                                <td class="left">디지털 행정 기초</td>
                                <td>수강 완료 시 3점</td>
                                <td>공통</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div><!-- /#tab-list -->

        <!-- ===== 탭3: 수강생 별 가산점 현황 조회 (ES-A04-004) ===== -->
        <div class="tab-content" id="tab-check" data-group="main">
            <div class="cur-tab">수강생 별 가산점 현황 조회</div>
            <div class="section-box">
                <div class="section-head">
                    수강생 별 가산점 현황 조회
                    <button class="btn btn-sm btn-blue" onclick="exportExcel()">엑셀 다운</button>
                </div>
                <div class="section-body">
                    <div class="search-bar">
                        <label>가산점 취득 여부</label>
                        <select id="checkFilter">
                            <option value="">전체</option>
                            <option value="취득">취득</option>
                            <option value="미취득">미취득</option>
                        </select>
                        <button class="btn btn-blue btn-sm" onclick="filterCheck()">검색</button>
                        <button class="btn btn-sm" onclick="resetFilter(['checkFilter'], 'checkBody')">초기화</button>
                    </div>
                    <table class="board-table">
                        <thead>
                            <tr>
                                <th style="width:90px;">성명</th>
                                <th>수강 강좌명</th>
                                <th style="width:120px;">가산점 획득 여부</th>
                            </tr>
                        </thead>
                        <tbody id="checkBody">
                            <!-- DB: SELECT s.name, c.course_name, IF(b.score>0,'취득','미취득') ... -->
                            <tr data-status="취득">
                                <td>홍길동</td>
                                <td class="left">공무원 행정법 기초 / 세무직 실무 완성</td>
                                <td><span class="badge badge-on">취득</span></td>
                            </tr>
                            <tr data-status="취득">
                                <td>이영희</td>
                                <td class="left">관세법 핵심 정리</td>
                                <td><span class="badge badge-on">취득</span></td>
                            </tr>
                            <tr data-status="미취득">
                                <td>박민수</td>
                                <td class="left">보건직 전문 과정 (수강중)</td>
                                <td><span class="badge badge-end">미취득</span></td>
                            </tr>
                            <tr data-status="미취득">
                                <td>김지은</td>
                                <td class="left">디지털 행정 기초 (수강중)</td>
                                <td><span class="badge badge-end">미취득</span></td>
                            </tr>
                            <tr data-status="취득">
                                <td>최영준</td>
                                <td class="left">세무직 실무 완성 / 디지털 행정 기초</td>
                                <td><span class="badge badge-on">취득</span></td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="paging">
                        <a href="#">&lt;</a>
                        <span class="on">1</span>
                        <a href="#">2</a>
                        <a href="#">&gt;</a>
                    </div>
                </div>
            </div>
        </div><!-- /#tab-check -->

    </div><!-- /.main -->
</div><!-- /.layout -->

<footer>
    <strong>대전광역시 인재개발원</strong> | eGov-School 관리자 페이지 &nbsp;|&nbsp; Copyright &copy; 2026
</footer>

<!-- ===== 모달: 가산점 기준 생성 ===== -->
<div class="modal-overlay" id="modal-gen">
    <div class="modal-box">
        <div class="modal-head">
            가산점 기준 생성
            <div class="modal-btns">
                <button class="mbtn-ok" onclick="saveGen()">저장</button>
                <button class="mbtn-cancel" onclick="closeModal('modal-gen')">취소</button>
            </div>
        </div>
        <div class="modal-body">
            <!-- DB: INSERT INTO bonus_criteria (course_id, detail, note) VALUES (?, ?, ?) -->
            <input type="hidden" id="gen-course-id">
            <div class="form-row">
                <label>강좌명</label>
                <input type="text" id="gen-course" class="full" readonly>
            </div>
            <div class="form-row">
                <label>가산점 상세내용</label>
                <textarea id="gen-detail" class="full" rows="4"
                          placeholder="가산점 부여 조건 및 상세 내용을 입력하세요."></textarea>
            </div>
            <div class="form-row">
                <label>비고</label>
                <input type="text" id="gen-note" class="full" placeholder="비고 입력 (선택)">
            </div>
        </div>
    </div>
</div>

<!-- ===== 모달: 가산점 기준 상세 (ES-A04-003) ===== -->
<div class="modal-overlay" id="modal-detail">
    <div class="modal-box">
        <div class="modal-head">
            가산점 기준 상세
            <div class="modal-btns">
                <button class="mbtn-cancel" onclick="closeModal('modal-detail')">닫기</button>
            </div>
        </div>
        <div class="modal-body">
            <div class="form-row">
                <label>강좌명</label>
                <input type="text" id="detail-course" class="full" readonly>
            </div>
            <div class="form-row">
                <label>가산점 상세내용</label>
                <div class="preview-area" id="detail-content"></div>
            </div>
        </div>
    </div>
</div>


<script>
    /* 이 페이지 전용 함수 */

    /* 가산점 기준 생성 모달 열기 */
    function openGenModal(courseName, courseId) {
        document.getElementById('gen-course').value    = courseName;
        document.getElementById('gen-course-id').value = courseId;
        document.getElementById('gen-detail').value   = '';
        document.getElementById('gen-note').value     = '';
        openModal('modal-gen');
    }

    /* 저장 (DB: INSERT) */
    function saveGen() {
        var detail = document.getElementById('gen-detail').value.trim();
        if (!detail) { alert('가산점 상세내용을 입력하세요.'); return; }
        /* 실제 서비스: fetch('/api/bonus', {method:'POST', body: formData}) */
        alert('저장되었습니다.');
        closeModal('modal-gen');
    }

    /* 리스트 상세 모달 열기 */
    function openDetailModal(course, content) {
        document.getElementById('detail-course').value       = course;
        document.getElementById('detail-content').textContent = content;
        openModal('modal-detail');
    }

    /* 수강생 별 가산점 필터 */
    function filterCheck() {
        var val  = document.getElementById('checkFilter').value;
        var rows = document.querySelectorAll('#checkBody tr');
        for (var i = 0; i < rows.length; i++) {
            var st = rows[i].getAttribute('data-status') || '';
            rows[i].style.display = (!val || st === val) ? '' : 'none';
        }
    }
</script>
</body>
</html>
    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin 공무원 대시보드 - 강사지원자 이력서 확인</title>
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
        <button class="btn-logout" onclick="doLogout()">로그아웃</button>
    </div>
</header>

<!-- ===== 레이아웃 ===== -->
<div class="layout">

    <!-- 사이드바 -->
    <div class="sidebar">
        <div class="side-menu">
            <a href="/admin/main">공무원 선발 가산점</a>
            <a href="/admin/feedback">강사 피드백</a>
            <a href="/admin/cv" class="on">강사지원자 이력서 확인</a>
            <a href="/admin/curriculum">강좌 커리큘럼 확인</a>
        </div>
        <div class="side-bottom">
            <strong>${adminName}</strong>
            관리자
        </div>
    </div>

    <!-- 메인 -->
    <div class="main">
        <div class="page-title">강사 지원자 이력서 확인</div>
        <div class="page-sub">eschool / dash / adm / cv</div>

        <div class="section-box">
            <div class="section-head">강사 지원자 이력서 확인</div>
            <div class="section-body">

                <div class="search-bar">
                    <label>지원직무</label>
                    <select id="cvJobFilter">
                        <option value="">전체</option>
                        <option value="관세직">관세직</option>
                        <option value="세무직">세무직</option>
                        <option value="보건직">보건직</option>
                        <option value="행정직">행정직</option>
                        <option value="기술직">기술직</option>
                        <option value="농촌지도사">농촌지도사</option>
                    </select>
                    <label>검토 상태</label>
                    <select id="cvStatusFilter">
                        <option value="">전체</option>
                        <option value="검토중">검토중</option>
                        <option value="대기">대기</option>
                        <option value="합격">합격</option>
                        <option value="불합격">불합격</option>
                    </select>
                    <input type="text" id="cvKeyword" placeholder="성명, 경력 검색">
                    <button class="btn btn-blue btn-sm" onclick="filterCV()">검색</button>
                    <button class="btn btn-sm" onclick="resetCV()">초기화</button>
                    <button class="btn btn-blue btn-sm" style="margin-left:auto;" onclick="exportExcel()">엑셀 다운</button>
                </div>

                <!-- 지원자 테이블 -->
                <table class="board-table">
                    <thead>
                        <tr>
                            <th style="width:80px;">접수번호</th>
                            <th style="width:80px;">성명</th>
                            <th style="width:120px;">연락처</th>
                            <th style="width:80px;">지원직무</th>
                            <th>경력 요약</th>
                            <th style="width:80px;">상태</th>
                            <th style="width:80px;">이력서</th>
                        </tr>
                    </thead>
                    <tbody id="cvBody">
                        <tr data-job="관세직" data-status="검토중">
                            <td>d247</td>
                            <td>홍길동</td>
                            <td>010-1234-5678</td>
                            <td>관세직</td>
                            <td class="left">관세청 근무 5년, 관세사 자격 보유</td>
                            <td><span class="badge badge-on">검토중</span></td>
                            <td><button class="btn btn-sm" onclick="openCVModal('홍길동','관세직','d247','관세청 근무 5년, 관세사 자격 보유')">보기</button></td>
                        </tr>
                        <tr data-job="세무직" data-status="검토중">
                            <td>t083</td>
                            <td>이영희</td>
                            <td>010-2345-6789</td>
                            <td>세무직</td>
                            <td class="left">세무서 근무 3년, 세무사 시험 합격</td>
                            <td><span class="badge badge-on">검토중</span></td>
                            <td><button class="btn btn-sm" onclick="openCVModal('이영희','세무직','t083','세무서 근무 3년, 세무사 시험 합격')">보기</button></td>
                        </tr>
                        <tr data-job="보건직" data-status="대기">
                            <td>h512</td>
                            <td>박민수</td>
                            <td>010-3456-7890</td>
                            <td>보건직</td>
                            <td class="left">보건소 근무 7년, 간호사 면허 보유</td>
                            <td><span class="badge">대기</span></td>
                            <td><button class="btn btn-sm" onclick="openCVModal('박민수','보건직','h512','보건소 근무 7년, 간호사 면허 보유')">보기</button></td>
                        </tr>
                        <tr data-job="행정직" data-status="합격">
                            <td>a391</td>
                            <td>김지은</td>
                            <td>010-4567-8901</td>
                            <td>행정직</td>
                            <td class="left">지방자치단체 근무 4년</td>
                            <td><span class="badge badge-end">합격</span></td>
                            <td><button class="btn btn-sm" onclick="openCVModal('김지은','행정직','a391','지방자치단체 근무 4년')">보기</button></td>
                        </tr>
                        <tr data-job="기술직" data-status="불합격">
                            <td>e704</td>
                            <td>최영준</td>
                            <td>010-5678-9012</td>
                            <td>기술직</td>
                            <td class="left">기술직 공무원 10년, 기사 자격 다수 보유</td>
                            <td><span class="badge badge-red">불합격</span></td>
                            <td><button class="btn btn-sm" onclick="openCVModal('최영준','기술직','e704','기술직 공무원 10년, 기사 자격 다수 보유')">보기</button></td>
                        </tr>
                        <tr data-job="농촌지도사" data-status="대기">
                            <td>r156</td>
                            <td>정수현</td>
                            <td>010-6789-0123</td>
                            <td>농촌지도사</td>
                            <td class="left">농업기술센터 근무 6년</td>
                            <td><span class="badge">대기</span></td>
                            <td><button class="btn btn-sm" onclick="openCVModal('정수현','농촌지도사','r156','농업기술센터 근무 6년')">보기</button></td>
                        </tr>
                    </tbody>
                </table>

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
</div><!-- /.layout -->

<!-- ===== 모달: 이력서 상세 ===== -->
<div class="modal-overlay" id="modal-cv">
    <div class="modal-box" style="width:520px;">
        <div class="modal-head">
            강사 지원자 이력서
            <div class="modal-btns">
                <button class="mbtn-ok" onclick="updateStatus('합격')">합격</button>
                <button class="btn btn-sm btn-gray" style="padding:3px 12px; font-size:12px;"
                        onclick="updateStatus('불합격')">불합격</button>
                <button class="mbtn-cancel" onclick="closeModal('modal-cv')">닫기</button>
            </div>
        </div>
        <div class="modal-body">
            <!-- DB: SELECT * FROM applications WHERE id=? -->
            <div class="form-row">
                <label>접수번호</label>
                <input type="text" id="cv-receipt" class="full" readonly>
            </div>
            <div class="form-row">
                <label>성명 / 지원직무</label>
                <div class="preview-area" id="cv-info"></div>
            </div>
            <div class="form-row">
                <label>경력사항</label>
                <div class="preview-area" id="cv-career"></div>
            </div>
            <div class="form-row">
                <label>내부 검토 메모</label>
                <!-- DB: UPDATE applications SET memo=? WHERE id=? -->
                <textarea id="cv-memo" class="full" rows="3" placeholder="내부 검토 메모 입력"></textarea>
            </div>
            <div style="text-align:right; margin-top:8px;">
                <button class="btn btn-blue btn-sm" onclick="saveMemo()">메모 저장</button>
            </div>
        </div>
    </div>
</div>


<script>
    /* 이력서 모달 열기 */
    function openCVModal(name, job, receipt, career) {
        document.getElementById('cv-receipt').value          = receipt;
        document.getElementById('cv-info').textContent      = '성명: ' + name + '  |  지원직무: ' + job;
        document.getElementById('cv-career').textContent    = career;
        document.getElementById('cv-memo').value            = '';
        openModal('modal-cv');
    }

    /* 합격/불합격 처리 */
    function updateStatus(status) {
        var receipt = document.getElementById('cv-receipt').value;
        /* 실제 서비스: fetch('/api/cv/status', {method:'POST', body: JSON.stringify({id: receipt, status: status})}) */
        if (confirm('[' + receipt + '] 지원자를 ' + status + ' 처리하시겠습니까?')) {
            alert(status + ' 처리되었습니다.');
            closeModal('modal-cv');
        }
    }

    /* 메모 저장 */
    function saveMemo() {
        var memo = document.getElementById('cv-memo').value.trim();
        if (!memo) { alert('메모를 입력하세요.'); return; }
        /* 실제 서비스: fetch('/api/cv/memo', {method:'POST', ...}) */
        alert('메모가 저장되었습니다.');
    }

    /* 필터링 */
    function filterCV() {
        var job     = document.getElementById('cvJobFilter').value;
        var status  = document.getElementById('cvStatusFilter').value;
        var keyword = document.getElementById('cvKeyword').value.trim();
        var rows    = document.querySelectorAll('#cvBody tr');

        for (var i = 0; i < rows.length; i++) {
            var r      = rows[i];
            var rowJob = r.getAttribute('data-job')    || '';
            var rowSt  = r.getAttribute('data-status') || '';
            var text   = r.textContent;
            var ok     = true;

            if (job     && rowJob.indexOf(job)     === -1) ok = false;
            if (status  && rowSt.indexOf(status)   === -1) ok = false;
            if (keyword && text.indexOf(keyword)   === -1) ok = false;

            r.style.display = ok ? '' : 'none';
        }
    }

    function resetCV() {
        document.getElementById('cvJobFilter').value    = '';
        document.getElementById('cvStatusFilter').value = '';
        document.getElementById('cvKeyword').value      = '';
        var rows = document.querySelectorAll('#cvBody tr');
        for (var i = 0; i < rows.length; i++) { rows[i].style.display = ''; }
    }
</script>
</body>
</html>

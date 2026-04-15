<<<<<<< HEAD
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
    
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link type="text/css" rel="stylesheet"
      href="../../../resources/css/admin/admin.css" />

<title>inlearning_admin_main</title>

</head>

<body>

<%@ include file="../modules/adminHeader.jsp"%>


<div class="content">

    <div class="top">
        <div class="icon">
            <a href=""><i class="fa-regular fa-user"></i></a>
        </div>
        <div class="state_bar">
            <p>${adminName}님의 메인 대시보드</p>
        </div>
        <div class="logout_dash">
            <div class="mes">
                <a href=""><i class="fa-regular fa-envelope"></i></a>
            </div>
            <div class="out">
                <button type="button" class="btn btn-sm"
                    style="background-color: #1a6d91; color: white; border-radius: 4px; font-size: 12px;">로그아웃
                </button>
            </div>
        </div>
    </div>

    <div class="mid admin-wrap" style="padding: 30px 40px;">

        <div class="page-title">공무원 선발 가산점</div>

        <div class="tab-bar" data-group="main">
            <a href="#" class="on" onclick="showTab('tab-gen', this)">가산점 기준 생성</a>
            <a href="#" onclick="search_list(1, 0);showTab('tab-list', this)">가산점 기준 리스트 확인</a>
            <a href="#" onclick="search_list(1, 1);showTab('tab-check', this)">수강생 별 가산점 현황 조회</a>
        </div>

        <div class="tab-content active" id="tab-gen" data-group="main">
            <div class="section-box">
                <div class="section-head">
                    가산점 기준 생성
                    <button class="btn btn-sm" style="color:#fff; border-color:#4a8fac; background:none;"
                            onclick="openRegModal()">등록</button>
                </div>
                <div class="section-body">
                    <div class="card-grid" id="courseGrid">
                        <div class="card-item" onclick="openRegModal()">
                            <div class="card-thumb">
                                <img src="../../../resources/images/default.jpg" alt="">
                            </div>
                            <div class="card-info"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="two-col">
				<div class="section-box" style="margin-bottom:0;">
					<div class="section-head">
					    가산점 기준 리스트 확인
					    <button class="btn btn-sm" style="color:#fff;border-color:#4a8fac;background:none;"
					       onclick="search_list(1, 0);showTab('tab-list', document.querySelectorAll('.tab-bar a')[1])">더보기</button>
					</div>
					<div class="section-body">
						<table class="board-table">
							<thead>
								<tr>
									<th>강좌명</th>
									<th style="width: 80px;">가산점</th>
								</tr>
							</thead>
							<tbody>
								<!-- DB: SELECT course_name, score, note FROM bonus_criteria -->
							<c:forEach items="${bsbVOs}" var="vo" begin="0" end="4">
							<tr>
								<td class="left">${vo.bcContent }</td>
							<td>${vo.bcScore }</td>
							</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
	
				<div class="section-box" style="margin-bottom: 0;">
					<div class="section-head">
						수강생 별 가산점 현황 조회
						<button class="btn btn-sm" style="color:#fff;border-color:#4a8fac;background:none;"
							onclick="search_list(1, 1);showTab('tab-check', document.querySelectorAll('.tab-bar a')[2])">더보기</button>
					</div>
					<div class="section-body">
						<table class="board-table">
							<thead>
								<tr>
									<th style="width: 80px;">성명</th>
									<th>수강강좌</th>
									<th style="width: 70px;">가산점</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${bstVOs}" var="vo" begin="0" end="4">
								<tr>
									<td class="left">${vo.userName }</td>
									<td>${vo.subjectName }</td>
									<td>${vo.bcScore }</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	    	
        
        <div class="tab-content" id="tab-list" data-group="main">
            <div class="section-box">
                <div class="section-head">
                    가산점 기준 리스트 확인
                    <button class="btn btn-sm" style="color:#fff;border-color:#4a8fac;background:none;"
                            onclick="deleteSelected('listBody')">삭제</button>
                </div>
                <div class="section-body" id="userAreaList0">
                    <table class="board-table">
                        <thead>
                            <tr>
                                <th style="width:40px;"><input type="checkbox" onclick="toggleAll(this,'listBody')"></th>
                                <th>강좌명</th>
                                <th style="width:200px;">가산점 상세내용</th>
                            </tr>
                        </thead>
                        <tbody id="listBody">
                            <c:forEach items="${bsbVOs}" var="vo">
							<!-- <tr onclick="openDetailModal('공무원 행정법 기초', '수강 완료 시 5점 부여. 행정직 응시자 대상.')"> -->
							<tr>
							    <td onclick="event.stopPropagation()"><input type="checkbox"></td>
								<td class="left">${vo.bcContent }</td>
								<td>${vo.bcScore }</td>
							</tr>
							</c:forEach>
                        </tbody>
                    </table>
                    <div class="pagination_wrapper">
                    	<nav aria-label="Navigation" style="margin-top: 40px;">
							<ul class="pagination justify-content-center m-0">
								<li class="page-item">
									<a class="page-link" href="javascript:search_list(1, 0);"> 
										<i class="fas fa-angle-double-left"></i>
									</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="javascript:search_list(${pageMaker.page > 1 ? pageMaker.page - 1 : 1 }, 0);">
										<i class="fas fa-angle-left"></i>
									</a>
								</li>
								
							<c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
								<li class="page-item ${pageMaker.page == pageNum ? 'active' : ''}">
									<a class="page-link" href="javascript:search_list(${pageNum}, 0);">
										${pageNum}
									</a>
								</li>
							</c:forEach>
						
								<li class="page-item">
									<a class="page-link" href="javascript:search_list(${pageMaker.page < pageMaker.realEndPage ? pageMaker.page + 1 : pageMaker.realEndPage }, 0);">
										<i class="fas fa-angle-right"></i>
									</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="javascript:search_list(${pageMaker.realEndPage}, 0);">
										<i class="fas fa-angle-double-right"></i>
									</a>
								</li>
							</ul>
						</nav>
						
						<form id="jobForm0" style="display: none;">
							<input type='text' name="num" value="0" />
							<input type='text' name="page" value="1" /> 
							<input type='text' name="perPageNum" value="" /> 
							<input type='text' name="searchType" value="" /> 
							<input type='text' name="keyword" value="" />
							<c:choose>
						        <%-- 1. 객체에 값이 있는 경우 우선순위 --%>
						        <c:when test="${not empty roomDetail.claNum}">
						            <input type='hidden' name="claNum" value="${roomDetail.claNum}" /> 
						        </c:when>
						        <%-- 2. 객체는 없지만 URL 파라미터에 있는 경우 --%>
						        <c:when test="${not empty param.claNum}">
						            <input type='hidden' name="claNum" value="${param.claNum}" />				            
						        </c:when>
						    </c:choose>
						</form>
                    </div>
                </div>
            </div>
        </div>

        <div class="tab-content" id="tab-check" data-group="main">
            <div class="section-box">
                <div class="section-head">
                    수강생 별 가산점 현황 조회
<!--                    <button class="btn btn-sm btn-blue" style="color:#fff;border-color:#4a8fac;background:none;" onclick="exportExcel()">엑셀 다운</button>  -->
                </div>
                <div class="section-body" id="userAreaList1">
<!--                     <div class="search-bar">
                        <label>가산점 취득 여부</label>
                        <select id="checkFilter">
                            <option value="">전체</option>
                            <option value="취득">취득</option>
                            <option value="미취득">미취득</option>
                        </select>
                        <button class="btn btn-blue btn-sm" onclick="filterCheck()">검색</button>
                        <button class="btn btn-sm" onclick="resetFilter(['checkFilter'], 'checkBody')">초기화</button>
                    </div> -->
                    <table class="board-table">
                        <thead>
                            <tr>
                                <th style="width:90px;">성명</th>
                                <th>수강 강좌명</th>
                                <th style="width:120px;">가산점 획득 여부</th>
                                <th style="width: 70px;">가산점</th>
                            </tr>
                        </thead>
                        <tbody id="checkBody">
							<c:forEach items="${bstVOs}" var="vo">
							<c:choose>
			                <%-- vo.passed 값이 'Y'인 경우 --%>
			                <c:when test="${vo.passed eq 'Y'}">
			                    <tr data-status="취득">
			                        <td>${vo.userName}</td>
			                        <td class="left">${vo.subjectName}</td>
			                        <td><span class="badge badge-on">취득</span></td>
			                        <td>${vo.bcScore}</td>
			                    </tr>
			                </c:when>
			                <%-- vo.passed 값이 'N'인 경우 (그 외의 경우) --%>
			                <c:otherwise>
			                    <tr data-status="미취득">
			                        <td>${vo.userName}</td>
			                        <td class="left">${vo.subjectName} (수강중)</td>
			                        <td><span class="badge badge-on">미취득</span></td>
			                        <td></td>
			                    </tr>
			                </c:otherwise>
				            </c:choose>
							</c:forEach>
                        </tbody>
                    </table>
                    <div class="pagination_wrapper">
                    	<nav aria-label="Navigation" style="margin-top: 40px;">
							<ul class="pagination justify-content-center m-0">
								<li class="page-item">
									<a class="page-link" href="javascript:search_list(1, 1);"> 
										<i class="fas fa-angle-double-left"></i>
									</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="javascript:search_list(${pageMaker.page > 1 ? pageMaker.page - 1 : 1 }, 1);">
										<i class="fas fa-angle-left"></i>
									</a>
								</li>
								
							<c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
								<li class="page-item ${pageMaker.page == pageNum ? 'active' : ''}">
									<a class="page-link" href="javascript:search_list(${pageNum}, 1);">
										${pageNum}
									</a>
								</li>
							</c:forEach>
						
								<li class="page-item">
									<a class="page-link" href="javascript:search_list(${pageMaker.page < pageMaker.realEndPage ? pageMaker.page + 1 : pageMaker.realEndPage }, 1);">
										<i class="fas fa-angle-right"></i>
									</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="javascript:search_list(${pageMaker.realEndPage}, 1);">
										<i class="fas fa-angle-double-right"></i>
									</a>
								</li>
							</ul>
						</nav>
						
						<form id="jobForm1" style="display: none;">
							<input type='text' name="num" value="1" />
							<input type='text' name="page" value="1" /> 
							<input type='text' name="perPageNum" value="" /> 
							<input type='text' name="searchType" value="" /> 
							<input type='text' name="keyword" value="" />
							<c:choose>
						        <%-- 1. 객체에 값이 있는 경우 우선순위 --%>
						        <c:when test="${not empty roomDetail.claNum}">
						            <input type='hidden' name="claNum" value="${roomDetail.claNum}" /> 
						        </c:when>
						        <%-- 2. 객체는 없지만 URL 파라미터에 있는 경우 --%>
						        <c:when test="${not empty param.claNum}">
						            <input type='hidden' name="claNum" value="${param.claNum}" />				            
						        </c:when>
						    </c:choose>
						</form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal-overlay" id="modal-reg">
    <div class="modal-box">
        <div class="modal-head">
            가산점 기준 등록
            <div class="modal-btns">
                <button class="mbtn-ok" onclick="submitReg()">저장</button>
                <button class="mbtn-cancel" onclick="closeModal('modal-reg')">취소</button>
            </div>
        </div>
        <div class="modal-body">
            <div class="form-row">
                <label>강좌 선택</label>
                <select id="reg-cla-num" class="full">
                    <option value="">-- 강좌를 선택하세요 --</option>
                    <c:forEach var="lesson" items="${lessonList}">
                        <option value="${lesson.claNum}">${lesson.claName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-row">
                <label>가산점 상세내용</label>
                <textarea id="reg-bc-content" class="full" rows="4"
                          placeholder="예: 수강률 100%, test 60점 이상"></textarea>
            </div>
            <div class="form-row">
                <label>가산점 (점수)</label>
                <input type="number" id="reg-bc-score" class="full" placeholder="예: 3" min="0" max="100">
            </div>
            <div class="form-row">
                <label>비고</label>
                <input type="text" id="reg-bc-note" class="full" placeholder="비고 입력 (선택)">
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="/resources/js/admin.js"></script>

<script>
    /* 가산점 기준 생성 모달 열기 */
    function openRegModal(courseName, courseId) {
        document.getElementById('gen-course').value    = courseName;
        document.getElementById('gen-course-id').value = courseId;
        document.getElementById('gen-detail').value   = '';
        document.getElementById('gen-note').value     = '';
        openModal('modal-gen');
    }

    /* 저장 */
    function saveGen() {
        var detail = document.getElementById('gen-detail').value.trim();
        if (!detail) { alert('가산점 상세내용을 입력하세요.'); return; }
        alert('저장되었습니다.');
        closeModal('modal-gen');
    }

    /* 리스트 상세 모달 열기 */
    function openDetailModal(course, content) {
        document.getElementById('detail-course').value        = course;
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
<!-- REQUIRED SCRIPTS -->
<script>
	function search_list(page, num) {
		
		// 검색 결과 없으면 기본 페이지는 1
		if (!page) page = 1;
		
		// 폼객체 먼저 가져오기
		let form = document.querySelector("#jobForm" + num);
		
		// perPageNum 있으면 그거 우선 사용
		let serverValue = ${pageMaker.perPageNum};
		
		// 서버에도  perPageNum 이 비어있는 경우 대비
		if (!form.perPageNum.value || form.perPageNum.value == "") {
			form.perPageNum.value = (serverValue && serverValue != 0) ? serverValue : 10;
		}
		
		// 화면에 있는 검색창에서 값 가져오기 (각 페이지에 id="keywordInput" 주기)
/* 		let keywordInput = document.querySelector("#keywordInput");
		if (keywordInput) {
			// 검색어 비었나 확인
			if (keywordInput.value.trim() == "") {
				// 전체 검색이 되도록
				form.searchType.value = "";
				form.keyword.value = "";
			} else {
				// 검색어 있으면
				form.keyword.value = keywordInput.value;
			}
		} */
		
		// perPageNum이 화면에 있으면 가져오고 없는 경우 유지
		let perPageSelect = document.querySelector ('select[name="perPageNum"]');
		if (perPageSelect) {
			form.perPageNum.value = perPageSelect.value;
		}

		// 페이지 번호 세팅
		form.page.value = page;
		
		// 현재 브라우저 경로로 전송 : 비동기
		$.ajax({
			// 지금 경로
	        url: window.location.pathname,
	        type: "get",
	     	// 폼 안의 모든 값(page, keyword, perPageNum 등)을 한 번에 보냄
	        data: $(form).serialize(),
	     	// 서버에서 HTML 조각을 받아옴
	        dataType: "html",             
	        success: function(result) {
	            let newList = $(result).find("#userAreaList" + num).html();
	            if (newList) {
	                $("#userAreaList" + num).html(newList);
	                console.log("리스트 및 페이지네이션 교체 완료");
	            } else {
	                console.error("서버 응답에서 #userAreaList" + num + "를 찾을 수 없습니다.");
	            }
	            window.scrollTo(0, 0);
	        },
	        error: function(xhr) {
	            console.log("에러 발생: " + xhr.status);
	        }
	    });
	}

/*     document.addEventListener("input", function(e) {
        const keywordInput = document.querySelector("#keywordInput");
        if (keywordInput) {
        	// 이벤트가 진행된 타겟이 키워드가 맞으면
        	if (e.target && e.target.id === "keywordInput") {
                if (e.target.value.trim() == "") {
                    search_list(1);
                }
            }
        }
    }); */
</script>
</html>
>>>>>>> branch 'admin' of https://github.com/KGyeongSu/eGov-School.git

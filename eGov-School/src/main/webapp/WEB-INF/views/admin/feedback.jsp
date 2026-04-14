<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
		
		    <div class="search-bar" style="display: flex !important; justify-content: space-between; align-items: center; margin-bottom: 20px; background: #fff; padding: 15px 20px; border-radius: 8px; border: 1px solid #ddd;">
		        <div class="filter-side">
		            <label style="font-weight: bold; margin-right: 10px;">강사 선택</label>
		            <select id="selectLecterer" onchange="getLecturerStats(this)" style="min-width: 200px; padding: 5px; border-radius: 4px;">
					    <option value="">강사를 선택하세요</option>
					    <c:forEach var="lec" items="${lectererList}">
					        <option value="${lec.userNum}">${lec.userName}(${lec.userEmail})</option>
					    </c:forEach>
					</select>
		        </div>
		        <div class="action-side">
		            <button class="btn btn-blue" style="padding: 10px 20px; font-weight: bold;" onclick="openModal('modal-send')">
		                강좌 피드백 발송
		            </button>
		        </div>
		    </div>
		
		    <div class="full-stats-layout" style="display: flex; flex-direction: column; gap: 20px;">
		        
		        <div class="section-box" style="margin:0; width: 100%; border: 1px solid #ddd !important; overflow: hidden;">
		            <div class="section-head" style="display: flex !important; height: 50px !important; align-items: center !important; padding: 0 !important; background: #004d73; color: #fff; border: none;">
		                <div style="flex: 0 0 220px; padding-left: 20px; font-weight: bold; border-right: 1px solid rgba(255,255,255,0.2); box-sizing: border-box;">
		                    수강생 만족도 평균
		                </div>
		                <div style="flex: 1; display: flex; text-align: center; font-size: 14px; font-weight: bold;">
		                    <span style="width: 75%;">강좌명</span>
		                    <span style="width: 25%;">평점</span>
		                </div>
		            </div>
		            
		            <div class="section-body" style="display: flex !important; align-items: stretch !important; padding: 0 !important; height: 245px; background: #fff;">
		                <div style="flex: 0 0 220px; text-align: center; display: flex; flex-direction: column; justify-content: center; align-items: center; border-right: 1px solid #eee; background: #fafafa; box-sizing: border-box;">
		                    <span id="avgScoreDisplay" style="font-size: 48px; font-weight: bold; color: #0056b3; line-height: 1;">-</span>
		                    <span style="font-size: 13px; color: #666; margin-top: 10px; white-space: nowrap;">평균 평점</span>
		                </div>
		                <div style="flex: 1; padding: 0 20px; display: flex; flex-start; overflow-y: auto;">
		                    <table class="board-table" style="width: 100%; table-layout: fixed; border: none !important; margin: 0 !important;">
		                        <tbody id="scoreTableBody">
		                            <tr><td colspan="2" style="text-align:center; color:#ccc; border: none !important;">강사를 선택해 주세요.</td></tr>
		                        </tbody>
		                    </table>
		                </div>
		            </div>
		        </div>
		
		        <div class="section-box" style="margin:0; width: 100%; border: 1px solid #ddd !important; overflow: hidden;">
		            <div class="section-head" style="display: flex !important; height: 50px !important; align-items: center !important; padding: 0 !important; background: #004d73; color: #fff; border: none;">
		                <div style="flex: 0 0 220px; padding-left: 20px; font-weight: bold; border-right: 1px solid rgba(255,255,255,0.2); box-sizing: border-box;">
		                    전체 수강생 수
		                </div>
		                <div style="flex: 1; display: flex; text-align: center; font-size: 14px; font-weight: bold;">
		                    <span style="width: 75%;">강좌명</span>
		                    <span style="width: 25%;">수강생</span>
		                </div>
		            </div>
		            
		            <div class="section-body" style="display: flex !important; align-items: stretch !important; padding: 0 !important; height: 245px; background: #fff;">
		                <div style="flex: 0 0 220px; text-align: center; display: flex; flex-direction: column; justify-content: center; align-items: center; border-right: 1px solid #eee; background: #fafafa; box-sizing: border-box;">
		                    <span id="totalStudentDisplay" style="font-size: 48px; font-weight: bold; color: #0056b3; line-height: 1;">-</span>
		                    <span style="font-size: 13px; color: #666; margin-top: 10px; white-space: nowrap;">전체 수강생</span>
		                </div>
		                <div style="flex: 1; padding: 0 20px; display: flex; flex-start; overflow-y: auto;">
		                    <table class="board-table" style="width: 100%; table-layout: fixed; border: none !important; margin: 0 !important;">
		                        <tbody id="studentTableBody">
		                            <tr><td colspan="2" style="text-align:center; color:#ccc; border: none !important;">강사를 선택해 주세요.</td></tr>
		                        </tbody>
		                    </table>
		                </div>
		            </div>
		        </div>
		
		    </div>
		</div><!-- /#tab-fb-general -->
		
		    </div><!-- /.main -->
		</div><!-- /.layout -->
		
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
		            강좌 피드백 발송
		            <div class="modal-btns">
		                <button class="mbtn-ok" onclick="doSend()">전송</button>
		                <button class="mbtn-cancel" onclick="closeModal('modal-send')">취소</button>
		            </div>
		        </div>
		        <div class="modal-body">
		            <!-- DB: SELECT course_name FROM courses / SELECT AVG(score) FROM feedback WHERE course_id=? -->
		            <div class="form-row">
		                <label>강좌명</label>
				        <div class="select-wrapper" style="border: 1px solid #ddd; border-radius: 4px; overflow: hidden;">
				        <select id="send-course" class="full" style="border: none; outline: none;">
				            <option value="">강사를 먼저 선택해주세요</option>
				        </select>
				    </div>
		            </div>
		            <div class="form-row">
		                <label>평가 내용</label>
		                <textarea id="send-comment" class="full" 
                          placeholder="강사에게 전달할 평가 내용을 입력하세요." 
                          style="width: 100%; height: 120px; padding: 10px; border: 1px solid #ddd; border-radius: 4px; resize: none;"></textarea>
		            </div>
		        </div>
		    </div>
		</div>


<script>
	
	window.getLecturerStats = function(el) {
	    console.log("=== 통계 함수 실행 시작 ===");
	    
	    // 1. 전달받은 el이 있으면 그것을 쓰고, 없으면 ID로 찾음
	    var selectEl = el || document.getElementById('selectLecterer');
	    if (!selectEl) {
	        console.error("강사 선택 요소를 찾을 수 없습니다.");
	        return;
	    }
	
	    // 2. 선택된 값(userNum) 추출
	    var userNum = selectEl.value;
	    console.log("선택된 강사 번호: [" + userNum + "]");
	
	    // 표시 엘리먼트들
	    var avgScoreDisp = document.getElementById('avgScoreDisplay');
	    var totalStudentDisp = document.getElementById('totalStudentDisplay');
	    var scoreTable = document.getElementById('scoreTableBody');
	    var studentTable = document.getElementById('studentTableBody');
	
	    // 강사를 선택하지 않았을 경우 초기화 로직
	    if (!userNum || userNum.trim() === "") {
	        if(avgScoreDisp) avgScoreDisp.textContent = "-";
	        if(totalStudentDisp) totalStudentDisp.textContent = "-";
	        var emptyMsg = '<tr><td colspan="2" style="text-align:center; color:#ccc; border:none !important; padding:40px 0;">강사를 선택해 주세요.</td></tr>';
	        if(scoreTable) scoreTable.innerHTML = emptyMsg;
	        if(studentTable) studentTable.innerHTML = emptyMsg;
	        return;
	    }
	
	    // 3. 요청 URL 생성
	    var contextPath = '<%=request.getContextPath()%>';
	    var url = contextPath + '/admin/getLRep?userNum=' + encodeURIComponent(userNum);
	    console.log("서버 요청 주소: " + url);
	
	    // 4. AJAX 요청
	    fetch(url)
	        .then(function(response) {
	            if (!response.ok) throw new Error('네트워크 응답 에러');
	            return response.json();
	        })
	        .then(function(data) {
	            console.log("서버 데이터 수신 성공:", data);
	
	            if (data && data.length > 0) {
	                if(avgScoreDisp) avgScoreDisp.textContent = data[0].totalAvg; 
	                if(totalStudentDisp) totalStudentDisp.textContent = data[0].sumScore.toLocaleString();
	
	                var scoreRows = "";
	                var studentRows = "";
	                var courseOptions = '<option value="">강좌를 선택하세요</option>';
	
	                for (var i = 0; i < data.length; i++) {
	                    var vo = data[i];
	                    
	                    courseOptions += '<option value="' + vo.claNum + '">' + vo.claTitle + '</option>';
	                    
	                    scoreRows += '<tr>' +
	                        '<td style="width: 75%; text-align: left; padding-left: 20px; border:none !important;">' + vo.claTitle + '</td>' +
	                        '<td style="width: 25%; text-align: center; border:none !important;">★ ' + vo.avgScore + '</td>' +
	                        '</tr>';
	                    
	                    studentRows += '<tr>' +
	                        '<td style="width: 75%; text-align: left; padding-left: 20px; border:none !important;">' + vo.claTitle + '</td>' +
	                        '<td style="width: 25%; text-align: center; border:none !important;">' + vo.studentCount + '명</td>' +
	                        '</tr>';
	                }
	                
	                var sendCourseSelect = document.getElementById('send-course');
	                
	                if(sendCourseSelect) {
	                	
	                    sendCourseSelect.innerHTML = courseOptions;

	                }
	
	                if(scoreTable) scoreTable.innerHTML = scoreRows;
	                if(studentTable) studentTable.innerHTML = studentRows;
	                
	            } else {
	                if(avgScoreDisp) avgScoreDisp.textContent = "0.0";
	                if(totalStudentDisp) totalStudentDisp.textContent = "0";
	                var noDataHtml = '<tr><td colspan="2" style="text-align:center; color:#ccc; border:none !important; padding:40px 0;">조회된 데이터가 없습니다.</td></tr>';
	                if(scoreTable) scoreTable.innerHTML = noDataHtml;
	                if(studentTable) studentTable.innerHTML = noDataHtml;
	            }
	        })
	        .catch(function(error) {
	            console.error('AJAX 처리 중 오류 발생:', error);
	            alert('데이터를 불러오는 중 오류가 발생했습니다.');
	        });
	};

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
    	
    	var adminNum = "${sessionScope.loginUser.userNum}";
    	
    	if(!adminNum || adminNum === "") {
            alert("로그인 세션이 만료되었습니다. 다시 로그인해주세요.");
            location.href = "<%=request.getContextPath()%>/commons/login"; 
            return;
        }
    	
    	var selectEl = document.getElementById('send-course');
        
        var claNum = selectEl.value;
        var claTitle = selectEl.options[selectEl.selectedIndex].text; 
        
        var comment = document.getElementById('send-comment').value;

        // 유효성 검사
        if(!claNum) { 
            alert('발송할 강좌를 선택해주세요.'); 
            return; 
        }
        
        if(!comment.trim()) { 
            alert('평가 내용을 입력해주세요.'); 
            return; 
        }
        
        var data = {
                userNum: adminNum,    
                claNum: claNum,      
                repContent: comment,  
            };

        fetch('<%=request.getContextPath()%>/admin/insertFeedback', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        })
        .then(response => response.text()) 
		.then(result => {
		    if(result === "success") { 
		        alert('[' + claTitle + '] 강좌에 대한 피드백이 성공적으로 전송되었습니다.');
		        document.getElementById('send-comment').value = '';
		        closeModal('modal-send');
		    } else {
		        alert('서버 저장에 실패했습니다.');
		    }
		})
        .catch(error => {
            console.error('Error:', error);
            alert('서버 연결에 실패했습니다.');
        });
    }
    
</script>
</body>
</html>
    
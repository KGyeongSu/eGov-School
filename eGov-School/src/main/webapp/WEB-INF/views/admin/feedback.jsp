<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.6);
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
			<a href="/admin/main"> <img src="../../../resources/images/dashboardLogo.png"
				alt="대전광역시 인재개발원">
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
				<a href="/admin/main">공무원 선발 가산점</a> <a href="/admin/feedback"
					class="on">강사 피드백</a> <a href="/admin/cv">강사지원자 이력서 확인</a> <a
					href="/admin/curriculum">강좌 커리큘럼 확인</a>
			</div>
			<div class="side-bottom">
				<strong>${loginUser.userName}</strong> 관리자
			</div>
		</div>

		<div class="main">
			<div class="page-title">강사 피드백</div>
			<div class="page-sub">eschool / dash / adm / fb</div>

			<div class="tab-bar" data-group="fb">
				<a href="#" class="on" onclick="showTab('tab-fb-list', this)">수강생
					피드백 확인</a> <a href="#" onclick="showTab('tab-fb-general', this)">강사
					피드백 종합</a>
			</div>

			<div class="tab-content active" id="tab-fb-list" data-group="fb">
				<div class="cur-tab">수강생 피드백 확인</div>
				<div class="section-box">
					<div class="section-head">수강생 피드백 확인</div>
					<div class="section-body">
						<form action="/admin/feedback" method="get">
							<div class="search-bar">
								<label>강사</label> <select name="lecturerName" id="fbInstructor">
									<option value="">전체</option>
									<c:forEach var="lec" items="${lectererList}">
										<option value="${lec.userName}"
											${searchVO.lecturerName == lec.userName ? 'selected' : ''}>${lec.userName}</option>
									</c:forEach>
								</select> <label>점수</label> <select name="repSat" id="fbScoreSelect">
									<option value="0">전체</option>
									<option value="5" ${searchVO.repSat == 5 ? 'selected' : ''}>5점</option>
									<option value="4" ${searchVO.repSat == 4 ? 'selected' : ''}>4점</option>
									<option value="3" ${searchVO.repSat == 3 ? 'selected' : ''}>3점</option>
									<option value="2" ${searchVO.repSat == 2 ? 'selected' : ''}>2점</option>
									<option value="1" ${searchVO.repSat == 1 ? 'selected' : ''}>1점</option>
								</select> <input type="text" name="keyword" value="${searchVO.keyword}"
									placeholder="수강생명/강좌/내용 검색">
								<button type="submit" class="btn btn-blue btn-sm">검색</button>
								<button type="button" class="btn btn-sm"
									onclick="location.href='/admin/feedback'">초기화</button>
							</div>
						</form>

						<div class="card-grid" id="fbGrid">
							<c:forEach var="fb" items="${reputationList}">
								<div class="card-item"
									onclick="openFbModal('${fb.userName}','${fb.lecturerName}','${fb.claTitle}',`<c:out value="${fb.repContent}"/>`, '${fb.repSat}')">
									<div class="card-thumb">피드백 카드</div>
									<div class="card-info">
										${fb.userName} | ${fb.claTitle}<br> 강사:
										${fb.lecturerName} <span
											class="${fb.repSat <= 2 ? 'score-low' : 'score-normal'}">
											<c:forEach begin="1" end="${fb.repSat}">★</c:forEach> <c:forEach
												begin="${fb.repSat + 1}" end="5">☆</c:forEach>
										</span> ${fb.repSat}.0
									</div>
								</div>
							</c:forEach>
							<c:if test="${empty reputationList}">
								<div
									style="grid-column: 1/-1; text-align: center; padding: 50px; color: #999;">
									검색 결과가 없습니다.</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>

			<!-- ===== 탭2: 강사 피드백 종합 (ES-A04-007, 008) ===== -->
			<div class="tab-content" id="tab-fb-general" data-group="fb">
				<div class="cur-tab">강사 피드백 종합</div>

				<div class="search-bar"
					style="display: flex !important; justify-content: space-between; align-items: center; margin-bottom: 20px; background: #fff; padding: 15px 20px; border-radius: 8px; border: 1px solid #ddd;">
					<div class="filter-side">
						<label style="font-weight: bold; margin-right: 10px;">강사
							선택</label> <select id="selectLecterer" onchange="getLecturerStats(this)"
							style="min-width: 200px; padding: 5px; border-radius: 4px;">
							<option value="">강사를 선택하세요</option>
							<c:forEach var="lec" items="${lectererList}">
								<option value="${lec.userNum}">${lec.userName}(${lec.userEmail})</option>
							</c:forEach>
						</select>
					</div>
					<div class="action-side">
						<button class="btn btn-blue"
							style="padding: 10px 20px; font-weight: bold;"
							onclick="openModal('modal-send')">강좌 피드백 발송</button>
					</div>
				</div>

				<div class="full-stats-layout"
					style="display: flex; flex-direction: column; gap: 20px;">

					<div class="section-box"
						style="margin: 0; width: 100%; border: 1px solid #ddd !important; overflow: hidden;">
						<div class="section-head"
							style="display: flex !important; height: 50px !important; align-items: center !important; padding: 0 !important; background: #004d73; color: #fff; border: none;">
							<div
								style="flex: 0 0 220px; padding-left: 20px; font-weight: bold; border-right: 1px solid rgba(255, 255, 255, 0.2); box-sizing: border-box;">
								수강생 만족도 평균</div>
							<div
								style="flex: 1; display: flex; text-align: center; font-size: 14px; font-weight: bold;">
								<span style="width: 75%;">강좌명</span> <span style="width: 25%;">평점</span>
							</div>
						</div>

						<div class="section-body"
							style="display: flex !important; align-items: stretch !important; padding: 0 !important; height: 245px; background: #fff;">
							<div
								style="flex: 0 0 220px; text-align: center; display: flex; flex-direction: column; justify-content: center; align-items: center; border-right: 1px solid #eee; background: #fafafa; box-sizing: border-box;">
								<span id="avgScoreDisplay"
									style="font-size: 48px; font-weight: bold; color: #0056b3; line-height: 1;">-</span>
								<span
									style="font-size: 13px; color: #666; margin-top: 10px; white-space: nowrap;">평균
									평점</span>
							</div>
							<div
								style="flex: 1; padding: 0 20px; display: flex; flex-start; overflow-y: auto;">
								<table class="board-table"
									style="width: 100%; table-layout: fixed; border: none !important; margin: 0 !important;">
									<tbody id="scoreTableBody">
										<tr>
											<td colspan="2"
												style="text-align: center; color: #ccc; border: none !important;">강사를
												선택해 주세요.</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<div class="section-box"
						style="margin: 0; width: 100%; border: 1px solid #ddd !important; overflow: hidden;">
						<div class="section-head"
							style="display: flex !important; height: 50px !important; align-items: center !important; padding: 0 !important; background: #004d73; color: #fff; border: none;">
							<div
								style="flex: 0 0 220px; padding-left: 20px; font-weight: bold; border-right: 1px solid rgba(255, 255, 255, 0.2); box-sizing: border-box;">
								전체 수강생 수</div>
							<div
								style="flex: 1; display: flex; text-align: center; font-size: 14px; font-weight: bold;">
								<span style="width: 75%;">강좌명</span> <span style="width: 25%;">수강생</span>
							</div>
						</div>

						<div class="section-body"
							style="display: flex !important; align-items: stretch !important; padding: 0 !important; height: 245px; background: #fff;">
							<div
								style="flex: 0 0 220px; text-align: center; display: flex; flex-direction: column; justify-content: center; align-items: center; border-right: 1px solid #eee; background: #fafafa; box-sizing: border-box;">
								<span id="totalStudentDisplay"
									style="font-size: 48px; font-weight: bold; color: #0056b3; line-height: 1;">-</span>
								<span
									style="font-size: 13px; color: #666; margin-top: 10px; white-space: nowrap;">전체
									수강생</span>
							</div>
							<div
								style="flex: 1; padding: 0 20px; display: flex; flex-start; overflow-y: auto;">
								<table class="board-table"
									style="width: 100%; table-layout: fixed; border: none !important; margin: 0 !important;">
									<tbody id="studentTableBody">
										<tr>
											<td colspan="2"
												style="text-align: center; color: #ccc; border: none !important;">강사를
												선택해 주세요.</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
			</div>
			<!-- /#tab-fb-general -->
		</div>
		<!-- /.main -->
	</div>
	<!-- /.layout -->



	<div class="modal-overlay" id="modal-fb"
		onclick="handleOverlayClick(event)">
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
					<div class="preview-area" id="fb-content"
						style="white-space: pre-wrap;"></div>
				</div>
				<div class="form-row">
					<label>평점</label>
					<div class="preview-area score-box" id="fb-score-val"></div>
				</div>
			</div>
		</div>
	</div>
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
				<div class="form-row">
					<label>강좌 선택</label> <select id="send-course" class="full">
						<option value="">강사를 먼저 선택하세요</option>
					</select>
				</div>
				<div class="form-row">
					<label>평가 내용</label>
					<textarea id="send-comment" class="full" rows="4"
						placeholder="강좌 피드백 내용을 입력하세요."></textarea>
				</div>
			</div>
		</div>
	</div>

	<script>
	// 육상우
	/* 피드백 모달 열기 */
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
    
    //이은영
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
                repSat: 0
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

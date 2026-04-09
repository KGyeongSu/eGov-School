<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../modules/lecHeader.jsp"%>

<head>
<!-- 개별 css -->
<link type="text/css" rel="stylesheet"
	href="../../../resources/css/lecterer/style.css" />

<!-- 달력 알림 & 달력 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link
	href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.css"
	rel="stylesheet">

<title>inlearning_mainDashBoard</title>

</head>

<body>

	<div class="content">
		<div class="top">
			<div class="icon">
				<a href="${pageContext.request.contextPath}/lecterer/mainDashBoard"><i class="fa-regular fa-user"></i></a>
			</div>
			<div class="state_bar">
				<p>${loginUser.userName}님의 메인대시보드</p>
			</div>
			<div class="logout_dash">
				<div class="mes" onclick="location.href='reputationHome';" style="cursor: pointer; position: relative; display: inline-block;">
				    <i class="fa-regular fa-envelope"></i>
				    <span id="repBadge" style="position: absolute; top: 5px; right: 50px; background-color: #dc3545; color: white; font-size: 10px; font-weight: bold; padding: 2px 6px; border-radius: 50%; display: none; border: 2px solid white;">
				    	0
				    </span>
				</div>
				<div class="out">
					<button type="button" class="btn btn-sm" onclick="location.href='${pageContext.request.contextPath}/commons/logout'"
						style="background-color: #1a6d91; color: white; border-radius: 4px; font-size: 12px;">로그아웃
					</button>
				</div>
			</div>
		</div>
		<div class="mid">
			<div class="container-fluid">
				<h4 class="section-title">진행중인 강좌</h4>
				<div class="row">
					<c:choose>
						<c:when test="${empty classList}">
							<div class="col-12 text-center">
								<p>현재 진행 중인 강좌가 없습니다.</p>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach items="${classList}" var="classs" begin="0" end="2">
								<div class="col-md-4">
									<div class="card course-card-v2">
										<div class="course-img-wrapper">
											<c:choose>
										        <%-- DB에 썸네일 파일명이 있는 경우 --%>
										        <c:when test="${not empty classs.claThumb}">
										            <img src="${pageContext.request.contextPath}${classs.claSavePath}/${classs.claSaveName}" 
										                 class="course-img" 
										                 onerror="this.src='${pageContext.request.contextPath}/resources/images/default.jpg'">
										        </c:when>
										        <%-- 없는 경우 기본 이미지 출력 --%>
										        <c:otherwise>
										            <img src="${pageContext.request.contextPath}/resources/images/default.jpg" 
										                 class="course-img">
										        </c:otherwise>
										      </c:choose>
											<div class="course-overlay">
												<button class="btn-play" onclick="go_roomDetail('${classs.claNum}', '${classs.claTitle}');">
													<i class="fa-solid fa-door-open"></i> 강의실 바로가기
												</button>
											</div>
										</div>
										<div class="card-body">
											<h3 class="course-title">${classs.claTitle}</h3>
											<div class="course-status-text">
												<span>등록 강좌율</span><span class="percent-text">${classs.claGoal }</span>
											</div>
											<div class="progress custom-progress-v2" style="height: 20px; background-color: #eee;">
												<div class="progress-bar" style="width: ${classs.claGoal}!important; height: 100%; background-color: #1a6d91 !important; "></div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div class="bot">
			<div class="container-fluid">
				<h4 class="section-title">최근 출제한 평가</h4>
				<div class="row">
					<div class="col-sm-6">
					    <div class="card" style="height: 380px">
					        <div class="card-body p-0">
							    <table class="table table-valign-middle table-hover" style="margin-top: 5px;">
							        <thead>
							            <tr>
							                <th style="width: 10px">no.</th>
							                <th style="width: 50%">강좌명</th>
							                <th style="text-align: left;">응시율</th>
							            </tr>
							        </thead>
							        <tbody>
							            <c:choose>
							                <c:when test="${empty examList}">
							                    <tr>
							                        <td colspan="3" class="text-center" style="padding: 50px 0; color: #999;">
							                            최근 출제된 평가 내역이 없습니다.
							                        </td>
							                    </tr>
							                </c:when>
							                <c:otherwise>
							                    <c:forEach items="${examList}" var="exam" varStatus="vs" begin="0" end="4">
							                        <tr onclick="location.href='${pageContext.request.contextPath}/lecterer/resultManage';" 
							                            style="cursor:pointer;">
							                            <td>${vs.count}.</td>
							                            <td>
							                                <div style="font-weight: 600; font-size: 15px; color: #333; padding: 5px 0;">
							                                    ${exam.claTitle}
							                                </div>
							                            </td>
							                            <td>
							                                <div style="display: flex; align-items: center;">
							                                    <c:set var="fakeRate" value="${95 - (vs.count * 6)}" />
							                                    
							                                    <div class="progress progress-xs" style="flex: 1; margin-right: 15px; margin-bottom: 0; background-color: #eee;">
							                                        <div class="progress-bar ${fakeRate > 80 ? 'bg-success' : 'bg-primary'}" 
							                                             style="width: ${fakeRate}%"></div>
							                                    </div>
							                                    <span class="badge ${fakeRate > 80 ? 'bg-success' : 'bg-primary'}">${fakeRate}%</span>
							                                </div>
							                            </td>
							                        </tr>
							                    </c:forEach>
							                </c:otherwise>
							            </c:choose>
							        </tbody>
							    </table>
							</div>
					    </div>
					</div>
					<div class="col-sm-6">
						<div id="mini-calendar"></div>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog"
			aria-hidden="true">
			<div class="modal-dialog modal-xl" role="document">
				<div class="modal-content">
					<div class="modal-header bg-primary text-white">
						<h5 class="modal-title font-weight-bold">전체 일정 관리 및 수정</h5>
						<button type="button" class="close text-white"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div id="full-calendar"></div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="saveBtn">저장하기</button>
					</div>
				</div>
			</div>
		</div>
</body>

<script src="/resources/js/commons.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>

<script>

	$(document).ready(function() {
		
		updateReputationAlarm();
		
		setInterval(updateReputationAlarm, 60000);
	
	    // 모달 포커스 에러 방지
	    if (window.jQuery && $.fn.modal) {
	        $.fn.modal.Constructor.prototype._enforceFocus = function() {};
	    }
	
	    const STORAGE_KEY = 'dashboard_calendar_events';
	
	    function loadEvents() {
	        try { return JSON.parse(localStorage.getItem(STORAGE_KEY)) || []; }
	        catch(e) { return []; }
	    }
	    function saveEvents(events) {
	        localStorage.setItem(STORAGE_KEY, JSON.stringify(events));
	    }
	
	    // ── 1. 미니 캘린더 (대시보드 메인) ────────────────────────────────────
	    const miniCalendar = new FullCalendar.Calendar(document.getElementById('mini-calendar'), {
	        initialView: 'dayGridMonth',
	        locale: 'ko',
	        height: '112%',
	        expandRows: true,
	        headerToolbar: { left: 'prev', center: 'title', right: 'next' },
	        dayCellContent: (info) => info.date.getDate(),
	        events: loadEvents(),
	        dateClick: function() { $('#calendarModal').modal('show'); },
	        eventClick: function() { $('#calendarModal').modal('show'); }
	    });
	    miniCalendar.render();
	
	    // ── 2. 풀 캘린더 (모달 내부) ─────────────────────────────────────
	    let fullCalendar = null;
	
	    function buildFullCalendar() {
	        if (fullCalendar) { fullCalendar.destroy(); }
	
	        fullCalendar = new FullCalendar.Calendar(document.getElementById('full-calendar'), {
	            initialView: 'dayGridMonth',
	            locale: 'ko',
	            selectable: true,
	            selectMirror: true,
	            headerToolbar: { left: 'prev,next today', center: 'title', right: 'dayGridMonth,listWeek' },
	            dayCellContent: (info) => info.date.getDate(),
	            events: loadEvents(),
	
	            // 날짜 선택 → 세련된 일정 추가 모달
	            select: function(info) {
	                const startLabel = info.startStr.slice(0,10);
	                const endDate   = new Date(info.end); endDate.setDate(endDate.getDate()-1);
	                const endLabel  = endDate.toISOString().slice(0,10);
	                const dateLabel = startLabel === endLabel ? startLabel : startLabel + ' ~ ' + endLabel;
	
	                Swal.fire({
	                    title: '<span style="font-size:18px; font-weight:800; color:#1a6d91;">새 일정 추가</span>',
	                    html: '<div style="font-size:12px; color:#64748b; margin-bottom:8px;"><i class="fa-solid fa-calendar-day" style="color:#1a6d91;"></i> ' + dateLabel + '</div>',
	                    input: 'text',
	                    inputPlaceholder: '일정 제목을 입력하세요',
	                    inputAttributes: { maxlength: 30 },
	                    customClass: {
	                        input: 'swal-custom-input',
	                        confirmButton: 'swal-confirm-btn',
	                        cancelButton: 'swal-cancel-btn'
	                    },
	                    showCancelButton: true,
	                    confirmButtonColor: '#1a6d91',
	                    confirmButtonText: '<i class="fa-solid fa-plus"></i> 추가',
	                    cancelButtonText: '취소',
	                    didOpen: () => {
	                        const input = Swal.getInput();
	                        input.style.cssText = 'border-radius:8px; border:1.5px solid #cbd5e1; font-size:14px; padding:10px 14px; box-sizing:border-box;';
	                        input.addEventListener('focus', () => { input.style.borderColor = '#1a6d91'; input.style.outline = 'none'; input.style.boxShadow = '0 0 0 3px rgba(26,109,145,0.15)'; });
	                        input.addEventListener('blur',  () => { input.style.borderColor = '#cbd5e1'; input.style.boxShadow = 'none'; });
	                    }
	                }).then((result) => {
	                    if (result.isConfirmed && result.value && result.value.trim()) {
	                        fullCalendar.addEvent({
	                            id: Date.now().toString(),
	                            title: result.value.trim(),
	                            start: info.startStr,
	                            end: info.endStr,
	                            allDay: info.allDay,
	                            color: '#1a6d91' // 일정 띠 색상
	                        });
	                    }
	                    fullCalendar.unselect();
	                });
	            },
	
	            // 이벤트 클릭 → 세련된 삭제 경고 모달
	            eventClick: function(info) {
	                const startStr = info.event.startStr ? info.event.startStr.slice(0,10) : '';
	                Swal.fire({
	                    title: '<span style="font-size:16px; font-weight:800; color:#1e293b;">일정 삭제</span>',
	                    html: '<div style="margin:10px 0;">' +
	                          '<div style="background:#fef2f2; border-radius:8px; padding:12px; margin-bottom:8px;">' +
	                          '<div style="font-weight:700; color:#dc3545; font-size:14px;">' + info.event.title + '</div>' +
	                          (startStr ? '<div style="font-size:12px; color:#94a3b8; margin-top:3px;"><i class="fa-solid fa-calendar"></i> ' + startStr + '</div>' : '') +
	                          '</div>' +
	                          '<div style="font-size:12px; color:#64748b;">이 일정을 삭제하면 복구할 수 없습니다.</div></div>',
	                    icon: 'warning',
	                    showCancelButton: true,
	                    confirmButtonColor: '#dc3545',
	                    confirmButtonText: '<i class="fa-solid fa-trash"></i> 삭제',
	                    cancelButtonText: '취소',
	                    reverseButtons: true
	                }).then((result) => {
	                    if (result.isConfirmed) {
	                        info.event.remove();
	                        Swal.fire({
	                            icon: 'success',
	                            title: '삭제되었습니다',
	                            text: '저장하기를 눌러 반영하세요.',
	                            timer: 1800,
	                            showConfirmButton: false,
	                            toast: true,
	                            position: 'top-end'
	                        });
	                    }
	                });
	            }
	        });
	
	        fullCalendar.render();
	    }
	
	    // ── 3. 저장하기 버튼 클릭 이벤트 ──────────────────────────────────────
	    document.getElementById('saveBtn').addEventListener('click', function() {
	        if (!fullCalendar) return;
	
	        const currentEvents = fullCalendar.getEvents().map(e => ({
	            id: e.id || Date.now().toString(),
	            title: e.title,
	            start: e.startStr,
	            end: e.endStr || null,
	            allDay: e.allDay,
	            color: '#1a6d91'
	        }));
	
	        saveEvents(currentEvents);
	
	        // 미니 캘린더 갱신
	        miniCalendar.getEvents().forEach(e => e.remove());
	        currentEvents.forEach(e => miniCalendar.addEvent(e));
	
	        $('#calendarModal').modal('hide');
	
	        // 우측 상단 토스트 알림으로 부드럽게 완료 메시지
	        setTimeout(() => {
	            Swal.fire({
	                icon: 'success',
	                title: '저장 완료!',
	                text: '일정이 대시보드에 반영되었습니다.',
	                timer: 2000,
	                showConfirmButton: false,
	                toast: true,
	                position: 'top-end'
	            });
	        }, 300);
	    });
	
	    // ── 4. 모달 열고 닫기 관리 ────────────────────────────────
	    $('#calendarModal').on('shown.bs.modal', function() { buildFullCalendar(); });
	    $('#calendarModal').on('hidden.bs.modal', function() {
	        if (fullCalendar) { fullCalendar.destroy(); fullCalendar = null; }
	    });
	    
	    function updateReputationAlarm() {
	        
	    	$.ajax({
	            
	    		url: '${pageContext.request.contextPath}/lecterer/reputationAlarm',
	            type: 'GET',
	            success: function(count) {
	                
	            	const badge = $('#repBadge');
	            	
	                if (count > 0) {
	                    
	                	badge.text(count).show(); // 0보다 크면 숫자 넣고 보여줌
	                	
	                } else {
	                   
	                	badge.hide(); // 0이면 숨김
	                	
	                }
	            },
	            
	            error: function() {
	            	
	                console.log("알림 데이터를 가져오는데 실패했습니다.");
	                
	            }
	        });
	    
		}
	
	});
	
	// 강의실 이동 함수
	function go_roomDetail(claNum, claTitle) {
		
	    alert(claTitle + " 강의실로 이동합니다.");
	    location.href = "/lecterer/roomDetail?claNum=" + claNum;
	    
	}

</script>

</html>

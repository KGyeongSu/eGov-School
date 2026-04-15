<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<!DOCTYPE html>
	<html lang="ko">
	<head>
	    <meta charset="UTF-8">
	    <title>대시보드</title>
	    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.css" rel="stylesheet">
	    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/style.css" />
	
	    <style>
	        /* 미니 캘린더 클릭 힌트 */
	        .calendar-hint {
	            text-align: center;
	            font-size: 11px;
	            color: #94a3b8;
	            margin-top: 6px;
	            display: flex;
	            align-items: center;
	            justify-content: center;
	            gap: 4px;
	        }
	        .calendar-hint i { color: #0e506e; }
	
	        /* Swal 커스텀 */
	        .swal-input-styled .swal2-input {
	            border-radius: 8px !important;
	            border: 1px solid #cbd5e1 !important;
	            font-size: 14px !important;
	            padding: 10px 14px !important;
	        }
	        .swal-input-styled .swal2-input:focus {
	            border-color: #0e506e !important;
	            box-shadow: 0 0 0 3px rgba(14,80,110,0.15) !important;
	        }
	    </style>
	</head>
	<body>
	    <div class="main-wrapper">
	        <%@include file="../modules/userHeader.jsp" %>
	
	        <div class="mid">
	            <div class="container-fluid">
	
	                <div class="section-header">
	                    <h4 style="font-weight:bold; color:#0e506e; margin:0;">
	                        <i class="fa-solid fa-book-open-reader mr-2"></i>수강 중인 강좌
	                    </h4>
	                </div>
	
	                <div class="row mb-5">
	                    <c:forEach items="${result.applyList}" var="apply" end="2">
	                        <div class="col-md-4">
	                            <div class="course-card-custom shadow-sm">
	                                <div class="card-thumb-area">
									    <c:choose>
									        <c:when test="${not empty apply.claSaveName}">
									            <img src="${pageContext.request.contextPath}${apply.claSavePath}/${apply.claSaveName}" 
									                 style="width:100%; height:100%; object-fit:cover;"
									                 onerror="this.src='${pageContext.request.contextPath}/resources/images/no-image.png'">
									        </c:when>
									        <c:otherwise>
									            <img src="${pageContext.request.contextPath}/resources/images/no-image.png" 
									                 style="width:100%; height:100%; object-fit:cover;">
									        </c:otherwise>
									    </c:choose>
									</div>
	                                <div style="padding:20px;">
	                                    <h5 style="font-weight:bold; height:42px; overflow:hidden; margin-bottom:15px;">${apply.claName}</h5>
	                                    <div class="d-flex justify-content-between mb-1" style="font-size:12px;">
	                                        <span>학습 진도율</span>
	<strong>
	    <fmt:formatNumber value="${apply.progress}" pattern="0" />%
	</strong>
	                                    </div>
	                                    <div class="progress" style="height:8px;">
	                                        <div class="progress-bar progress-bar-striped progress-bar-animated"
	                                             style="width:${apply.progress}%; background:#0e506e;"></div>
	                                    </div>
	                                    <button class="btn btn-block mt-3"
	                                            style="background:#0e506e; color:white; font-weight:bold;"
	                                            onclick="location.href='${pageContext.request.contextPath}/user/videolect?claNum=${apply.claNum}'">
	                                        학습 이어하기
	                                    </button>
	                                </div>
	                            </div>
	                        </div>
	                    </c:forEach>
	                </div>
	
	                <div class="bottom-container">
	                    <div class="card card-outline card-navy shadow-sm card-fixed-height">
	                        <div class="card-header py-2">
	                            <h5 class="m-0 font-weight-bold" style="color:#0e506e;">최근 시험 성적 통계</h5>
	                        </div>
	                        <div class="fixed-card-body">
	                            <div style="flex:1.5; position:relative; height:100%; min-height:0;">
	                                <canvas id="evaluationChart"></canvas>
	                            </div>
	                            <div style="width:280px; display:flex; flex-direction:column; min-height:0;">
	                                <h6 class="font-weight-bold mb-3" style="font-size:14px;">시험 결과 상세</h6>
	                                <div style="flex:1; overflow-y:auto; padding-right:5px;">
	                                    <c:forEach items="${result.endList}" var="exam">
	                                        <div class="status-item">
	                                            <span class="subject-name">${exam.claName}</span>
	                                            <div class="status-row">
	                                                <div class="d-flex align-items-center">
	                                                    <div class="square ${exam.erScore >= 60 ? 'pass' : 'fail'}"></div>
	                                                    <span style="font-size:12px; font-weight:600; color:${exam.erScore >= 60 ? '#28a745' : '#dc3545'}">
	                                                        ${exam.erScore >= 60 ? '합격' : '불합격'}
	                                                    </span>
	                                                    <span class="rank-badge ml-2">${exam.erScore}점</span>
	                                                </div>
	                                                <c:if test="${exam.erScore < 60}">
	                                                    <button class="btn-retake">재시험</button>
	                                                </c:if>
	                                            </div>
	                                        </div>
	                                    </c:forEach>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	
	                    <div style="flex:1; display:flex; flex-direction:column; min-height:0;">
	                        <div id="mini-calendar" style="flex:1; min-height:0;"></div>
	                        <div class="calendar-hint">
	                            <i class="fa-solid fa-circle-info"></i>
	                            캘린더를 클릭하면 일정을 관리할 수 있습니다
	                        </div>
	                    </div>
	                </div>
	
	            </div>
	        </div>
	    </div>
	
	    <div class="modal fade" id="calendarModal" tabindex="-1">
	        <div class="modal-dialog modal-xl">
	            <div class="modal-content">
	                <div class="modal-header" style="background:#0e506e;">
	                    <div>
	                        <h5 class="modal-title font-weight-bold text-white mb-0">
	                            <i class="fa-solid fa-calendar-days mr-2"></i>학습 일정 관리
	                        </h5>
	                        <small class="text-white-50" style="font-size:11px;">날짜를 드래그하여 일정 추가 · 일정 클릭 시 삭제</small>
	                    </div>
	                    <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
	                </div>
	                <div class="modal-body">
	                    <div id="full-calendar"></div>
	                </div>
	                <div class="modal-footer">
	                    <div style="font-size:12px; color:#94a3b8; margin-right:auto;">
	                        <i class="fa-solid fa-floppy-disk mr-1"></i>저장 후 대시보드에 반영됩니다
	                    </div>
	                    <button type="button" class="btn btn-light" data-dismiss="modal"
	                            style="border:1px solid #e2e8f0; font-weight:600; border-radius:8px;">닫기</button>
	                    <button type="button" id="saveBtn" class="btn"
	                            style="background:#0e506e; color:white; border:none; font-weight:700; border-radius:8px; padding:8px 22px;">
	                        <i class="fa-solid fa-check mr-1"></i>저장하기
	                    </button>
	                </div>
	            </div>
	        </div>
	    </div>
	
	    <script>
	    $(document).ready(function() {
	
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
	
	        // ── 1. 차트 ──────────────────────────────────────────
	        new Chart(document.getElementById('evaluationChart'), {
	            type: 'bar',
	            data: {
	                labels: [
	                    <c:forEach items="${result.endList}" var="e" end="3" varStatus="status">
	                        '${e.claName}'${!status.last ? ',' : ''}
	                    </c:forEach>
	                ],
	                datasets: [{
	                    label: '취득 점수',
	                    data: [
	                        <c:forEach items="${result.endList}" var="e" end="3" varStatus="status">
	                            ${e.erScore}${!status.last ? ',' : ''}
	                        </c:forEach>
	                    ],
	                    backgroundColor: [
	                        <c:forEach items="${result.endList}" var="e" end="3" varStatus="status">
	                            '${e.erScore >= 60 ? "#28a745" : "#dc3545"}'${!status.last ? ',' : ''}
	                        </c:forEach>
	                    ],
	                    borderRadius: 6,
	                    borderSkipped: false,
	                    categoryPercentage: 0.3, 
	                    barPercentage: 0.8
	                }]
	            },
	            options: {
	                responsive: true,
	                maintainAspectRatio: false,
	                plugins: { legend: { labels: { font: { weight: '600' } } } },
	                scales: {
	                    y: { beginAtZero: true, max: 100, grid: { color: '#f1f5f9' } },
	                    x: { grid: { display: false } }
	                }
	            }
	        });
	
	        // ── 2. 미니 캘린더 ────────────────────────────────────
	        const miniCalendar = new FullCalendar.Calendar(document.getElementById('mini-calendar'), {
	            initialView: 'dayGridMonth',
	            locale: 'ko',
	            height: '100%',
	            headerToolbar: { left: 'prev', center: 'title', right: 'next' },
	            dayCellContent: (info) => info.date.getDate(),
	            events: loadEvents(),
	            dateClick: function() { $('#calendarModal').modal('show'); },
	            eventClick: function() { $('#calendarModal').modal('show'); }
	        });
	        miniCalendar.render();
	
	        // ── 3. 풀 캘린더 ─────────────────────────────────────
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
	                select: function(info) {
	                    const startLabel = info.startStr.slice(0,10);
	                    const endDate   = new Date(info.end); endDate.setDate(endDate.getDate()-1);
	                    const endLabel  = endDate.toISOString().slice(0,10);
	                    const dateLabel = startLabel === endLabel ? startLabel : startLabel + ' ~ ' + endLabel;
	                    Swal.fire({
	                        title: '<span style="font-size:18px; font-weight:800; color:#0e506e;">새 일정 추가</span>',
	                        html: '<div style="font-size:12px; color:#64748b; margin-bottom:8px;"><i class="fa-solid fa-calendar-day" style="color:#0e506e;"></i> ' + dateLabel + '</div>',
	                        input: 'text',
	                        inputPlaceholder: '일정 제목을 입력하세요',
	                        inputAttributes: { maxlength: 30 },
	                        showCancelButton: true,
	                        confirmButtonColor: '#0e506e',
	                        confirmButtonText: '<i class="fa-solid fa-plus"></i> 추가',
	                        cancelButtonText: '취소',
	                        didOpen: () => {
	                            const input = Swal.getInput();
	                            input.style.cssText = 'border-radius:8px; border:1.5px solid #cbd5e1; font-size:14px; padding:10px 14px; box-sizing:border-box;';
	                        }
	                    }).then((result) => {
	                        if (result.isConfirmed && result.value && result.value.trim()) {
	                            fullCalendar.addEvent({
	                                id: Date.now().toString(),
	                                title: result.value.trim(),
	                                start: info.startStr,
	                                end: info.endStr,
	                                allDay: info.allDay,
	                                color: '#0e506e'
	                            });
	                        }
	                        fullCalendar.unselect();
	                    });
	                },
	                eventClick: function(info) {
	                    const startStr = info.event.startStr ? info.event.startStr.slice(0,10) : '';
	                    Swal.fire({
	                        title: '<span style="font-size:16px; font-weight:800; color:#1e293b;">일정 삭제</span>',
	                        html: '<div style="margin:10px 0;"><div style="background:#fef2f2; border-radius:8px; padding:12px; margin-bottom:8px;"><div style="font-weight:700; color:#dc3545; font-size:14px;">' + info.event.title + '</div>' + (startStr ? '<div style="font-size:12px; color:#94a3b8; margin-top:3px;"><i class="fa-solid fa-calendar"></i> ' + startStr + '</div>' : '') + '</div><div style="font-size:12px; color:#64748b;">이 일정을 삭제하면 복구할 수 없습니다.</div></div>',
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
	
	        document.getElementById('saveBtn').addEventListener('click', function() {
	            if (!fullCalendar) return;
	            const currentEvents = fullCalendar.getEvents().map(e => ({
	                id: e.id || Date.now().toString(),
	                title: e.title,
	                start: e.startStr,
	                end: e.endStr || null,
	                allDay: e.allDay,
	                color: '#0e506e'
	            }));
	            saveEvents(currentEvents);
	            miniCalendar.getEvents().forEach(e => e.remove());
	            currentEvents.forEach(e => miniCalendar.addEvent(e));
	            $('#calendarModal').modal('hide');
	            setTimeout(() => {
	                Swal.fire({ icon: 'success', title: '저장 완료!', timer: 2000, showConfirmButton: false, toast: true, position: 'top-end' });
	            }, 300);
	        });
	
	        $('#calendarModal').on('shown.bs.modal', function() { buildFullCalendar(); });
	        $('#calendarModal').on('hidden.bs.modal', function() {
	            if (fullCalendar) { fullCalendar.destroy(); fullCalendar = null; }
	        });
	    });
	    </script>
	</body>
	</html>
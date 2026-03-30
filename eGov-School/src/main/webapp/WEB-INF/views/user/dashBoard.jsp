<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/style.css" />
    <%@include file="../modules/userHeader.jsp" %>
    <title>Dashboard</title>
    <style>
        /* 수강 중인 강좌 섹션 스타일 */
        .section-header {
            border-bottom: 2px solid #0e506e;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .course-card-custom {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid #eee;
            transition: transform 0.3s ease;
        }
        .course-card-custom:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body>   
    <div class="mid">
        <div class="container-fluid">
            
            <div class="section-header">
                <h4 class="section-title" style="font-weight: bold; color: #0e506e; margin: 0;">
                    <i class="fa-solid fa-book-open-reader mr-2"></i>수강 중인 강좌
                </h4>
            </div>

            <div class="card_wrap">
                <div class="row">
                    <c:choose>
                        <%-- 데이터가 없을 경우 --%>
                        <c:when test="${empty result.applyList}">
                            <div class="col-12 text-center" style="padding: 80px 0; color: #888;">
                                <i class="fa-solid fa-folder-open mb-3" style="font-size: 40px; display: block;"></i>
                                수강 중인 강좌 내역이 없습니다.
                            </div>
                        </c:when>
                        
                        <%-- 데이터가 있을 경우 반복 출력 --%>
                        <c:otherwise>
                            <c:forEach items="${result.applyList}" var="apply" end="2">
                                <div class="col-md-4 mb-4">
                                    <div class="course-card-custom shadow-sm">
                                        <div class="card-thumb-area" style="position: relative; height: 180px; overflow: hidden;">
                                            <div class="inner-rect" style="position: absolute; top: 10px; left: 10px; z-index: 2; background: #ff4757; color: #fff; padding: 2px 8px; border-radius: 4px; font-size: 11px; font-weight: bold;">ING</div>
                                            <img src="${pageContext.request.contextPath}/resources/imgs/lope.png" class="thumb-img" style="width: 100%; height: 100%; object-fit: cover;">
                                            <div class="thumb-overlay">
                                                <span class="view-text">상세보기</span>
                                            </div>
                                        </div>
                                        <div class="card-body-area" style="padding: 20px;">
                                            <h3 class="course-name" style="font-size: 18px; font-weight: bold; color: #333; margin-bottom: 15px;">${apply.claName}</h3>
                                            <div class="progress-wrapper">
                                                <div class="progress-text" style="display: flex; justify-content: space-between; font-size: 13px; margin-bottom: 8px;">
                                                    <span style="color: #666;">학습 진행률</span>
                                                    <strong style="color: #0e506e;">${apply.progress}%</strong>
                                                </div>
                                                <div class="progress" style="height: 10px; background-color: #f0f0f0; border-radius: 5px;">
                                                    <div class="progress-bar progress-bar-striped progress-bar-animated ${apply.progress >= 80 ? 'bg-success' : 'bg-primary'}"
                                                        style="width: ${apply.progress}%;"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="button-area" style="padding: 0 20px 20px;">
                                            <button class="btn btn-block" 
                                                    style="background: #0e506e; color: #fff; font-weight: bold; padding: 10px; border-radius: 6px;"
                                                    onclick="location.href='${pageContext.request.contextPath}/user/videolect?claNum=${apply.claNum}'">
                                                학습하기 | 이어하기
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-sm-8">
                    <div class="result-card card card-outline card-navy">
                        <div class="card-header"><h3 class="card-title" style="font-weight: 600;">최근 평가 결과</h3></div>
                        <div class="card-body result-flex-box">
                            <div class="chart-area"><div style="height: 300px;"><canvas id="evaluationChart"></canvas></div></div>
                            <div class="status-panel">
                                <div class="status-header">과목별 상태</div>
                                <ul id="evaluationStatusList"></ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div id="mini-calendar"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title font-weight-bold">전체 일정 관리</h5>
                    <button type="button" class="close text-white" data-dismiss="modal"><span>&times;</span></button>
                </div>
                <div class="modal-body"><div id="full-calendar"></div></div>
                <div class="modal-footer">
                    <p class="mr-auto text-muted"><small>* 날짜 클릭/드래그로 추가, 일정 클릭으로 삭제</small></p>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" id="saveCalendarBtn">저장하기</button>
                </div>
            </div>
        </div>
    </div>

    <script>
    if (window.jQuery && $.fn.modal) {
        $.fn.modal.Constructor.prototype._enforceFocus = function() {};
    }

    var miniCalendar, fullCalendar;
    var calendarEvents = JSON.parse(localStorage.getItem('dashEvents')) || [{ title: '강좌 마감', start: '2026-03-20', color: '#f39c12' }];

    $(document).ready(function() {
        // 그래프 데이터 및 초기화 (수정 없음)
        var evaluationData = [
            { subject: '자바 프로그래밍', score: 85, status: 'pass', rank: 5.2 },
            { subject: '데이터베이스', score: 55, status: 'fail', rank: null },
            { subject: '웹 퍼블리싱', score: 92, status: 'pass', rank: 2.1 },
            { subject: '알고리즘', score: 40, status: 'fail', rank: null }
        ];

        var ctx = document.getElementById('evaluationChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: evaluationData.map(function(d) { return d.subject; }),
                datasets: [{ 
                    label: '점수', 
                    data: evaluationData.map(function(d) { return d.score; }), 
                    borderColor: '#0e506e',
                    backgroundColor: 'rgba(14, 80, 110, 0.1)',
                    borderWidth: 3,
                    pointBackgroundColor: '#fff',
                    pointBorderColor: '#0e506e',
                    pointRadius: 5,
                    fill: true,
                    tension: 0.3
                }]
            },
            options: { maintainAspectRatio: false, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, max: 100 } } }
        });

        var statusHtml = "";
        for(var i=0; i<evaluationData.length; i++) {
            var item = evaluationData[i];
            var isPass = (item.status === 'pass');
            statusHtml += '<li class="status-item"><span class="subject-name">' + item.subject + '</span><div class="status-row"><div class="status-left"><span class="square ' + (isPass ? 'pass' : 'fail') + '"></span><span class="status-text">' + (isPass ? '합격' : '불합격') + '</span></div>' + (isPass ? '<span class="rank-badge">상위 ' + item.rank + '%</span>' : '<button class="btn-retake" onclick="retakeCourse(\'' + item.subject + '\')">재수강</button>') + '</div></li>';
        }
        $("#evaluationStatusList").html(statusHtml);

        // 캘린더 초기화 (수정 없음)
        miniCalendar = new FullCalendar.Calendar(document.getElementById('mini-calendar'), {
            initialView: 'dayGridMonth',
            locale: 'ko',
            height: 480,
            dayCellContent: function(info) { return { html: info.dayNumberText.replace('일', '') }; },
            events: calendarEvents,
            dateClick: function() { $('#calendarModal').modal('show'); }
        });
        miniCalendar.render();

        fullCalendar = new FullCalendar.Calendar(document.getElementById('full-calendar'), {
            initialView: 'dayGridMonth',
            locale: 'ko',
            height: 650,
            selectable: true,
            editable: true,
            events: JSON.parse(JSON.stringify(calendarEvents)),
            select: function(info) {
                Swal.fire({
                    title: '일정 추가',
                    input: 'text',
                    inputPlaceholder: '내용을 입력하세요',
                    showCancelButton: true
                }).then(function(result) {
                    if (result.value) {
                        fullCalendar.addEvent({ title: result.value, start: info.startStr, end: info.endStr, allDay: info.allDay, backgroundColor: '#28a745', borderColor: '#28a745' });
                    }
                    fullCalendar.unselect();
                });
            },
            eventClick: function(info) {
                Swal.fire({
                    title: '일정 삭제',
                    text: '"' + info.event.title + '" 일정을 삭제할까요?',
                    icon: 'warning',
                    showCancelButton: true
                }).then(function(result) {
                    if (result.isConfirmed) { info.event.remove(); }
                });
            }
        });

        $('#calendarModal').on('shown.bs.modal', function () {
            fullCalendar.render();
            fullCalendar.updateSize();
        });

        $('#saveCalendarBtn').on('click', function() {
            var newEvents = fullCalendar.getEvents().map(function(e) {
                return { title: e.title, start: e.startStr, end: e.endStr, backgroundColor: e.backgroundColor };
            });
            localStorage.setItem('dashEvents', JSON.stringify(newEvents));
            calendarEvents = newEvents;
            miniCalendar.removeAllEvents();
            miniCalendar.addEventSource(calendarEvents);
            $('#calendarModal').modal('hide');
            Swal.fire('저장 성공', '대시보드에 반영되었습니다.', 'success');
        });
    });
    
    function retakeCourse(name) { Swal.fire(name + ' 재수강 신청 완료'); }
    </script>
</body>
</html>
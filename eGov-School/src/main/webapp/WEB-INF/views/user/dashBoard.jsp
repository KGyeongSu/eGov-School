<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <link type="text/css" rel="stylesheet" href="../../../resources/css/user/style.css" />
    <%@include file="../modules/userHeader.jsp" %>
    <title>Dashboard</title>
</head>
<body>
    <div class="mid">
        <div class="container-fluid">
            <h4 class="section-title">진행중인 강좌</h4>
            <div class="row">
                <div class="col-md-4">
                    <div class="card course-card-v2">
                        <div class="course-img-wrapper">
                            <img src="../../../resources/imgs/lope.png" class="course-img">
                            <div class="course-overlay"><button class="btn-play" onclick="location.href='#'"><i class="fas fa-play"></i> 학습하기</button></div>
                        </div>
                        <div class="card-body">
                            <h3 class="course-title">자바 프로그래밍</h3>
                            <div class="course-status-text"><span>학습 진행률</span><span class="percent-text">65%</span></div>
                            <div class="progress custom-progress-v2"><div class="progress-bar" style="width:65%"></div></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card course-card-v2">
                        <div class="course-img-wrapper">
                            <img src="../../../resources/imgs/lope.png" class="course-img">
                            <div class="course-overlay"><button class="btn-play" onclick="location.href='#'"><i class="fas fa-play"></i> 학습하기</button></div>
                        </div>
                        <div class="card-body">
                            <h3 class="course-title">데이터베이스</h3>
                            <div class="course-status-text"><span>학습 진행률</span><span class="percent-text">40%</span></div>
                            <div class="progress custom-progress-v2"><div class="progress-bar bg-warning" style="width:40%"></div></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card course-card-v2">
                        <div class="course-img-wrapper">
                            <img src="../../../resources/imgs/lope.png" class="course-img">
                            <div class="course-overlay"><button class="btn-play" onclick="location.href='#'"><i class="fas fa-play"></i> 학습하기</button></div>
                        </div>
                        <div class="card-body">
                            <h3 class="course-title">웹 퍼블리싱</h3>
                            <div class="course-status-text"><span>학습 진행률</span><span class="percent-text">85%</span></div>
                            <div class="progress custom-progress-v2"><div class="progress-bar bg-success" style="width:85%"></div></div>
                        </div>
                    </div>
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
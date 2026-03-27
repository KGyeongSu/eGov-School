<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../modules/lecHeader.jsp"%>

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
				<a href=""><i class="fa-regular fa-user"></i></a>
			</div>
			<div class="state_bar">
				<p>???님의 메인 대시보드</p>
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
		<div class="mid">
			<div class="container-fluid">
				<h4 class="section-title">진행중인 강좌</h4>
				<div class="row">
					<div class="col-md-4">
						<div class="card course-card-v2">
							<div class="course-img-wrapper">
								<img src="../../../resources/imgs/lope.png" class="course-img">
								<div class="course-overlay">
									<button class="btn-play" onclick="location.href='#'">
										<i class="fas fa-cloud-upload-alt"></i> 강좌 업로드
									</button>
								</div>
							</div>
							<div class="card-body">
								<h3 class="course-title">자바 프로그래밍</h3>
								<div class="course-status-text">
									<span>등록 강좌율</span><span class="percent-text">65%</span>
								</div>
								<div class="progress custom-progress-v2">
									<div class="progress-bar" style="width: 65%"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card course-card-v2">
							<div class="course-img-wrapper">
								<img src="../../../resources/imgs/lope.png" class="course-img">
								<div class="course-overlay">
									<button class="btn-play" onclick="location.href='#'">
										<i class="fas fa-cloud-upload-alt"></i>강좌 업로드
									</button>
								</div>
							</div>
							<div class="card-body">
								<h3 class="course-title">데이터베이스</h3>
								<div class="course-status-text">
									<span>등록 강좌율</span><span class="percent-text">40%</span>
								</div>
								<div class="progress custom-progress-v2">
									<div class="progress-bar bg-warning" style="width: 40%"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card course-card-v2">
							<div class="course-img-wrapper">
								<img src="../../../resources/imgs/lope.png" class="course-img">
								<div class="course-overlay">
									<button class="btn-play" onclick="location.href='#'">
										<i class="fas fa-cloud-upload-alt"></i> 강좌 업로드
									</button>
								</div>
							</div>
							<div class="card-body">
								<h3 class="course-title">웹 퍼블리싱</h3>
								<div class="course-status-text">
									<span>등록 강좌율</span><span class="percent-text">85%</span>
								</div>
								<div class="progress custom-progress-v2">
									<div class="progress-bar bg-success" style="width: 85%"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="bot">
			<div class="container-fluid">
				<h4 class="section-title">최근 출제한 평가</h4>
				<div class="row">
					<div class="col-sm-6">
						<div class="card" style="height: 380px">
							<div class="card-header">
								<h3 class="card-title">출제 목록</h3>

								<div class="card-tools">
									<ul class="pagination pagination-sm float-right">
										<li class="page-item"><a class="page-link" href="#">«</a></li>
										<li class="page-item"><a class="page-link" href="#">1</a></li>
										<li class="page-item"><a class="page-link" href="#">2</a></li>
										<li class="page-item"><a class="page-link" href="#">3</a></li>
										<li class="page-item"><a class="page-link" href="#">»</a></li>
									</ul>
								</div>
							</div>
							<!-- /.card-header -->
							<div class="card-body p-0">
								<table class="table">
									<thead>
										<tr>
											<th style="width: 10px">no.</th>
											<!-- 1. 여기 너비를 넓히면 나머지가 오른쪽으로  -->
											<th style="width: 50%">강좌명</th>
											<th style="text-align: left;">응시율</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1.</td>
											<td>Update software</td>
											<!-- 2. 막대기와 배지를 한 칸(td)에 넣고 flex로 정렬합니다 -->
											<td>
												<div style="display: flex; align-items: center;">
													<div class="progress progress-xs"
														style="flex: 1; margin-right: 15px; margin-bottom: 0;">
														<div class="progress-bar progress-bar-danger"
															style="width: 55%"></div>
													</div>
													<span class="badge bg-danger">55%</span>
												</div>
											</td>
										</tr>
										<tr>
											<td>2.</td>
											<td>Clean database</td>
											<td>
												<div style="display: flex; align-items: center;">
													<div class="progress progress-xs"
														style="flex: 1; margin-right: 15px; margin-bottom: 0;">
														<div class="progress-bar bg-warning" style="width: 70%"></div>
													</div>
													<span class="badge bg-warning">70%</span>
												</div>
											</td>
										</tr>
										<tr>
											<td>3.</td>
											<td>Cron job running</td>
											<td>
												<div style="display: flex; align-items: center;">
													<div class="progress progress-xs progress-striped active"
														style="flex: 1; margin-right: 15px; margin-bottom: 0;">
														<div class="progress-bar bg-primary" style="width: 30%"></div>
													</div>
													<span class="badge bg-primary">30%</span>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- /.card-body -->
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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>

<script>
	
document.addEventListener('DOMContentLoaded', function() {
	
	   if (window.jQuery && $.fn.modal) {
	        $.fn.modal.Constructor.prototype._enforceFocus = function() {};
	    }
	
    // 1. 전역 변수 설정 (데이터 공유용)
    let newEvents = []; 

    // 2. 작은 캘린더 (대시보드 메인)
    const miniEl = document.getElementById('mini-calendar');
    const miniCalendar = new FullCalendar.Calendar(miniEl, {
        initialView: 'dayGridMonth',
        locale: 'ko',
        headerToolbar: { left: 'prev', center: 'title', right: 'next' },
        height: '112%', 
        expandRows: true,
        dayCellContent: (info) => info.date.getDate(),
        // 날짜 클릭 시 모달 열기
        dateClick: function() { 
            $('#calendarModal').modal('show'); 
        },
        events: [{ title: '기존 일정', start: '2026-03-20', color: '#f39c12' }]
    });
    miniCalendar.render();

    // 3. 큰 캘린더 (모달 안쪽)
    const fullEl = document.getElementById('full-calendar');
    const fullCalendar = new FullCalendar.Calendar(fullEl, {
        initialView: 'dayGridMonth',
        locale: 'ko',
        selectable: true, // [중요] 이게 있어야 드래그/클릭 선택이 됩니다
        headerToolbar: { left: 'prev,next today', center: 'title', right: 'dayGridMonth,listWeek' },
        dayCellContent: (info) => info.date.getDate(),
        
        // 날짜를 선택(클릭)했을 때 실행
        select: function(info) {
            Swal.fire({
                title: '새 일정 등록',
                input: 'text',
                inputLabel: '일정 제목을 입력하세요',
                showCancelButton: true,
                confirmButtonColor: '#1a6d91',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed && result.value) {
                    const eventData = {
                        title: result.value,
                        start: info.startStr,
                        end: info.endStr,
                        allDay: info.allDay,
                        color: '#1a6d91'
                    };
                    
                    // 큰 캘린더에 즉시 표시 (미리보기)
                    fullCalendar.addEvent(eventData);
                    // 임시 배열에 저장 (나중에 한꺼번에 저장 버튼으로 처리)
                    newEvents.push(eventData);
                }
                fullCalendar.unselect(); // 선택 해제
            });
        }
    });

    // 4. 저장 버튼 클릭 시 (작은 캘린더로 전송)
    document.getElementById('saveBtn').addEventListener('click', function() {
        if (newEvents.length === 0) {
            Swal.fire('알림', '추가할 일정이 없습니다.', 'info');
            return;
        }

        // 임시 저장된 모든 일정을 작은 캘린더에 추가
        newEvents.forEach(event => {
            miniCalendar.addEvent(event);
        });

        // 초기화
        newEvents = [];
        
        Swal.fire({
            icon: 'success',
            title: '저장 완료',
            text: '대시보드 캘린더에 반영되었습니다.',
            timer: 1500
        });
        
        $('#calendarModal').modal('hide'); // 모달 닫기
    });

    // 모달이 열릴 때 캘린더 크기 재조정 (안 하면 깨짐)
    $('#calendarModal').on('shown.bs.modal', function () {
        fullCalendar.render();
        fullCalendar.updateSize();
    });
});
	
</script>

</html>
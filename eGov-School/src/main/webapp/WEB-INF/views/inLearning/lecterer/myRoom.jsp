<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../modules/lecHeader.jsp"%>
<!-- 개별 css -->
<link type="text/css" rel="stylesheet"
	href="../../../resources/css/lecterer/styler.css" />

<title>inlearning_lDashboard</title>

</head>

<body>
	<div class="content">
		<div class="top">
			<div class="icon">
				<a href=""><i class="fa-regular fa-user"></i></a>
			</div>
			<div class="state_bar">
				<p>My 강의실</p>
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
		<div class="mid" style="margin-top: 20px;">
			<div class="container-fluid">
				<!-- 상단 타이틀 영역 -->
				<div class="d-flex justify-content-between align-items-center mb-3"
					style="height: 55px; margin-bottom: 20px !important;">
					<h5 style="margin: 0; font-weight: 600;">진행 중인 강의</h5>
					<button type="button" class="btn btn-add-room"
						style="width: 200px; height: 50px;">
						<i class="fa-solid fa-plus mr-1"></i> 강의실 등록
					</button>
				</div>

				<!-- 카드 리스트 영역: row 하나만 유지 -->
				<div class="row">
					<%-- <c:forEach var="course" items="${courseList}"> --%>

					<div class="col-md-4 mb-4">
						<div class="card course-card-v2">
							<!-- 이미지 영역 -->
							<div class="course-img-wrapper">
								<img src="../../../resources/imgs/jun.jpg" class="course-img">
								<div class="course-overlay">
									<button class="btn-play" onclick="location.href='#'">
										<i class="fas fa-arrow-right"></i> 강의실 바로가기
									</button>
								</div>
							</div>

							<!-- 카드 내용 -->
							<div class="card-body">
								<h3 class="course-title">강의 제목</h3>

								<div class="course-status-text">
									<span>등록 강좌율</span> <span class="percent-text">65%</span>
								</div>

								<div class="progress custom-progress-v2">
									<div class="progress-bar" style="width: 65%"></div>
								</div>
							</div>
						</div>
					</div>

					<%-- </c:forEach> --%>
				</div>
				<!-- row 끝 -->
			</div>
		</div>
		<div class="pagination_wrapper">
			<!-- pagination -->
			<%@ include file="/WEB-INF/views/modules/pagination.jsp"%>
		</div>
	</div>
</body>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		<div class="mid" style="margin-top: 0px !important;">
			<div class="container-fluid">
				<!-- 상단 타이틀 영역 -->
				<div class="d-flex justify-content-between align-items-center mb-3"
					style="height: 55px; margin-bottom: 50px !important;">
					<h5 style="margin: 0; font-size: 25px; font-weight: 600;">진행 중인 강의</h5>
					<button type="button" class="btn btn-add-room"
						style="width: 200px; height: 50px;" onclick="OpenWindow('makeRoom', 'makeRoom', 1000, 700);">
						<i class="fa-solid fa-plus mr-1"></i> 강의실 등록
					</button>
				</div>
				<div id="userListArea">
					<!-- 카드 리스트 영역: row 하나만 유지 -->
					<div class="row">
						<c:choose>
							<c:when test="${empty classList}">
								<div class="col-12 text-center">
									<p>현재 진행 중인 강좌가 없습니다.</p>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach items="${classList}" var="classs">
									<div class="col-md-4" style="margin-bottom: 20px;">
										<div class="card course-card-v2">
											<div class="course-img-wrapper">
												<img
													src="${not empty classs.claThumb ? classs.claThumb : '/resources/images/default.jpg'}"
													class="course-img">
												<div class="course-overlay">
													<button class="btn-play" onclick="go_roomDetail('${classs.claNum}', '${classs.claTitle}');">
														<i class="fas fa-cloud-upload-alt"></i> 강좌 업로드
													</button>
												</div>
											</div>
											<div class="card-body">
												<h3 class="course-title" style="display: flex !important; align-items: center; justify-content: space-between;">${classs.claTitle}
													<c:choose>
            											<c:when test="${classs.claStatus eq '승인완료'}">
                											<span style="margin-left: auto; background-color: #e6f4ea; color: #1e7e34; font-size: 11px; padding: 3px 10px; border-radius: 50px; font-weight: 600; border: 1px solid #c3e6cb;">
                    											승인완료
                											</span>
            											</c:when>
            											<c:when test="${classs.claStatus eq '승인대기'}">
               												<span style="margin-left: auto; background-color: #f1f3f5; color: #6c757d; font-size: 11px; padding: 3px 10px; border-radius: 50px; font-weight: 600; border: 1px solid #dee2e6;">
                    											승인대기
                											</span>
											            </c:when>
											        </c:choose>
												</h3>
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
					<!-- row 끝 -->
					<!-- pagination -->
					<div class="pagination_wrapper" style="margin-top: 50px !important;">
						<%@ include file="/WEB-INF/views/modules/pagination.jsp"%>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="/resources/js/commons.js"></script>

<script>

function go_roomDetail (claNum, claTitle) {
	
	alert (claTitle + " 강의실로 이동합니다.");
	location.href="/lecterer/roomDetail?claNum=" + claNum;
	
}

</script>

</html>
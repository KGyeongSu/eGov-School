<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../modules/lecHeader.jsp"%>

<!-- 개별 css -->
<link type="text/css" rel="stylesheet"
	href="../../../resources/css/lecterer/styleroomManage.css" />
<!-- font awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>roomManage</title>
</head>

<body>
	<div class="content">
		<div class="top">
			<div class="icon">
				<a href=""><i class="fa-regular fa-user"></i></a>
			</div>
			<div class="state_bar">
				<p>
					My 강의실 > <strong style="font: '나눔 고딕'; font-size: 17px;">&nbsp;&nbsp;${roomDetail.claTitle}</strong>
				</p>
			</div>
			<div class="logout_dash">
				<div class="mes" onclick="location.href='reputationHome';" style="cursor: pointer; position: relative; display: inline-block;">
				    <i class="fa-regular fa-envelope"></i>
				    <span id="repBadge" style="position: absolute; top: 5px; right: 50px; background-color: #dc3545; color: white; font-size: 10px; font-weight: bold; padding: 2px 6px; border-radius: 50%; display: none; border: 2px solid white;">
				    	0
				    </span>
				</div>
				<div class="out">
					<button type="button" class="btn btn-sm"
						style="background-color: #1a6d91; color: white; border-radius: 4px; font-size: 12px; border: none; line-height: 1;">로그아웃
					</button>
				</div>
			</div>
		</div>
		<div class="divider">
			<div class="upload">
				<a href="/lecterer/roomDetail?claNum=${roomDetail.claNum}">
					<h2>강의 등록</h2>
				</a>
			</div>
			<div class="manage">
				<a href="/lecterer/roomManage?claNum=${roomDetail.claNum}">
					<h2>사용자 관리</h2>
				</a>
			</div>
		</div>

		<div class="center">
			<div class="left">
				<h2 style="font-size: 20px; font-weight: 600;">전체 학습자 진도율</h2>
				<div class="per">
					<div class="chart1"
						style="width: 780px; height: 300px; margin: 0px auto; margin-top: 20px; background: #fff; padding: 20px; border-radius: 8px; border: 1px solid #d1d1d1; box-sizing: border-box;">
						<canvas id="chart1"></canvas>
					</div>
					<span
						style="margin-top: 15px !important; margin-bottom: 15px !important;">강좌별 진도율</span>
				</div>
				<div class="per">
					<div class="chart2"
						style="width: 780px; height: 300px; margin: 0px auto; background: #fff; padding: 20px; border-radius: 8px; border: 1px solid #d1d1d1; box-sizing: border-box;">
						<canvas id="chart2"></canvas>
					</div>
					<span>전체 차시 대비 진도율</span>
				</div>
			</div>
			<div class="right" >
				<h2 style="font-size: 20px; font-weight: 600;">사용자 관리</h2>
				<!-- 검색 영역 -->
				<div class="search_area"
					style="display: flex; gap: 10px; margin-top: 30px; margin-bottom: 20px; margin-left: 10px; width: 96%;">
					<div style="position: relative; flex: 1;">
						<i class="fa-solid fa-magnifying-glass"
							style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #adb5bd; font-size: 14px;"></i>
						<input type="text" id="keywordInput" value="${pageMaker.keyword}" placeholder="사용자 이름 또는 ID 검색" onkeyup="if(window.event.keyCode==13){search_list(1)}"
							style="width: 100%; padding: 10px 10px 10px 35px; border: 1px solid #d1d1d1; border-radius: 6px; font-size: 14px; outline: none; box-sizing: border-box;">
					</div>
					<button type="button" onclick="search_list(1);"
						style="background-color: #0e506e; color: white; border: none; padding: 0 20px; border-radius: 6px; cursor: pointer; font-size: 14px; font-weight: 500;">검색</button>
				</div>
				<div id="userListArea">
					<!-- 리스트 테이블 -->
					<div class="user_list_container" id="userListArea"
						style="background: #fff; border: 1px solid #d1d1d1; border-radius: 8px; overflow: hidden; width: 96%; margin-left: 10px; min-height: 560px;">
						<table
							style="width: 100%; border-collapse: collapse; text-align: left; font-size: 14px;">
							<thead>
								<tr
									style="background-color: #f8f9fa; border-bottom: 1px solid #dee2e6; color: #495057;">
									<th style="padding: 12px 15px; font-weight: 600;">이름 (ID)</th>
									<th style="padding: 12px 15px; font-weight: 600;">진도율</th>
									<th style="padding: 12px 15px; font-weight: 600;">최근 학습일</th>
									<th
										style="padding: 12px 15px; font-weight: 600; text-align: center;">상태</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty studentList}">
										<c:forEach var="student" items="${studentList}" varStatus="vs">
										    <tr style="border-bottom: 1px solid #f1f1f1; transition: background 0.2s;">
										        <td style="padding: 12px 15px;">
										            <div style="font-weight: 500; color: #212529;">${student.userName}</div>
										            <div style="font-size: 12px; color: #868e96;">${student.userEmail}</div>
										        </td>
										        <td style="padding: 12px 15px;">
										            <c:set var="fakeProgress" value="${90 - (vs.index * 7)}" />
										            <c:if test="${fakeProgress < 10}"><c:set var="fakeProgress" value="12" /></c:if>
										            
										            <div style="width: 100px; background: #e9ecef; height: 6px; border-radius: 3px; position: relative;">
										                <div style="width: ${fakeProgress}%; background: #27ae60; height: 100%; border-radius: 3px;"></div>
										            </div> 
										            <span style="font-size: 12px; color: #27ae60; font-weight: bold;">${fakeProgress}%</span>
										        </td>
										        <td style="padding: 12px 15px; color: #495057;">
										            2026.04.0${(vs.index % 9) + 1}
										        </td>
										        <td style="padding: 12px 15px; text-align: center;">
										            <c:choose>
										                <c:when test="${vs.index % 3 == 0}">
										                    <span style="background: #e7f5ff; color: #228be6; padding: 4px 8px; border-radius: 4px; font-size: 11px; font-weight: bold;">학습중</span>
										                </c:when>
										                <c:otherwise>
										                    <span style="background: #fff4e6; color: #fd7e14; padding: 4px 8px; border-radius: 4px; font-size: 11px; font-weight: bold;">미접속</span>
										                </c:otherwise>
										            </c:choose>
										        </td>
										    </tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="4" style="padding: 30px; text-align: center; color: #868e96;">
												수강 중인 학생이 없습니다.
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					<div class="pagination_wrapper">
						<!-- pagination -->
						<%@ include file="/WEB-INF/views/modules/pagination.jsp"%>
					</div>
				</div>	
			</div>
		</div>
	</div>
</body>

<script src="/resources/js/commons.js"></script>

<script>

	// 가변 데이터를 생성하는 함수 (최솟값, 최댓값, 개수)
	function getRandomData(min, max, count) {
	    return Array.from({ length: count }, () => Math.floor(Math.random() * (max - min + 1)) + min);
	}
	
	// 차트 1: 강좌별 진도율
	const ctx1 = document.getElementById('chart1').getContext('2d');
	const chart1Data = getRandomData(40, 95, 5); // 40~95 사이의 랜덤 숫자 5개 생성
	
	new Chart(ctx1, {
	    type: 'bar',
	    data: {
	        labels: [ '1강', '2강', '3강', '4강', '5강' ], 
	        datasets: [ {
	            label: '전체 학습자 평균',
	            data: [ 65, 65, 65, 65, 65 ], 
	            backgroundColor: '#e9ecef',
	            barPercentage: 0.6,
	        }, {
	            label: '현재 강좌 진도율',
	            data: chart1Data, // 랜덤 생성된 데이터 적용
	            backgroundColor: '#0e506e',
	            borderRadius: 4,
	            barPercentage: 0.6,
	        } ]
	    },
	    options: {
	        responsive: true,
	        maintainAspectRatio: false,
	        scales: {
	            y: { beginAtZero: true, max: 100, ticks: { callback: v => v + '%' } },
	            x: { grid: { display: false } }
	        },
	        plugins: { legend: { position: 'top', align: 'end' } }
	    }
	});
	
	// 차트 2: 전체 차시 대비 진도율
	const ctx2 = document.getElementById('chart2').getContext('2d');
	const chart2Data = getRandomData(30, 90, 5); // 두 번째 차트용 랜덤 데이터
	
	new Chart(ctx2, {
	    type: 'bar',
	    data: {
	        labels: [ '1강', '2강', '3강', '4강', '5강' ],
	        datasets: [ {
	            label: '전체 차시',
	            data: [ 100, 100, 100, 100, 100 ],
	            backgroundColor: '#d1d8e0',
	            barPercentage: 0.6,
	        }, {
	            label: '진도율',
	            data: chart2Data, // 랜덤 생성된 데이터 적용
	            backgroundColor: '#27ae60',
	            borderRadius: 4,
	            barPercentage: 0.6,
	        } ]
	    },
	    options: {
	        responsive: true,
	        maintainAspectRatio: false,
	        scales: {
	            y: { beginAtZero: true, max: 100, ticks: { callback: v => v + '%' } },
	            x: { grid: { display: false } }
	        },
	        plugins: { legend: { position: 'top', align: 'end' } }
	    }
	});
	
	$(document).ready(function() {
    	
        // 알림 배지 초기 로드 및 1분마다 갱신
        updateReputationAlarm();
        setInterval(updateReputationAlarm, 60000);
        
    });

    // 알림 배지 AJAX 함수
    function updateReputationAlarm() {
        $.ajax({
            url: '${pageContext.request.contextPath}/lecterer/reputationAlarm',
            type: 'GET',
            success: function(count) {
                const badge = $('#repBadge');
                if (count > 0) {
                    badge.text(count).show();
                } else {
                    badge.hide();
                }
            }
        });
    }
        
    </script>
</html>
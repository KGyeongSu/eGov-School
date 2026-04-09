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
				<a href="${pageContext.request.contextPath }/lecterer/mainDashBoard"><i class="fa-regular fa-user"></i></a>
			</div>
			<div class="state_bar">
				<a href="${pageContext.request.contextPath }/lecterer/myRoom">
					<p>
						My 강의실 > <strong style="font: '나눔 고딕'; font-size: 17px;">&nbsp;&nbsp;${roomDetail.claTitle}</strong>
					</p>
				</a>
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
					<h2>수강생 관리</h2>
				</a>
			</div>
		</div>

		<div class="center">
			<div class="left">
			    <h2 style="font-size: 20px; font-weight: 600;">학습 데이터</h2>
			    
			    <div class="per">
			        <div class="chart1" style="width: 780px; height: 285px; margin: 0px auto; margin-top: 20px; background: #fff; padding: 20px; border-radius: 8px; border: 1px solid #d1d1d1; box-sizing: border-box;">
			            <canvas id="chart1"></canvas>
			        </div>
			        <span style="margin-top: 15px !important; margin-bottom: 18px !important;">평균 진도율</span>
			    </div>
			
			    <div class="per">
			        <div class="chart2" style="width: 780px; height: 285px; margin: 0px auto; background: #fff; padding: 10px; border-radius: 8px; border: 1px solid #d1d1d1; box-sizing: border-box;">
			            <canvas id="chart2"></canvas>
			        </div>
			        <span style="margin-top: 15px !important;">수강생 시험 응시 현황</span>
			    </div>
			</div>
			<div class="right" >
				<h2 style="font-size: 20px; font-weight: 600;">수강생 현황</h2>
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
// 그래디언트 배경색 생성을 위한 유틸리티 함수
function getGradient(ctx, chartArea, color) {
    if (!chartArea) return null;
    const gradient = ctx.createLinearGradient(0, chartArea.bottom, 0, chartArea.top);
    gradient.addColorStop(0, 'rgba(255, 255, 255, 0)'); // 투명
    gradient.addColorStop(1, color.replace('1)', '0.1)'));  // 연한 테마색
    return gradient;
}

// 1. 꺾은선 그래프 (진도율 추이) - 디자인 수정
const ctx1 = document.getElementById('chart1').getContext('2d');
const mainColor = '#0e506e'; // 테마 컬러

new Chart(ctx1, {
    type: 'line',
    data: {
        labels: ['1주차', '2주차', '3주차', '4주차', '5주차'],
        datasets: [{
            label: '진도율',
            data: [15, 38, 55, 72, 88],
            borderColor: mainColor,
            backgroundColor: function(context) { // 동적 그래디언트 적용
                const chart = context.chart;
                const {ctx, chartArea} = chart;
                return getGradient(ctx, chartArea, mainColor);
            },
            fill: true,                // 선 아래 채우기
            tension: 0.4,              // 부드러운 곡선 효과
            pointRadius: 5,            // 점 크기 키움
            pointBackgroundColor: '#fff', // 점 내부 흰색
            pointBorderWidth: 2,       // 점 테두리
            pointHoverRadius: 7        // 마우스 올렸을 때 점 크기
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        layout: { padding: { top: 10, bottom: 10 } },
        plugins: {
            legend: { display: false }, // 상단 범례 숨김 (깔끔하게)
            tooltip: {
                callbacks: {
                    label: function(context) { return context.parsed.y + '%'; } // 툴팁에 % 추가
                }
            }
        },
        scales: {
            y: { 
                beginAtZero: true, 
                max: 100, 
                ticks: { 
                    stepSize: 20,
                    callback: v => v + '%' // Y축 라벨에 % 추가
                },
                grid: { color: 'rgba(0, 0, 0, 0.03)' } // 연한 그리드 선
            },
            x: { grid: { display: false } } // X축 그리드 숨김
        }
    }
});

// 2. 도넛 그래프 (시험 응시율) - 디자인 수정 (중앙 퍼센트 플러그인 포함)
const ctx2 = document.getElementById('chart2').getContext('2d');
// 실제 데이터는 서버에서 가져온 testRate 변수 등을 활용하세요.
const attendanceRate = 82; // 예시 응시율
const successColor = '#27ae60'; // 응시 완료 컬러

// 도넛 중앙에 텍스트를 그리는 커스텀 플러그인 정의
const centerTextPlugin = {
    id: 'centerText',
    afterDraw(chart, args, options) {
        const { ctx, chartArea: { top, bottom, left, right, width, height } } = chart;
        ctx.save();
        
        // 중앙 위치 계산
        const centerX = (left + right) / 2;
        const centerY = (top + bottom) / 2;

        // 텍스트 스타일 설정 (퍼센트 숫자)
        ctx.font = 'bold 36px "나눔 고딕", sans-serif';
        ctx.fillStyle = successColor;
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText(attendanceRate + '%', centerX, centerY - 5); // 숫자를 살짝 위로

        // 텍스트 스타일 설정 (단위/설명)
        ctx.font = '14px "나눔 고딕", sans-serif';
        ctx.fillStyle = '#868e96';
        ctx.fillText('응시율', centerX, centerY + 25); // '응시율' 텍스트를 숫 아래에

        ctx.restore();
    }
};

new Chart(ctx2, {
    type: 'doughnut',
    data: {
        labels: ['응시 완료', '미응시'],
        datasets: [{
            data: [attendanceRate, 100 - attendanceRate],
            backgroundColor: [successColor, '#f1f3f5'], // 초록색과 연회색 조화
            hoverOffset: 4,
            borderWidth: 0,
            weight: 1 // 도넛 두께감 조절
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: '80%', // 숫자가 들어갈 공간 확보
        plugins: {
            legend: {
                position: 'right', // 범례를 오른쪽에 배치
                labels: {
                    boxWidth: 10,
                    padding: 20,
                    font: { size: 13, weight: 'bold' },
                    usePointStyle: true // 범례 박스를 점(원) 모양으로
                }
            },
            tooltip: { enabled: false } // 중앙에 숫자가 있으니 툴팁은 숨김 (깔끔하게)
        }
    },
    plugins: [centerTextPlugin] // 위에서 정의한 플러그인 등록
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
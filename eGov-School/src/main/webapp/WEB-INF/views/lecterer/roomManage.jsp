<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
			    
			    <div class="per" style="overflow-x: auto;">
				    <div class="chart-scroll-wrapper">
				        <div id="chart1Container">
				            <canvas id="chart1"></canvas>
				        </div>
				    </div>
				    <span>평균 진도율</span>
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
										            <div style="width: 100px; background: #e9ecef; height: 6px; border-radius: 3px; position: relative;">
										                <div style="width: ${student.progress}%; background: #27ae60; height: 100%; border-radius: 3px;"></div>
										            </div> 
										            <span style="font-size: 12px; color: #27ae60; font-weight: bold;">${student.progress}%</span>
										        </td>
										        <td style="padding: 12px 15px; color: #495057;">
										            <c:choose>
										                <c:when test="${not empty student.prgLastdate}">
										                    <fmt:formatDate value="${student.prgLastdate}" pattern="yyyy.MM.dd"/>
										                </c:when>
										                <c:otherwise>-</c:otherwise>
										            </c:choose>
										        </td>
										        <td style="padding: 12px 15px; text-align: center;">
										            <c:choose>
												        <c:when test="${student.userStatus eq '학습중'}">
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

function getGradient(ctx, chartArea, color) {
    if (!chartArea) return null;
    const gradient = ctx.createLinearGradient(0, chartArea.bottom, 0, chartArea.top);
    gradient.addColorStop(0, 'rgba(255, 255, 255, 0)'); // 투명
    gradient.addColorStop(1, color.replace('1)', '0.1)'));  // 연한 테마색
    return gradient;
}

const labels = [
    <c:forEach var="vo" items="${weeklyProgress}" varStatus="s">
        '${vo.label}'${!s.last ? ',' : ''}
    </c:forEach>
];

const dataValues = [
    <c:forEach var="vo" items="${weeklyProgress}" varStatus="s">
        ${vo.value}${!s.last ? ',' : ''}
    </c:forEach>
];

const container = document.getElementById('chart1Container');
const dynamicWidth = labels.length * 100;
container.style.width = (dynamicWidth > 780 ? dynamicWidth : 780) + 'px';

const ctx1 = document.getElementById('chart1').getContext('2d');
const mainColor = '#0e506e';

new Chart(ctx1, {
    type: 'line',
    data: {
        labels: labels,
        datasets: [{
            label: '평균 진도율',
            data: dataValues,
            borderColor: mainColor,
            backgroundColor: function(context) {
                const chart = context.chart;
                const {ctx, chartArea} = chart;
                return getGradient(ctx, chartArea, mainColor);
            },
            fill: true,
            tension: 0.4,
            pointRadius: 5,
            pointBackgroundColor: '#fff',
            pointBorderWidth: 2
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: { display: false },
    		
		    tooltip: {
		        callbacks: {
		            label: function(context) {
		                let label = context.dataset.label || '';
		                if (label) {
		                    label += ': ';
		                }
		                if (context.parsed.y !== null) {
		                    label += context.parsed.y + '%'; 
		                }
		                return label;
		            }
		        }
		    }
    
        },
        scales: {
            y: { 
                beginAtZero: true, 
                max: 100,
                ticks: { callback: v => v + '%' }
            },
            x: { grid: { display: false } }
        }
    }
});

// 도넛 그래프 (시험 응시율)
const ctx2 = document.getElementById('chart2').getContext('2d');
const attendanceRate = ${not empty roomDetail.testRate ? roomDetail.testRate : 0};
const successColor = '#27ae60'; 

const centerTextPlugin = {
    id: 'centerText',
    afterDraw(chart) {
        const { ctx, chartArea: { top, bottom, left, right } } = chart;
        ctx.save();
        
        // 차트 중앙
        const centerX = (left + right) / 2;
        const centerY = (top + bottom) / 2;

        // 퍼센트 숫자
        ctx.font = 'bold 36px "나눔 고딕", sans-serif';
        ctx.fillStyle = successColor;
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText(attendanceRate + '%', centerX, centerY - 10); 

        // '응시율' 글씨
        ctx.font = '14px "나눔 고딕", sans-serif';
        ctx.fillStyle = '#868e96';
        ctx.fillText('응시율', centerX, centerY + 30); 

        ctx.restore();
    }
};

new Chart(ctx2, {
    type: 'doughnut',
    data: {
        labels: ['응시 완료', '미응시'],
        datasets: [{
            data: [attendanceRate, 100 - attendanceRate],
            backgroundColor: [successColor, '#f1f3f5'],
            hoverOffset: 4,
            borderWidth: 0
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,

        layout: {
            padding: {
            	left: 130,
                right: 20 
            }
        },
        cutout: '80%',
        plugins: {
            legend: {
                position: 'right',
                align: 'center', 
                labels: {
                    boxWidth: 12,
                    padding: 25,
                    font: { size: 14, weight: 'bold' },
                    usePointStyle: true
                }
            },
            tooltip: { enabled: false }
        }
    },
    plugins: [centerTextPlugin]
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
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
				<div class="mes">
					<a href=""><i class="fa-regular fa-envelope"></i></a>
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
						style="margin-top: 15px !important; margin-bottom: 15px !important;">강좌별
						진도율</span>
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
										<c:forEach var="student" items="${studentList}">
											<tr
												style="border-bottom: 1px solid #f1f1f1; transition: background 0.2s;">
												<td style="padding: 12px 15px;">
													<div style="font-weight: 500; color: #212529;">${student.userName}</div>
													<div style="font-size: 12px; color: #868e96;">${student.userEmail}</div>
												</td>
												<td style="padding: 12px 15px;">
													<div
														style="width: 100px; background: #e9ecef; height: 6px; border-radius: 3px; position: relative;">
														<div
															style="width: 50%; background: #27ae60; height: 100%; border-radius: 3px;">
														</div>
													</div> <span
													style="font-size: 12px; color: #27ae60; font-weight: bold;">50%</span> <%-- ${student.progress} --%>
												</td>
												<td style="padding: 12px 15px; color: #495057;">
													2026.04.01</td><%-- ${student.lastStudyDate} --%>
												<td style="padding: 12px 15px; text-align: center;"><c:if
														test="${student.userStatus == '활성'}">
														<span
															style="background: #e7f5ff; color: #228be6; padding: 4px 8px; border-radius: 4px; font-size: 11px; font-weight: bold;">학습중</span>
													</c:if> <c:if test="${student.userStatus != '비활성'}">
														<span
															style="background: #fff4e6; color: #fd7e14; padding: 4px 8px; border-radius: 4px; font-size: 11px; font-weight: bold;">미접속</span>
													</c:if>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="4"
												style="padding: 30px; text-align: center; color: #868e96;">
												수강 중인 학생이 없습니다.</td>
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
	const ctx1 = document.getElementById('chart1').getContext('2d');

	new Chart(ctx1, {
		type : 'bar',
		data : {
			labels : [ '강좌 1', '강좌 2', '강좌 3', '강좌 4', '강좌 5' ], // 강좌 명칭
			datasets : [ {
				label : '전체 학습자 평균',
				data : [ 65, 65, 65, 65, 65 ], // 평균값은 고정
				backgroundColor : '#e9ecef', // 연한 회색 배경 느낌
				borderWidth : 0,
				barPercentage : 0.6, // 막대 두께 조절
			}, {
				label : '강좌별 진도율',
				data : [ 85, 42, 70, 55, 90 ], // 실제 내 강좌 진도율
				backgroundColor : '#0e506e', // 포인트 컬러 (네이비)
				borderRadius : 4, // 막대 끝을 둥글게
				barPercentage : 0.6,
			} ]
		},
		options : {
			responsive : true,
			maintainAspectRatio : false,
			scales : {
				y : {
					beginAtZero : true,
					max : 100, // 진도율은 100%가 만점
					ticks : {
						callback : function(value) {
							return value + '%';
						}
					}
				},
				x : {
					grid : {
						display : false
					}
				// X축 줄무늬 제거 (깔끔함)
				}
			},
			plugins : {
				legend : {
					position : 'top',
					align : 'end'
				}
			// 범례를 오른쪽 상단으로
			}
		}
	});

	const ctx2 = document.getElementById('chart2').getContext('2d');

	new Chart(ctx2, {
		type : 'bar',
		data : {
			labels : [ '강좌 1', '강좌 2', '강좌 3', '강좌 4', '강좌 5' ], // 강좌 명칭
			datasets : [ {
				label : '전체 차시',
				data : [ 100, 100, 100, 100, 100 ], // 평균값은 고정
				backgroundColor : '#d1d8e0', // 연한 회색 배경 느낌
				borderWidth : 0,
				barPercentage : 0.6, // 막대 두께 조절
			}, {
				label : '진도율',
				data : [ 85, 42, 70, 55, 90 ], // 실제 내 강좌 진도율
				backgroundColor : '#27ae60', // 포인트 컬러 (네이비)
				borderRadius : 4, // 막대 끝을 둥글게
				barPercentage : 0.6,
			} ]
		},
		options : {
			responsive : true,
			maintainAspectRatio : false,
			scales : {
				y : {
					beginAtZero : true,
					max : 100, // 진도율은 100%가 만점
					ticks : {
						callback : function(value) {
							return value + '%';
						}
					}
				},
				x : {
					grid : {
						display : false
					}
				// X축 줄무늬 제거 (깔끔함)
				}
			},
			plugins : {
				legend : {
					position : 'top',
					align : 'end'
				}
			// 범례를 오른쪽 상단으로
			}
		}
	});
</script>

</html>
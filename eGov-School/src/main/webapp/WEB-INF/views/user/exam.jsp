<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Dashboard</title>

<link type="text/css" rel="stylesheet"
	href="../../../resources/css/user/styleEX.css" />
<%@include file="../modules/userHeader.jsp"%>
</head>
<body>

	<div class="mid">
		<div class="container-fluid">
			<div class="top-interface">
				<div class="tabs">
					<span class="tab active" onclick="showTab('ing')">평가 예정 강좌</span> <span
						class="tab" onclick="showTab('end')">평가 종료 강좌</span>
				</div>
				<div class="search-wrapper">
					<input type="text" placeholder="강좌명을 입력하세요" class="search-input">
					<button type="button" class="search-btn">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</div>
			</div>

			<div class="main-content-wrap">
				<div class="listwrap">
					<table>
						<thead>
							<tr>
								<th style="width: 8%;">No</th>
								<th id="columnTitle" style="width: 40%;">평가 미응시 강좌명</th>
								<th style="width: 25%;">응시 가능 기간</th>
								<th style="width: 12%;">제한 시간</th>
								<th style="width: 15%;">상태</th>
							</tr>
						</thead>

						<tbody id="ing-list">
							<tr>
								<td class="col-no">1</td>
								<td class="col-title"><div class="course-title">[헌법]
										헌법 기초</div></td>
								<td class="col-period">2026.03.20 ~ 2026.03.25</td>
								<td class="col-time">30분</td>
								<td class="col-action">
									<button type="button" class="btn-main-action is-feedback">
										<i class="fa-solid fa-pen-to-square"></i> 응시하기
									</button>
								</td>
							</tr>
						</tbody>

						<tbody id="end-list" style="display: none;">
							<tr>
								<td class="col-no">1</td>
								<td class="col-title"><div class="course-title">[민법]
										민법 총론</div></td>
								<td class="col-period">2026.02.01 ~ 2026.02.10</td>
								<td class="col-time">30분</td>
								<td class="col-action">
									<button type="button" class="btn-main-action is-completed">
										<i class="fa-solid fa-chart-simple"></i> 결과 확인
									</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="pagination-container">
				<%@ include file="/WEB-INF/views/modules/pagination.jsp"%>
			</div>
		</div>
	</div>


	<div class="modal fade" id="resultModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content result-modal-content">
				<div class="modal-body p-0">
					<div class="result-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h5 id="resCourseName">[강좌명]</h5>
						<h2 style="font-weight: 800; margin-bottom: 0;">평가 결과 리포트</h2>
					</div>
					<div class="p-5 text-center">
						<div class="mb-4">
							<span style="font-size: 18px; color: #666;">나의 성취도 점수</span>
							<div class="score-value">
								92<span style="font-size: 24px; color: #aaa; margin-left: 5px;">/
									100</span>
							</div>
						</div>
						<div class="progress-bar-bg mb-2">
							<div class="progress-bar-fill"></div>
						</div>
						<div class="result-badge">
							<p style="margin: 0; color: #856404; font-weight: 600;">
								🎉 축하합니다! 귀하는 전체 수강생 중 <br> <span
									style="font-size: 22px; color: #d35400;">상위 5.2%</span>에 해당합니다.
							</p>
						</div>
					</div>
				</div>
				<div class="modal-footer"
					style="border: none; justify-content: center; padding-bottom: 30px;">
					<button type="button" class="btn btn-round" data-dismiss="modal"
						style="background: #eee; color: #666;">닫기</button>
					<button type="button" class="btn btn-round"
						style="background: #0e506e; color: white;"
						onclick="alert('수료증을 내려받습니다.')">수료증 출력</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(document)
				.ready(
						function() {
							$(document)
									.on(
											'click',
											'.is-feedback',
											function() {
												location.href = "${pageContext.request.contextPath}/user/test";
											});
							$(document)
									.on(
											'click',
											'.is-completed',
											function() {
												const courseName = $(this)
														.closest('tr')
														.find('.course-title')
														.text();
												$('#resCourseName').text(
														courseName);
												$('#resultModal').modal('show');
											});
						});

		window.showTab = function(type) {
			$('.tab').removeClass('active');
			if (type === 'ing') {
				$('.tab:eq(0)').addClass('active');
				$('#columnTitle').text('평가 미응시 강좌명');
				$('#ing-list').show();
				$('#end-list').hide();
			} else {
				$('.tab:eq(1)').addClass('active');
				$('#columnTitle').text('평가 완료 강좌명');
				$('#ing-list').hide();
				$('#end-list').show();
			}
		}
	</script>
</body>
</html>
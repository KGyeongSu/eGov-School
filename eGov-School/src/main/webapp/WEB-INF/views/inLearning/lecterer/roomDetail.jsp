<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../modules/lecHeader.jsp" %>
<!-- 개별 css -->
<link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styleroomDetail.css" />
<title>roomDetail</title>
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
						style="background-color: #1a6d91; color: white; border-radius: 4px; font-size: 12px;  border: none; line-height: 1;">로그아웃
					</button>
				</div>
			</div>
		</div>
		<div class="divider">
			<div class="upload">
				<a href="">
					<h2>강의 등록</h2>
				</a>
			</div>
			<div class="manage">
				<a href="">
					<h2>사용자 관리</h2>
				</a>
			</div>
		</div>
		<div class="mid">
			<div class="reg_container">
				<!-- 왼쪽 -->
				<div class="reg_left">
					<div class="section_box video_main_section">
						<div id="video_preview_box" class="large_preview">
							<video id="video_player" controls
								style="display: none; width: 100%; height: 100%;"></video>
							<div id="preview_placeholder" class="placeholder_text">
								<i class="fa-solid fa-clapperboard"></i>
								<p>업로드할 동영상을 선택해주세요.</p>
							</div>
						</div>

						<div class="upload_row">
							<div id="file_list_container" class="file_list_box">
								<div class="file_list_header">
									<span><i class="fa-solid fa-paperclip"></i> 첨부된 파일</span> <span
										id="file_count">0개</span>
								</div>
								<ul id="attached_file_list" class="file_item_list">
									<li class="empty_msg">선택된 파일이 없습니다.</li>
								</ul>
							</div>
							<div class="file_btn_group">
								<label for="video_up" class="custom_file_btn video_btn">
									<i class="fa-solid fa-video"></i> 동영상 파일 선택
								</label> <input type="file" id="video_up" accept="video/*"
									onchange="previewVideo(this)" style="display: none;"> <label
									for="file_up" class="custom_file_btn file_btn"> <i
									class="fa-solid fa-paperclip"></i> 첨부파일 선택
								</label> <input type="file" id="file_up" multiple style="display: none;">
							</div>
						</div>
					</div>

					<!-- 강의 정보 입력 -->
					<div class="section_box info_section">
						<div class="input_item">
							<label>강의 제목</label> <input type="text"
								placeholder="강의 제목을 입력하세요.">
						</div>
						<div class="input_item">
							<label>강의 목표</label>
							<textarea placeholder="강의 목표를 입력하세요."></textarea>
						</div>
					</div>
				</div>

				<!-- 오른쪽 -->
				<div class="reg_right">
					<div class="action_box">
						<button class="btn_edit">수정하기</button>
						<button class="btn_save">저장하기</button>
					</div>
					<div class="list_box">
						<h3>
							<i class="fa-solid fa-list-check"></i> 강의 차시 목록
						</h3>
						<ul class="chapter_list">
							<li class="empty">등록된 차시가 없습니다.</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- .reg_container 끝 -->
		</div>
		<!-- .mid 끝 -->
	</div>
</body>

<script src="../../../resources/js/commons.js"></script>

</html>
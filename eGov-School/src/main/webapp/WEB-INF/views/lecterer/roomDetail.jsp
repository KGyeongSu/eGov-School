<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../modules/lecHeader.jsp"%>
<!-- 개별 css -->
<link type="text/css" rel="stylesheet"
	href="../../../resources/css/lecterer/styleroomDetail.css" />
<title>roomDetail</title>
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
				<a href="">
					<h2>사용자 관리</h2>
				</a>
			</div>
		</div>
		<div class="mid">
			<form action="/lecterer/insertLesson" method="post"
				enctype="multipart/form-data">
				<!-- 수정, 등록인지 여부, 강의 등록 시 강의실 번호 알려주기 위함 -->
				<input type="hidden" name="claNum" value="${roomDetail.claNum}">
				<input type="hidden" id="lsnNum" name="lsnNum" value="${lesson.lsnNum }">
				<input type="hidden" id="lsnSeq" name="lsnSeq" value="${lesson.lnsSqeNum }">
				<input type="hidden" id="deleteFiles" name="deleteFiles" value="">
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
										<span><i class="fa-solid fa-paperclip"></i> 첨부 파일</span>
									</div>
									<ul id="attached_file_list" class="file_item_list">
										<li class="empty_msg">선택된 파일이 없습니다.</li>
									</ul>
								</div>
								<div class="file_btn_group">
									<label for="video_up" class="custom_file_btn video_btn">
										<i class="fa-solid fa-video"></i> 동영상 파일 선택
									</label> <input type="file" id="video_up" name="files" accept="video/*"
										onchange="previewVideo(this)" style="display: none;">
									<label for="file_up" class="custom_file_btn file_btn">
										<i class="fa-solid fa-paperclip"></i> 첨부파일 선택
									</label> <input type="file" id="file_up" name="files" multiple
										style="display: none;">
								</div>
							</div>
						</div>

						<!-- 강의 정보 입력 -->
						<div class="section_box info_section">
							<div class="input_item">
								<label>강의 제목</label> <input type="text" name="lsnTitle"
									placeholder="강의 제목을 입력하세요.">
							</div>
							<div class="input_item">
								<label>강의 목표</label>
								<textarea name="lsnContent" placeholder="강의 목표를 입력하세요."></textarea>
							</div>
						</div>
					</div>

					<!-- 오른쪽 -->
					<div class="reg_right">
						<div class="action_box">
							<button type="button" class="btn_edit" onclick="go_modify();">수정하기</button>
							<button type="button" class="btn_save" onclick="go_save();">저장하기</button>
						</div>
						<div class="list_box">
							<h3>
								<i class="fa-solid fa-list-check"></i> 강의 차시 목록
							</h3>
							<ul class="chapter_list"
								style="max-height: 550px; overflow-y: auto;">
								<c:choose>
									<c:when test="${not empty lessonList}">
										<c:forEach items="${lessonList}" var="lesson">
											<li class="lesson_item"
												style="display: flex; align-items: center; padding: 12px 10px; border-bottom: 1px solid #f1f1f1; cursor: pointer;"
												onclick="fillUpdateForm(this, '${lesson.lsnNum}', '${lesson.lsnTitle}', '${lesson.lsnContent}', '${lesson.lsnSeq}')">
												<div class="lesson_btns" style="margin-right: 12px;">
													<i class="fa-solid fa-pen-to-square"
														style="cursor: pointer; color: #1a6d91; font-size: 16px;" >

														<c:forEach items="${lesson.lessonAttachList}" var="at">
															<span class="temp_file_info" style="display: none;"
																data-name="${at.laName}"
																data-savename="${at.laSaveName}"></span>
														</c:forEach>
													</i>
												</div>

												<div class="lesson_info"
													style="display: flex; align-items: center;">
													<span style="font-weight: bold; margin-right: 8px;">${lesson.lsnSeq}.</span>
													<span>${lesson.lsnTitle}</span>
												</div>
											</li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<li class="empty">등록된 차시가 없습니다.</li>
									</c:otherwise>
								</c:choose>
							</ul>
						</div>
					</div>
				</div>
				<!-- .reg_container 끝 -->
			</form>
		</div>
		<!-- .mid 끝 -->
	</div>
</body>

<script src="../../../resources/js/commons.js"></script>

<script>

	document.addEventListener ('DOMContentLoaded', function () {
		
		// 필요한거 가져오기
		const fileInput = document.getElementById('file_up');
		const showFileList = document.getElementById('attached_file_list');
		
		// 파일 이름 보여주기
		fileInput.addEventListener ('change', function () {
			
			const files = fileInput.files;
			
			if (files.length > 0) {
				
				// 기존 삭제
				const emptyMsg = showFileList.querySelector('.empty_msg');
				
				if (emptyMsg) emptyMsg.remove();
				
			
			
			// 선택된 모든 파일 이름 보여주기
			for (let i = 0; i < files.length; i++) {
					
				const li = document.createElement('li');
					
				li.style.display = "flex";
	            li.style.alignItems = "center";
	            li.style.padding = "5px 0";
	            li.style.fontSize = "14px";
	            li.style.borderBottom = "1px solid #f1f1f1";
	                
	            // 아이콘 + 파일명
	            li.innerHTML = `
	               	<i class="fa-solid fa-file-lines" style="margin-right:10px; color:#1a6d91;"></i>
	                <span class="file_name">\${files[i].name}</span>
	                <button type="button" onclick="this.parentElement.remove()" style="margin-left:auto; border:none; background:none; color:red; cursor:pointer;">x</button>
	                `;
	                
	               	// 만든거 자식으로 추가
	                showFileList.appendChild(li);
					
				}
			
			}
			
		});
		
	});

</script>

<script>

	function fillUpdateForm(element, num, title, content, seq) {
		
   	 	const videoPlayer = document.getElementById('video_player');
    	const placeholder = document.getElementById('preview_placeholder');
    	const fileList = document.getElementById('attached_file_list');

    	// 기본 정보 채우기
    	document.getElementById('lsnNum').value = num;
    	document.querySelector('input[name="lsnTitle"]').value = title;
    	document.querySelector('textarea[name="lsnContent"]').value = content;
    	document.getElementById('lsnSeq').value = seq;

   		 // 초기화
    	fileList.innerHTML = ""; 
    	videoPlayer.src = "";
    	videoPlayer.style.display = "none";
    	placeholder.style.display = "block";
    	document.getElementById('deleteFiles').value = "";
    	
    	// 비디오 존재여부 확인 용도
    	let hasVideo = false;

   		 // 아이콘 안에 숨겨둔 파일 정보들 싹 찾기
    	const fileInfos = element.querySelectorAll('.temp_file_info');

    	fileInfos.forEach(info => {
    		
        	const name = info.dataset.name;
        	const saveName = info.dataset.savename;
        	
        	if (!name || name === 'undefined' || name.trim() === '') return;
        
        	// 동영상인지 확인
       		 const isVideo = name.toLowerCase().match(/\.(mp4|webm|avi|mov)$/);

       		 if (isVideo) {
       			 
            	// 동영상 플레이어 세팅
            	videoPlayer.src = "/upload/lesson/" + saveName;
            	videoPlayer.style.display = "block";
            	placeholder.style.display = "none";
            	videoPlayer.load();
            	hasVideo = true;
            	
        	} else {
        		
            	// 일반 파일 리스트 추가
            	const li = document.createElement('li');
            	li.style.display = "flex";
           		li.style.alignItems = "center";
            	li.style.padding = "8px 10px";
            	li.style.marginBottom = "5px";
            	li.style.backgroundColor = "#f9f9f9";
            	li.style.borderRadius = "4px";

           		 // 아이콘 + 파일명 + [삭제 버튼]
            	li.innerHTML = `
                	<i class="fa-solid fa-file-lines" style="color:#1a6d91; margin-right:10px;"></i>
                	<span style="flex:1; font-size:13px; color:#555;">\${name}</span>
                	<button type="button" class="old_file_del_btn" 
                        	onclick="markFileForDeletion(this, '\${saveName}')" 
                       		style="border:none; background:none; color:#ff4d4d; cursor:pointer; padding:0 5px;">
                    <i class="fa-solid fa-circle-xmark"></i>
               	 </button>
            	`;
            	
            		fileList.appendChild(li);
            		
        	}
    	});

    	// 파일이 없을 때
		if (!hasVideo) {
			
        videoPlayer.style.display = "none";
        placeholder.style.display = "block";
        
    }    	
    	
		if (fileList.querySelectorAll('li').length === 0) {
			
	        fileList.innerHTML = '<li class="empty_msg">첨부된 파일이 없습니다.</li>';
	        
	    }
    	
}
	
	function markFileForDeletion(btn, saveName) {
		
        if (confirm("이 파일을 삭제하시겠습니까?\n(수정하기 버튼을 눌러야 최종 반영됩니다.)")) {
        	
            // 화면에서 제거
            const li = btn.closest('li');
            const parent = li.parentElement;
            li.remove();

            //  메시지 출력
            if (parent.children.length === 0) {
            	
                parent.innerHTML = '<li class="empty_msg">첨부된 파일이 없습니다.</li>';
                
            }

            // 삭제할 파일명 추가
            const deleteInput = document.getElementById('deleteFiles');
            let currentDeleted = deleteInput.value;
            
            if (currentDeleted === "") {
            	
                deleteInput.value = saveName;
                
            } else {
            	
                deleteInput.value = currentDeleted + "," + saveName;
                
            }
        }
    }

</script>

<script>

function go_save() {
	
    const title = document.querySelector('input[name="lsnTitle"]').value;
    const content = document.querySelector('textarea[name="lsnContent"]').value;
    const videoFile = document.getElementById('video_up').files;
    
    if (!title.trim()) {
    	
        alert("강의 제목을 입력해주세요.");
        document.querySelector('input[name="lsnTitle"]').focus();
        return;
    }
    if (!content.trim()) {
    	
        alert("강의 목표를 입력해주세요.");
        document.querySelector('textarea[name="lsnContent"]').focus();
        return;
    }

    if (videoFile.length === 0) {
    	
        alert("강의용 동영상 파일은 필수입니다. 파일을 선택해주세요.");
        return;
    }
    
    if (confirm('새로운 강의를 등록하시겠습니까?')) {
    	
        document.getElementById('lsnNum').value = ""; 
        document.querySelector('form').submit();
        
    }
}

function go_modify() {
	
    const lsnNum = document.getElementById('lsnNum').value
    const title = document.querySelector('input[name="lsnTitle"]').value;
    const content = document.querySelector('textarea[name="lsnContent"]').value;
    
    if (!lsnNum) {
    	
        alert("목록에서 수정할 강의를 먼저 선택해 주세요.");
        return;
        
    }
    
    if (!title.trim()) {
    	
        alert("수정할 강의 제목을 입력해주세요.");
        return;
        
    }
    
    if (!content.trim()) {
    	
        alert("수정할 강의 목표를 입력해주세요.");
        return;
        
    }
    
    if (confirm("기존 강의 정보를 수정하시겠습니까?")) {
    	
        document.querySelector('form').submit(); 
        
    }
}
	
</script>

<script>

    // 컨트롤러에서 보낸 msg가 있을 경우에만 실행
    var msg = "${msg}";
    
    if (msg) {
    	
        alert(msg);
        history.replaceState({}, null, location.pathname);
        
    }
    
</script>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link type="text/css" rel="stylesheet"
	href="../../../resources/css/lecterer/stylep.css" />
<title>inlearning_profile</title>
</head>

<body>
	<div class="window">

		<header>
			<div class="title">
				<h1>My 프로필</h1>
			</div>
			<button class="modify" onclick="go_save('수정');">수정</button>
			<button class="regist" onclick="go_save('등록');">등록</button>
		</header>

		<div class="wrap">
			<div class="pimg">
				<div class="upload-container">
					<div class="upload-placeholder">
						<c:choose>
							<%-- 사진 있을 때 --%>
							<c:when test="${not empty loginUser.userPhoto}">
								<img src="/display/${loginUser.userPhoto}"
									style="width: 100%; height: 100%; object-fit: cover;"
									alt="프로필 사진">
							</c:when>

							<%-- 사진 없을 때 --%>
							<c:otherwise>
								<p>클릭하거나 이미지를 드래그하세요</p>
								<span>(JPG, PNG, 최대 5MB)</span>
							</c:otherwise>
						</c:choose>
					</div>
					<input type="file" class="upload-input" style="display: none;">
				</div>
			</div>

			<div class="divider"></div>

			<div class="info">
				<div class="form-container upload-container">
					<!-- 사진첨부 -->
					<form name="profile" class="profile" action="/lecterer/profile"
						method="post" enctype="multipart/form-data">
						<!-- type 값 저장해서 보내주는 용도 -->
						<input type="hidden" name="type" id="submitType">
						<div class="form-group">
							<label for="photo">사진첨부</label>
							<div class="input-wrapper">
								<input type="file" id="photo" class="upload-input real"
									name="uploadProfile"><span id="file-name-display" style="color: #24272b; font-size: 14px; font-weight: bold; margin-left: 10px; position: relative; top: -3px;">
										${not empty loginUser.userPhoto ? loginUser.userPhoto : '선택된 파일 없음'}
									</span>
							</div>
						</div>
					</form>

					<!-- 이름 -->
					<div class="form-group">
						<label for="name">이름</label>
						<div class="input-wrapper">
							<input type="text" id="name" class="form-input"
								value="${loginUser.userName}" readonly>
						</div>
					</div>

					<!-- 연락처 -->
					<div class="form-group">
						<label for="phone">연락처</label>
						<div class="input-wrapper">
							<input type="tel" id="phone" class="form-input"
								value="${loginUser.userPhone}" readonly>
						</div>
					</div>

					<!-- 이메일 -->
					<div class="form-group">
						<label for="email">이메일</label>
						<div class="input-wrapper">
							<input type="email" id="email" class="form-input"
								value="${loginUser.userEmail}" readonly>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>

<script src="/resources/js/commons.js"></script>

<script>

	document.addEventListener("DOMContentLoaded", function() {
		
   		const pimg = document.querySelector('.pimg');
   		const fileNameDisplay = document.getElementById('file-name-display');
        const photoInput = document.getElementById('photo');
    
    	// 사진 존재 여부 확인
    	const hasPhoto = ${not empty loginUser.userPhoto}; 

   		if (hasPhoto && pimg) {
   			
        	pimg.style.border = 'none';
        	
    	}
   		
   		// 원래 파일 있으면 해당 파일 이름 보여주기
   		if (photoInput) {
   			
            photoInput.addEventListener('change', function(e) {
            	
                const file = e.target.files[0];
                
                if (file) {
                	
                    // 파일 이름 변경
                    if (fileNameDisplay) {
                    	
                        fileNameDisplay.innerText = file.name;
                        
                    }
                }
            });
   		}
   		
   		let originalName = "${loginUser.userPhoto}"; 
   	    
   	    if (originalName && fileNameDisplay) {
   	    	
   	        const lastDashIndex = originalName.lastIndexOf('-');
   	        
   	        if (lastDashIndex !== -1) {
   	        	
   	            const cleanName = originalName.substring(lastDashIndex + 1);
   	            fileNameDisplay.innerText = cleanName;
   	            
   	        }
   	    }
   		
	});

	function go_save(type) {

		const fileInput = document.querySelector('.real');

		if (!fileInput.files[0]) {

			alert(type + "할 사진을 먼저 선택해 주세요!");
			return;

		}

		if (confirm("프로필을 " + type + "하시겠습니까?")) {

			//제출
			document.getElementById('submitType').value = type;
			document.querySelector(".profile").submit();

		}

	}

	const msg = "${msg}";
	if (msg) {

		alert(msg);

	}
</script>

</html>
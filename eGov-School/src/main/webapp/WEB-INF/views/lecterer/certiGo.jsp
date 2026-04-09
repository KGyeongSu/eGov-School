<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styleForm.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        crossorigin="anonymous" referrerpolicy="no-referrer" />

    <title>certiGo</title>
</head>

<body>
    <div class="inner">
        <div class="form">
            <!-- 버튼 -->
            <div class="form_top">
                <h2 class="title">
                	<c:choose>
		                <c:when test="${not empty certiInfo}">수료증 수정</c:when>
		                <c:otherwise>수료증 등록</c:otherwise>
		            </c:choose>
                </h2>
                <div class="send_btn">
                    <button type="button" class="btn" onclick="submitFile();">
		                <i class="fa-solid fa-check"></i>
		                <c:choose>
		                    <c:when test="${not empty certiInfo}">수정하기</c:when>
		                    <c:otherwise>등록하기</c:otherwise>
		                </c:choose>
		            </button>
                </div>
            </div>

            <div class="form_mid">
                <!-- 강좌명 선택 -->
                <div class="lecName">
				    <label>강좌명</label>
				    <input type="text" class="input_control read_only_style" 
				           value="${cClassInfo.claTitle }" readonly>
				    <input type="hidden" id="claNum" value="${cClassInfo.claNum}">
            		<input type="hidden" id="cerNum" value="${certiInfo.cerNum}">
				</div>
            </div>

            <!-- 파일 첨부 -->
            <div class="form_bot">
                <div class="file_box">
                    <label>수료증 파일 첨부</label>
                    <div class="file_input_area">
                        <input type="file" id="file_upload" onchange="updateFileName(this)">
		                <label for="file_upload" class="file_btn">
		                    <i class="fa-solid fa-file-arrow-up"></i>
		                    <span id="fileNameDisplay">
		                        <c:choose>
		                            <c:when test="${not empty certiInfo}">
		                                기존 파일: ${certiInfo.cerName} (클릭하여 변경)
		                            </c:when>
		                            <c:otherwise>클릭하여 파일 업로드</c:otherwise>
		                        </c:choose>
		                    </span>
		                </label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

<script src="/resources/js/commons.js"></script>

<script>
// 파일 선택 시 화면에 파일명 즉시 업데이트
function updateFileName(input) {
	
    if (input.files && input.files[0]) {
        document.getElementById('fileNameDisplay').innerText = input.files[0].name;
    }
    
}

function submitFile() {
	
    const fileInput = document.getElementById('file_upload');
    const cerNum = document.getElementById('cerNum').value;
    const claNum = document.getElementById('claNum').value;

    // 등록일 때는 파일이 필수
    if (!cerNum && fileInput.files.length === 0) {
    	
        alert("등록할 수료증 파일을 선택해주세요.");
        return;
        
    }

    // 전송
    const formData = new FormData();
    
    // 파일이 선택된 경우에만 추가
    if (fileInput.files[0]) {
    	
        formData.append("uploadFile", fileInput.files[0]);
        
    }
    
    let url = "";
    
    if (cerNum) {
    	
        // 수정
        url = "/lecterer/certiEdit";
        formData.append("cerNum", cerNum);
        formData.append("claNum", claNum);
        
    } else {
    	
        // 등록
        url = "/lecterer/certiGo";
        formData.append("claNum", claNum);
        
    }

    // 서버 전송
    fetch(url, {
    	
        method: 'POST',
        body: formData
        
    })
    
    .then(response => response.text())
    .then(data => {
    	
        if (data === "success") {
        	
            alert(cerNum ? "수료증이 수정되었습니다." : "수료증이 등록되었습니다.");
            
            if (window.opener) {
            	
                window.opener.location.reload();
                
            }
            
            window.close(); 
            
        } else {
        	
            alert("처리 중 오류가 발생했습니다.");
            
        }
    })
    .catch(error => {
    	
        console.error('Error:', error);
        alert("서버 통신 오류가 발생했습니다.");
        
    });
}
</script>

</html>
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
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styleForm.css">
    <title>giveForm</title>
</head>

<body>
    <div class="inner">
        <div class="form">
            <!-- 버튼 -->
            <div class="form_top">
                <h2 class="title">평가 제출</h2>
                <div class="send_btn">
                    <button type="button" class="btn"><i class="fa-solid fa-paper-plane"></i> 평가 제출</button>
                </div>
            </div>

            <div class="form_mid">
                <div class="arrive">
					    <label>관리자 선택</label>
					    <div class="search_wrap">
					        <select id="adminList" name="msReceiverNum" class="input_control">
					            <option value="">전송할 관리자를 선택하세요</option>
					            <c:forEach items="${adminList}" var="admin">
					                <option value="${admin.userNum}">
					                    ${admin.userName} (${admin.userEmail})
					                </option>
					            </c:forEach>
					        </select>
					    </div>
					</div>
                <!-- 강좌명 선택 -->
                <div class="lecName">
				    <label>강좌명</label>
				    <input type="text" class="input_control read_only_style" 
				           value="${gClassInfo.claTitle }" readonly>
				</div>

                <!-- 파일 첨부 부분 -->
                <div class="form_bot" style="margin-top: 30px; padding: 0;">
                    <div class="file_box">
                        <label style="display: block; margin-bottom: 8px; font-weight: bold;">평가 결과 파일 첨부</label>
                        <div class="file_input_area" style="width: 100%; height: 100px; border: 1px dashed #ccc; background: #f9f9f9; display: flex; justify-content: center; align-items: center; border-radius: 6px; box-sizing: border-box;">
                            <input type="file" id="file_upload" style="display: none;">
                            <label for="file_upload" class="file_btn"
                                style="cursor: pointer; color: #555; text-align: center;">
                                <i class="fa-solid fa-file-arrow-up" style="display: block; font-size: 20px; margin-bottom: 5px;"></i>
                                <span style="font-size: 14px;">클릭하여 파일 업로드</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
     </div>
</body>

<script src="/resources/js/commons.js"></script>

<script>

document.addEventListener('DOMContentLoaded', function() {
	
    const sendBtn = document.querySelector('.send_btn .btn');
    const fileInput = document.getElementById('file_upload');
    const adminSelect = document.getElementById('adminList');

    // 파일 선택하면 화면에 이름 나오게 하기
    fileInput.addEventListener('change', function() {
    	
        if(this.files.length > 0) {
            document.querySelector('.file_btn span').innerText = this.files[0].name;
        }
        
    });

    // 제출 버튼 클릭
    sendBtn.addEventListener('click', function() {
    	
        const receiverNum = adminSelect.value;
        const file = fileInput.files[0];
        const claNum = "${gClassInfo.claNum}"; 

        if (!receiverNum) {
        	
            alert("관리자를 선택해주세요.");
            return;
            
        }
        if (!file) {
        	
            alert("파일을 첨부해주세요.");
            return;
            
        }

        if (confirm("평가 결과를 제출하시겠습니까?")) {
        	
            const formData = new FormData();
            
            formData.append("msReceiverNum", receiverNum);
            formData.append("claNum", claNum);
            formData.append("uploadFile", file);
            formData.append("msContent", "${gClassInfo.claTitle} 평가 결과 제출");

            fetch("/lecterer/giveFormGo", {
            	
                method: "POST",
                body: formData
                
            })
            .then(res => res.text())
            .then(data => {
            	
                if (data == "success") {
                	
                    alert("성공적으로 제출되었습니다.");
                    window.close(); 
                    
                } else {
                	
                    alert("제출 실패! 다시 시도해주세요.");
                    
                }
            })
            
            .catch(err => console.error(err));
            
        }
    });
});
</script>

</html>
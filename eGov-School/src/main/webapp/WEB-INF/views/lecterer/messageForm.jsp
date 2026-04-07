<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styleForm.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>messageForm</title>
</head>

<body>
    <div class="inner">
        <div class="form">
            <!-- 버튼 -->
            <div class="form_top">
                <h2 class="title">평가 발송</h2>
                <div class="send_btn">
                    <button type="button" id="sendBtn" class="btn"><i class="fa-solid fa-paper-plane"></i> 평가 발송</button>
                </div>
            </div>

            <div class="form_mid">
                <!-- 강좌명 선택 -->
                <div class="lecName">
				    <label>강좌명</label>
				    <input type="text" class="input_control read_only_style" 
				           value="${mClassInfo.claTitle }" readonly>
				</div>

                <!-- 수신자 검색 -->
                <div class="arrive">
				    <label>수신자 선택</label>
				    <div class="search_wrap">
				        <select id="studentList" class="input_control">
				            <option value="">수강생 목록</option>
				        </select>
				    </div>
				</div>

                <!-- 내용 -->
                <div class="content">
                    <div class="pnp">
					    <label>수료 여부</label>
					    <input type="text" id="pnpStatus" class="input_control read_only_style" 
					           value="수강생을 선택하세요." readonly>
					</div>
                    <div class="say">
                        <label>메시지</label>
                        <textarea class="input_control" id="msContent" name="msContent" placeholder="전송할 메시지 내용을 입력하세요."></textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script src="/resources/js/commons.js"></script>
<script>
    // 페이지가 로드시 자동으로 실행
    window.onload = function() {
    	
        const studentSelect = document.getElementById('studentList');
        const pnpInput = document.getElementById('pnpStatus');
    	const claNum = "${mClassInfo.claNum}";
    	
        loadStudentList();
        
        studentSelect.addEventListener('change', function() {
    		
            const userNum = this.value;

            // 학생을 선택하지 않은 경우
            if (!userNum) {
            	
            	pnpInput.value = "수강생을 선택하세요.";
                return;
                
            }

            // 서버에 데이터 요청
            fetch("/lecterer/passStudent?userNum=" + userNum + "&claNum=" + claNum)
            
                .then(response => {
                	
                    if (!response.ok) throw new Error('네트워크 응답 오류');
                    return response.text(); 
                    
                })
                .then(data => {
                	
                	const pnp = data.trim();
                	
                   	if(pnp == 'Y') {
                   		
                   		pnpInput.value = "수료 (Pass)";
                        
                    } else {
                    	
                    	pnpInput.value = "미수료 (Non-Pass)";
                        
                    }
                })
                
                .catch(error => {
                	
                    console.error('확인 불가:', error);
                    pnpInput.value = "확인 불가";
                    
                });
    	});
        
        const sendBtn = document.getElementById('sendBtn');
        const messageArea = document.querySelector('.say textarea');

        sendBtn.addEventListener('click', function() {
            const userNum = studentSelect.value; // 수신자 번호
            const content = document.getElementById("msContent").value;   // 메시지 내용
            const claNum = "${mClassInfo.claNum}"; // 강의 번호
            const tetNum = "${mClassInfo.tetNum}";

            if (!userNum) {
                alert("수신자를 선택해주세요.");
                return;
            }
            if (!content.trim()) {
                alert("메시지 내용을 입력해주세요.");
                return;
            }

            // 서버로 데이터 전송 (발송/저장 요청)
            fetch("/lecterer/messageGo", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "msReceiverNum=" + userNum + 
                	  "&msContent=" + encodeURIComponent(content) + 
                	  "&claNum=" + claNum +
                	  "&tetNum=" + tetNum
            })
            .then(response => response.text())
            .then(data => {
                if(data.trim() == "success") {
                	
                    alert("평가가 성공적으로 발송되었습니다.");
                    messageArea.value = ""; 
                    
                    window.close();
                    
                } else {
                    alert("발송 실패");
                }
            })
            .catch(error => console.error('Error:', error));
        });
        
    };

    function loadStudentList() {
    	
        const claNum = "${mClassInfo.claNum}";
        const tetNum = "${mClassInfo.tetNum}";
        const studentSelect = document.getElementById('studentList');

        fetch("/lecterer/searchStudent?claNum=" + claNum + "&tetNum=" + tetNum)
            .then(response => {
            	
                if (!response.ok) throw new Error('목록을 불러오지 못했습니다.');
                return response.json();
                
            })
            .then(data => {
            	
                studentSelect.innerHTML = '<option value="">전체 수강생 중 선택하세요</option>';
                
                if (data && data.length > 0) {
                	
                    data.forEach(user => {
                    	
                        const option = document.createElement('option');
                        option.value = user.userNum; 
                        option.textContent = `\${user.userName} (\${user.userEmail})`;
                        studentSelect.appendChild(option);
                        
                    });
                    
                } else {
                	
                    studentSelect.innerHTML = '<option value="">수강생이 없습니다.</option>';
                    
                }
            })
            .catch(error => {
            	
                console.error('Error:', error);
                studentSelect.innerHTML = '<option value="">목록 로딩 실패</option>';
                
            });
        	
    }
</script>

</html>
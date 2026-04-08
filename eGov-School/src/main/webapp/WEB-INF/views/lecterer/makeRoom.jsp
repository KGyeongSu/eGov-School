<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- 개별 css -->
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styleForm.css">
    <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <title>makeRoom</title>
</head>

<body>
    <div class="inner" style="background-color: #f0f4f7 !important;">
    	<form id="makeRoomForm" class="form"  action="makeRoom" method="post" style="border: none !important; box-shadow: 0 10px 40px rgba(0,0,0,0.08) !important; max-width: 900px !important;">
            <!-- 버튼 -->
            <div class="form_top" style="border-bottom: 1px solid #eee !important; padding: 25px 40px !important;">
                <h2 class="title">강의실 생성</h2>
                <div class="send_btn">
                    <button type="button" class="btn"><i class="fa-solid fa-file-signature"></i>승인 신청</button>
                </div>
            </div>

            <div class="form_mid">
                <!-- 작성자/강의명 -->
                <div class="write_down">
                    <div class="per_name">
                        <label>작성자</label>
                        <div class="read_only_box">
                            <span class="badge_lec">강사명</span>${loginUser.userName }
                        </div>
                    </div>
                    <div class="lec_name">
                        <label>강의명</label>
                        <input type="text" name="claTitle" class="input_control" placeholder="강의명을 입력하세요">
                    </div>
                    <!-- 강의 분야 입력란 -->
                	<div class="category" style="margin-bottom: 20px;">
            			<label>강의 분야</label>
            			<input type="text" name="claCategory" class="input_control" placeholder="헌법, 행정법, 지방소비세법 등">
        			</div>
                </div>
                <div class="items">
                    <!-- 학습목표 입력란 -->
                    <div class="goal">
                        <label>학습 목표</label>
                        <input type="text" name="claContent" class="input_control" placeholder="학습 목표를 입력하세요">
                    </div>
                </div>
            </div>

            <!-- 커리큘럼 작성 (동적 생성 영역) -->
            <div class="form_bot">
                <div class="curri_box">
                    <div class="curri_header">
                        <label>커리큘럼 상세 입력</label>
                        <button type="button" class="add_curri_btn" onclick="addCurriculum()">
                            <i class="fa-solid fa-plus"></i>강의 추가
                        </button>
                    </div>
                    
                    <!-- 스크롤이 발생하는 컨테이너 -->
                    <div id="curriculum_list" class="curriculum_container">
                        <div class="curri_item">
                            <span class="step_badge">1강</span>
                            <input type="text" name="lessonList[0].lsnTitle" class="input_control" placeholder="강의 주제를 입력하세요">
                            <button type="button" class="remove_btn" onclick="removeCurri(this)">
                                <i class="fa-solid fa-xmark"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>

<script src="../../../resources/js/commons.js"></script>

<script>

	document.querySelector ('.send_btn .btn'). addEventListener('click', function () {
		
		// 폼객체 가져오기
		const form = document.getElementById('makeRoomForm');
		
		// 입력값 가져오기
		const claTitle = form.querySelector('input[name="claTitle"]').value.trim();
		const claContent = form.querySelector('input[name="claContent"]').value.trim();
		const claCategory = form.querySelector('input[name="claCategory"]').value.trim();
		const curri = form.querySelectorAll('input[name^="lessonList"]');
		let curriReal = true;
		
		// 유효성 검사
		if (!claTitle) {
			
			alert ("강의명 입력은 필수입니다.");
			form.querySelector('input[name="claTitle"]').focus();
			return;
			
		}
		
		if (!claCategory) {
			
			alert ("강의 분야 입력은 필수입니다.");
			form.querySelector('input[name="claCategory"]').focus();
			return;
			
		}
		
		if (!claContent) {
			
			alert ("학습 목표 입력은 필수입니다");
			form.querySelector('input[name="claContent"]').focus();
			return;
			
		}
		
		if (curri.length == 0) {
			
			alert ("커리큘럼 입력은 필수입니다.");
			form.querySelector('input[name="lessonList"]').focus();
			return;
			
		}
		
		for (let i = 0; i < curri.length; i++) {
			
            if (!curri[i].value.trim()) {
            	
            	const badgeText = curri[i].closest('.curri_item').querySelector('.step_badge').innerText;
            	alert(`${badgeText} 주제를 입력해주세요.`);
                curri[i].focus();
                curriReal = false;
                break;
            }
        }
		
		if (!curriReal) return;
		
		if (confirm ("강의실 승인을 신청하시겠습니까 ?")) {
			
			form.submit();
			
		}
		
	});
	
    window.onload = function() {
    	
        var message = "${msg}"; 
        var status = "${status}";
        
        if (message) {
        	
            alert(message);
            
            if (status === "success") {
            
            	if (window.opener && !window.opener.closed) CloseWindow();
            
            }
            
        }
    };

</script>

</html>
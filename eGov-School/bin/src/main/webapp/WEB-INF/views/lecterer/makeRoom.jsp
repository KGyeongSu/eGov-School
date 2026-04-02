<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- 개별 css -->
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styleForm.css">
    <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
    
    <title>makeRoom</title>
</head>

<body>
    <div class="inner">
        <div class="form">
            <!-- 버튼 -->
            <div class="form_top">
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
                            <span class="badge_lec">강사명</span>이이이
                        </div>
                    </div>
                    <div class="lec_name">
                        <label>강의명</label>
                        <input type="text" class="input_control" placeholder="강의명을 입력하세요">
                    </div>
                </div>
                <div class="items">
                    <!-- 학습목표 입력란 -->
                    <div class="goal">
                        <label>학습 목표</label>
                        <input type="text" class="input_control" placeholder="학습 목표를 입력하세요">
                    </div>
                    
                    <!-- 캘린더 아이콘 및 날짜 정보 -->
                    <div class="calendar_item">
                        <div class="calendar_box">
                        	<input type="text" id="datePicker" style="display:none;">
                            <i class="fa-solid fa-calendar-days" id="calendarIcon" style="cursor:pointer;"></i>
                        </div>
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
                            <input type="text" class="input_control" placeholder="강의 주제를 입력하세요">
                            <button type="button" class="remove_btn" onclick="removeCurri(this)">
                                <i class="fa-solid fa-xmark"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

<script src="../../../resources/js/commons.js"></script>

</html>
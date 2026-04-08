<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../modules/lecHeader.jsp" %>

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
                    <button type="button" class="btn"><i class="fa-solid fa-paper-plane"></i> 평가 전송</button>
                </div>
            </div>

            <div class="form_mid">
                <!-- 수신자 검색 -->
                <div class="arrive">
                    <label>관리자 선택</label>
                    <div class="search_wrap">
                        <input type="text" class="input_control" placeholder="관리자 성명 검색">
                        <button type="button" class="btn_search"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </div>
                </div>
                <!-- 강좌명 선택 부분 -->
                <div class="lecName" style="margin-top: 20px;">
                    <label style="display: block; margin-bottom: 8px; font-weight: bold;">강좌명</label>
                    <select class="input_control" style="width: 100%; height: 45px; padding: 10px; border: 1px solid #d1d1d1; border-radius: 4px; box-sizing: border-box; outline: none;">
                        <option value="">강좌를 선택하세요</option>
                        <option value="1">2026년 대전 신규 공무원 역량 강화 과정</option>
                        <option value="2">공직자 윤리 및 청렴 교육</option>
                    </select>
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
</body>

</html>
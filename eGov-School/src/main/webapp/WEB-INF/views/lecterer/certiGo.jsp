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

    <title>certiGo</title>
</head>

<body>
    <div class="inner">
        <div class="form">
            <!-- 버튼 -->
            <div class="form_top">
                <h2 class="title">수료증 등록</h2>
                <div class="send_btn">
                    <button type="button" class="btn"><i class="fa-solid fa-plus"></i>등록하기</button>
                </div>
            </div>

            <div class="form_mid">
                <!-- 강좌명 선택 -->
                <div class="lecName">
                    <label>강좌명</label>
                    <select class="input_control">
                        <option value="">강좌를 선택하세요</option>
                        <option value="1">2026년 대전 신규 공무원 역량 강화 과정</option>
                        <option value="2">공직자 윤리 및 청렴 교육</option>
                    </select>
                </div>
            </div>

            <!-- 파일 첨부 -->
            <div class="form_bot">
                <div class="file_box">
                    <label>수료증 파일 첨부</label>
                    <div class="file_input_area">
                        <input type="file" id="file_upload">
                        <label for="file_upload" class="file_btn">
                            <i class="fa-solid fa-file-arrow-up"></i> 클릭하여 파일 업로드
                        </label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/stylep.css" />
    <title>inlearning_profile</title>
</head>

<body>
    <div class="window">

        <header>
            <div class="title">
                <h1>My 프로필</h1>
            </div>
            <button class="modify">수정</button>
            <button class="regist">등록</button>
        </header>

        <div class="wrap">
            <div class="pimg">
                <div class="upload-placeholder">
                    <p>클릭하거나 이미지를 드래그하세요</p>
                    <span>(JPG, PNG, 최대 5MB)</span>
                </div>
            </div>

            <div class="divider"></div>

            <div class="info">
                <div class="form-container">
                    <!-- 사진첨부 -->
                    <div class="form-group">
                        <label for="photo">사진첨부</label>
                        <div class="input-wrapper">
                            <input type="file" id="photo" class="form-input">
                        </div>
                    </div>

                    <!-- 이름 -->
                    <div class="form-group">
                        <label for="name">이름</label>
                        <div class="input-wrapper">
                            <input type="text" id="name" placeholder="이름을 입력하세요" class="form-input">
                        </div>
                    </div>

                    <!-- 연락처 -->
                    <div class="form-group">
                        <label for="phone">연락처</label>
                        <div class="input-wrapper">
                            <input type="tel" id="phone" placeholder="연락처를 입력하세요" class="form-input">
                        </div>
                    </div>

                    <!-- 이메일 -->
                    <div class="form-group">
                        <label for="email">이메일</label>
                        <div class="input-wrapper">
                            <input type="email" id="email" placeholder="example@mail.com" class="form-input">
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</body>

</html>
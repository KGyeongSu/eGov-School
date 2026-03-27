<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../modules/lecHeader.jsp" %>
	<!-- 개별 css -->
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styletestMake.css" />
    <!-- font awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <title>testMake</title>
</head>

<body>
    <div class="content">
        <div class="top">
            <div class="icon">
                <a href=""><i class="fa-regular fa-user"></i></a>
            </div>
            <div class="state_bar">
                <p>평가 출제</p>
            </div>
            <div class="logout_dash">
                <div class="mes">
                    <a href=""><i class="fa-regular fa-envelope"></i></a>
                </div>
                <div class="out">
                    <button type="button" class="btn btn-sm"
                        style="background-color: #1a6d91; color: white; border-radius: 4px; font-size: 12px;  border: none; line-height: 1;">로그아웃
                    </button>
                </div>
            </div>
        </div>
        <div class="divider">
            <div class="write"><a href="">
                    <h2>평가 출제</h2>
                </a></div>
            <div class="manage"><a href="">
                    <h2>평가 관리</h2>
                </a></div>
        </div>
        <div class="main">
            <div class="ques">
                <div class="ques_top">
                    <div class="course_info">
                        <span class="label">강좌명 :</span>
                        <span class="name">2026년 대전 신규 공무원 역량 강화 과정</span>
                    </div>
                    <button type="button" class="btn_nav">이전 문제</button>
                    <button type="button" class="btn_nav">다음 문제</button>
                </div>
                <div class="ques_mid">
                    <!-- 지문  -->
                    <div class="section_box">
                        <div class="label_bar">지문 입력</div>
                        <textarea class="text_area" rows="4" placeholder="지문을 입력하세요."></textarea>
                    </div>
                    <div class="section_box">
                        <div class="label_bar">선지 및 정답 입력</div>
                        <div class="choice_container">
                            <div class="choice_row">
                                <input type="radio" name="correct_chk">
                                <span class="num_label">1</span>
                                <input type="text" class="choice_input" placeholder="내용을 입력하세요.">
                            </div>
                            <div class="choice_row">
                                <input type="radio" name="correct_chk">
                                <span class="num_label">2</span>
                                <input type="text" class="choice_input" placeholder="내용을 입력하세요.">
                            </div>
                            <div class="choice_row">
                                <input type="radio" name="correct_chk">
                                <span class="num_label">3</span>
                                <input type="text" class="choice_input" placeholder="내용을 입력하세요.">
                            </div>
                            <div class="choice_row">
                                <input type="radio" name="correct_chk">
                                <span class="num_label">4</span>
                                <input type="text" class="choice_input" placeholder="내용을 입력하세요.">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="ques_bot">
                    <div class="section_box">
                        <div class="label_bar">문제 해설</div>
                        <textarea class="text_area" rows="4" placeholder="문제의 해설을 입력하세요."></textarea>
                    </div>
                </div>
            </div>
            <div class="state">
                <div class="state_up">
                    <button type="button" class="btn_register">평가 등록</button>
                </div>
                <div class="state_down">
                    <h2 class="status_title">문제 출제 현황</h2>
                    <div class="status_content">
                        <ul class="question_status_list">
                            <!-- 등록 완료 상태 -->
                            <li class="item complete">
                                <span class="q_no">01</span>
                                <span class="q_title">객관식 문항 제목</span>
                                <span class="state_icon">✔</span>
                            </li>
                            <!-- 현재 작성 중 상태 -->
                            <li class="item active">
                                <span class="q_no">02</span>
                                <span class="q_title">작성 중인 문항입니다.</span>
                                <span class="state_tag">작성중</span>
                            </li>
                            <!-- 미작성 -->
                            <li class="item">
                                <span class="q_no">03</span>
                                <span class="q_title">미등록 문항</span>
                            </li>
                            <!--
                            <c:forEach var="i" begin="4" end="20">
                                <li class="item">
                                    <span class="q_no">${i < 10 ? '0' : '' }${i}</span>
                                            <span class="q_title">미등록 문항</span>
                                </li>
                            </c:forEach>
                            -->
                          </ul>
                    </div>
                </div>
            </div>
         </div>
      </div>
</body>

</html>
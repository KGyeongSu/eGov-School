<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>eGov-School</title>
    <link rel="stylesheet" href="/resources/css/MainPage/main.css">
    <link
        href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;900&family=Gowun+Batang:wght@400;700&display=swap"
        rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/resources/js/script.js"></script>
</head>

<body>

    <%@ include file="modules/header.jsp" %>
    <!-- 이미지슬라이드부분 -->
    <content>
        <div class="img_slide">
            <div class="slide_list">
                <ul>
                    <li>
                        <a href="lecterer/mainDashBoard">
                            <img src="/resources/images/slide1.png" />
                        </a>
                    </li>
                    <li>
                        <a href="user/dashBoard">
                            <img src="/resources/images/slide2.png" />
                        </a>
                    </li>
                    <li>
                        <a href="admin/admin_main">
                            <img src="/resources/images/slide3.png" />
                        </a>
                    </li>
                </ul>
            </div>

            <button class="slide_btn prev">&#10094;</button>
            <button class="slide_btn next">&#10095;</button>

            <div class="slide_dots">
                <button class="dot active"></button>
                <button class="dot"></button>
                <button class="dot"></button>
            </div>
        </div>
        <!-- 카드섹션(교육과정 미리보기) -->
        <div class="section">
            <div class="section_filter">
                <h2>교육과정<small>교육 과정을 확인하세요.</small></h2>
                <div class="filter_btn">
                    <button class="active">전체</button>
                    <button>신규</button>
                    <button>조회수</button>
                </div>
            </div>

            <!-- 카드 리스트 -->
            <div class="card_list">
                <!-- 카드1 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>행정학</span>
                    </div>
                    <div class="card_info">
                        <h3>행정학 - 기초부터 실무까지</h3>
                        <p class="card_date">2026.03.01 ~ 2026.04.07</p>
                    </div>
                    <div class="card_info2">
                        <span>김경수 강사</span>
                        <span>수강생 110명</span>
                    </div>
                </div>
                <!-- 카드2 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>법학</span>
                    </div>
                    <div class="card_info">
                        <h3>헌법 - 기초부터 실무까지</h3>
                        <p class="card_date">2026.03.02 ~ 2026.04.07</p>
                    </div>
                    <div class="card_info2">
                        <span>김진아 강사</span>
                        <span>수강생 100명</span>
                    </div>
                </div>
                <!-- 카드3 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>경제학</span>
                    </div>
                    <div class="card_info">
                        <h3>경제학 - 기초부터 실무까지</h3>
                        <p class="card_date">2026.03.03 ~ 2026.04.07</p>
                    </div>
                    <div class="card_info2">
                        <span>이은영 강사</span>
                        <span>수강생 90명</span>
                    </div>
                </div>
                <!-- 카드4 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>한국사</span>
                    </div>
                    <div class="card_info">
                        <h3>한국사 - 기초부터 실무까지</h3>
                        <p class="card_date">2026.03.04 ~ 2026.04.07</p>
                    </div>
                    <div class="card_info2">
                        <span>육상우 강사</span>
                        <span>수강생 80명</span>
                    </div>
                </div>
                <!-- 카드5 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>지방자치론</span>
                    </div>
                    <div class="card_info">
                        <h3>지방자치론 - 이론과 실제</h3>
                        <p class="card_date">2026.03.05 ~ 2026.04.07</p>
                    </div>
                    <div class="card_info2">
                        <span>박민호 강사</span>
                        <span>수강생 70명</span>
                    </div>
                </div>
                <!-- 카드6 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>행정법</span>
                    </div>
                    <div class="card_info">
                        <h3>행정법 - 기초부터 실무까지</h3>
                        <p class="card_date">2026.03.06 ~ 2026.04.07</p>
                    </div>
                    <div class="card_info2">
                        <span>정수현 강사</span>
                        <span>수강생 60명</span>
                    </div>
                </div>
                <!-- 카드7 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>사회복지학</span>
                    </div>
                    <div class="card_info">
                        <h3>사회복지학 - 정책과 실천</h3>
                        <p class="card_date">2026.03.07 ~ 2026.04.07</p>
                    </div>
                    <div class="card_info2">
                        <span>한지은 강사</span>
                        <span>수강생 50명</span>
                    </div>
                </div>
                <!-- 카드8 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>공직윤리</span>
                    </div>
                    <div class="card_info">
                        <h3>공직윤리 - 청렴과 책임</h3>
                        <p class="card_date">2026.03.08 ~ 2026.04.07</p>
                    </div>
                    <div class="card_info2">
                        <span>오태영 강사</span>
                        <span>수강생 40명</span>
                    </div>
                </div>
                <!-- 카드9 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>민법</span>
                    </div>
                    <div class="card_info">
                        <h3>민법 - 총칙과 계약법</h3>
                        <p class="card_date">2026.03.09 ~ 2026.04.14</p>
                    </div>
                    <div class="card_info2">
                        <span>최영호 강사</span>
                        <span>수강생 95명</span>
                    </div>
                </div>
                <!-- 카드10 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>세법</span>
                    </div>
                    <div class="card_info">
                        <h3>세법 - 국세와 지방세의 이해</h3>
                        <p class="card_date">2026.03.10 ~ 2026.04.14</p>
                    </div>
                    <div class="card_info2">
                        <span>문정빈 강사</span>
                        <span>수강생 75명</span>
                    </div>
                </div>
                <!-- 카드11 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>통계학</span>
                    </div>
                    <div class="card_info">
                        <h3>통계학 - 데이터 분석 기초</h3>
                        <p class="card_date">2026.03.11 ~ 2026.04.14</p>
                    </div>
                    <div class="card_info2">
                        <span>윤서준 강사</span>
                        <span>수강생 65명</span>
                    </div>
                </div>
                <!-- 카드12 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>정보학</span>
                    </div>
                    <div class="card_info">
                        <h3>행정정보학 - 전자정부와 ICT</h3>
                        <p class="card_date">2026.03.12 ~ 2026.04.14</p>
                    </div>
                    <div class="card_info2">
                        <span>장현우 강사</span>
                        <span>수강생 55명</span>
                    </div>
                </div>
                <!-- 카드13 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>교육학</span>
                    </div>
                    <div class="card_info">
                        <h3>교육학 - 공무원 교육론</h3>
                        <p class="card_date">2026.03.13 ~ 2026.04.14</p>
                    </div>
                    <div class="card_info2">
                        <span>서민지 강사</span>
                        <span>수강생 85명</span>
                    </div>
                </div>
                <!-- 카드14 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>회계학</span>
                    </div>
                    <div class="card_info">
                        <h3>회계학 - 공공재정 회계</h3>
                        <p class="card_date">2026.03.14 ~ 2026.04.14</p>
                    </div>
                    <div class="card_info2">
                        <span>강태훈 강사</span>
                        <span>수강생 45명</span>
                    </div>
                </div>
                <!-- 카드15 -->
                <div class="card">
                    <div class="card_img"><img src="/resources/images/image1.png">
                        <span>국어</span>
                    </div>
                    <div class="card_info">
                        <h3>국어 - 공무원 국어 완성</h3>
                        <p class="card_date">2026.03.15 ~ 2026.04.14</p>
                    </div>
                    <div class="card_info2">
                        <span>임수빈 강사</span>
                        <span>수강생 120명</span>
                    </div>
                </div>
            </div>

                <!--페이지네이션-->
                <div class="pagination">
                    <a href="#" class="prev">《</a>
                    <a href="#" class="prev">〈</a>
                    <a href="#" class="page active">1</a>
                    <a href="#" class="page">2</a>
                    <a href="#" class="page">3</a>
                    <a href="#" class="next">〉</a>
                    <a href="#" class="prev">》</a>
                </div>
            </div>
    </content>

    
	<%@ include file="modules/footer.jsp" %>
</body>

</html>
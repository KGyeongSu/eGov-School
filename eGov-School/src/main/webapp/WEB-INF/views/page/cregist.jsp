<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수강신청</title>
    <link rel="stylesheet" href="/resources/css/MainPage/main.css">
    <link rel="stylesheet" href="/resources/css/MainPage/cregist.css">
    <link
        href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;900&family=Gowun+Batang:wght@400;700&display=swap"
        rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/resources/js/script.js"></script>

</head>

<body>
	<%@ include file="../modules/header.jsp" %>

    <content>

        <!-- 검색바 -->
        <div class="cregist_search">
            <h2>수강신청</h2>
            <div class="search_bar">
                <form id="searchc">
                    <input type="text" name="keyword" placeholder="강좌명을 검색하세요">
                    <button type="submit" class="c_search">검색</button>
                </form>
            </div>
        </div>

        <!-- 강좌 테이블 -->
        <div class="course_table_wrap">
            <table class="course_table">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>강좌제목</th>
                        <th>강사</th>
                        <th>교육기간</th>
                        <th>접수기간</th>
                        <th>모집현황</th>
                        <th>상세보기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td class="course_title" onclick="openCourseModal(this.closest('tr'))">행정학 - 기초부터 실무까지</td>
                        <td>김경수</td>
                        <td>2026.03.01 ~ 04.07</td>
                        <td>2026.02.15 ~ 02.28</td>
                        <td>12/30</td>
                        <td><button class="btn_detail" onclick="openCourseModal(this.closest('tr'))">상세보기</button></td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td class="course_title" onclick="openCourseModal(this.closest('tr'))">헌법 - 기초부터 실무까지</td>
                        <td>김진아</td>
                        <td>2026.03.02 ~ 04.07</td>
                        <td>2026.02.15 ~ 03.01</td>
                        <td>25/30</td>
                        <td><button class="btn_detail" onclick="openCourseModal(this.closest('tr'))">상세보기</button></td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td class="course_title" onclick="openCourseModal(this.closest('tr'))">경제학 - 기초부터 실무까지</td>
                        <td>이은영</td>
                        <td>2026.03.03 ~ 04.07</td>
                        <td>2026.02.15 ~ 03.02</td>
                        <td>30/30</td>
                        <td><button class="btn_detail" onclick="openCourseModal(this.closest('tr'))">상세보기</button></td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td class="course_title" onclick="openCourseModal(this.closest('tr'))">한국사 - 기초부터 실무까지</td>
                        <td>육상우</td>
                        <td>2026.03.04 ~ 04.07</td>
                        <td>2026.02.15 ~ 03.03</td>
                        <td>5/30</td>
                        <td><button class="btn_detail" onclick="openCourseModal(this.closest('tr'))">상세보기</button></td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td class="course_title" onclick="openCourseModal(this.closest('tr'))">지방자치론 - 이론과 실제</td>
                        <td>박민호</td>
                        <td>2026.03.05 ~ 04.07</td>
                        <td>2026.02.15 ~ 03.04</td>
                        <td>18/30</td>
                        <td><button class="btn_detail" onclick="openCourseModal(this.closest('tr'))">상세보기</button></td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td class="course_title" onclick="openCourseModal(this.closest('tr'))">행정법 - 기초부터 실무까지</td>
                        <td>정수현</td>
                        <td>2026.03.06 ~ 04.07</td>
                        <td>2026.02.15 ~ 03.05</td>
                        <td>22/30</td>
                        <td><button class="btn_detail" onclick="openCourseModal(this.closest('tr'))">상세보기</button></td>
                    </tr>
                    <tr>
                        <td>7</td>
                        <td class="course_title" onclick="openCourseModal(this.closest('tr'))">사회복지학 - 정책과 실천</td>
                        <td>한지은</td>
                        <td>2026.03.07 ~ 04.07</td>
                        <td>2026.02.15 ~ 03.06</td>
                        <td>8/30</td>
                        <td><button class="btn_detail" onclick="openCourseModal(this.closest('tr'))">상세보기</button></td>
                    </tr>
                    <tr>
                        <td>8</td>
                        <td class="course_title" onclick="openCourseModal(this.closest('tr'))">공직윤리 - 청렴과 책임</td>
                        <td>오태영</td>
                        <td>2026.03.08 ~ 04.07</td>
                        <td>2026.02.15 ~ 03.07</td>
                        <td>15/30</td>
                        <td><button class="btn_detail" onclick="openCourseModal(this.closest('tr'))">상세보기</button></td>
                    </tr>
                </tbody>
            </table>
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

    </content>

    <!-- 강좌 상세보기 모달 -->
    <div id="courseModal" class="modal_overlay" style="display:none;">
        <div class="course_modal">
            <div class="cm_header">
                <h3>강좌 상세보기</h3>
                <button class="cm_close" onclick="closeCourseModal()">&times;</button>
            </div>
            <div class="cm_body">
                <!-- 상단 영역 -->
                <div class="cm_top">
                    <div class="cm_thumb"></div>
                    <div class="cm_info_wrap">
                        <p class="cm_no"></p>
                        <h3 class="cm_title"></h3>
                        <div class="cm_info_grid">
                            <div class="cm_info_card">
                                <span class="cm_label">강사</span>
                                <span class="cm_value cm_teacher"></span>
                            </div>
                            <div class="cm_info_card">
                                <span class="cm_label">신청기간</span>
                                <span class="cm_value cm_receipt"></span>
                            </div>
                            <div class="cm_info_card">
                                <span class="cm_label">교육기간</span>
                                <span class="cm_value cm_date"></span>
                            </div>
                            <div class="cm_info_card">
                                <span class="cm_label">수강인원 / 현황</span>
                                <span class="cm_value cm_status"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 하단 영역 -->
                <div class="cm_bottom">
                    <div class="cm_curriculum">
                        <h4>커리큘럼 (총 10강)</h4>
                        <div class="cm_curriculum_list">
                            <div class="cm_lecture"><span class="cm_badge">1강</span><span>행정학의 개념과 발전</span></div>
                            <div class="cm_lecture"><span class="cm_badge">2강</span><span>행정조직론의 기초</span></div>
                            <div class="cm_lecture"><span class="cm_badge">3강</span><span>인사행정과 공무원 제도</span></div>
                            <div class="cm_lecture"><span class="cm_badge">4강</span><span>재무행정의 이해</span></div>
                            <div class="cm_lecture"><span class="cm_badge">5강</span><span>정책학 개론</span></div>
                            <div class="cm_lecture"><span class="cm_badge">6강</span><span>정책분석과 평가</span></div>
                            <div class="cm_lecture"><span class="cm_badge">7강</span><span>공공관리와 거버넌스</span></div>
                            <div class="cm_lecture"><span class="cm_badge">8강</span><span>지방행정의 실제</span></div>
                            <div class="cm_lecture"><span class="cm_badge">9강</span><span>행정학 사례 분석</span></div>
                            <div class="cm_lecture"><span class="cm_badge">10강</span><span>종합정리 및 복습</span></div>
                        </div>
                    </div>
                    <div class="cm_right">
                        <div class="cm_section">
                            <h4>학습 내용</h4>
                            <p class="cm_goal"></p>
                        </div>
                        <div class="cm_section">
                            <h4>수료 조건</h4>
                            <div class="cm_conditions">
                                <div class="cm_condition"><span class="cm_dot"></span><span>전체 강좌 100% 수강 완료</span>
                                </div>
                                <div class="cm_condition"><span class="cm_dot"></span><span>평가 시험 응시</span></div>
                                <div class="cm_condition"><span class="cm_dot"></span><span>수료 기준점수 80점 이상</span></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="cm_footer">
                <button class="btn_cregist_modal">수강신청</button>
            </div>
        </div>
    </div>

    <%@ include file="../modules/footer.jsp" %>

</body>

</html>
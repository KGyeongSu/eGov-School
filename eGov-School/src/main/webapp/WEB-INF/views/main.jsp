<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>eGov-School</title>
    <link rel="stylesheet" href="/resources/css/MainPage/main.css">
    <link rel="stylesheet" href="/resources/css/MainPage/cregist.css">
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
                            <img src="/resources/images/slide4.png" />
                    </li>
                    
                    <li>
                            <img src="/resources/images/slide5.png" />
                    </li>
                    
                    <li>
                            <img src="/resources/images/slide6.png" />
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
                <h2>교육과정<small>현재 운영중인 강좌를 확인하세요.</small></h2>
                
                <div class="filter_btn">
    				<button class="${empty pageMaker.searchType || pageMaker.searchType == '' ? 'active' : ''}"
            				onclick="location.href='/main?page=1&searchType='">전체</button>
    				<button class="${pageMaker.searchType == 'latest' ? 'active' : ''}"
            				onclick="location.href='/main?page=1&searchType=latest'">최신순</button>
    				<button class="${pageMaker.searchType == 'views' ? 'active' : ''}"
           					onclick="location.href='/main?page=1&searchType=views'">조회수순</button>
				</div>
            </div>

            <!-- 카드 리스트 -->
			<div class="card_list">
			    <c:choose>
			        <c:when test="${not empty classList}">
			            <c:forEach var="cls" items="${classList}">
			                <div class="card" onclick="openCourseDetail('${cls.claNum}')" style="cursor: pointer;">
			                    <div class="card_img">
			                        <c:choose>
			                            <c:when test="${not empty cls.userPhoto}">
			                                <img src="/display/${cls.userPhoto}">
			                            </c:when>
			                            <c:otherwise>
			                                <img src="/resources/images/default.jpg">
			                            </c:otherwise>
			                        </c:choose>
			                        <span>${cls.claCategory}</span>
			                    </div>
			                    <div class="card_info">
			                        <h3>${cls.claTitle}</h3>
			                        <p class="card_date">
			                            <fmt:formatDate value="${cls.claStartDate}" pattern="yyyy.MM.dd"/>
			                            ~
			                            <fmt:formatDate value="${cls.claEndDate}" pattern="yyyy.MM.dd"/>
			                        </p>
			                    </div>
			                    <div class="card_info2">
			                        <span>${cls.userName} 강사</span>
			                        <span>수강생 ${cls.applyCnt}명</span>
			                    </div>
			                </div>
			            </c:forEach>
			        </c:when>
			        <c:otherwise>
			            <p style="padding: 40px; text-align: center;">등록된 강좌가 없습니다.</p>
			        </c:otherwise>
			    </c:choose>
			</div>

                <!-- 페이지네이션 -->
				<div class="pagination">
    					<a href="/main?page=1&searchType=${pageMaker.searchType}" class="prev">《</a>
    					<a href="/main?page=${pageMaker.page - 1 < 1 ? 1 : pageMaker.page - 1}&searchType=${pageMaker.searchType}" class="prev">〈</a>
    				
    				<c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
        				<a href="/main?page=${pageNum}&searchType=${pageMaker.searchType}" class="page ${pageMaker.page == pageNum ? 'active' : ''}">${pageNum}</a>
    				</c:forEach>
    				
  						<a href="/main?page=${pageMaker.page + 1 > pageMaker.realEndPage ? pageMaker.realEndPage : pageMaker.page + 1}&searchType=${pageMaker.searchType}" class="next">〉</a>
    					<a href="/main?page=${pageMaker.realEndPage == 0 ? 1 : pageMaker.realEndPage}&searchType=${pageMaker.searchType}" class="next">》</a>
				</div>
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
                <div class="cm_top">
                    <div class="cm_thumb">
                        <img id="cm_thumb_img" src="" alt="강사 사진" onerror="this.style.display='none'">
                    </div>
                    <div class="cm_info_wrap">
                        <p class="cm_no"></p>
                        <h3 class="cm_title"></h3>
                        <div class="cm_info_grid">
                            <div class="cm_info_card">
                                <span class="cm_label">강사</span>
                                <span class="cm_value cm_teacher"></span>
                            </div>
                            <div class="cm_info_card">
                                <span class="cm_label">카테고리</span>
                                <span class="cm_value cm_category"></span>
                            </div>
                            <div class="cm_info_card">
                                <span class="cm_label">교육기간</span>
                                <span class="cm_value cm_date"></span>
                            </div>
                            <div class="cm_info_card">
                                <span class="cm_label">현재인원 / 수강정원</span>
                                <span class="cm_value cm_status"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="cm_bottom">
                    <div class="cm_curriculum">
                        <h4>커리큘럼</h4>
                        <div class="cm_lesson_list"></div>
                    </div>
                    <div class="cm_right">
                        <div class="cm_section">
                            <h4>학습 목표</h4>
                            <p class="cm_content_text"></p>
                        </div>
                        <div class="cm_section">
                            <h4>수료 조건</h4>
                            <div class="cm_conditions"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="cm_footer">
                <button class="btn_cregist_modal" onclick="location.href='/page/cregist'">수강신청 페이지로 이동</button>
            </div>
        </div>
    </div>
    
	<%@ include file="modules/footer.jsp" %>
	
	<script>
    function openCourseDetail(claNum) {
        $.ajax({
            url: '/page/classDetail',
            type: 'get',
            data: { claNum: claNum },
            dataType: 'json',
            success: function(data) {
                $('.cm_title').text(data.claTitle);
                $('.cm_teacher').text(data.userName || '-');
                $('.cm_category').text(data.claCategory || '-');
                $('.cm_status').text((data.applyCnt || 0) + '/' + data.claMaxStu);

                if (data.claStartDate && data.claEndDate) {
                    var start = new Date(data.claStartDate);
                    var end = new Date(data.claEndDate);
                    var format = function(d) {
                        return d.getFullYear() + '.' + String(d.getMonth()+1).padStart(2,'0') + '.' + String(d.getDate()).padStart(2,'0');
                    };
                    $('.cm_date').text(format(start) + ' ~ ' + format(end));
                } else {
                    $('.cm_date').text('-');
                }

                if (data.userPhoto) {
                    $('#cm_thumb_img').attr('src', '/display/' + data.userPhoto + '?t=' + new Date().getTime()).show();
                } else {
                    $('#cm_thumb_img').attr('src', '/resources/images/default.jpg').show();
                }

                $('.cm_content_text').text(data.claContent || '정보 없음');

                var conditionsHtml = '';
                if (data.claComplete) {
                    var conditions = data.claComplete.split(',');
                    for (var i = 0; i < conditions.length; i++) {
                        var text = conditions[i].trim();
                        if (text) {
                            conditionsHtml += '<div class="cm_condition"><span class="cm_dot"></span><span>' + text + '</span></div>';
                        }
                    }
                } else {
                    conditionsHtml = '<div class="cm_condition"><span class="cm_dot"></span><span>수료 조건 미설정</span></div>';
                }
                $('.cm_conditions').html(conditionsHtml);

                var lessonHtml = '';
                if (data.lessonList && data.lessonList.length > 0) {
                    for (var i = 0; i < data.lessonList.length; i++) {
                        var lesson = data.lessonList[i];
                        lessonHtml += '<div class="cm_lesson_item"><span class="cm_lesson_seq">' + lesson.lsnSeq + '강</span><span class="cm_lesson_title">' + lesson.lsnTitle + '</span></div>';
                    }
                } else {
                    lessonHtml = '<p style="color:#999;">등록된 커리큘럼이 없습니다.</p>';
                }
                $('.cm_lesson_list').html(lessonHtml);

                $('#courseModal').show();
            },
            error: function() {
                alert('강좌 정보를 불러올 수 없습니다.');
            }
        });
    }

    function closeCourseModal() {
        $('#courseModal').hide();
    }

    $(document).on('click', '.modal_overlay', function(e) {
        if (e.target === this) closeCourseModal();
    });
    </script>
	
</body>

</html>
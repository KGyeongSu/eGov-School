<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수강신청</title>
    <link rel="stylesheet" href="/resources/css/MainPage/main.css">
    <link rel="stylesheet" href="/resources/css/MainPage/cregist.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link
        href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;900&family=Gowun+Batang:wght@400;700&display=swap"
        rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/resources/js/script.js"></script>

    <style>
        
    </style>
</head>

<body>
    <%@ include file="../modules/header.jsp" %>

    <content>

        <!-- 검색 & 필터 영역 -->
        <div class="cregist_search">
            <h2>수강신청</h2>
            <div class="search_bar">
			<form id="searchc" onsubmit="search_list(1); return false;">
				<select name="searchType" id="sortType">
					<option value="latest"
						${pageMaker.searchType == 'latest' || pageMaker.searchType == '' ? 'selected' : ''}>최신순</option>
					<option value="views"
						${pageMaker.searchType == 'views' ? 'selected' : ''}>조회수순</option>
				</select> <input type="text" id="keywordInput" name="keyword"
					placeholder="강좌명을 검색하세요" value="${pageMaker.keyword}">
				<button type="submit" class="c_search">검색</button>
			</form>
			</div>
        </div>

        <!-- 강좌 테이블 -->
        <div id="userListArea">
            <div class="course_table_wrap">
                <table class="course_table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>카테고리</th>
                            <th>강좌제목</th>
                            <th>강사</th>
                            <th>교육기간</th>
                            <th>모집현황</th>
                            <th>상세보기</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty classList}">
                                <c:forEach var="cls" items="${classList}" varStatus="status">
                                    <tr>
                                        <td>${pageMaker.totalCount - ((pageMaker.page - 1) * pageMaker.perPageNum) - status.index}</td>
                                        <td><span class="category_badge">${cls.claCategory}</span></td>
                                        <td class="course_title" onclick="openCourseDetail('${cls.claNum}')">${cls.claTitle}</td>
                                        <td>${cls.userName}</td>
                                        <td>
                                            <fmt:formatDate value="${cls.claStartDate}" pattern="yyyy.MM.dd"/>
                                            ~
                                            <fmt:formatDate value="${cls.claEndDate}" pattern="yyyy.MM.dd"/>
                                        </td>
                                        <td>
                                            <span class="${cls.applyCnt >= cls.claMaxStu ? 'recruit_full' : ''}">${cls.applyCnt}/${cls.claMaxStu}</span>
                                        </td>
                                        <td><button class="btn_detail" onclick="openCourseDetail('${cls.claNum}')">상세보기</button></td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" style="text-align:center; padding:40px; color:#999;">등록된 강좌가 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- 페이지네이션 -->
			<div class="pagination">
			    <a href="/page/cregist?page=1&searchType=${pageMaker.searchType}&keyword=${pageMaker.keyword}" class="prev">《</a>
			    <a href="/page/cregist?page=${pageMaker.page - 1 < 1 ? 1 : pageMaker.page - 1}&searchType=${pageMaker.searchType}&keyword=${pageMaker.keyword}" class="prev">〈</a>
			
			    <c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			        <a href="/page/cregist?page=${pageNum}&searchType=${pageMaker.searchType}&keyword=${pageMaker.keyword}"
			           class="page ${pageMaker.page == pageNum ? 'active' : ''}">${pageNum}</a>
			    </c:forEach>
			
			    <a href="/page/cregist?page=${pageMaker.page + 1 > pageMaker.realEndPage ? pageMaker.realEndPage : pageMaker.page + 1}&searchType=${pageMaker.searchType}&keyword=${pageMaker.keyword}" class="next">〉</a>
			    <a href="/page/cregist?page=${pageMaker.realEndPage == 0 ? 1 : pageMaker.realEndPage}&searchType=${pageMaker.searchType}&keyword=${pageMaker.keyword}" class="next">》</a>
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
				<!-- 상단 영역 -->
				<div class="cm_top">
					<div class="cm_thumb">
						<img id="cm_thumb_img" src="" alt="강사 사진"
							onerror="this.style.display='none'">
					</div>
					<div class="cm_info_wrap">
						<p class="cm_no"></p>
						<h3 class="cm_title"></h3>
						<div class="cm_info_grid">
							<div class="cm_info_card">
								<span class="cm_label">강사</span> <span
									class="cm_value cm_teacher"></span>
							</div>
							<div class="cm_info_card">
								<span class="cm_label">카테고리</span> <span
									class="cm_value cm_category"></span>
							</div>
							<div class="cm_info_card">
								<span class="cm_label">교육기간</span> <span
									class="cm_value cm_date"></span>
							</div>
							<div class="cm_info_card">
								<span class="cm_label">현재인원 / 수강정원</span> <span
									class="cm_value cm_status"></span>
							</div>
						</div>
					</div>
				</div>
				<!-- 하단 영역 -->
				<div class="cm_bottom">
					<!-- 왼쪽: 커리큘럼 -->
					<div class="cm_curriculum">
						<h4>커리큘럼</h4>
						<div class="cm_lesson_list">
							<!-- JS에서 동적으로 채움 -->
						</div>
					</div>
					<!-- 오른쪽: 학습 목표 + 수료 조건 -->
					<div class="cm_right">
						<div class="cm_section">
							<h4>학습 목표</h4>
							<p class="cm_content_text"></p>
						</div>
						<div class="cm_section">
							<h4>수료 조건</h4>
							<div class="cm_conditions">
								<!-- JS에서 동적으로 채움 -->
							</div>
						</div>
					  </div>
					</div>
				</div>
				<div class="cm_footer">
					<input type="hidden" id="modalClaNum" value="">
					<button class="btn_cregist_modal" onclick="applyCourse()">수강신청</button>
				</div>
			</div>
		</div>
		
		<%@ include file="../modules/footer.jsp" %>

    <script>
	 // 정렬 변경 시 URL로 직접 이동
    $(document).on('change', '#sortType', function() {
        var keyword = $('#keywordInput').val() || '';
        location.href = '/page/cregist?page=1&searchType=' + this.value + '&keyword=' + encodeURIComponent(keyword);
    });
 	// 페이지네이션 클릭 시 sortType 유지
    $(document).on('click', '.page-link', function() {
        $('#jobForm input[name="searchType"]').val($('#sortType').val() || 'latest');
    });

    // 정렬 select 변경 시
    $(document).on('change', '#sortType', function() {
        search_list(1);
    });

    // 강좌 상세보기 모달
    function openCourseDetail(claNum) {
    $.ajax({
        url: '/page/classDetail',
        type: 'get',
        data: { claNum: claNum },
        dataType: 'json',
        success: function(data) {
            // 상단 정보
            $('.cm_title').text(data.claTitle);
            $('.cm_teacher').text(data.userName || '-');
            $('.cm_category').text(data.claCategory || '-');
            $('.cm_status').text((data.applyCnt || 0) + '/' + data.claMaxStu);

            // 교육기간
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

            // 강사 사진
            if (data.userPhoto) {
                $('#cm_thumb_img').attr('src', '/display/' + data.userPhoto).show();
            } else {
                $('#cm_thumb_img').attr('src', '/resources/images/default.jpg').show();
            }

            // 학습 목표 (cla_content → "학습 목표"로 표시)
            $('.cm_content_text').text(data.claContent || '정보 없음');

            // 수료 조건 (cla_complete → 쉼표 구분 동적 생성)
            var conditionsHtml = '';
            if (data.claComplete) {
                var conditions = data.claComplete.split(',');
                for (var i = 0; i < conditions.length; i++) {
                    var text = conditions[i].trim();
                    if (text) {
                        conditionsHtml += '<div class="cm_condition">'
                                       + '<span class="cm_dot"></span>'
                                       + '<span>' + text + '</span>'
                                       + '</div>';
                    }
                }
            } else {
                conditionsHtml = '<div class="cm_condition">'
                               + '<span class="cm_dot"></span>'
                               + '<span>수료 조건 미설정</span>'
                               + '</div>';
            }
            $('.cm_conditions').html(conditionsHtml);

            // 커리큘럼 (lessonList → 차시 목록 동적 생성)
            var lessonHtml = '';
            if (data.lessonList && data.lessonList.length > 0) {
                for (var i = 0; i < data.lessonList.length; i++) {
                    var lesson = data.lessonList[i];
                    lessonHtml += '<div class="cm_lesson_item">'
                                + '<span class="cm_lesson_seq">' + lesson.lsnSeq + '강</span>'
                                + '<span class="cm_lesson_title">' + lesson.lsnTitle + '</span>'
                                + '</div>';
                }
            } else {
                lessonHtml = '<p style="color:#999;">등록된 커리큘럼이 없습니다.</p>';
            }
            $('.cm_lesson_list').html(lessonHtml);

            $('#modalClaNum').val(claNum);
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

    function applyCourse() {
        var claNum = $('#modalClaNum').val();
        if (!claNum) return;
        if (!confirm('수강신청 하시겠습니까?')) return;

        $.ajax({
            url: '/user/classApply',
            type: 'post',
            data: { claNum: claNum },
            success: function(result) {
                if (result === 'success') {
                    alert('수강신청이 완료되었습니다.');
                    closeCourseModal();
                    location.reload();
                } else if (result === 'already') {
                    alert('이미 수강신청한 강좌입니다.');
                } else if (result === 'full') {
                    alert('모집인원이 마감되었습니다.');
                } else if (result === 'denied') {
                    alert('수강생만 수강신청이 가능합니다.');
                } else {
                    alert('로그인이 필요합니다.');
                    location.href = '/commons/login';
                }
            },
            error: function() {
                alert('로그인이 필요합니다.');
                location.href = '/commons/login';
            }
        });
    }
</script>

</body>

</html>

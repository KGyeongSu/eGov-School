<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공무원채용</title>
    <link rel="stylesheet" href="/resources/css/MainPage/main.css">
    <link rel="stylesheet" href="/resources/css/MainPage/notice.css">
    <link
        href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;900&family=Gowun+Batang:wght@400;700&display=swap"
        rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/resources/js/script.js"></script>
</head>

<body>
    <%@ include file="../modules/header.jsp" %>

    <content>
        <div class="notice_wrap">
            <h2>공무원채용</h2>

            <!-- 탭 버튼 -->
            <div class="notice_tabs">
                <a href="/page/notice?tab=job"
                   class="tab_btn ${tab == 'job' || empty tab ? 'active' : ''}">채용공고</a>
                <a href="/page/notice?tab=exam"
                   class="tab_btn ${tab == 'exam' ? 'active' : ''}">시험공고</a>
            </div>

            <!-- 검색바 -->
            <div class="notice_search">
                <form action="/page/notice" method="get">
                    <input type="hidden" name="tab" value="${tab}">
                    <input type="text" name="keyword" placeholder="제목을 검색하세요"
                           value="${pageMaker.keyword}">
                    <button type="submit" class="notice_search_btn">검색</button>
                </form>
            </div>
            
            <!-- 글쓰기 버튼 (관리자만 보임) -->
            <sec:authorize access="hasRole('관리자')">
                <div class="notice_write_btn_wrap">
                    <button class="btn_write" onclick="openWriteModal()">글쓰기</button>
                </div>
            </sec:authorize>

            <!-- 채용공고 테이블 -->
            <c:if test="${tab == 'job' || empty tab}">
                <table class="notice_table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>등록일</th>
                            <th>조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty jobList}">
                                <c:forEach var="job" items="${jobList}" varStatus="status">
                                    <tr>
                                        <td>${pageMaker.totalCount - ((pageMaker.page - 1) * pageMaker.perPageNum) - status.index}</td>
                                        <td class="notice_title" onclick="openJobDetail('${job.jnNum}')">${job.jnTitle}</td>
                                        <td>${job.userName}</td>
                                        <td><fmt:formatDate value="${job.jnRegDate}" pattern="yyyy.MM.dd"/></td>
                                        <td>${job.jnViews}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="notice_empty">등록된 채용공고가 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </c:if>

            <!-- 시험공고 테이블 -->
            <c:if test="${tab == 'exam'}">
                <table class="notice_table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>등록일</th>
                            <th>조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty examList}">
                                <c:forEach var="exam" items="${examList}" varStatus="status">
                                    <tr>
                                        <td>${pageMaker.totalCount - ((pageMaker.page - 1) * pageMaker.perPageNum) - status.index}</td>
                                        <td class="notice_title" onclick="openExamDetail('${exam.enNum}')">${exam.enTitle}</td>
                                        <td>${exam.userName}</td>
                                        <td><fmt:formatDate value="${exam.enRegDate}" pattern="yyyy.MM.dd"/></td>
                                        <td>${exam.enViews}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="notice_empty">등록된 시험공고가 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </c:if>

            <!-- 페이지네이션 -->
            <div class="pagination">
                <a href="/page/notice?tab=${tab}&page=1&keyword=${pageMaker.keyword}" class="prev">《</a>
                <a href="/page/notice?tab=${tab}&page=${pageMaker.page - 1 < 1 ? 1 : pageMaker.page - 1}&keyword=${pageMaker.keyword}" class="prev">〈</a>

                <c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <a href="/page/notice?tab=${tab}&page=${pageNum}&keyword=${pageMaker.keyword}"
                       class="page ${pageMaker.page == pageNum ? 'active' : ''}">${pageNum}</a>
                </c:forEach>

                <a href="/page/notice?tab=${tab}&page=${pageMaker.page + 1 > pageMaker.realEndPage ? pageMaker.realEndPage : pageMaker.page + 1}&keyword=${pageMaker.keyword}" class="next">〉</a>
                <a href="/page/notice?tab=${tab}&page=${pageMaker.realEndPage == 0 ? 1 : pageMaker.realEndPage}&keyword=${pageMaker.keyword}" class="next">》</a>
            </div>

        </div>
        
	    <!-- 상세보기 모달 -->
	    <div id="noticeModal" class="modal_overlay" style="display:none;">
	        <div class="notice_modal">
	            <div class="nm_header">
	                <h3 class="nm_title"></h3>
	                <button class="nm_close" onclick="closeNoticeModal()">&times;</button>
	            </div>
	            <div class="nm_info">
	                <span class="nm_writer"></span>
	                <span class="nm_date"></span>
	                <span class="nm_views"></span>
	            </div>
	            <div class="nm_body">
	                <p class="nm_content"></p>
	            </div>
	            <div class="nm_footer">
	                <button class="nm_close_btn" onclick="closeNoticeModal()">닫기</button>
	            </div>
	        </div>
	    </div>
	    
	    <!-- 글쓰기 모달 (관리자 전용) -->
    <div id="writeModal" class="modal_overlay" style="display:none;">
        <div class="notice_modal">
            <div class="nm_header">
                <h3>공고 등록</h3>
                <button class="nm_close" onclick="closeWriteModal()">&times;</button>
            </div>
            <div class="nm_body">
                <div class="write_form">
                    <div class="write_field">
                        <label>제목</label>
                        <input type="text" id="writeTitle" placeholder="제목을 입력하세요">
                    </div>
                    <div class="write_field">
                        <label>내용</label>
                        <textarea id="writeContent" rows="10" placeholder="내용을 입력하세요"></textarea>
                    </div>
                </div>
            </div>
            <div class="nm_footer">
                <button class="nm_close_btn" onclick="closeWriteModal()">취소</button>
                <button class="btn_write_submit" onclick="submitNotice()">등록</button>
            </div>
        </div>
    </div>
	    
    </content>

    <%@ include file="../modules/footer.jsp" %>

</body>

<script>
	function openWriteModal() {
	    $('#writeTitle').val('');
	    $('#writeContent').val('');
	    $('#writeModal').show();
	}
	
	function closeWriteModal() {
	    $('#writeModal').hide();
	}
	
	function submitNotice() {
	    var title = $('#writeTitle').val().trim();
	    var content = $('#writeContent').val().trim();
	
	    if (!title) {
	        alert('제목을 입력하세요.');
	        return;
	    }
	    if (!content) {
	        alert('내용을 입력하세요.');
	        return;
	    }
	
	    // 현재 탭에 따라 채용공고 or 시험공고 구분
	    var tab = '${tab}' || 'job';
	    var url = tab === 'exam' ? '/page/insertExamNotice' : '/page/insertJobNotice';
	
	    $.ajax({
	        url: url,
	        type: 'POST',
	        data: {
	            title: title,
	            content: content
	        },
	        success: function(result) {
	            if (result === 'success') {
	                alert('공고가 등록되었습니다.');
	                closeWriteModal();
	                location.reload();
	            } else {
	                alert('등록에 실패했습니다.');
	            }
	        },
	        error: function() {
	            alert('서버 오류가 발생했습니다.');
	        }
	    });
	}
	
	$(document).on('click', '.modal_overlay', function(e) {
	    if (e.target === this) {
	        closeNoticeModal();
	        closeWriteModal();
	    }
	});


    function openJobDetail(jnNum) {
        $.ajax({
            url: '/page/jobDetail',
            type: 'GET',
            data: { jnNum: jnNum },
            dataType: 'json',
            success: function(data) {
                $('.nm_title').text(data.jnTitle);
                $('.nm_writer').text('작성자: ' + data.userName);

                var date = new Date(data.jnRegDate);
                var dateStr = date.getFullYear() + '.' + String(date.getMonth()+1).padStart(2,'0') + '.' + String(date.getDate()).padStart(2,'0');
                $('.nm_date').text('등록일: ' + dateStr);

                $('.nm_views').text('조회수: ' + data.jnViews);
                $('.nm_content').text(data.jnContent);

                $('#noticeModal').show();
            },
            error: function() {
                alert('공고 정보를 불러올 수 없습니다.');
            }
        });
    }

    function openExamDetail(enNum) {
        $.ajax({
            url: '/page/examDetail',
            type: 'GET',
            data: { enNum: enNum },
            dataType: 'json',
            success: function(data) {
                $('.nm_title').text(data.enTitle);
                $('.nm_writer').text('작성자: ' + data.userName);

                var date = new Date(data.enRegDate);
                var dateStr = date.getFullYear() + '.' + String(date.getMonth()+1).padStart(2,'0') + '.' + String(date.getDate()).padStart(2,'0');
                $('.nm_date').text('등록일: ' + dateStr);

                $('.nm_views').text('조회수: ' + data.enViews);
                $('.nm_content').text(data.enContent);

                $('#noticeModal').show();
            },
            error: function() {
                alert('공고 정보를 불러올 수 없습니다.');
            }
        });
    }

    function closeNoticeModal() {
        $('#noticeModal').hide();
    }

    $(document).on('click', '.modal_overlay', function(e) {
        if (e.target === this) {
            closeNoticeModal();
        }
    });
</script>


</html>
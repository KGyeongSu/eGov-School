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
                            <img src="/resources/images/slide1.png" />
                    </li>
                    
                    <li>
                            <img src="/resources/images/slide2.png" />
                    </li>
                    
                    <li>
                            <img src="/resources/images/slide3.png" />
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
			                <div class="card">
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

    
	<%@ include file="modules/footer.jsp" %>
</body>

</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="../modules/lecHeader.jsp" %>
	<!-- 개별 css -->	
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styleresultManage.css" />
    
    <title>reputationHome</title>
</head>

<body>
    <div class="content">
        <div class="top">
            <div class="icon">
                <a href="${pageContext.request.contextPath }/lecterer/mainDashBoard"><i class="fa-regular fa-user"></i></a>
            </div>
            <div class="state_bar">
                <p>${loginUser.userName}님의 메인 대시보드</p>
            </div>
            <div class="logout_dash">
                 <div class="mes" onclick="location.href='reputationHome';" style="cursor: pointer; position: relative; display: inline-block;">
				    <i class="fa-regular fa-envelope"></i>
				    <span id="repBadge" style="position: absolute; top: 5px; right: 50px; background-color: #dc3545; color: white; font-size: 10px; font-weight: bold; padding: 2px 6px; border-radius: 50%; display: none; border: 2px solid white;">
				    	0
				    </span>
				</div>
               	<div class="out">
					<button type="button" class="btn btn-sm" onclick="location.href='${pageContext.request.contextPath}/commons/logout'"
						style="background-color: #1a6d91; color: white; border-radius: 4px; font-size: 12px; border: none; line-height: 1;">로그아웃
					</button>
				</div>
            </div>
        </div>
        <div class="divider">
            <div class="meg">
                <h2>My 메시지</h2>
            </div>
            <div class="search">
                <div class="search_area" style="display: flex; gap: 10px; width: 96%;">
                    <div style="position: relative; flex: 1;">
                        <i class="fa-solid fa-magnifying-glass"
                            style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #adb5bd; font-size: 14px;"></i>
                        <input type="text" id="keywordInput" placeholder="피드백 검색" value="${pageMaker.keyword}" onkeyup="if(window.event.keyCode==13){search_list(1);}" 
                            style="width: 100%; padding: 10px 10px 10px 35px; border: 1px solid #d1d1d1; border-radius: 6px; font-size: 14px; outline: none; box-sizing: border-box;">
                    </div>
                    <button type="button" onclick="search_list(1);" style="background-color: #0e506e; color: white; border: none; padding: 0 20px; border-radius: 6px; cursor: pointer; font-size: 14px; font-weight: 500;">검색</button>
                </div>
            </div>
        </div>
        <div class="main" id="userListArea">
            <div class="listwrap">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 5%; text-align: center; padding: 15px 10px;">No.</th>
                            <th style="width: 10%; text-align: center;">구분</th>
                            <th style="width: 65%; text-align: left; padding-left: 100px;">내용</th>
                            <th style="width: 20%; text-align: center;">날짜 및 관리</th>
                        </tr>
                    </thead>
                    <tbody>
					    <c:if test="${empty reputationList}">
					        <tr>
					            <td colspan="4" style="text-align: center; padding: 50px; color: #999;">
					                받은 피드백이 없습니다.
					            </td>
					        </tr>
					    </c:if>
					
					    <c:if test="${not empty reputationList}">
					        <c:forEach items="${reputationList}" var="rep" varStatus="status">
					            <tr style="${rep.repCheck eq 'Y' ? 'background-color: #f8f9fa;' : ''}">
					                <td style="text-align: center; color: #24272b; font-size: 13px; font-weight: 500;">
					                    ${(pageMaker.page - 1) * pageMaker.perPageNum + status.count}
					                </td>
					                
					                <td>
					                    <c:choose>
					                        <c:when test="${rep.userRole eq '관리자'}">
					                            <span class="mbtn">관리자</span>
					                        </c:when>
					                        <c:otherwise>
					                            <span class="ubtn">수강생</span>
					                        </c:otherwise>
					                    </c:choose>
					                </td>
					                
					                <td style="padding-left: 100px;">
					                    <div style="font-weight: 700; color: #0e506e; font-size: 14px; margin-bottom: 5px;">
					                        [${rep.claTitle}]
					                    </div>
					                    <div style="color: #24272b; font-size: 14px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 550px;">
					                        <c:choose>
					                            <c:when test="${fn:length(rep.repContent) > 12}">
					                                ${fn:substring(rep.repContent, 0, 12)}...
					                            </c:when>
					                            <c:otherwise>
					                                ${rep.repContent}
					                            </c:otherwise>
					                        </c:choose>
					                    </div>
					                </td>
					                
					                <td style="text-align: center;">
					                    <span style="font-size: 13px; color: #24272b; margin-right: 15px;">
					                        <fmt:formatDate value="${rep.repRegDate}" pattern="yyyy-MM-dd" />
					                    </span>
					                    <c:choose>
					                        <c:when test="${rep.repCheck eq 'Y'}">
					                            <button type="button" style="background-color: #e9ecef; color: #6c757d; border: 1px solid #dee2e6; padding: 6px 12px; border-radius: 4px; font-size: 12px; cursor: default;">
					                                확인완료
					                            </button>
					                        </c:when>
					                        <c:otherwise>
					                            <button type="button" onclick="updateBadgeDirectly(this); OpenWindow('/lecterer/reputationDetail?repNum=${rep.repNum}', '피드백 상세', 900, 650);" style="background: #fff; border: 1px solid #d1d1d1; padding: 6px 12px; border-radius: 4px; font-size: 12px; cursor: pointer;">
					                                상세보기
					                            </button>
					                        </c:otherwise>
					                    </c:choose>
					                </td>
					            </tr>
					        </c:forEach>
					    </c:if>
					</tbody>
                </table>

            	</div>
                <!-- 페이지네이션 -->
                <div class="pagination_wrapper" >
						<!-- pagination -->
						<%@ include file="/WEB-INF/views/modules/pagination.jsp"%>
				</div>
        	</div>
    	</div>
	</body>

<script src="/resources/js/commons.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
    $(document).ready(function() {
    	
        // 알림 배지 초기 로드 및 1분마다 갱신
        updateReputationAlarm();
        setInterval(updateReputationAlarm, 60000);
        
    });

    // 알림 배지 AJAX 함수
    function updateReputationAlarm() {
        $.ajax({
            url: '${pageContext.request.contextPath}/lecterer/reputationAlarm',
            type: 'GET',
            success: function(count) {
                const badge = $('#repBadge');
                if (count > 0) {
                    badge.text(count).show();
                } else {
                    badge.hide();
                }
            }
        });
    }
    
    function updateBadgeDirectly(btn, repNum) {
    	
        const isClicked = $(btn).attr('data-clicked'); 
        
        if (isClicked !== 'Y') {
        	
            const badge = $('#repBadge');
            let currentCount = parseInt(badge.text()) || 0; 

            if (currentCount > 0) {
                currentCount -= 1;
                if (currentCount > 0) {
                    badge.text(currentCount).show();
                } else {
                    badge.hide(); 
                }
            }
            
            $(btn).attr('data-clicked', 'Y');
            $(btn).closest('tr').css('background-color', '#f8f9fa');
            $(btn).text('확인완료').css({
                'background-color': '#e9ecef',
                'color': '#6c757d',
                'border-color': '#dee2e6'
            });

        }
    }

    // 검색 실행 함수
    function search_list(page) {
    	
        let url = "reputationHome";
        url += "?page=" + page;
        url += "&perPageNum=${pageMaker.perPageNum}";
        url += "&keyword=" + encodeURIComponent($('#keywordInput').val());
        
        location.href = url;
        
    }
</script>

</html>
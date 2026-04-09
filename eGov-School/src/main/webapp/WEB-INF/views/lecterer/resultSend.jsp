<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../modules/lecHeader.jsp" %>

	<!-- 개별 css -->
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styleresultSend.css" />
    
    <!-- 그래프 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <title>resultSend</title>
</head>

<body>
    <div class="content">
        <div class="top">
            <div class="icon">
                <a href="${pageContext.request.contextPath }/lecterer/mainDashBoard"><i class="fa-regular fa-user"></i></a>
            </div>
            <div class="state_bar">
                <p>평가 관리</p>
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
            <div class="write">
			    <a href="/lecterer/resultManage?userNum=${loginUser.userNum}">
			        <h2>평가 출제</h2>
			    </a>
			</div>
			<div class="manage">
			    <a href="/lecterer/resultSend?userNum=${loginUser.userNum}">
			        <h2>평가 관리</h2>
			    </a>
			</div>
            <div class="search">
                <div class="search_area" style="display: flex; gap: 10px; width: 96%;">
                    <div style="position: relative; flex: 1;">
                        <i class="fa-solid fa-magnifying-glass"
                            style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #adb5bd; font-size: 14px;"></i>
                        <input type="text" id="keywordInput" value="${pageMaker.keyword}" placeholder="평가 관리 강의 검색" onkeyup="if(window.event.keyCode==13){search_list(1)}"
                            style="width: 100%; padding: 10px 10px 10px 35px; border: 1px solid #d1d1d1; border-radius: 6px; font-size: 14px; outline: none; box-sizing: border-box;">
                    </div>
                    <button type="button" onclick="search_list(1);"
                        style="background-color: #0e506e; color: white; border: none; padding: 0 20px; border-radius: 6px; cursor: pointer; font-size: 14px; font-weight: 500;">검색</button>
                </div>
            </div>
            </div>
	        <div class="main" id="userListArea">
	            <div class="listwrap">
	                <table style="width: 100%; border-collapse: collapse; text-align: left;">
	                    <thead>
	                        <tr style="background-color: #f8f9fa; border-bottom: 2px solid #dee2e6;">
	                        	<th style="width: 5%; text-align: center; padding: 15px 10px;">No.</th>
	                            <th style="padding: 18px 20px; font-weight: 600; color: #495057; width: 40%;">평가 관리 강의명</th>
	                            <th style="padding: 18px 260px; font-weight: 600; color: #495057; width: 20%; text-align: right;">관리</th>
	                        </tr>
	                    </thead>
	                    <tbody>
					    <c:choose>
					        <%-- 1. 데이터가 있는 경우 --%>
					        <c:when test="${not empty resultSendList}">
					            <c:forEach var="test" items="${resultSendList}" varStatus="status">
					                <tr style="border-bottom: 1px solid #f1f1f1; transition: background 0.2s;">
					                    <td style="text-align: center; color: #24272b; font-size: 13px;">${(pageMaker.page - 1) * pageMaker.perPageNum + status.count}</td>
					                    <td style="padding: 18px 20px;">
					                        <div style="font-weight: 600; color: #212529;">${test.claTitle}</div>
					                    </td>
					                    <td style="padding: 18px 15px; text-align: right; white-space: nowrap;">
					                        <button type="button" onclick="OpenWindow('/lecterer/messageForm?claNum=${test.claNum}&tetNum=${test.tetNum}', '평가 발송', 900, 650);"
					                            style="background: #fff; border: 1px solid #d1d1d1; color: #495057; padding: 7px 12px; border-radius: 4px; font-size: 13px; cursor: pointer; transition: all 0.2s; display: inline-flex; align-items: center; gap: 6px; margin-right: 10px;"
					                            onmouseover="this.style.backgroundColor='#f1f1f1';"
					                            onmouseout="this.style.backgroundColor='#fff';">
					                            <i class="fa-solid fa-paper-plane"></i> 평가 발송
					                        </button>
					
					                        <button type="button" onclick="OpenWindow('/lecterer/giveForm?claNum=${test.claNum}', '평가 제출', 900, 550);"
					                            style="background: #fff; border: 1px solid #d1d1d1; color: #495057; padding: 7px 12px; border-radius: 4px; font-size: 13px; cursor: pointer; transition: all 0.2s; display: inline-flex; align-items: center; gap: 6px; margin-right: 10px;"
					                            onmouseover="this.style.backgroundColor='#f1f1f1';"
					                            onmouseout="this.style.backgroundColor='#fff';">
					                            <i class="fa-solid fa-file-import"></i> 평가 제출
					                        </button>
					
					                        <button type="button" 
										        class="${empty test.cerNum ? 'certi-btn-active' : 'certi-btn-disabled'}"
										        <c:if test="${empty test.cerNum}">onclick="OpenWindow('/lecterer/certiGo?claNum=${test.claNum}', '수료증 등록', 900, 400);"</c:if>
										        <c:if test="${not empty test.cerNum}">disabled</c:if>
										        style="padding: 7px 12px; border-radius: 4px; font-size: 13px; transition: all 0.2s; display: inline-flex; align-items: center; gap: 6px; margin-right: 10px;">
										        <i class="fa-solid fa-award"></i> 수료증 등록
										    </button>
										
										    <button type="button" 
										        class="${not empty test.cerNum ? 'certi-btn-active' : 'certi-btn-disabled'}"
										        <c:if test="${not empty test.cerNum}">onclick="OpenWindow('/lecterer/certiGo?claNum=${test.claNum}', '수료증 수정', 900, 400);"</c:if>
										        <c:if test="${empty test.cerNum}">disabled</c:if>
										        style="padding: 7px 12px; border-radius: 4px; font-size: 13px; transition: all 0.2s; display: inline-flex; align-items: center; gap: 6px; margin-right: 35px;">
										        <i class="fa-solid fa-pen-to-square"></i> 수료증 수정
										    </button>
					                    </td>
					                </tr>
					            </c:forEach>
					        </c:when>
					        <%-- 2. 데이터가 없는 경우 --%>
					        <c:otherwise>
					            <tr>
					                <td colspan="3" style="text-align: center; padding: 50px; color: #868e96;">
					                    조회된 강의 내역이 없습니다.
					                </td>
					            </tr>
					        </c:otherwise>
					    </c:choose>
					</tbody>
	            </table>
	            </div>
	            <div class="pagination_wrapper">
					<!-- pagination -->
					<%@ include file="/WEB-INF/views/modules/pagination.jsp"%>
				</div>
	     </div>
   	</div>
</body>

<script src="../../../resources/js/commons.js"></script>
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
    
</script>

</html>
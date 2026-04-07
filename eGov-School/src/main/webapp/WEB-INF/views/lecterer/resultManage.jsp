<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../modules/lecHeader.jsp" %>
	<!-- 개별 css -->
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styleresultManage.css" />
    
    <!-- 그래프 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <title>resultManage</title>
</head>

<body>
    <div class="content">
        <div class="top">
            <div class="icon">
                <a href=""><i class="fa-regular fa-user"></i></a>
            </div>
            <div class="state_bar">
                <p>My 평가</p>
            </div>
            <div class="logout_dash">
                <div class="mes" onclick="location.href='reputationHome';" style="cursor: pointer;">
				    <i class="fa-regular fa-envelope"></i>
				</div>
                <div class="out">
                    <button type="button" class="btn btn-sm"
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
                        <input type="text" id="keywordInput" value="${pageMaker.keyword}" placeholder="평가 강의 검색" onkeyup="if(window.event.keyCode==13){search_list(1)}"
                            style="width: 100%; padding: 10px 10px 10px 35px; border: 1px solid #d1d1d1; border-radius: 6px; font-size: 14px; outline: none; box-sizing: border-box;">
                    </div>
                    <button type="button" onclick="search_list(1);"
                        style="background-color: #0e506e; color: white; border: none; padding: 0 20px; border-radius: 6px; cursor: pointer; font-size: 14px; font-weight: 500;">검색</button>
                </div>
            </div>
        </div>
        <div class="main" id="userListArea">
            <div class="listwrap" >
                <table style="width: 100%; border-collapse: collapse; text-align: left;">
                    <thead>
                        <tr style="background-color: #f8f9fa; border-bottom: 2px solid #dee2e6;">
                        	<th style="width: 5%; text-align: center; padding: 15px 10px;">No.</th>
                            <th style="padding: 18px 20px; font-weight: 600; color: #495057; width: 40%;">평가 출제 강의명</th>
                            <th style="padding: 18px 200px; font-weight: 600; color: #495057; width: 20%; text-align: right;">관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 리스트 -->
                        <c:choose>
							<c:when test="${empty testList}">
					            <tr>
					                <td colspan="3" style="text-align: center; padding: 100px 0; color: #adb5bd; font-size: 15px; background-color: #ffffff;">
					                    <i class="fa-solid fa-file-circle-xmark" style="font-size: 40px; color: #dee2e6; display: block; margin-bottom: 15px;"></i>
					                    시험을 출제할 강좌가 없습니다.
					                </td>
					            </tr>
					        </c:when>
	                        <c:otherwise>
					            <c:forEach var="test" items="${testList}" varStatus="status">
								    <tr style="border-bottom: 1px solid #f1f1f1; transition: background 0.2s;">
								        <td style="text-align: center; color: #24272b; font-size: 13px;">${(pageMaker.page - 1) * pageMaker.perPageNum + status.count}</td>
								        
								        <td style="padding: 18px 20px;">
								            <div style="font-weight: 600; color: #212529;">${test.claTitle}</div>
								        </td>
								        
								        <td style="padding: 18px 103px; text-align: right;">
								            <c:choose>
								                <%-- ★ 이미 시험을 출제한 경우 --%>
								                <c:when test="${not empty test.tetNum}">
								                    <button type="button" disabled
								                        style="background: #f8f9fa; border: 1px solid #dee2e6; color: #adb5bd; padding: 7px 15px; border-radius: 4px; font-size: 13px; cursor: not-allowed; display: inline-flex; align-items: center; gap: 6px; margin-right: 10px;">
								                        <i class="fa-solid fa-check"></i> 출제완료
								                    </button>
								                    
								                    <button type="button"
								                        style="background: #fff; border: 1px solid #d1d1d1; color: #495057; padding: 7px 15px; border-radius: 4px; font-size: 13px; cursor: pointer; transition: all 0.2s; display: inline-flex; align-items: center; gap: 6px;"
								                        onclick="location.href='testEdit?claNum=${test.claNum}';">
								                        <i class="fa-solid fa-file-pen"></i> 수정하기
								                    </button>
								                </c:when>
								
								                <%-- ★ CASE 2: 아직 시험을 출제하지 않은 경우 (tetNum이 없음) --%>
								                <c:otherwise>
								                    <button type="button"
								                        style="background: #fff; border: 1px solid #d1d1d1; color: #495057; padding: 7px 15px; border-radius: 4px; font-size: 13px; cursor: pointer; transition: all 0.2s; display: inline-flex; align-items: center; gap: 6px; margin-right: 10px;"
								                        onclick="location.href='testMake?claNum=${test.claNum}';">
								                        <i class="fa-solid fa-file-circle-plus"></i> 출제하기
								                    </button>
								                    
								                    <button type="button" disabled
								                        style="background: #f8f9fa; border: 1px solid #dee2e6; color: #adb5bd; padding: 7px 15px; border-radius: 4px; font-size: 13px; cursor: not-allowed; display: inline-flex; align-items: center; gap: 6px;">
								                        <i class="fa-solid fa-file-pen"></i> 수정하기
								                    </button>
								                </c:otherwise>
								            </c:choose>
								        </td>
								    </tr>
								</c:forEach>
	        				</c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            <div class="pagination_wrapper" >
				<!-- pagination -->
				<%@ include file="/WEB-INF/views/modules/pagination.jsp"%>
			</div>
        </div>
    </div>
    
<script src="/resources/js/commons.js"></script>

</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styleForm.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        crossorigin="anonymous" referrerpolicy="no-referrer" />

    <title>reputationDetail</title>
</head>

<body>
    <div class="inner reputation_detail_page">
        <div class="form">
            <div class="form_top">
                <h2 class="title">[${rdetail.claTitle}] 피드백 상세 보기</h2>
                <div class="send_btn">
                    <button type="button" class="btn" onclick="go_back();">
                        <i class="fa-solid fa-xmark" style="margin-top: 3px;"></i>닫기
                    </button>
                </div>
            </div>

            <div class="form_mid">
                <div class="info_group">
				    <label>발신 구분</label>
				    <div class="read_only_box" style="display: flex; align-items: center;">
				        <c:choose>
				            <c:when test="${rdetail.userRole eq '관리자'}">
				                <span style=" background-color: #82d932; color: #24272b; padding: 6px 12px; border-radius: 4px; font-size: 13px; font-weight: bold; display: inline-block; line-height: 1; ">
				                	관리자
				                </span>
				            </c:when>
				            <c:otherwise>
				                <span style=" background-color: #ebf1f6; color: #24272b;  padding: 6px 12px; border-radius: 4px; font-size: 13px; font-weight: bold; line-height: 1; ">
				                	수강생
				                </span>
				            </c:otherwise>
				        </c:choose>
				        <span style="margin-left: 10px; font-size: 14px; color: #24272b; font-weight: 500;">
				            ${rdetail.userName} 님
				        </span>
				    </div>
				</div>

                <div class="info_group" style="margin-top: 15px;">
                    <label>수신 일시</label>
                    <div class="read_only_text">
                        <fmt:formatDate value="${rdetail.repRegDate}" pattern="yyyy-MM-dd" />
                    </div>
                </div>
            </div>

            <div class="form_bot">
                <div class="message_detail_box">
                    <label>피드백 상세 내용</label>
                    <div class="message_content" style="max-height: 200px; overflow-y: auto;" >
                        <p style="position: relative; top: -55px;">${rdetail.repContent}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

<script src="/resources/js/commons.js"></script>

<script>
	
	function go_back () {
		
		window.close();
		
	}

</script>

</html>
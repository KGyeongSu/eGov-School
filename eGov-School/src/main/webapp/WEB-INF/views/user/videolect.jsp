<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강좌 시청 - ${lesson.lsnTitle}</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/styleV.css" />
<%@include file="../modules/userHeader.jsp"%>
<style>

    #lectureVideo {
        background-color: #000;
        display: block;
        width: 100%; 
    }
</style>
</head>
<body class="videolet">
    <div class="content">
        <div class="mid">
            <div class="videodash">
                <div class="letti">
                    <h3>${lesson.lsnTitle}
                        <small style="color: #7f8c8d; font-size: 18px; font-weight: normal;">(${lesson.lsnSeq}차시)</small>
                    </h3>

                    <div style="margin-left: auto; display: flex; gap: 10px; align-items: center;">
                        <c:if test="${not empty lesson.lessonFiles}">
                            <c:forEach items="${lesson.lessonFiles}" var="file">
                                <c:set var="fName" value="${file.laSaveName.toLowerCase()}" />
                                <c:if test="${!fName.contains('.mp4') && !fName.contains('.avi') && !fName.contains('.wmv')}">
                                    <a href="${pageContext.request.contextPath}/user/common/download?laNum=${file.laNum}" class="downloadbtn"> 
                                        <i class="fa-solid fa-file-arrow-down"></i> <span>학습자료</span>
                                    </a>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/user/myKang" class="return"> 
                            <i class="fa-solid fa-list"></i> <span>목록</span>
                        </a>
                    </div>
                </div>

                <div class="videochair">
                    <c:choose>
                        <c:when test="${not empty lesson.lsnVideo}">
                            <video id="lectureVideo" controls controlsList="nodownload" oncontextmenu="return false;">
                                <source src="${pageContext.request.contextPath}/resources/upload/lesson/${lesson.lsnVideo}" type="video/mp4">
                                브라우저가 비디오 재생을 지원하지 않습니다.
                            </video>
                        </c:when>
                        <c:otherwise>
                            <div style="color: #fff; text-align: center;">
                                <i class="fa-solid fa-video-slash" style="font-size: 40px; margin-bottom: 10px;"></i><br>
                                재생 가능한 영상이 없습니다.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="letco">
                    <div class="learning-info" style="flex: 1;">
                        <h4><i class="fa-solid fa-bullseye"></i> 학습 목표</h4>
                        <div class="goal-content">
                            <c:out value="${empty lesson.lsnContent ? '등록된 학습 목표가 없습니다.' : lesson.lsnContent}" />
                        </div>
                    </div>

                    <div class="lecture-nav">
                        <%-- 이전 강의 버튼 --%>
                        <c:choose>
                            <c:when test="${lesson.lsnSeq > 1}">
                                <a href="?claNum=${lesson.claNum}&lsnSeq=${lesson.lsnSeq - 1}" class="nav-btn prev"> 
                                    <i class="fa-solid fa-chevron-left"></i> 이전 강의
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="nav-btn prev disabled">첫 강의</span>
                            </c:otherwise>
                        </c:choose>

                        <%-- 다음 강의 버튼 (lsnSeq와 전체 강의 수 비교) --%>
                        <c:choose>
                            <c:when test="${not empty lesson.lsnSeq and lesson.lsnSeq < totalLsnCount}"> 
                                <a href="?claNum=${lesson.claNum}&lsnSeq=${lesson.lsnSeq + 1}" class="nav-btn next"> 
                                    다음 강의 <i class="fa-solid fa-chevron-right"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="nav-btn next disabled">마지막 강의</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            const video = document.getElementById('lectureVideo');
            if (!video) return;

            let isSubmitted = false;
            video.onended = function() {
                if (!isSubmitted) {
                    $.ajax({
                        url : '${pageContext.request.contextPath}/user/updateProgress',
                        type : 'POST',
                        data : {
                            claNum : '${lesson.claNum}',
                            lsnSeq : '${lesson.lsnSeq}'
                        },
                        success : function(res) {
                            if(res === "success") {
                                isSubmitted = true;
                                alert("이번 차시 학습을 완료했습니다!");
                                location.reload(); 
                            }
                        }
                    });
                }
            };
        });
    </script>
</body>
</html>
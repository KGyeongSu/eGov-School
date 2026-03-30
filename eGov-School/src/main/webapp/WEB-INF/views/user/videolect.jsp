<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>강좌 시청</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/styleV.css" />
    <%@include file="../modules/userHeader.jsp" %>
</head>
<body class="videolet">
    <div class="content">
        <div class="mid">
            <div class="videodash">
                <div class="letti">
                    <h3>${lesson.claName} - ${lesson.lsnTitle} (${lesson.lsnSeq}차시)</h3>
                    <c:if test="${not empty lesson.lessonFiles}">
                        <c:forEach items="${lesson.lessonFiles}" var="file">
                            <a href="${pageContext.request.contextPath}/download?fileNum=${file.laNum}" class="downloadbtn" style="margin-right:5px;">
                                <i class="fa-solid fa-file"></i>
                                <span>${file.laName}</span>
                            </a>
                        </c:forEach>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/user/myKang" class="return">
                        <i class="fa-solid fa-arrow-rotate-left"></i>
                        <span>목록</span>
                    </a>
                </div>
                <div class="videochair">
                    <video id="lectureVideo" controls autoplay style="width: 100%; height: 100%; background: #000;">
                        <source src="${pageContext.request.contextPath}/resources/videos/${lesson.lsnVideo}" type="video/mp4">
                    </video>
                </div>
                <div class="letco">
                    <div class="learning-info">
                        <h4><i class="fa-solid fa-bullseye"></i> 오늘의 학습 목표</h4>
                        <ul>
                            <li>${lesson.lsnContent}</li>
                        </ul>
                    </div>
                    <div class="lecture-nav">
                        <c:choose>
                            <c:when test="${lesson.lsnSeq > 1}">
                                <a href="?claNum=${lesson.claNum}&lsnSeq=${lesson.lsnSeq - 1}" class="nav-btn prev">
                                    <i class="fa-solid fa-chevron-left"></i> 이전 강의
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="nav-btn prev disabled">첫 번째 강의</span>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${lesson.lsnSeq < 12}">
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
        let isUpdated = false;

        video.onended = function() {
            if(!isUpdated) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/user/updateProgress',
                    type: 'POST',
                    data: {
                        claNum: '${lesson.claNum}',
                        lsnSeq: '${lesson.lsnSeq}'
                    },
                    success: function(res) {
                        isUpdated = true;
                    },
                    error: function(err) {
                        console.error("Update failed");
                    }
                });
            }
        };
    });
    </script>
</body>
</html>
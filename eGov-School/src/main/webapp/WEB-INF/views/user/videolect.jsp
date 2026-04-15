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
    /* 상태 배지 스타일 */
    .status-badge {
        font-size: 11px;
        padding: 2px 6px;
        border-radius: 4px;
        margin-left: auto;
        font-weight: bold;
        color: #fff;
    }
    .status-complete { background-color: #2ecc71; } /* 초록: 이수완료 */
    .status-ing { background-color: #3498db; }      /* 파랑: 수강중 */
    .status-none { background-color: #e74c3c; }     /* 빨강: 미이수 */
    
    /* 잠긴 강의 리스트 아이템 스타일 */
    .locked {
        opacity: 0.5;
        cursor: not-allowed !important;
    }
    .locked a {
        pointer-events: none; /* 클릭 방지 보조 */
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

                <div class="video-main-body">
                    <div class="videochair">
                        <c:choose>
                            <c:when test="${not empty lesson.lsnVideo}">
                                <video id="lectureVideo" controls controlsList="nodownload" oncontextmenu="return false;">
                                    <source src="${pageContext.request.contextPath}/upload/lesson/${lesson.lsnVideo}" type="video/mp4">
                                    브라우저가 비디오 재생을 지원하지 않습니다.
                                </video>
                            </c:when>
                            <c:otherwise>
                                <div style="color: #fff; text-align: center; padding: 100px 0;">
                                    <i class="fa-solid fa-video-slash" style="font-size: 40px; margin-bottom: 10px;"></i><br>
                                    재생 가능한 영상이 없습니다.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <aside class="chapter-sidebar">
                        <div class="sidebar-header">
                            <i class="fa-solid fa-layer-group"></i> 강좌 구성
                        </div>
                        <ul class="chapter-list">
                            <%-- 루프 시작 전, 이전 강의 완료 여부 초기화 (첫 강의는 무조건 열려있어야 함) --%>
                            <c:set var="prevStatus" value="Y" />
                            
                            <c:forEach items="${lessonList}" var="list" varStatus="status">
                                <%-- 1. 현재 루프의 강의가 수강 완료된 상태인지 userProgressList에서 찾기 --%>
                                <c:set var="currentComplete" value="N" />
                                <c:forEach items="${userProgressList}" var="prog">
                                    <c:if test="${prog.lsnNum == list.lsnNum}">
                                        <c:set var="currentComplete" value="${prog.prgComplete}" />
                                    </c:if>
                                </c:forEach>

                                <%-- 2. 이전 강의가 완료('Y')가 아니라면 잠금 대상 --%>
                                <c:set var="isLocked" value="${prevStatus != 'Y'}" />

                                <li class="chapter-item ${list.lsnNum == lesson.lsnNum ? 'active' : ''} ${isLocked ? 'locked' : ''}">
                                    <a href="?claNum=${lesson.claNum}&lsnNum=${list.lsnNum}" 
                                       class="chapter-link" 
                                       onclick="return checkAccess(event, ${isLocked});">
                                        <span class="chapter-seq">${list.lsnSeq}</span>
                                        <span class="chapter-title">${list.lsnTitle}</span>
                                        
                                        <c:choose>
                                            <c:when test="${currentComplete == 'Y'}">
                                                <span class="status-badge status-complete">이수 완료</span>
                                            </c:when>
                                            <c:when test="${list.lsnNum == lesson.lsnNum}">
                                                <span class="status-badge status-ing">이수 중</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-none">미이수</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </li>
                                
                                <%-- 3. 다음 루프를 위해 현재 강의의 완료 상태를 prevStatus에 저장 --%>
                                <c:set var="prevStatus" value="${currentComplete}" />
                            </c:forEach>
                        </ul>
                    </aside>
                </div>

                <div class="letco">
                    <div class="learning-info" style="flex: 1;">
                        <h4><i class="fa-solid fa-bullseye"></i> 학습 목표</h4>
                        <div class="goal-content">
                            <c:out value="${empty lesson.lsnContent ? '등록된 학습 목표가 없습니다.' : lesson.lsnContent}" />
                        </div>
                    </div>

                    <div class="lecture-nav">
                        <c:choose>
                            <c:when test="${not empty prevLsnNum}">
                                <a href="?claNum=${lesson.claNum}&lsnNum=${prevLsnNum}" class="nav-btn prev"> 
                                    <i class="fa-solid fa-chevron-left"></i> 이전 강의
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="nav-btn prev disabled">첫 강의</span>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="${not empty nextLsnNum}">
                                <%-- 다음 강의 버튼 활성화 체크: 현재 보고 있는 lesson이 userProgressList에서 완료되었는지 확인 --%>
                                <c:set var="thisLessonComplete" value="N" />
                                <c:forEach items="${userProgressList}" var="p">
                                    <c:if test="${p.lsnNum == lesson.lsnNum}">
                                        <c:set var="thisLessonComplete" value="${p.prgComplete}" />
                                    </c:if>
                                </c:forEach>
                                
                                <c:set var="nextLocked" value="${thisLessonComplete != 'Y'}" />
                                <a href="?claNum=${lesson.claNum}&lsnNum=${nextLsnNum}" 
                                   class="nav-btn next ${nextLocked ? 'locked' : ''}"
                                   onclick="return checkAccess(event, ${nextLocked});"> 
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
    // 강의 접근 제한 체크 함수
    function checkAccess(event, isLocked) {
        if (isLocked) {
            event.preventDefault(); // href 이동 차단
            alert("이전 차시 강의 수강을 완료해야 다음 강의를 수강할 수 있습니다.");
            return false;
        }
        return true;
    }

    $(document).ready(function() {
        const video = document.getElementById('lectureVideo');
        if (!video) return;

        const claNum = "${lesson.claNum}";
        const lsnNum = "${lesson.lsnNum}";

        let isSubmitted = false;
        
        video.onended = function() {
            if (!isSubmitted) {
                if(!lsnNum || lsnNum === "") return;

                $.ajax({
                    url : '${pageContext.request.contextPath}/user/updateProgress',
                    type : 'POST',
                    data : { claNum : claNum, lsnNum : lsnNum },
                    success : function(res) {
                        if(res.trim() === "success") {
                            isSubmitted = true;
                            alert("이번 차시 학습을 완료했습니다! 이제 다음 강의 수강이 가능합니다.");
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>대시보드</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/style.css" />
    <%@include file="../modules/userHeader.jsp" %>
    <style>
        .section-header { border-bottom: 2px solid #0e506e; padding-bottom: 10px; margin-bottom: 20px; }
        .course-card-custom { background: #fff; border-radius: 12px; overflow: hidden; border: 1px solid #eee; transition: 0.3s; }
        .course-card-custom:hover { transform: translateY(-5px); box-shadow: 0 8px 15px rgba(0,0,0,0.1); }
    </style>
</head>
<body>   
    <div class="mid" style="padding: 30px 40px;">
        <div class="container-fluid">
            
            <div class="section-header">
                <h4 style="font-weight: bold; color: #0e506e; margin: 0;">
                    <i class="fa-solid fa-book-open-reader mr-2"></i>수강 중인 강좌
                </h4>
            </div>

            <div class="card_wrap">
                <div class="row">
                    <c:choose>
                        <c:when test="${empty result.applyList}">
                            <div class="col-12 text-center" style="padding: 80px 0; color: #888;">
                                <i class="fa-solid fa-folder-open mb-3" style="font-size: 40px; display: block;"></i>
                                수강 중인 강좌 내역이 없습니다.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <%-- 최근 수강 강좌 최대 3개만 노출 --%>
                            <c:forEach items="${result.applyList}" var="apply" end="2">
                                <div class="col-md-4 mb-4">
                                    <div class="course-card-custom shadow-sm">
                                        <div class="card-thumb-area" style="position: relative; height: 180px;">
                                            <div style="position: absolute; top: 10px; left: 10px; z-index: 2; background: #ff4757; color: #fff; padding: 2px 8px; border-radius: 4px; font-size: 11px; font-weight: bold;">ING</div>
                                            <img src="${pageContext.request.contextPath}/resources/imgs/lope.png" style="width: 100%; height: 100%; object-fit: cover;">
                                        </div>
                                        <div class="card-body-area" style="padding: 20px;">
                                            <h3 style="font-size: 18px; font-weight: bold; color: #333; margin-bottom: 15px;">${apply.claName}</h3>
                                            <div class="progress-wrapper">
                                                <div style="display: flex; justify-content: space-between; font-size: 13px; margin-bottom: 8px;">
                                                    <span style="color: #666;">진도율</span>
                                                    <strong style="color: #0e506e;"><fmt:formatNumber value="${apply.progress}" pattern="0" />%</strong>
                                                </div>
                                                <div class="progress" style="height: 10px; background-color: #f0f0f0; border-radius: 5px;">
                                                    <div class="progress-bar progress-bar-striped progress-bar-animated bg-primary" 
                                                         style="width: ${apply.progress}%;"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="button-area" style="padding: 0 20px 20px;">
                                            <button class="btn btn-block" style="background: #0e506e; color: #fff; font-weight: bold;"
                                                    onclick="location.href='${pageContext.request.contextPath}/user/videolect?claNum=${apply.claNum}'">
                                                학습하기 | 이어하기
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-sm-8">
                    <div class="card card-outline card-navy shadow-sm">
                        <div class="card-header"><h3 class="card-title" style="font-weight: 600;">최근 평가 통계</h3></div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-7"><canvas id="evaluationChart" style="height: 250px;"></canvas></div>
                                <div class="col-md-5" id="evaluationStatusList"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div id="mini-calendar" class="shadow-sm" style="background: #fff; border-radius: 12px; padding: 10px;"></div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
    $(document).ready(function() {
        // 차트 및 캘린더 초기화 로직 (기존 코드 유지)
        var ctx = document.getElementById('evaluationChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['자바', 'DB', 'HTML', '알고리즘'],
                datasets: [{ 
                    label: '내 점수', 
                    data: [85, 55, 92, 40], 
                    borderColor: '#0e506e', 
                    tension: 0.3,
                    fill: true,
                    backgroundColor: 'rgba(14, 80, 110, 0.05)'
                }]
            },
            options: { maintainAspectRatio: false }
        });
        
        // 미니 캘린더 초기화
        var miniCalendar = new FullCalendar.Calendar(document.getElementById('mini-calendar'), {
            initialView: 'dayGridMonth',
            locale: 'ko',
            height: 'auto',
            headerToolbar: { left: 'prev', center: 'title', right: 'next' }
        });
        miniCalendar.render();
    });
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/stylek.css" />
    <%@include file="../modules/userHeader.jsp" %>
    <style>
        .card_wrap { display: none; }
        .card_wrap.active { display: block; }
        /* 진행률 100% 시 버튼 스타일 */
        .btn-disabled-custom { 
            background-color: #6c757d !important; 
            color: white !important; 
            cursor: default !important; 
            pointer-events: none; 
            opacity: 0.8; 
            border: none; 
            width: 100%;
            padding: 10px;
            font-weight: bold;
        }
        .badge-status { padding: 4px 12px; border-radius: 20px; font-size: 13px; font-weight: 600; margin-bottom: 10px; display: inline-block; }
        .bg-pass { background-color: #e8f5e9; color: #2e7d32; }
        .bg-fail { background-color: #ffebee; color: #c62828; }
        .btn-main-action { width: 100%; padding: 10px; font-weight: bold; }
    </style>
</head>
<body style="display: flex; height: 100vh; overflow: hidden; margin: 0;">   
    <div class="content" style="display: flex; flex-direction: column; flex: 1; height: 100vh; min-width: 0;">
        <div class="mid" style="flex: 1; overflow-y: auto; padding: 30px 40px;">
            <div class="container-fluid">
                
                <div class="tabs" style="margin-bottom: 25px;">
                    <span class="tab active" id="tab_ing" onclick="showTab('ing')">수강 중인 강좌</span> 
                    <span class="tab" id="tab_end" onclick="showTab('end')">수강 종료 강좌</span>
                </div>

                <div id="ing_wrap" class="card_wrap active">
                    <div class="row">
                        <c:if test="${empty result.applyList}">
                            <div class="col-12 text-center" style="padding: 100px 0; color: #888;">수강 중인 강좌가 없습니다.</div>
                        </c:if>
                        <c:forEach items="${result.applyList}" var="apply">
                            <div class="col-md-4 mb-4">
                                <div class="course-card-custom hover-reveal" data-clanum="${apply.claNum}">
                                    <div class="card-thumb-area">
                                        <div class="inner-rect">ING</div>
                                        <img src="${pageContext.request.contextPath}/resources/images/psyduck.png" class="thumb-img">
                                        <div class="thumb-overlay"><span class="view-text">상세보기</span></div>
                                    </div>
                                    <div class="card-body-area">
                                        <h3 class="course-name">${apply.claName}</h3>
                                        <div class="progress-wrapper">
                                            <div class="progress-text">
                                                <span>진도율</span><strong><fmt:formatNumber value="${apply.progress}" pattern="0" />%</strong>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar progress-bar-striped bg-primary" style="width: ${apply.progress}%;"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="button-area" style="padding: 15px;">
                                        <c:choose>
                                            <c:when test="${apply.progress >= 100}">
                                                <button class="btn-disabled-custom">시험응시가능</button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-primary btn-main-action" data-clanum="${apply.claNum}">
                                                    ${apply.progress > 0 ? '이어보기' : '학습하기'}
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div id="end_wrap" class="card_wrap">
                    <div class="row">
                        <c:if test="${empty result.endList}">
                            <div class="col-12 text-center" style="padding: 100px 0; color: #888;">종료된 강좌가 없습니다.</div>
                        </c:if>
                        <c:forEach items="${result.endList}" var="end">
                            <div class="col-md-4 mb-4">
                                <div class="course-card-custom">
                                    <div class="card-body-area" style="padding: 20px;">
                                        <h3 class="course-name" style="margin-bottom: 15px;">${end.claName}</h3>
                                        <div class="status-action-area">
                                            <c:choose>
                                                <%-- 불합격 (60점 미만) --%>
                                                <c:when test="${end.erScore < 60}">
                                                    <div class="badge-status bg-fail">불합격 (${end.erScore}점)</div>
                                                    <button class="btn btn-danger w-100" onclick="retakeExam('${end.claNum}')">재수강 하기</button>
                                                </c:when>
                                                <%-- 합격 & 피드백 미작성 --%>
                                                <c:when test="${end.erScore >= 60 && end.feedbackYN == 'N'}">
                                                    <div class="badge-status bg-pass">시험 합격 (${end.erScore}점)</div>
                                                    <button class="btn btn-success w-100" onclick="openFeedbackModal('${end.claNum}')">피드백 작성</button>
                                                </c:when>
                                                <%-- 수료 완료 (합격 & 피드백 작성완료) --%>
                                                <c:otherwise>
                                                    <div class="badge-status bg-dark text-white">수료 완료</div>
                                                    <div class="d-flex" style="gap: 5px;">
                                                        <button class="btn btn-outline-dark flex-fill" style="pointer-events: none;">수료완료</button>
                                                        <button class="btn btn-primary flex-fill" onclick="printCert('${end.claNum}')">수료증 출력</button>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="courseModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4 pb-3" style="border-bottom: 2px solid #f4f4f4;">
                        <h2 id="mTitle" style="font-size: 22px; font-weight: bold; color: #0e506e; margin: 0;"></h2>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <ul class="list-group list-group-flush" id="lList"></ul>
                </div>
            </div>
        </div>
    </div>

    <script>
    function showTab(type) {
        $('.tab').removeClass('active');
        $('.card_wrap').removeClass('active');
        if (type === 'ing') {
            $('#tab_ing').addClass('active');
            $('#ing_wrap').addClass('active');
        } else {
            $('#tab_end').addClass('active');
            $('#end_wrap').addClass('active');
        }
    }

    $(document).ready(function() {
        // 카드 클릭 시 상세보기 (학습 버튼 제외)
        $(document).on('click', '.course-card-custom', function(e) {
            if($(e.target).closest('.button-area, .status-action-area').length > 0) return;
            const title = $(this).find('.course-name').text();
            const claNum = $(this).data('clanum');
            $('#mTitle').text(title);
            
            $.ajax({
                url: '${pageContext.request.contextPath}/user/getLessonList',
                type: 'GET',
                data: { "claNum": claNum },
                success: function(data) {
                    let html = '';
                    data.forEach(item => {
                        html += `<li class="list-group-item d-flex justify-content-between align-items-center" style="padding:15px; border-bottom:1px solid #eee;">
                                    <span>\${item.lsnSeq}차시 : \${item.lsnTitle}</span>
                                    <button class="btn btn-sm btn-primary" onclick="location.href='${pageContext.request.contextPath}/user/videolect?claNum=\${item.claNum}&lsnSeq=\${item.lsnSeq}'">학습</button>
                                 </li>`;
                    });
                    $('#lList').html(html || '<li class="text-center py-3">강의가 없습니다.</li>');
                    $('#courseModal').modal('show');
                }
            });
        });

        // 학습하기/이어보기 버튼 클릭 시
        $(document).on('click', '.btn-main-action', function(e) {
            e.stopPropagation();
            location.href = "${pageContext.request.contextPath}/user/videolect?claNum=" + $(this).data('clanum');
        });
    });

    function retakeExam(claNum) {
        if(confirm("재수강을 신청하시겠습니까?")) {
            location.href = "${pageContext.request.contextPath}/user/retake?claNum=" + claNum;
        }
    }
    function openFeedbackModal(claNum) {
        location.href = "${pageContext.request.contextPath}/user/feedbackForm?claNum=" + claNum;
    }
    function printCert(claNum) {
        window.open("${pageContext.request.contextPath}/user/certPrint?claNum=" + claNum, "cert", "width=800,height=600");
    }
    </script>
</body>
</html>
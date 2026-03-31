<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/stylek.css" />
    <%@include file="../modules/userHeader.jsp" %>
</head>
<body style="display: flex; height: 100vh; overflow: hidden; margin: 0;">   
    <div class="content" style="display: flex; flex-direction: column; flex: 1; height: 100vh; min-width: 0;">
        <div class="mid" style="flex: 1; overflow-y: auto; padding: 30px 40px;">
            <div class="container-fluid">
                <div class="tabs">
                    <span class="tab active" onclick="showTab('ing')">수강 중인 강좌</span> 
                    <span class="tab" onclick="showTab('end')">수강 종료 강좌</span>
                </div>
                <div class="card_wrap ing">
                    <div class="row">
                        <c:if test="${empty result.applyList}">
                            <div class="col-12 text-center" style="padding: 100px 0; color: #888;">
                                수강 중인 강좌 내역이 없습니다.
                            </div>
                        </c:if>
                        <c:forEach items="${result.applyList}" var="apply">
                            <div class="col-md-4">
                                <div class="course-card-custom hover-reveal">
                                    <div class="card-thumb-area">
                                        <div class="inner-rect">D-DAY</div>
                                        <img src="${pageContext.request.contextPath}/resources/images/psyduck.png" class="thumb-img">
                                        <div class="thumb-overlay">
                                            <span class="view-text">상세보기</span>
                                        </div>
                                    </div>
                                    <div class="card-body-area">
                                        <h3 class="course-name">${apply.claName}</h3>
                                        <div class="progress-wrapper">
                                            <div class="progress-text">
                                                <span>진도율</span><strong><fmt:formatNumber value="${apply.progress}" pattern="0" />%</strong>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar progress-bar-striped bg-primary"
                                                    style="width: ${apply.progress}%;"><fmt:formatNumber value="${apply.progress}" pattern="0" />%</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="button-area">
                                        <button class="btn-learn-full btn-main-action" data-clanum="${apply.claNum}">
                                            학습하기 | 이어하기
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="pagination-wrap">
                    <%@ include file="/WEB-INF/views/modules/pagination.jsp"%>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="courseModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content" style="border-radius: 8px; border: none;">
                <div class="modal-body p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4 pb-3" style="border-bottom: 2px solid #f4f4f4;">
                        <div><h2 id="mTitle" style="font-size: 22px; font-weight: bold; color: #0e506e; margin: 0;"></h2></div>
                        <button type="button" class="close" data-dismiss="modal" style="font-size: 28px;">&times;</button>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <h5 style="font-size: 16px; font-weight: bold; color: #333; margin-bottom: 15px;">
                            <i class="fa-solid fa-layer-group mr-2"></i>전체 강좌 구성
                        </h5>
                        <div style="max-height: 500px; overflow-y: auto;" class="lecture-scroll">
                            <ul class="list-group list-group-flush" id="lList"></ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
    $(document).ready(function() {
        $(document).on('click', '.course-card-custom', function(e) {
            if($(e.target).closest('.button-area').length > 0) return;
            
            const title = $(this).find('.course-name').text();
            const claNum = $(this).find('.btn-main-action').data('clanum');
            $('#mTitle').text(title);
            
            $.ajax({
                url: '${pageContext.request.contextPath}/user/getLessonList',
                type: 'GET',
                data: { "claNum": claNum },
                dataType: 'json',
                success: function(data) {
                    let html = '';
                    if(data.length > 0) {
                        data.forEach(function(item) {
                            html += `<li class="list-group-item d-flex justify-content-between align-items-center" 
                                        style="padding: 18px 20px; border: 1px solid #eee; margin-bottom: 8px; cursor: pointer; border-radius: 6px;"
                                        onclick="location.href='${pageContext.request.contextPath}/user/videolect?claNum=\${item.claNum}&lsnSeq=\${item.lsnSeq}'">
                                    <span style="font-size:16px; font-weight:500;">\${item.lsnSeq}차시 : \${item.lsnTitle}</span>
                                    <div class="d-flex align-items-center">
                                        <span style="font-size: 13px; color: #888; margin-right: 15px;">학습하기</span>
                                        <i class="fa-regular fa-circle-play" style="font-size:22px; color:#0e506e;"></i>
                                    </div>
                                </li>`;
                        });
                    } else {
                        html = '<li class="text-center py-4">등록된 강좌가 없습니다.</li>';
                    }
                    $('#lList').html(html);
                    $('#courseModal').modal('show');
                },
                error: function() {
                    alert("강좌 목록을 불러오는데 실패했습니다.");
                }
            });
        });

        $(document).on('click', '.btn-main-action', function(e) {
            e.stopPropagation(); 
            const claNum = $(this).data('clanum');
            location.href = "${pageContext.request.contextPath}/user/videolect?claNum=" + claNum;
        });
    });

    window.showTab = function(type) {
        $('.tab').removeClass('active');
        if (type === 'ing') {
            $('.tab:eq(0)').addClass('active');
            $('.btn-main-action').text('학습하기 | 이어하기');
        } else {
            $('.tab:eq(1)').addClass('active');
            $('.btn-main-action').text('수강완료');
        }
    }
    </script>
</body> 
</html>
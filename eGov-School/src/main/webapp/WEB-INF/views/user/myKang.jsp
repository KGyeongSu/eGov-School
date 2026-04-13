<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내 강의실</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/stylek.css?v=${System.currentTimeMillis()}" />
<%@include file="../modules/userHeader.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
</head>
<body style="display:flex; height:100vh; overflow:hidden; margin:0;">
    <div class="content" style="display:flex; flex-direction:column; flex:1; height:100vh; min-width:0;">
        <div class="mid" style="flex:1; overflow-y:auto;">
            <div class="container-fluid">
                <div class="tabs">
                    <span class="tab active" id="tab_ing" onclick="showTab('ing')">수강 중인 강좌</span>
                    <span class="tab" id="tab_end" onclick="showTab('end')">수강 종료 강좌</span>
                </div>

                <div id="ing_wrap" class="card_wrap active">
                    <div class="row" id="userListArea">
                        <c:choose>
                            <c:when test="${empty result.applyList}">
                                <div class="col-12 text-center no-data-box">
                                    <i class="fa-solid fa-folder-open mb-3"></i> 수강 중인 강좌가 없습니다.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${result.applyList}" var="apply">
                                    <div class="col-md-4 mb-4">
                                        <div class="course-card-custom hover-reveal shadow-sm" data-clanum="${apply.claNum}">
                                            <div class="card-thumb-area">
											    <div class="inner-rect">ING</div>
											    <c:choose>
											        <c:when test="${not empty apply.claSaveName}">
											            <img src="${pageContext.request.contextPath}${apply.claSavePath}/${apply.claSaveName}" 
											                 class="thumb-img" 
											                 onerror="this.src='${pageContext.request.contextPath}/resources/images/no-image.png'">
											        </c:when>
											        <c:otherwise>
											            <img src="${pageContext.request.contextPath}/resources/images/no-image.png" class="thumb-img">
											        </c:otherwise>
											    </c:choose>
											    <div class="thumb-overlay"><span class="view-text">상세보기</span></div>
											</div>
                                            <div class="card-body-area">
                                                <h3 class="course-name">${apply.claName}</h3>
                                                <div class="progress-wrapper">
                                                    <div class="progress-text">
                                                        <span>학습 진도율</span>
                                                        <strong><fmt:formatNumber value="${apply.progress}" pattern="0" />%</strong>
                                                    </div>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-striped progress-bar-animated progress-bar-custom" style="width:${apply.progress}%;"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="button-area">
                                                <c:choose>
                                                    <c:when test="${apply.progress >= 100}">
                                                        <button class="btn btn-disabled-custom">시험응시가능</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-main-action" data-clanum="${apply.claNum}">
                                                            ${apply.progress > 0 ? '학습 이어하기' : '학습 시작하기'}
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="pagination_wrapper" id="paginationArea">
                        <%@include file="/WEB-INF/views/modules/pagination.jsp"%>
                    </div>
                </div>

                <div id="end_wrap" class="card_wrap">
                    <div class="row">
                        <c:choose>
                            <c:when test="${empty result.endList}">
                                <div class="col-12 text-center no-data-box">
                                    <i class="fa-solid fa-box-archive mb-3"></i> 종료된 강좌가 없습니다.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${result.endList}" var="end">
                                    <div class="col-md-4 mb-4">
                                        <div class="course-card-custom shadow-sm">
                                            <div class="card-thumb-area">
											    <div class="inner-rect" style="background:#666 !important;">END</div>
											    <c:choose>
											        <c:when test="${not empty end.claSaveName}">
											            <img src="${pageContext.request.contextPath}${end.claSavePath}/${end.claSaveName}" 
											                 class="thumb-img" 
											                 onerror="this.src='${pageContext.request.contextPath}/resources/images/no-image.png'">
											        </c:when>
											        <c:otherwise>
											            <img src="${pageContext.request.contextPath}/resources/images/no-image.png" class="thumb-img">
											        </c:otherwise>
											    </c:choose>
											</div>
                                            <div class="card-body-area">
                                                <h3 class="course-name">${end.claName}</h3>
                                                <div class="status-action-area">
                                                    <c:choose>
                                                        <c:when test="${end.erScore < 60}">
                                                            <div class="badge-status bg-fail-custom">불합격 (${end.erScore}점)</div>
                                                            <button class="btn btn-danger w-100 font-weight-bold" onclick="retakeExam('${end.claNum}')">재수강 하기</button>
                                                        </c:when>
                                                        <c:when test="${end.erScore >= 60 && end.feedbackYN == 'N'}">
                                                            <div class="badge-status bg-pass-custom">시험 합격 (${end.erScore}점)</div>
                                                            <div class="d-flex" style="gap:5px;">
                                                                <button class="btn flex-fill btn-feedback-open" onclick="openFeedbackModal('${end.claNum}')">피드백 작성</button>
                                                                <button class="btn flex-fill btn-cert" onclick="printCert('${end.claNum}', '${end.claName}')">수료증 출력</button>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="badge-status bg-dark text-white p-badge">수료 완료</div>
                                                            <div class="d-flex" style="gap:5px;">
                                                                <button class="btn btn-feedback-done flex-fill" disabled>피드백 완료</button>
                                                                <button class="btn flex-fill btn-cert" onclick="printCert('${end.claNum}', '${end.claName}')">수료증 출력</button>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="courseModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content" style="border-radius:12px; overflow:hidden;">
                <div class="modal-body p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4 pb-3" style="border-bottom:2px solid #f4f4f4;">
                        <h2 id="mTitle" style="font-size:20px; font-weight:bold; color:#0e506e; margin:0;"></h2>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="lecture-scroll" style="max-height:400px; overflow-y:auto;">
                        <ul class="list-group list-group-flush" id="lList"></ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="feedbackModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 style="font-weight:bold; color:#0e506e; margin:0;">강의 피드백 작성</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <input type="hidden" id="f_claNum">
                    <div class="form-group text-center">
                        <label style="font-size:14px; color:#555; margin-bottom:15px; display:block;">강의는 어떠셨나요? 별점을 클릭해 주세요.</label>
                        <div class="star-rating">
                            <input type="radio" id="5-stars" name="repSat" value="5"><label for="5-stars" class="star">★</label>
                            <input type="radio" id="4-stars" name="repSat" value="4"><label for="4-stars" class="star">★</label>
                            <input type="radio" id="3-stars" name="repSat" value="3" checked><label for="3-stars" class="star">★</label>
                            <input type="radio" id="2-stars" name="repSat" value="2"><label for="2-stars" class="star">★</label>
                            <input type="radio" id="1-star"  name="repSat" value="1"><label for="1-star"  class="star">★</label>
                        </div>
                    </div>
                    <div class="form-group mt-4">
                        <textarea class="form-control" id="f_content" rows="4"
                                  style="resize:none; border-radius:8px; padding:15px;"
                                  placeholder="후기를 작성해주세요."></textarea>
                    </div>
                    <div class="d-flex" style="gap:10px; margin-top:25px;">
                        <button type="button" class="btn btn-light flex-fill" data-dismiss="modal"
                                style="font-weight:bold; height:45px; background:#f4f4f4;">취소</button>
                        <button type="button" class="btn flex-fill btn-cert" onclick="submitFeedback()">등록하기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="certModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="d-flex align-items-center" style="gap:10px;">
                        <i class="fa-solid fa-certificate" style="color:#fff; font-size:18px;"></i>
                        <span style="color:#fff; font-weight:700; font-size:16px;">수료증 발급</span>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" style="color:#fff; opacity:0.8;">&times;</button>
                </div>
                <div class="modal-body d-flex justify-content-center" style="background:#f1f5f9; padding:40px 20px; overflow-x:auto;">
                    <div id="certContent">
                        <div class="cert-header">
                            <div class="cert-badge">CERTIFICATE OF COMPLETION</div>
                            <h1>수 료 증</h1>
                            <div class="cert-underline"></div>
                        </div>
                        <table class="cert-info-table">
                            <tr>
                                <td>성&nbsp;&nbsp;&nbsp;&nbsp;명</td>
                                <td>${loginUser.userName}</td>
                            </tr>
                            <tr>
                                <td>과 정 명</td>
                                <td id="c_claName" style="font-weight:700; color:#0e506e;"></td>
                            </tr>
                        </table>
                        <div class="cert-body-text">
                            위 사람은 본 기관에서 주관하는<br>
                            <span class="highlight" id="c_claName2"></span> 과정을<br>
                            성실히 이수하였으므로 이 증서를 수여합니다.
                        </div>
                        <div class="cert-footer">
                            <div class="cert-date">
                                <i class="fa-regular fa-calendar" style="margin-right:5px; color:#0e506e;"></i>
                                <span id="c_date"></span>
                            </div>
                            <div class="cert-sign">
                                <span class="sign-name">대전광역시 인재개발원</span>
                                <div class="sign-stamp">인</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-cert" onclick="downloadPDF()">PDF 저장</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
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
        $(document).on('click', '.course-card-custom', function(e) {
            if ($(e.target).closest('.button-area, .status-action-area, .btn').length > 0) return;
            const title  = $(this).find('.course-name').text();
            const claNum = $(this).data('clanum');
            $('#mTitle').text(title);
            $.ajax({
                url: '${pageContext.request.contextPath}/user/getLessonList',
                type: 'GET',
                data: { claNum: claNum },
                success: function(data) {
                    let html = '';
                    if (data && data.length > 0) {
                        data.forEach(item => {
                            html += `<li class="list-group-item d-flex justify-content-between align-items-center"
                                         style="padding:15px; border-bottom:1px solid #eee;">
                                        <span style="font-size:14px; color:#333;">\${item.lsnSeq}차시 : \${item.lsnTitle}</span>
                                        <button class="btn btn-sm btn-cert"
                                            onclick="location.href='${pageContext.request.contextPath}/user/videolect?claNum=\${item.claNum}&lsnNum=\${item.lsnNum}'">
                                            학습하기
                                        </button>
                                     </li>`;
                        });
                    }
                    $('#lList').html(html || '<li class="text-center py-4 text-muted">등록된 강의가 없습니다.</li>');
                    $('#courseModal').modal('show');
                }
            });
        });

        $(document).on('click', '.btn-main-action', function(e) {
            e.stopPropagation();
            location.href = "${pageContext.request.contextPath}/user/videolect?claNum=" + $(this).data('clanum');
        });
    });

    function retakeExam(claNum) {
        if (confirm("재수강을 신청하시겠습니까?")) {
            location.href = "${pageContext.request.contextPath}/page/cregist?claNum=" + claNum;
        }
    }

    function openFeedbackModal(claNum) {
        $('#f_claNum').val(claNum);
        $('#f_content').val('');
        $('input:radio[name="repSat"][value="3"]').prop("checked", true);
        $('#feedbackModal').modal('show');
    }

    function submitFeedback() {
        const claNum   = $('#f_claNum').val();
        const content  = $('#f_content').val();
        const satValue = $('input[name="repSat"]:checked').val();
        if (!content.trim()) { alert("후기 내용을 입력해주세요."); return; }
        $.ajax({
            url: '${pageContext.request.contextPath}/user/registFeedback',
            type: 'POST',
            data: { claNum: claNum, repContent: content, repSat: satValue },
            success: function(res) {
                if (res === "success") {
                    alert("피드백이 등록되었습니다.");
                    $('#feedbackModal').modal('hide');
                    location.reload();
                }
            }
        });
    }

    function printCert(claNum, claName) {
        const today = new Date();
        const dateStr = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월 " + today.getDate() + "일";
        $('#c_claName').text(claName);
        $('#c_claName2').text(claName);
        $('#c_date').text(dateStr);
        $('#certModal').modal('show');
    }

    function downloadPDF() {
        const element = document.getElementById('certContent');
        const claName = $('#c_claName').text();
        const opt = {
            margin: 0,
            filename: '수료증_' + claName + '.pdf',
            image: { type: 'jpeg', quality: 0.98 },
            html2canvas: { scale: 2, useCORS: true },
            jsPDF: { unit: 'px', format: [720, 510], orientation: 'landscape' }
        };
        html2pdf().set(opt).from(element).save();
    }
    </script>
</body>
</html>
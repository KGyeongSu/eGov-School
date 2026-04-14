<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/styleEX.css" />
<%@include file="../modules/userHeader.jsp"%>

<div class="mid">
    <div class="container-fluid">
        <div class="top-interface">
            <div class="tabs">
                <span class="tab active" id="tab-ing" onclick="showTab('ing')">평가 예정 강좌</span> 
                <span class="tab" id="tab-end" onclick="showTab('end')">평가 종료 강좌</span>
            </div>
            <div class="search-wrapper">
                <input type="text" id="courseSearch" placeholder="강좌명을 입력하세요" class="search-input">
                <button type="button" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
            </div>
        </div>

        <div class="main-content-wrap">
            <div class="listwrap">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 8%;">No</th>
                            <th id="columnTitle" style="width: 40%;">평가 미응시 강좌명</th>
                            <th style="width: 25%;">응시 가능 기간</th>
                            <th style="width: 12%;">상태</th>
                            <th style="width: 15%;">관리</th>
                        </tr>
                    </thead>

                    <tbody id="ing-list">
                        <c:choose>
                            <c:when test="${empty pendingTestList}">
                                <tr><td colspan="5" style="text-align:center; padding:50px 0;">평가 예정인 강좌가 없습니다.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="test" items="${pendingTestList}" varStatus="status">
                                    <tr class="eval-row">
                                        <td>${status.count}</td>
                                        <td class="col-title" style="text-align:left;">
                                            <b>[${test.claTitle}] ${test.tetTitle}</b>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${test.claStartDate}" pattern="yyyy.MM.dd"/>
                                            ~ 
                                            <fmt:formatDate value="${test.claEndDate}" pattern="yyyy.MM.dd"/>
                                        </td>
                                        <td><span style="color:#0e506e; font-weight:700;">응시가능</span></td>
                                        <td>
                                            <button type="button" class="btn-main-action is-feedback" 
                                                onclick="location.href='${pageContext.request.contextPath}/user/test?tetNum=${test.tetNum}'">
                                                응시하기
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>

                    <tbody id="end-list" style="display: none;">
                        <c:choose>
                            <c:when test="${empty completedTestList}">
                                <tr><td colspan="5" style="text-align:center; padding:50px 0;">평가 종료된 강좌가 없습니다.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="res" items="${completedTestList}" varStatus="status">
                                    <tr class="eval-row">
                                        <td>${status.count}</td>
                                        <td class="col-title" style="text-align:left;">
                                            <b>${res.tetTitle}</b>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${res.erDate}" pattern="yyyy.MM.dd"/> 응시완료
                                        </td>
                                        <td>평가 완료</td>
                                        <td>
                                            <button type="button" class="btn-main-action is-completed"
                                                data-score="${res.erScore}"
                                                data-percent="${res.topPercent}"
                                                data-title="${res.tetTitle}"
                                                data-complete="${res.claComplete}">
                                                결과 확인
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="resultModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content result-modal-content">
            <div class="report-paper">
                <div class="report-header">
                    <h2>성 적 통 지 서</h2>
                </div>
                
                <table class="score-report-table">
                    <tr>
                        <th>시 험 명</th>
                        <td id="modalTitle" colspan="3" style="text-align:left; padding-left:20px;"></td>
                    </tr>
                    <tr>
                        <th>취득 점수</th>
                        <td id="modalScore" style="font-weight:bold;"></td>
                        <th>합격 기준</th>
                        <td id="modalStandard"></td>
                    </tr>
                    <tr>
                        <th>백 분 위</th>
                        <td id="modalPercent"></td>
                        <th>최종 결과</th>
                        <td id="modalStatus" style="font-weight:bold;"></td>
                    </tr>
                </table>

                <div class="result-stamp-box" id="modalFinalMsg"></div>

                <div style="text-align: center; margin-top: 30px;">
                    <button type="button" class="btn-report-close" data-dismiss="modal">닫기</button>
                    <button type="button" id="certBtn" class="btn-report-print" style="display:none;" onclick="alert('수료증 출력을 시작합니다.')">수료증 출력</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // [1] 결과 확인 모달 이벤트
        $(document).on('click', '.is-completed', function() {
            // .data() 대신 .attr()을 사용하여 데이터 유실 방지
            const score = parseInt($(this).attr('data-score')) || 0;
            const percent = $(this).attr('data-percent') || "0";
            const title = $(this).attr('data-title') || "강좌명 없음";
            const completeStr = $(this).attr('data-complete') || "60점";
            
            // 합격 기준 점수 추출 (숫자만)
            const match = completeStr.match(/\d+/);
            const passScore = match ? parseInt(match[0]) : 60;

            $('#modalTitle').text(title);
            $('#modalScore').text(score + " / 100 점");
            $('#modalStandard').text(passScore + "점 이상");
            $('#modalPercent').text("상위 " + percent + "%");

            if (score >= passScore) {
                $('#modalStatus').text("합격 (PASS)").addClass('status-pass').removeClass('status-fail');
                $('#modalFinalMsg').html("위 사람은 해당 평가에서 성적이 우수하여 <br><span class='status-pass' style='color:#2d6a4f; font-weight:bold;'>[합격]</span> 하였음을 통지합니다.");
                $('#certBtn').show();
            } else {
                $('#modalStatus').text("불합격 (FAIL)").addClass('status-fail').removeClass('status-pass');
                $('#modalFinalMsg').html("위 사람은 해당 평가에서 기준 점수 미달로 <br><span class='status-fail' style='color:#d90429; font-weight:bold;'>[불합격]</span> 하였음을 통지합니다.");
                $('#certBtn').hide();
            }
            
            // 모달 열기
            $('#resultModal').modal('show');
        });

        // [2] 실시간 검색 기능
        $('#courseSearch').on('keyup input', function() {
            const val = $(this).val().toLowerCase().trim();
            // 현재 보이는 리스트 내의 tr만 필터링
            $('tbody:visible tr.eval-row').each(function() {
                const title = $(this).find('.col-title').text().toLowerCase();
                $(this).toggle(title.indexOf(val) > -1);
            });
        });
    });

    // [3] 탭 전환 기능
    window.showTab = function(type) {
        // 검색창 초기화
        $('#courseSearch').val('');
        $('tr.eval-row').show();

        $('.tab').removeClass('active');
        if (type === 'ing') {
            $('#tab-ing').addClass('active');
            $('#ing-list').show();
            $('#end-list').hide();
            $('#columnTitle').text('평가 미응시 강좌명');
        } else {
            $('#tab-end').addClass('active');
            $('#ing-list').hide();
            $('#end-list').show();
            $('#columnTitle').text('평가 완료 강좌명');
        }
    }
</script>
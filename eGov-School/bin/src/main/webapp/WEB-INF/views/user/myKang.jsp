<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<link type="text/css" rel="stylesheet" href="../../../resources/css/user/stylek.css" />
 <%@include file="../modules/userHeader.jsp" %>

<title>Dashboard</title>
</head>
<body>   
		<div class="mid">
			<div class="container-fluid">
				<div class="tabs">
					<span class="tab active" onclick="showTab('ing')">수강 중인 강좌</span> <span
						class="tab" onclick="showTab('end')">수강 종료 강좌</span>
				</div>

				<div class="card_wrap ing">
					<div class="row">
                        <div class="col-md-4">
							<div class="course-card-custom hover-reveal">
								<div class="card-thumb-area">
									<div class="inner-rect">D-70</div>
									<img src="../../../resources/imgs/gorapadoc.jpg"
										class="thumb-img">
									<div class="thumb-overlay">
										<span class="view-text">상세보기</span>
									</div>
								</div>
								<div class="card-body-area">
									<h3 class="course-name">강좌 A</h3>
									<div class="progress-wrapper">
										<div class="progress-text">
											<span>진도율</span><strong>100%</strong>
										</div>
										<div class="progress">
											<div class="progress-bar progress-bar-striped bg-primary"
												style="width: 100%;">100%</div>
										</div>
									</div>
								</div>
								<div class="button-area">
									<button class="btn-learn-full btn-main-action">학습하기 | 이어하기</button>
								</div>
							</div>
						</div>
                        </div>
				</div>
			</div>
		</div>
		<div class="pagination-wrap">
			<%@ include file="/WEB-INF/views/modules/pagination.jsp"%>
		</div>



	<div class="modal fade" id="courseModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content"
				style="border-radius: 8px; border: none; box-shadow: 0 5px 25px rgba(0, 0, 0, 0.2);">
				<div class="modal-body p-4">
					<div
						class="d-flex justify-content-between align-items-center mb-4 pb-3"
						style="border-bottom: 2px solid #f4f4f4;">
						<div>
							<h2 id="mTitle"
								style="font-size: 22px; font-weight: bold; color: #0e506e; margin: 0;">강좌 제목</h2>
						</div>
						<button type="button" class="close" data-dismiss="modal"
							style="font-size: 28px; line-height: 1;">&times;</button>
					</div>
					<div style="margin-bottom: 10px;">
						<h5 style="font-size: 16px; font-weight: bold; color: #333; margin-bottom: 15px;">
							<i class="fa-solid fa-layer-group mr-2"></i>전체 강좌 구성
						</h5>
						<div style="max-height: 500px; overflow-y: auto; padding-right: 5px;" class="lecture-scroll">
							<ul class="list-group list-group-flush" id="lList"></ul>
						</div>
					</div>
				</div>
				<div class="modal-footer" style="border-top: 1px solid #eee; background: #f9f9f9;">
					<button type="button" class="btn btn-secondary" data-dismiss="modal" style="padding: 8px 25px;">닫기</button>
				</div>
			</div>
		</div>
	</div>

    <div class="modal fade" id="feedbackModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 12px; overflow: hidden;">
                <div class="modal-header" style="background: #0e506e; color: #fff;">
                    <h5 class="modal-title">강좌 피드백 등록</h5>
                    <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body p-4">
                    <div class="text-center mb-4">
                        <p style="font-weight: bold; color: #333;">만족도 설정</p>
                        <div class="star-rating">
                            <input type="radio" id="5-stars" name="rating" value="5" /><label for="5-stars"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" id="4-stars" name="rating" value="4" /><label for="4-stars"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" id="3-stars" name="rating" value="3" /><label for="3-stars"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" id="2-stars" name="rating" value="2" /><label for="2-stars"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" id="1-star" name="rating" value="1" /><label for="1-star"><i class="fa-solid fa-star"></i></label>
                        </div>
                    </div>

                    <div class="mb-3">
                        <p style="font-weight: bold; color: #333;">피드백 작성</p>
                        <textarea id="feedbackContent" placeholder="강좌에 대한 소중한 의견을 남겨주세요."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="submitFeedback" style="background: #0e506e; border:none; padding: 8px 30px;">등록</button>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="certificateModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 15px; border: 3px double #0e506e;">
            <div class="modal-body text-center p-5">
                <i class="fa-solid fa-award" style="font-size: 80px; color: #f1c40f; margin-bottom: 20px;"></i>
                <h2 style="font-weight: bold; color: #0e506e;">강좌 수료를 축하합니다!</h2>
                <p style="font-size: 18px; color: #555; margin-top: 15px;">
                    모든 교육 과정을 성공적으로 마치셨습니다.<br>
                    아래 버튼을 눌러 수료증을 확인하세요.
                </p>
                <div style="margin-top: 30px;">
                    <button type="button" class="btn btn-lg" style="background: #0e506e; color: #fff; padding: 10px 40px;" onclick="alert('수료증 PDF 생성을 시작합니다.')">
                        <i class="fa-solid fa-file-pdf mr-2"></i>수료증 다운로드
                    </button>
                </div>
            </div>
            <div class="modal-footer" style="border: none; justify-content: center;">
                <button type="button" class="btn btn-link" data-dismiss="modal" style="color: #888;">닫기</button>
            </div>
        </div>
    </div>
</div>




<div class="modal fade" id="courseModal">...</div>
    <div class="modal fade" id="feedbackModal">...</div>
    <div class="modal fade" id="certificateModal">...</div>
 

</body> 
    <script>
    $(document).ready(function() {
        // 1. 상세보기 모달 로직 (카드 자체 클릭)
        $(document).on('click', '.course-card-custom', function(e) {
            if($(e.target).closest('.button-area').length > 0) return;
            const title = $(this).find('.course-name').text() || "강좌 명칭 미지정";
            $('#mTitle').text(title);
            
            let html = '';
            for(let i=1; i<=10; i++) {
                html += `
                    <li class="list-group-item d-flex justify-content-between align-items-center" 
                        style="padding: 18px 20px; border: 1px solid #eee; margin-bottom: 8px; cursor: pointer; border-radius: 6px; transition: 0.2s;">
                        <span style="font-size:16px; font-weight:500;">\${i}차시 강좌</span>
                        <div class="d-flex align-items-center">
                            <span style="font-size: 13px; color: #888; margin-right: 15px;">미수강</span>
                            <i class="fa-regular fa-circle-play" style="font-size:22px; color:#0e506e;"></i>
                        </div>
                    </li>`;
            }
            $('#lList').html(html);
            $('#courseModal').modal('show');
        });

        // 2. 피드백 버튼 클릭 이벤트 (URL 이동 및 수료증 로직 포함)
        $(document).on('click', '.btn-main-action', function(e) {
            e.stopPropagation(); 
            
            // 수료증 발급 상태일 때
            if($(this).hasClass('is-completed')) {
                $('#certificateModal').modal('show');
            } 
            // 피드백 등록 상태일 때
            else if($(this).hasClass('is-feedback')) {
                $('#feedbackModal').modal('show');
            } 
            // 수강 중일 때 (강의실 이동)
            else {
                alert("강의실로 이동합니다.");
                location.href = "${pageContext.request.contextPath}/user/videolect";
            }
        });

        // 3. 피드백 등록 완료 시나리오 (수료증 전환 로직)
        $('#submitFeedback').on('click', function() {
            const rating = $('input[name="rating"]:checked').val();
            const content = $('#feedbackContent').val();

            if(!rating) { alert("만족도 별점을 선택해주세요."); return; }
            if(!content.trim()) { alert("피드백 내용을 입력해주세요."); return; }

            alert("등록이 완료되었습니다.");
            $('#feedbackModal').modal('hide');

            // 버튼 상태를 수료증 발급으로 변경
            $('.btn-main-action.is-feedback').each(function() {
                $(this).text('수료증 발급받기');
                $(this).removeClass('is-feedback').addClass('is-completed');
                $(this).css('background-color', '#27ae60'); 
            });

            // 0.5초 뒤 수료증 모달 자동 오픈
            setTimeout(function() {
                $('#certificateModal').modal('show');
            }, 500);

            // 초기화
            $('input[name="rating"]').prop('checked', false);
            $('#feedbackContent').val('');
        });
    });

    // 탭 전환 함수 (전역)
    window.showTab = function(type) {
        $('.tab').removeClass('active');
        if (type === 'ing') {
            $('.tab:eq(0)').addClass('active');
            $('.btn-main-action').text('학습하기 | 이어하기').removeClass('is-feedback');
        } else {
            $('.tab:eq(1)').addClass('active');
            $('.btn-main-action').text('피드백 | 수료증').addClass('is-feedback');
        }
    }
</script>
</html>
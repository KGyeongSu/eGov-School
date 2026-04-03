<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<title>강좌 시청 - ${lesson.lsnTitle}</title>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/user/styleV.css" />
<%@include file="../modules/userHeader.jsp"%>
</head>
<body class="videolet">
	<div class="content">
		<div class="mid">
			<div class="videodash">
				<%-- 상단 타이틀 및 목록 이동 --%>
				<div class="letti">
					<h3>${lesson.lsnTitle}
						<small style="color: #7f8c8d; font-size: 14px;">(${lesson.lsnSeq}차시)</small>
					</h3>

					<div style="margin-left: auto; display: flex; gap: 10px;">
						<c:if test="${not empty lesson.lessonFiles}">
							<c:forEach items="${lesson.lessonFiles}" var="file">
								<%-- 비디오 파일이 아닌 일반 자료만 다운로드 버튼으로 노출 --%>
								<c:if
									test="${not file.laSaveName.endsWith('.mp4') and not file.laSaveName.endsWith('.avi') and not file.laSaveName.endsWith('.wmv')}">
									<a
										href="${pageContext.request.contextPath}/common/download?laNum=${file.laNum}"
										class="downloadbtn"> <i
										class="fa-solid fa-file-arrow-down"></i> <span>${file.laName}</span>
									</a>
								</c:if>
							</c:forEach>
						</c:if>
						<a href="${pageContext.request.contextPath}/user/myKang"
							class="return"> <i class="fa-solid fa-list"></i> <span>목록으로</span>
						</a>
					</div>
				</div>

			<div class="videochair">
    <c:choose>
        <%-- 영상 파일 정보가 존재할 때 --%>
        <c:when test="${not empty lesson.lsnVideo}">
            <video id="lectureVideo" controls autoplay 
                   controlsList="nodownload" oncontextmenu="return false;" 
                   style="width: 100%; height: 100%; background: #000; object-fit: contain;">

                <%-- [중요] 사진에 있는 실제 파일명을 직접 입력해서 테스트 --%>
                <source src="${pageContext.request.contextPath}/resources/upload/cc71a42e-3f32-4f5a-9696-07ce098f7b5b_JACOMO.mp4" type="video/mp4">
                
                브라우저가 비디오 재생을 지원하지 않습니다.
            </video>
        </c:when>

        <%-- 영상 정보가 없을 때 (에러 발생했던 부분) --%>
        <c:otherwise>
            <div style="color: #fff; text-align: center; padding: 20px;">
                <i class="fa-solid fa-circle-exclamation" style="font-size: 30px; margin-bottom: 10px;"></i><br>
                재생할 수 있는 영상 정보가 없습니다.
            </div>
        </c:otherwise>
    </c:choose>
</div>

			<%-- 하단 학습 정보 및 이전/다음 이동 --%>
			<div class="letco">
				<div class="learning-info">
					<h4>
						<i class="fa-solid fa-circle-info"></i> 학습 안내
					</h4>
					<p style="margin: 0; font-size: 14px; color: #555;">${lesson.lsnContent}</p>
				</div>

				<div class="lecture-nav">
					<%-- 이전 강의 --%>
					<c:choose>
						<c:when test="${lesson.lsnSeq > 1}">
							<a href="?claNum=${claNum}&lsnSeq=${lesson.lsnSeq - 1}"
								class="nav-btn prev"> <i class="fa-solid fa-chevron-left"></i>
								이전 강의
							</a>
						</c:when>
						<c:otherwise>
							<span class="nav-btn prev disabled">첫 강의</span>
						</c:otherwise>
					</c:choose>

					<%-- 다음 강의 --%>
					<c:choose>
						<c:when test="${not empty lesson.nextLsnNum}">
							<a href="?claNum=${claNum}&lsnSeq=${lesson.lsnSeq + 1}"
								class="nav-btn next"> 다음 강의 <i
								class="fa-solid fa-chevron-right"></i>
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
		$(document)
				.ready(
						function() {
							const video = document
									.getElementById('lectureVideo');
							if (!video)
								return;

							let isUpdated = false;

							// 영상이 끝났을 때 서버에 진도율 업데이트 요청
							video.onended = function() {
								if (!isUpdated) {
									$
											.ajax({
												url : '${pageContext.request.contextPath}/user/updateProgress',
												type : 'POST',
												data : {
													claNum : '${claNum}',
													lsnSeq : '${lesson.lsnSeq}'
												},
												success : function(res) {
													isUpdated = true;
													alert("학습이 완료되었습니다!");
												},
												error : function(err) {
													console
															.error("진도율 업데이트 실패");
												}
											});
								}
							};
						});
	</script>
</body>
</html>
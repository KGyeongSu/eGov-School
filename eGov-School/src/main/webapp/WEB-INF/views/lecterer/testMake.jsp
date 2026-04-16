
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../modules/lecHeader.jsp" %>
	<!-- 개별 css -->
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styletestMake.css" />
    <!-- font awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <title>testMake</title>
</head>

<body>
    <div class="content">
        <div class="top">
            <div class="icon">
                <a href="${pageContext.request.contextPath }/lecterer/mainDashBoard"><i class="fa-regular fa-user"></i></a>
            </div>
            <div class="state_bar">
                <c:choose>
	                <c:when test="${not empty testEditInfo}">
	                    <p>
	                    	평가 수정 > <strong style="font: '나눔 고딕'; font-size: 17px;">&nbsp;&nbsp;${testEditInfo.claTitle}</strong>
	                    </p>
	                </c:when>
	                <c:otherwise>
	                	<p>
	                    	평가 출제 > <strong style="font: '나눔 고딕'; font-size: 17px;">&nbsp;&nbsp;${testMake.claTitle}</strong>
	                    </p>
	                </c:otherwise>
	            </c:choose>
            </div>
            <div class="logout_dash">
                <div class="mes" onclick="location.href='reputationHome';" style="cursor: pointer; position: relative; display: inline-block;">
				    <i class="fa-regular fa-envelope"></i>
				    <span id="repBadge" style="position: absolute; top: 5px; right: 50px; background-color: #dc3545; color: white; font-size: 10px; font-weight: bold; padding: 2px 6px; border-radius: 50%; display: none; border: 2px solid white;">
				    	0
				    </span>
				</div>
                <div class="out">
                    <button type="button" class="btn btn-sm" onclick="location.href='${pageContext.request.contextPath}/commons/logout'"
                        style="background-color: #1a6d91; color: white; border-radius: 4px; font-size: 12px;  border: none; line-height: 1;">로그아웃
                    </button>
                </div>
            </div>
        </div>
        <div class="divider">
            <div class="write">
			    <a href="/lecterer/resultManage?userNum=${loginUser.userNum}">
			        <h2>평가 출제</h2>
			    </a>
			</div>
			<div class="manage">
			    <a href="/lecterer/resultSend?userNum=${loginUser.userNum}">
			        <h2>평가 관리</h2>
			    </a>
			</div>
        </div>
        <form action="/lecturer/testMake" method="post" id="testForm">
        		<input type="hidden" id="claNum" value="${not empty testEditInfo ? testEditInfo.claNum : testMake.claNum}">
			    <input type="hidden" name="quePoint" value="33"> 
			    <input type="hidden" name="testTimeLimit" value="40"> 
	        <div class="main">
	            <div class="ques">
	                <div class="ques_top">
					    <div class="info_row_wrapper">
					        <div class="info_column">
					            <div class="course_info">
					                <span class="label">강좌명 :</span>
					                <span class="name">
							            <c:choose>
							                <c:when test="${not empty testEditInfo}">
							                    ${testEditInfo.claTitle}
							                </c:when>
							                <c:otherwise>
							                    ${testMake.claTitle}
							                </c:otherwise>
							            </c:choose>
							        </span>
					            </div>
					        </div>
					
					        <div class="info_column">
					            <div class="course_info">
					                <span class="label">시험명 :</span>
					                <input type="text" name="tetTitle" class="test_title_input" placeholder="시험명을 입력하세요.">
					            </div>
					        </div>
					    </div>
					    
					    <button type="button" class="btn_nav" id="prevBtn">이전 문제</button>
					    <button type="button" class="btn_nav" id="nextBtn">다음 문제</button>
					</div>
	                <div class="ques_mid">
	                    <!-- 지문  -->
	                    <div class="section_box">
	                        <div class="label_bar">제 <span id="currentIdx">1</span>번 지문 입력</div>
                    		<textarea id="queText" class="text_area" rows="4" placeholder="지문을 입력하세요."></textarea>
	                    </div>
	                    <div class="section_box">
	                        <div class="label_bar">선지 및 정답 입력</div>
	                        <div class="choice_container">
							    <div class="choice_row">
							        <input type="radio" name="queAnswer" value="1">
							        <span class="num_label">1</span>
							        <input type="text" class="choice_input" name="queOpt1" placeholder="내용을 입력하세요.">
							    </div>
							    <div class="choice_row">
							        <input type="radio" name="queAnswer" value="2">
							        <span class="num_label">2</span>
							        <input type="text" class="choice_input" name="queOpt2" placeholder="내용을 입력하세요.">
							    </div>
							    <div class="choice_row">
							        <input type="radio" name="queAnswer" value="3">
							        <span class="num_label">3</span>
							        <input type="text" class="choice_input" name="queOpt3" placeholder="내용을 입력하세요.">
							    </div>
							    <div class="choice_row">
							        <input type="radio" name="queAnswer" value="4">
							        <span class="num_label">4</span>
							        <input type="text" class="choice_input" name="queOpt4" placeholder="내용을 입력하세요.">
							    </div>
							</div>
	                    </div>
	                </div>
	                <div class="ques_bot">
	                    <div class="section_box">
	                        <div class="label_bar">문제 해설</div>
	                        <textarea class="text_area" name="queDesc" rows="4" placeholder="문제의 해설을 입력하세요."></textarea>
	                    </div>
	                </div>
	            </div>
	            <div class="state">
	                <div class="state_up">
                    	<c:choose>
                    		<c:when test="${not empty testEdit.testQuestionList  }">
                    			<button type="submit" class="btn_register">평가수정</button>
                    		</c:when>
                    		<c:otherwise>
                    			<button type="submit" class="btn_register">평가등록</button>
                    		</c:otherwise>
                    	</c:choose>
	                </div>
	                <div class="state_down">
	                    <h2 class="status_title">문제 출제 현황</h2>
	                    <div class="status_content" data-idx="${i}">
	                        <ul class="question_status_list">
	                            <!-- 등록 완료 상태 -->
	                            <c:forEach var="i" begin="1" end="3">
		                            <li class="item ${i == 1 ? 'active' : ''}" data-idx="${i}" style="cursor: pointer !important;">
		                                <span class="q_no">${i < 10 ? '0' : ''}${i}</span>
		                                <span class="q_title">미등록 문항</span>
		                                <span class="state_icon" style="display:none;">✔</span>
		                            </li>
		                        </c:forEach>
	                          </ul>
	                    </div>
	                </div>
	            </div>
	         </div>
         </form>
      </div>
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/resources/js/commons.js"></script>

<script>
// 수정시 문제 세팅
const editData = {
	
	tetClaTitle: "${testEditInfo.claTitle}",
    tetTitle: "${testEdit.tetTitle}",
    questions: [
        <c:forEach var="que" items="${testEdit.testQuestionList}" varStatus="status">
        
        {
        	queNum: "${que.queNum}",
            queSeq: ${status.index + 1},
            queText: `${que.queText}`,
            queOpt1: `${que.queOpt1}`,
            queOpt2: `${que.queOpt2}`,
            queOpt3: `${que.queOpt3}`,
            queOpt4: `${que.queOpt4}`,
            queAnswer: "${que.queAnswer}",
            queDesc: `${que.queDesc}`
            
        }${!status.last ? ',' : ''}
        
        </c:forEach>
    ]
};

// 식별자 선언 & 초기화
const totalQuestions = 3;
let currentNum = 1;     
let questionList = editData.questions.length > 0 ? editData.questions : []; 

// 문제 & 현황판 상태 -> 가장 많이 호출, 최상단 위치 필요
function refreshUI(num) {
    currentNum = num;
    $("#currentIdx").text(currentNum);
    
    // 데이터 복원
    const data = questionList[currentNum - 1];
    if (data && data.queText) {
        $("#queText").val(data.queText);
        $("input[name='queOpt1']").val(data.queOpt1);
        $("input[name='queOpt2']").val(data.queOpt2);
        $("input[name='queOpt3']").val(data.queOpt3);
        $("input[name='queOpt4']").val(data.queOpt4);
        $(`input[name='queAnswer'][value='\${data.queAnswer}']`).prop("checked", true);
        $("textarea[name='queDesc']").val(data.queDesc);
    } else {
        // 초기화
        $("#queText").val("");                      
        $(".choice_input").val("");                
        $("textarea[name='queDesc']").val("");
        $("input[name='queAnswer']").prop("checked", false);
    }

    // 초기화
    const $items = $(".question_status_list .item");
    
    $items.each(function(index) {
    	
        const $this = $(this);
        const qData = questionList[index];
        
        $this.removeClass("active complete");
        $this.find(".state_tag").remove();
        $this.find(".state_icon").hide();

        // 데이터가 이미 존재하는 문항
        if (qData && qData.queText && qData.queText.trim() !== "") {
        	
            $this.addClass("complete");
            $this.find(".state_icon").show();
            const shortTitle = qData.queText.length > 8 ? qData.queText.substring(0, 20) + "..." : qData.queText;
            $this.find(".q_title").text(shortTitle);
            
        } else {
        	
            $this.find(".q_title").text("미등록 문항");
            
        }

        // 현재 내가 선택해서 보고 있는 문항
        
        if (index == (currentNum - 1)) {
        	
            $this.addClass("active");
            $this.find(".state_icon").hide();
            
            // 수정중/작성중 텍스트 결정
            const hasData = qData && qData.queText && qData.queText.trim() !== "";
            const tagText = hasData ? "수정중" : "작성중";
            const tagColor = hasData ? "#e67e22" : "#1a6d91";
            
            $this.append(`<span class="state_tag" style="color:${tagColor}; font-weight:bold; margin-left:5px; font-size:11px;">[\${tagText}]</span>`);
            
        }
    });

}

    // 유효성 검사
    function validate() {
    	
        if (!$("input[name='tetTitle']").val().trim()) {
        	
            alert("시험명을 입력해주세요.");
            $("input[name='tetTitle']").focus();
            return false;
            
        }
        
        if (!$("#queText").val().trim()) {
        	
            alert("지문을 입력해주세요.");
            $("#queText").focus();
            return false;
            
        }
        
        for (let i = 1; i <= 4; i++) {
        	
            let opt = $(`input[name='queOpt\${i}']`);
            console.log(`\${i}번 선지 요소 찾기 결과:`, opt.length);
            
            if (!opt.val() || opt.val().trim() === "") {
            	
                alert(i + "번 선지를 입력해주세요.");
                if(opt.length > 0) opt.focus();
                return false;
                
            }
            
        }
        
        if (!$("input[name='queAnswer']:checked").val()) {
        	
            alert("정답을 선택해주세요.");
            return false;
            
        }
        
        if (!$("textarea[name='queDesc']").val().trim()) {
        	
            alert("해설을 입력해주세요.");
            $("textarea[name='queDesc']").focus();
            return false;
            
        }
        
        return true;
    }

    // 임시 저장
    function saveTemp() {
    	
    	const text = $("#queText").val().trim();
        const answer = $("input[name='queAnswer']:checked").val();
        const existingData = questionList[currentNum - 1];
        const qNum = existingData ? existingData.queNum : null;
    	
        if (text !== "" || answer !== undefined) {
        		
            	questionList[currentNum - 1] = {
        		queNum: qNum,
                queSeq: currentNum,
                queText: text,
                queOpt1: $("input[name='queOpt1']").val(),
                queOpt2: $("input[name='queOpt2']").val(),
                queOpt3: $("input[name='queOpt3']").val(),
                queOpt4: $("input[name='queOpt4']").val(),
                queAnswer: answer || "",
                queDesc: $("textarea[name='queDesc']").val()
                
            };
            
        }
    }
    
 	// 시험 제출
    $(document).ready(function() {
    	
    	// 수정 : 시험 제목 미리 채우기
        if (editData.tetTitle) {
        	
            $("input[name='tetTitle']").val(editData.tetTitle);
            
        }
        
    	    refreshUI(1);
    	    
    	 // [다음 문제]
    	    $("#nextBtn").click(function() {
    	    	
    	        if (!validate()) return;
    	        
    	        saveTemp();
    	        
    	        if (currentNum < totalQuestions) {
    	        	
    	            refreshUI(currentNum + 1);
    	            
    	        } else {
    	        	
    	            alert("마지막 문항입니다.");
    	            
    	        }
    	    });

    	    // [이전 문제]
    	    $("#prevBtn").click(function() {
    	        saveTemp();
    	        if (currentNum > 1) {
    	            refreshUI(currentNum - 1);
    	        }
    	    });
    	    
    	    // 출제현황 문제 누르면 해당 문제로 이동
    	    $(document).on("click", ".question_status_list .item", function() {
    	        const targetIdx = parseInt($(this).attr("data-idx"));
    	        
    	        // 이동 전 현재 작성 중인 내용 자동 저장
    	        saveTemp();
    	        
    	        // 해당 번호 UI로 변경
    	        refreshUI(targetIdx);
    	    });

    	    // 평가 등록 AJAX 전송
    	    $(".btn_register").click(function(e) {
    	        e.preventDefault();
    	        if (!validate()) return;
    	        saveTemp();

    	        if (questionList.filter(q => q).length < totalQuestions) {
    	        	
    	            alert( totalQuestions + "문항을 모두 작성해야 등록됩니다."); 
    	    		return;
    	    		
    	        }

    	        const finalData = {
    	        		
    	            tetTitle: $("input[name='tetTitle']").val(),
    	            tetTimelimit: $("input[name='testTimeLimit']").val(),
    	            quePoint: $("input[name='quePoint']").val(),
    	            testQuestionList: questionList.filter(q => q)
    	            
    	        };
    	        
    	        const cNum = $("#claNum").val();
    	        const url = "${not empty testEditInfo ? '/lecterer/testEdit' : '/lecterer/testMake'}";
    	        const isEditMode = ${not empty testEditInfo ? true : false};
    	        const msg1 = isEditMode ? "성공적으로 수정되었습니다." : "성공적으로 등록되었습니다.";
    	        const msg2 = isEditMode ? "수정에 실패했습니다. 다시 시도해주세요." : "등록에 실패했습니다. 다시 시도해주세요.";
    	        
    	        $.ajax({
    	            url: url + "?claNum=" + cNum, 
    	            type: "POST",
    	            contentType: "application/json",
    	            data: JSON.stringify(finalData),
    	            
    	            success: function(res) {
    	            	
    	            	if (res === "success") {
    	            	
    	            	alert(msg1);	
    	                location.href = "/lecterer/resultManage";
    	                
    	            	} else {
    	            	
    	                	alert(msg2);
    	                	return;
    	                
    	            		}
    	           
    	            }, error: function(xhr) {
    	            	
    	            	alert("서버 통신 오류가 발생했습니다. (에러코드: " + xhr.status + ")");
    	            	return;
    	            	
    	            }
    	        });
    	    });
    	    
    	    // 페이지 로드 시 첫 번째 문항 초기화
    	    refreshUI(1);
    	});
 	
    $(document).ready(function() {
    	
        // 알림 배지 초기 로드 및 1분마다 갱신
        updateReputationAlarm();
        setInterval(updateReputationAlarm, 60000);
        
    });

    // 알림 배지 AJAX 함수
    function updateReputationAlarm() {
        $.ajax({
            url: '${pageContext.request.contextPath}/lecterer/reputationAlarm',
            type: 'GET',
            success: function(count) {
                const badge = $('#repBadge');
                if (count > 0) {
                    badge.text(count).show();
                } else {
                    badge.hide();
                }
            }
        });
    }

</script>


</html>
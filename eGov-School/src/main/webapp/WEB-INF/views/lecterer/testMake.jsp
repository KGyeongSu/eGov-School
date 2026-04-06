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
                <a href=""><i class="fa-regular fa-user"></i></a>
            </div>
            <div class="state_bar">
                <p>평가 출제</p>
            </div>
            <div class="logout_dash">
                <div class="mes">
                    <a href=""><i class="fa-regular fa-envelope"></i></a>
                </div>
                <div class="out">
                    <button type="button" class="btn btn-sm"
                        style="background-color: #1a6d91; color: white; border-radius: 4px; font-size: 12px;  border: none; line-height: 1;">로그아웃
                    </button>
                </div>
            </div>
        </div>
        <div class="divider">
            <div class="write"><a href="">
                    <h2>평가 출제</h2>
                </a></div>
            <div class="manage"><a href="">
                    <h2>평가 관리</h2>
                </a></div>
        </div>
        <form action="/lecturer/testMake" method="post" id="testForm">
        		<input type="hidden" id="claNum" value="${testMake.claNum}">
			    <input type="hidden" name="quePoint" value="5"> 
			    <input type="hidden" name="testTimeLimit" value="40"> 
	        <div class="main">
	            <div class="ques">
	                <div class="ques_top">
					    <div class="info_row_wrapper">
					        <div class="info_column">
					            <div class="course_info">
					                <span class="label">강좌명 :</span>
					                <span class="name">${testMake.claTitle}</span> </div>
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
	                    <button type="submit" class="btn_register">평가 등록</button>
	                </div>
	                <div class="state_down">
	                    <h2 class="status_title">문제 출제 현황</h2>
	                    <div class="status_content">
	                        <ul class="question_status_list">
	                            <!-- 등록 완료 상태 -->
	                            <c:forEach var="i" begin="1" end="20">
		                            <li class="item ${i == 1 ? 'active' : ''}">
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

// 초기화
const totalQuestions = 2; 
let currentNum = 1;        
let questionList = [];     

$(document).ready(function() {

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
    	
        if (text !== "" && answer !== undefined) {
        	
            	questionList[currentNum - 1] = {
            			
	                queSeq: currentNum,
	                queText: text,
	                queOpt1: $("input[name='queOpt1']").val(),
	                queOpt2: $("input[name='queOpt2']").val(),
	                queOpt3: $("input[name='queOpt3']").val(),
	                queOpt4: $("input[name='queOpt4']").val(),
	                queAnswer: answer,
	                queDesc: $("textarea[name='queDesc']").val()
	                
            };
            	
        } else {
        	
            questionList[currentNum - 1] = null;
            
        }
    }

    // 3. UI 업데이트 (현황판 상태 포함)
    function refreshUI(num) {
        currentNum = num;
        $("#currentIdx").text(currentNum);
        
        // 데이터 복원
        const data = questionList[currentNum - 1];
        if (data) {
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
		$items.removeClass("active").removeClass("complete"); 
		$items.find(".state_tag").remove();
		$items.find(".state_icon").hide();
		$items.find(".q_title").text("미등록 문항");
		
		// 작성중
		const $current = $items.eq(currentNum - 1);
		$current.addClass("active");
		$current.append('<span class="state_tag">작성중</span>');

        // 완료된 문항 체크 표시
        questionList.forEach((q, idx) => {
        	if(q && q.queText.trim() !== "") {
        		
                const $target = $items.eq(idx);
                $target.addClass("complete");
                $target.find(".state_icon").show();
                $target.find(".q_title").text(q.queText.substring(0, 10) + "...");
                
            }
        });
    }

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

    // [평가 등록] AJAX 전송
    $(".btn_register").click(function(e) {
        e.preventDefault();
        if (!validate()) return;
        saveTemp();

        if (questionList.filter(q => q).length < totalQuestions) {
            if (!confirm("미작성 문항이 있습니다. 정말 등록하시겠습니까?")) return;
        }

        const finalData = {
        		
            tetTitle: $("input[name='tetTitle']").val(),
            tetTimelimit: $("input[name='testTimeLimit']").val(),
            quePoint: $("input[name='quePoint']").val(),
            testQuestionList: questionList.filter(q => q)
            
        };
        
        const cNum = $("#claNum").val();

        $.ajax({
            url: "/lecterer/testMake?claNum=" + cNum, 
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(finalData),
            
            success: function(res) {
            	
            	if (res === "success") {
            	
                alert("성공적으로 등록되었습니다.");
                location.href = "/lecterer/resultManage";
                
            	} else {
            	
                	alert("등록에 실패했습니다. 다시 시도해주세요.");
                
            		}
           
            }, error: function(xhr) {
            	
            	alert("서버 통신 오류가 발생했습니다. (에러코드: " + xhr.status + ")");
            	
            }
        });
    });
    
    // 페이지 로드 시 첫 번째 문항 초기화
    refreshUI(1);
});
</script>

</html>
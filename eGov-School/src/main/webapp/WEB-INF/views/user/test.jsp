<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>${test.tetTitle}</title>
    <%@include file="../modules/userHeader.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/teststyle.css" />
</head>
<body>
    <div class="mid">
        <div class="eval">
            <div class="title" id="headerTitle" style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px; border-bottom:2px solid #333; padding-bottom:15px;">
                <span id="displayCourseTitle" style="font-size:1.5em; font-weight:bold; color:#333;">${test.tetTitle}</span>
                <button class="nav-btn" id="submitBtn" style="background:#004085; color:#fff; border:none;" onclick="submitTest()">제출</button>
            </div>
            <div id="mainDisplay">
                <div class="litmus" id="qText" style="font-size:1.3em; margin-bottom:25px; font-weight:500;"></div>
                <div id="qOptions"></div>
                <div class="page-nav" style="margin-top:40px; display:flex; justify-content:center; gap:15px;">
                    <button class="nav-btn" onclick="prevQuestion()">이전 문제</button>
                    <button class="nav-btn" onclick="nextQuestion()">다음 문제</button>
                </div>
            </div>
        </div>
        <div class="answer">
            <div class="timer" id="timerBox">40:00</div>
            <div id="omrContainer"></div>
        </div>
    </div>

    <script>
    var currentQuestion = 1;
    var userAnswers = new Array(${questionList.size() + 1}).fill(0);
    var resultData = null;
    var timeLeft = 40 * 60;
    var timerInterval = null;
    var isTimerRunning = false;

    var questions = [
        {},
        <c:forEach var="que" items="${questionList}" varStatus="status">
        { 
            queNum: "${que.queNum}", 
            q: "${que.queText}", 
            opts: ["${que.queOpt1}", "${que.queOpt2}", "${que.queOpt3}", "${que.queOpt4}"],
            seq: ${que.queSeq} 
        }${!status.last ? ',' : ''}
        </c:forEach>
    ];

    window.onpageshow = function(event) {
        if (event.persisted || (window.performance && window.performance.navigation.type === 2)) {
            location.reload();
        }
    };

    function startTimer() {
        if (isTimerRunning) return;
        isTimerRunning = true;
        timerInterval = setInterval(function() {
            if (resultData) { clearInterval(timerInterval); return; }
            var min = Math.floor(timeLeft / 60);
            var sec = timeLeft % 60;
            document.getElementById('timerBox').innerText = (min < 10 ? "0"+min : min) + ":" + (sec < 10 ? "0"+sec : sec);
            if (timeLeft-- <= 0) { clearInterval(timerInterval); submitTest(); }
        }, 1000);
    }

    function renderOMR() {
        var html = "";
        for(var i=1; i<questions.length; i++) {
            html += '<div class="omr-row">' +
                    '<span class="omr-no" onclick="loadQuestion(' + i + ')">' + i + '번</span>' +
                    '<div class="omr-mark-area">';
            
            for(var val=1; val<=4; val++) {
                var circleClass = "omr-circle";
                if (resultData) {
                    var ans = resultData.answerList[i-1];
                    if (val == ans.queAnswer) circleClass += " correct";
                    else if (val == userAnswers[i] && ans.eaCorrect === 'N') circleClass += " wrong";
                } else {
                    if (userAnswers[i] == val) circleClass += " selected";
                }
                html += '<span class="' + circleClass + '" onclick="selectChoiceFromOMR(' + i + ',' + val + ')">' + val + '</span>';
            }
            html += '</div></div>';
        }
        document.getElementById('omrContainer').innerHTML = html;
    }

    function loadQuestion(num) {
        currentQuestion = num;
        var data = questions[num];
        document.getElementById('qText').innerHTML = '<strong style="color:#004085;">' + data.seq + '번. </strong>' + data.q;
        
        var html = "";
        for(var i=0; i<data.opts.length; i++) {
            var val = i + 1;
            var txt = data.opts[i];
            var statusClass = "";
            var icon = "";
            
            if (resultData) {
                var ans = resultData.answerList[num - 1];
                if (val == ans.queAnswer) {
                    statusClass = "res-correct";
                    icon = " <span style='float:right; font-weight:bold;'>✅ 정답</span>";
                } else if (val == userAnswers[num] && ans.eaCorrect === 'N') {
                    statusClass = "res-wrong";
                    icon = " <span style='float:right; font-weight:bold;'>❌ 내 오답</span>";
                }
            } else {
                if (userAnswers[num] == val) statusClass = "active";
            }

            html += '<div class="choice-box ' + statusClass + '" onclick="selectChoice(' + val + ')">' +
                    '<div style="width:35px; font-weight:bold;">' + val + '.</div><div style="flex:1;">' + txt + icon + '</div></div>';
        }
        
        if(resultData) {
            var desc = resultData.answerList[num-1].queDesc;
            if(!desc || desc === 'null') desc = "해설 정보가 없습니다.";
            html += '<div class="commentary-box"><strong>💡 해설</strong><p style="margin-top:10px;">' + desc + '</p></div>';
        }
        document.getElementById('qOptions').innerHTML = html;
        renderOMR(); 
    }

    function selectChoice(val) {
        if (resultData) return;
        if (!isTimerRunning) startTimer();
        userAnswers[currentQuestion] = val;
        loadQuestion(currentQuestion);
    }

    function selectChoiceFromOMR(qIdx, val) {
        if (resultData) { loadQuestion(qIdx); return; }
        if (!isTimerRunning) startTimer();
        userAnswers[qIdx] = val;
        loadQuestion(qIdx);
    }

    function submitTest() {
        if(!resultData && !confirm("시험을 제출하시겠습니까?")) return;
        var ansArray = [];
        for(var i=1; i<questions.length; i++) {
            ansArray.push({ queNum: questions[i].queNum, queAnswer: userAnswers[i] });
        }
        var data = { tetNum: '${tetNum}', userAnswers: ansArray };
        
        $.ajax({
            url: '${pageContext.request.contextPath}/user/evaluate',
            type: 'POST',
            data: JSON.stringify(data),
            contentType: 'application/json',
            success: function(res) {
                resultData = res;
                showResultUI();
            },
            error: function() { alert("제출 중 오류가 발생했습니다."); }
        });
    }

    function showResultUI() {
        clearInterval(timerInterval);
        document.getElementById('timerBox').innerText = "평가 종료";
        document.getElementById('timerBox').style.background = "#6c757d";
        document.getElementById('submitBtn').style.display = "none";
        
        var headerHtml = '<span>최종 점수: <b style="color:red; font-size:1.3em;">' + resultData.erScore + '</b>점</span>' +
                         '<button class="nav-btn" style="margin-left:20px; background:#e9ecef;" onclick="location.href=\'${pageContext.request.contextPath}/user/main\'">목록으로</button>';
        document.getElementById('headerTitle').innerHTML = headerHtml;
        
        loadQuestion(1);
    }

    function prevQuestion() { if(currentQuestion > 1) loadQuestion(currentQuestion - 1); }
    function nextQuestion() { if(currentQuestion < questions.length - 1) loadQuestion(currentQuestion + 1); }

    window.onload = function() { 
        renderOMR(); 
        loadQuestion(1); 
    };
    </script>
</body>
</html>
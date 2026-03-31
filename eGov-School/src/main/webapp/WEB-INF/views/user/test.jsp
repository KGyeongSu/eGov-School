<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>${test.tetName} - 평가 시스템</title>
    <%@include file="../modules/userHeader.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/teststyle.css" />
</head>
<body>

    <div class="mid">
        <div class="eval">
            <div class="title">
                <span id="displayCourseTitle">${test.tetName}</span>
                <button class="submitbtn" onclick="submitTest()">제출</button>
            </div>
            <div id="questionArea">
                <div class="litmus" id="qText"></div>
                <div id="qOptions"></div>
            </div>
            <div class="page-nav">
                <button class="nav-btn" onclick="prevQuestion()"><i class="fa-solid fa-chevron-left"></i> 이전 문제</button>
                <button class="nav-btn" onclick="nextQuestion()">다음 문제 <i class="fa-solid fa-chevron-right"></i></button>
            </div>
        </div>

        <div class="answer">
            <div class="timer"><span class="timer-display">30:00</span></div>
            <div class="omr-card" id="omrContainer"></div>
        </div>
    </div>

    <script>
    let time = 1800;
    let timerInterval;
    let currentQuestion = 1;
    let userAnswers = new Array(${questionList.size() + 1}).fill(0);

    const questions = [
        {},
        <c:forEach var="que" items="${questionList}" varStatus="status">
        { 
            queNum: "${que.queNum}", 
            q: "${que.queText}", 
            a: ["${que.queOpt1}", "${que.queOpt2}", "${que.queOpt3}", "${que.queOpt4}"],
            seq: ${que.queSeq} 
        }${!status.last ? ',' : ''}
        </c:forEach>
    ];

    function initTest() {
        let omrHtml = "";
        for(let i=1; i<questions.length; i++) {
            omrHtml += '<div class="omr-row" id="omr-row-'+i+'" onclick="loadQuestion('+i+')">' +
                       '<div class="q-no">'+(i<10?'0'+i:i)+'</div>' +
                       '<div class="q-options">' +
                       '<span class="option" id="omr-'+i+'-1" onclick="event.stopPropagation(); selectFromOmr('+i+', 1)">1</span>' +
                       '<span class="option" id="omr-'+i+'-2" onclick="event.stopPropagation(); selectFromOmr('+i+', 2)">2</span>' +
                       '<span class="option" id="omr-'+i+'-3" onclick="event.stopPropagation(); selectFromOmr('+i+', 3)">3</span>' +
                       '<span class="option" id="omr-'+i+'-4" onclick="event.stopPropagation(); selectFromOmr('+i+', 4)">4</span>' +
                       '</div></div>';
        }
        document.getElementById('omrContainer').innerHTML = omrHtml;
        loadQuestion(1);
        startTimer();
    }

    function startTimer() {
        const display = document.querySelector('.timer-display');
        timerInterval = setInterval(() => {
            let min = Math.floor(time / 60);
            let sec = time % 60;
            display.innerText = (min < 10 ? '0' + min : min) + ":" + (sec < 10 ? '0' + sec : sec);
            if (time <= 0) { clearInterval(timerInterval); submitTest(); }
            else { time--; }
        }, 1000);
    }

    function loadQuestion(num) {
        currentQuestion = num;
        const data = questions[num];
        if(!data || !data.q) return;

        document.getElementById('qText').innerHTML = '<strong>' + data.seq + '번 문제</strong><br><br>' + data.q;
        
        let optHtml = "";
        data.a.forEach((txt, i) => {
            let selIdx = i + 1;
            let activeClass = (userAnswers[num] === selIdx) ? 'active' : '';
            optHtml += '<div class="choice-box ' + activeClass + '" onclick="selectChoice(this, ' + selIdx + ')">' +
                       '<div class="num">' + selIdx + '</div><div class="text">' + txt + '</div></div>';
        });
        document.getElementById('qOptions').innerHTML = optHtml;

        $('.omr-row').css('background', 'transparent').removeClass('current-focus');
        const $row = $('#omr-row-' + num);
        $row.addClass('current-focus');

        const container = document.getElementById('omrContainer');
        if (container && $row.length) {
            container.scrollTo({ top: $row[0].offsetTop - (container.offsetHeight / 2), behavior: 'smooth' });
        }
    }

    function selectChoice(el, num) {
        $('.choice-box').removeClass('active');
        $(el).addClass('active');
        userAnswers[currentQuestion] = num;
        $('#omr-row-' + currentQuestion + ' .option').removeClass('active');
        $('#omr-' + currentQuestion + '-' + num).addClass('active');
    }

    function selectFromOmr(qNum, optNum) {
        loadQuestion(qNum);
        userAnswers[qNum] = optNum;
        $('#omr-row-' + qNum + ' .option').removeClass('active');
        $('#omr-' + qNum + '-' + optNum).addClass('active');
        const targetIdx = optNum - 1;
        $('.choice-box').eq(targetIdx).addClass('active');
    }

    function prevQuestion() {
        if (currentQuestion > 1) loadQuestion(currentQuestion - 1);
        else alert("첫 번째 문제입니다.");
    }

    function nextQuestion() {
        if (currentQuestion < questions.length - 1) loadQuestion(currentQuestion + 1);
        else alert("마지막 문제입니다.");
    }

    function submitTest() {
        if (userAnswers.slice(1).includes(0)) {
            if(!confirm("풀지 않은 문제가 있습니다. 제출하시겠습니까?")) return;
        } else {
            if(!confirm("최종 제출하시겠습니까?")) return;
        }

        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/test/evaluate';

        const tetInput = document.createElement('input');
        tetInput.type = 'hidden';
        tetInput.name = 'tetNum';
        tetInput.value = '${tetNum}';
        form.appendChild(tetInput);

        for (let i = 1; i < questions.length; i++) {
            const qNumInput = document.createElement('input');
            qNumInput.type = 'hidden';
            qNumInput.name = 'userAnswers[' + (i-1) + '].queNum';
            qNumInput.value = questions[i].queNum;
            form.appendChild(qNumInput);

            const qAnsInput = document.createElement('input');
            qAnsInput.type = 'hidden';
            qAnsInput.name = 'userAnswers[' + (i-1) + '].queAnswer';
            qAnsInput.value = userAnswers[i];
            form.appendChild(qAnsInput);
        }

        document.body.appendChild(form);
        form.submit();
    }

    window.onload = initTest;
    </script>
</body>
</html>
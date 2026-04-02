<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>정보처리기기 평가 시스템</title>
     <%@include file="../modules/userHeader.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/teststyle.css" />
   
</head>
<body>

    <div class="mid">
        <div class="eval">
            <div class="title">
                <span id="displayCourseTitle">[정처기] 필기 모의고사</span>
                <button class="submitbtn" onclick="submitTest()">제출</button>
            </div>
            <div id="questionArea">
                <div class="litmus" id="qText"></div>
                <div class="commentary" id="qOptions"></div>
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
    let isSubmitted = false;
    let currentQuestion = 1;
    let userAnswers = new Array(21).fill(0);

    const questions = [
        {},
        { q: "응용 프로그램의 실행을 제어하고 리소스를 관리하는 소프트웨어는?", a: ["컴파일러", "운영체제", "유틸리티", "디버거"], cor: 2, exp: "운영체제(OS)는 하드웨어와 사용자 간의 인터페이스 역할을 하며 자원을 관리합니다." },
        { q: "OSI 7계층 중 물리적 매체를 통해 비트 흐름을 전송하는 계층은?", a: ["데이터 링크 계층", "네트워크 계층", "물리 계층", "전송 계층"], cor: 3, exp: "물리 계층(Physical Layer)은 전선, 허브 등을 통해 데이터를 전기적 신호로 전송합니다." },
        { q: "관계형 데이터베이스에서 행(Row)을 의미하는 용어는?", a: ["속성(Attribute)", "도메인(Domain)", "튜플(Tuple)", "차수(Degree)"], cor: 3, exp: "행은 튜플(Tuple) 혹은 레코드라고 부르며, 열은 속성(Attribute)이라고 부릅니다." },
        { q: "TCP/IP 모델에서 신뢰성 있는 데이터 전송을 담당하는 계층은?", a: ["인터넷 계층", "전송 계층", "응용 계층", "네트워크 액세스 계층"], cor: 2, exp: "전송 계층(Transport Layer)의 TCP 프로토콜이 신뢰성 있는 연결을 담당합니다." },
        { q: "소프트웨어 테스트 중 모듈을 결합하여 인터페이스 오류를 찾는 테스트는?", a: ["단위 테스트", "통합 테스트", "시스템 테스트", "인수 테스트"], cor: 2, exp: "통합 테스트는 모듈 간의 상호작용 및 인터페이스를 검증합니다." },
        { q: "디자인 패턴 중 생성 패턴에 속하는 것은?", a: ["Adapter", "Singleton", "Proxy", "Composite"], cor: 2, exp: "Singleton은 인스턴스를 하나만 생성하도록 제한하는 생성 패턴입니다." },
        { q: "데이터베이스 설계 순서로 옳은 것은?", a: ["개념-논리-물리", "논리-개념-물리", "물리-개념-논리", "개념-물리-논리"], cor: 1, exp: "DB 설계는 요구조건 분석 후 개념적, 논리적, 물리적 설계 순으로 진행됩니다." },
        { q: "프로세스들이 서로의 작업이 끝나기만을 기다리며 무한 대기하는 상태는?", a: ["세마포어", "교착 상태(Deadlock)", "임계 영역", "기아 상태"], cor: 2, exp: "교착 상태는 상호 배제, 점유 및 대기, 비선점, 환형 대기 조건 시 발생합니다." },
        { q: "IP 주소를 물리적 MAC 주소로 변환하는 프로토콜은?", a: ["RARP", "HTTP", "ARP", "ICMP"], cor: 3, exp: "ARP(Address Resolution Protocol)는 IP 주소를 하드웨어 주소로 매핑합니다." },
        { q: "사용자 요구사항을 분석하여 명세화하는 과정은?", a: ["설계", "구현", "요구공학", "유지보수"], cor: 3, exp: "요구공학은 요구사항의 추출, 분석, 명세, 확인을 다루는 학문입니다." },
        { q: "객체지향 원칙 중 부모 클래스의 기능을 자식이 물려받는 것은?", a: ["캡슐화", "상속", "다형성", "추상화"], cor: 2, exp: "상속(Inheritance)은 코드 재사용성을 높여줍니다." },
        { q: "화이트박스 테스트 기법에 해당하는 것은?", a: ["경계값 분석", "동등 분할", "제어 구조 검사", "원인 결과 그래프"], cor: 3, exp: "구문, 경로 등 로직을 직접 확인하는 것은 화이트박스 테스트입니다." },
        { q: "결합도(Coupling) 중 가장 낮은(좋은) 것은?", a: ["내용 결합도", "데이터 결합도", "공통 결합도", "제어 결합도"], cor: 2, exp: "결합도는 낮을수록 좋으며, 데이터 결합도가 가장 독립성이 높습니다." },
        { q: "응집도(Cohesion) 중 가장 높은(좋은) 것은?", a: ["순차적 응집도", "기능적 응집도", "절차적 응집도", "논리적 응집도"], cor: 2, exp: "응집도는 높을수록 좋으며, 기능적 응집도가 가장 강력합니다." },
        { q: "유스케이스 다이어그램의 구성 요소가 아닌 것은?", a: ["액터", "시스템 범위", "관계", "클래스"], cor: 4, exp: "클래스는 클래스 다이어그램의 핵심 요소입니다." },
        { q: "데이터베이스의 무결성 중 기본키는 NULL일 수 없다는 원칙은?", a: ["참조 무결성", "개체 무결성", "도메인 무결성", "사용자 무결성"], cor: 2, exp: "개체 무결성 제약조건에 따라 기본키(PK)는 중복과 NULL을 허용하지 않습니다." },
        { q: "UNIX에서 파일의 권한을 변경하는 명령어는?", a: ["ls", "pwd", "chmod", "cp"], cor: 3, exp: "chmod는 파일 및 디렉토리의 액세스 권한을 설정합니다." },
        { q: "릴레이션에서 튜플을 유일하게 식별할 수 있는 최소한의 속성 집합은?", a: ["슈퍼키", "후보키", "대체키", "외래키"], cor: 2, exp: "후보키는 유일성과 최소성을 모두 만족해야 합니다." },
        { q: "두 리스트를 비교하여 순차적으로 정렬하는 알고리즘은?", a: ["버블 정렬", "병합 정렬", "삽입 정렬", "선택 정렬"], cor: 2, exp: "병합 정렬(Merge Sort)은 분할 정복 방식을 사용하는 정렬입니다." },
        { q: "DoS 공격 중 하나로 패킷 전송 시 송신 주소를 수신 주소와 동일하게 설정하는 것은?", a: ["Smurf", "LAND Attack", "Ping of Death", "Slowloris"], cor: 2, exp: "LAND 공격은 패킷의 출발지와 목적지를 대상의 IP로 설정하여 시스템을 마비시킵니다." }
    ];

    function initTest() {
        let omrHtml = "";
        for(let i=1; i<=20; i++) {
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
        document.getElementById('qText').innerHTML = '<strong>' + num + '번 문제</strong><br><br>' + data.q;
        
        let optHtml = "";
        data.a.forEach((txt, i) => {
            let selIdx = i + 1;
            let activeClass = (userAnswers[num] === selIdx) ? 'active' : '';
            optHtml += '<div class="choice-box ' + activeClass + '" onclick="selectChoice(this, ' + selIdx + ')">' +
                       '<div class="num">' + selIdx + '</div><div class="text">' + txt + '</div></div>';
        });
        document.getElementById('qOptions').innerHTML = optHtml;

        $('.omr-row').removeClass('current-focus').css('background', 'transparent');
        const $row = $('#omr-row-' + num);
        $row.addClass('current-focus');

        const container = document.getElementById('omrContainer');
        if (container && $row.length) {
            container.scrollTo({ top: $row[0].offsetTop - (container.offsetHeight / 2), behavior: 'smooth' });
        }

        if(isSubmitted) showExplanation();
    }

    function selectChoice(el, num) {
        if (isSubmitted) return;
        $('.choice-box').removeClass('active');
        $(el).addClass('active');
        userAnswers[currentQuestion] = num;
        $('#omr-row-' + currentQuestion + ' .option').removeClass('active');
        $('#omr-' + currentQuestion + '-' + num).addClass('active');
    }

    function selectFromOmr(qNum, optNum) {
        if (isSubmitted) return;
        loadQuestion(qNum);
        const target = $('.choice-box').eq(optNum - 1);
        selectChoice(target, optNum);
    }

    function prevQuestion() {
        if (currentQuestion > 1) loadQuestion(currentQuestion - 1);
        else alert("첫 번째 문제입니다.");
    }

    function nextQuestion() {
        if (currentQuestion < 20) loadQuestion(currentQuestion + 1);
        else alert("마지막 문제입니다.");
    }

    function showExplanation() {
        $('.explanation-box').remove();
        const data = questions[currentQuestion];
        const userAns = userAnswers[currentQuestion];
        
        const isCorrect = (userAns !== 0 && userAns === data.cor);
        
        let tColor = isCorrect ? "#00A859" : "#EF4444";
        let bColor = isCorrect ? "#F0F9F4" : "#FEF2F2";
        let title = isCorrect ? "[정답]" : "[오답]";

        $('.choice-box').each(function(i){
            let n = i + 1;
            $(this).css('pointer-events', 'none');
            
            if(n === data.cor) {
                $(this).css({'background': '#00A859', 'color': '#fff', 'border-color': '#008F4C'});
            } else if(n === userAns) {
                $(this).css({'background': '#EF4444', 'color': '#fff', 'border-color': '#DC2626'});
            }
        });

        const exp = document.createElement('div');
        exp.className = "explanation-box";
        exp.style.cssText = "background-color:"+bColor+"; border-left:6px solid "+tColor+"; border: 1px solid "+tColor+"; padding:20px; border-radius:10px;";
        exp.innerHTML = "<h3 style='color:"+tColor+"; margin-top:0;'>"+title+" (정답: "+data.cor+"번)</h3>" +
                        "<p style='color:#334155; margin:0; line-height:1.7;'>"+data.exp+"</p>";
        
        document.getElementById('qOptions').appendChild(exp);
        
        /* OMR 색상 변경 로직 삭제 완료: 사용자가 선택한 기본 active 색상을 그대로 유지합니다. */
    }

    function submitTest() {
        if (userAnswers.slice(1, 21).includes(0)) {
            if(!confirm("풀지 않은 문제가 있습니다. 제출하시겠습니까?")) return;
        } else {
            if(!confirm("최종 제출하시겠습니까?")) return;
        }
        isSubmitted = true;
        clearInterval(timerInterval);
        $('.submitbtn').prop('disabled', true).text('채점 완료').css('background', '#94a3b8');
        loadQuestion(1);
    }

    window.onload = initTest;
    </script>
</body>
</html>
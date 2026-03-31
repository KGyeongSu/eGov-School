<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>

	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link type="text/css" rel="stylesheet" href="../../../resources/css/user/commons.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="../../../resources/bootstrap/dist/css/adminlte.min.css">
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<header>
    <div class="logo">
        <a href="http://localhost/user/dashBoard">
        	<img src="${pageContext.request.contextPath}/resources/imgs/dashboardLogo.png">
        </a>
    </div>
    <nav class="menu">
        <ul>
            <li class="${param.menu == 'course' ? 'active' : ''}"><a href="http://localhost/user/myKang"><span>My 강좌</span></a></li>
            <li class="${param.menu == 'eval' ? 'active' : ''}"><a href="http://localhost/user/exam"><span>My 평가</span></a></li>
        </ul>
    </nav>
</header>

<div class="content">
    <div class="top">
        <div class="icon">
            <a href="#"><i class="fa-regular fa-user"></i></a>
        </div>
        <div class="state_bar">
            <p>??님의 메인대시보드</p>
        </div>
        <div class="logout_dash">
            <div class="mes">
                <a href="#"><i class="fa-regular fa-envelope"></i></a>
            </div>
            <div class="out">
                <button type="button" class="btn btn-sm btn-info"
                    style="background-color: #1a6d91; border: none;">로그아웃</button>
            </div>
        </div>
    </div>
   
   
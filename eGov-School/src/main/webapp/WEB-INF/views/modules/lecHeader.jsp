<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 헤더 & 상단 고정 css -->
<link type="text/css" rel="stylesheet" href="../../resources/css/lecterer/commons.css" />
<!-- font awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- bootstrap -->
<link rel="stylesheet"
	href="../../../resources/bootstrap/dist/css/adminlte.min.css">

<body>	
<header>
		<div class="logo">
			<a href="mainDashBoard"><img src="../../../resources/images/dashboardLogo.png" /></a>
		</div>

		<nav class="menu">
			<ul>
				<li onclick="OpenWindow('profile', 'My 프로필', 700, 900);" style="cursor: pointer;"><span>My 프로필</span></li>
				<li onclick="location.href='myRoom';" style="cursor: pointer;"><span>My 강의실</span></li>
				<li onclick="location.href='resultManage';" style="cursor: pointer;"><span>My &nbsp; 평가</span></li>
			</ul>
		</nav>
</header>
</body>
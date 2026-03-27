<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../modules/lecHeader.jsp" %>
	<!-- 개별 css -->
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styleresultManage.css" />
    
    <!-- 그래프 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <title>resultManage</title>
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
						style="background-color: #1a6d91; color: white; border-radius: 4px; font-size: 12px; border: none; line-height: 1;">로그아웃
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
            <div class="search">
                <div class="search_area" style="display: flex; gap: 10px; width: 96%;">
                    <div style="position: relative; flex: 1;">
                        <i class="fa-solid fa-magnifying-glass"
                            style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #adb5bd; font-size: 14px;"></i>
                        <input type="text" placeholder="평가 강의 검색"
                            style="width: 100%; padding: 10px 10px 10px 35px; border: 1px solid #d1d1d1; border-radius: 6px; font-size: 14px; outline: none; box-sizing: border-box;">
                    </div>
                    <button type="button"
                        style="background-color: #0e506e; color: white; border: none; padding: 0 20px; border-radius: 6px; cursor: pointer; font-size: 14px; font-weight: 500;">검색</button>
                </div>
            </div>
        </div>
        <div class="main">
            <div class="listwrap">
                <table style="width: 100%; border-collapse: collapse; text-align: left;">
                    <thead>
                        <tr style="background-color: #f8f9fa; border-bottom: 2px solid #dee2e6;">
                        	<th style="width: 5%; text-align: center; padding: 15px 10px;">No.</th>
                            <th style="padding: 18px 20px; font-weight: 600; color: #495057; width: 40%;">평가 출제 강의명</th>
                            <th style="padding: 18px 200px; font-weight: 600; color: #495057; width: 20%; text-align: right;">관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 리스트 -->
                        <tr style="border-bottom: 1px solid #f1f1f1; transition: background 0.2s;">
                        	<td style="text-align: center; color: #24272b; font-size: 13px;">1</td>
                            <td style="padding: 18px 20px;">
                                <div style="font-weight: 600; color: #212529;">[헌법] 헌법 기초</div>
                                <div style="font-size: 12px; color: #868e96; margin-top: 4px;">강좌 ID: RAW_BASIC_01
                                </div>
                            </td>
                            <td style="padding: 18px 103px; text-align: right;">
                                <!-- 출제하기 및  수정하기 버튼 -->
                                 <button type="button"
                                    style="background: #fff; border: 1px solid #d1d1d1; color: #495057; padding: 7px 15px; border-radius: 4px; font-size: 13px; cursor: pointer; transition: all 0.2s; display: inline-flex; align-items: center; gap: 6px; margin-right: 10px;"
                                    onmouseover="this.style.backgroundColor='#f1f1f1'; this.style.opacity='0.8';"
                                    onmouseout="this.style.backgroundColor='#fff'; this.style.opacity='1';">
                                    <i class= "fa-solid fa-file-circle-plus"></i> 출제하기
                                </button>
                                <button type="button"
                                    style="background: #fff; border: 1px solid #d1d1d1; color: #495057; padding: 7px 15px; border-radius: 4px; font-size: 13px; cursor: pointer; transition: all 0.2s; display: inline-flex; align-items: center; gap: 6px;"
                                    onmouseover="this.style.backgroundColor='#f1f1f1'; this.style.opacity='0.8';"
                                    onmouseout="this.style.backgroundColor='#fff'; this.style.opacity='1';">
                                    <i class="fa-solid fa-file-pen"></i> 수정하기
                                </button>
                            </td>
                        </tr>
                        <!-- 데이터가 더 들어올 자리 -->
                    </tbody>
                </table>
            </div>
            <div class="pagination_wrapper" >
						<!-- pagination -->
						<%@ include file="/WEB-INF/views/modules/pagination.jsp"%>
			</div>
        </div>
    </div>
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../modules/lecHeader.jsp" %>
	<!-- 개별 css -->	
    <link type="text/css" rel="stylesheet" href="../../../resources/css/lecterer/styleresultManage.css" />
    
    <title>reputationHome</title>
</head>

<body>
    <div class="content">
        <div class="top">
            <div class="icon">
                <a href=""><i class="fa-regular fa-user"></i></a>
            </div>
            <div class="state_bar">
                <p>???님의 메인 대시보드</p>
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
            <div class="meg">
                <h2>My 메시지</h2>
            </div>
            <div class="search">
                <div class="search_area" style="display: flex; gap: 10px; width: 96%;">
                    <div style="position: relative; flex: 1;">
                        <i class="fa-solid fa-magnifying-glass"
                            style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #adb5bd; font-size: 14px;"></i>
                        <input type="text" placeholder="피드백 검색"
                            style="width: 100%; padding: 10px 10px 10px 35px; border: 1px solid #d1d1d1; border-radius: 6px; font-size: 14px; outline: none; box-sizing: border-box;">
                    </div>
                    <button type="button" style="background-color: #0e506e; color: white; border: none; padding: 0 20px; border-radius: 6px; cursor: pointer; font-size: 14px; font-weight: 500;">검색</button>
                </div>
            </div>
        </div>
        <div class="main">
            <div class="listwrap">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 5%; text-align: center; padding: 15px 10px;">No.</th>
                            <th style="width: 10%; text-align: center;">구분</th>
                            <th style="width: 65%; text-align: left; padding-left: 100px;">내용</th>
                            <th style="width: 20%; text-align: center;">날짜 및 관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 관리자 피드백 -->
                        <tr>
                            <td style="text-align: center; color: #24272b; font-size: 13px; font-weight: 500;">1</td>
                            <td>
                                <span class="mbtn">관리자</span>
                            </td>
                            <td style=" padding-left: 100px;">
                                <div style="font-weight: 700; color: #0e506e; font-size: 14px; margin-bottom: 5px;">[2026 신규 공무원 과정]</div>
                                <div style="color: #24272b; font-size: 14px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 550px;">강의 자료의 가독성이 매우 훌륭합니다. 수강생들의 만족도가 높으니 참고 부탁드립니다.</div>
                            </td>
                            <td style="text-align: center;">
                                <span style="font-size: 13px; color: #24272b; margin-right: 15px;">2026-03-19</span>
                                <button type="button"
                                    style="background: #fff; border: 1px solid #d1d1d1; padding: 6px 12px; border-radius: 4px; font-size: 12px; cursor: pointer;">상세보기</button>
                            </td>
                        </tr>

                        <!-- 수강생 피드백 -->
                        <tr>
                            <td style="text-align: center; color: #24272b; font-size: 13px; font-weight: 500;">2</td>
                            <td>
                                <span class="ubtn">수강생</span>
                            </td>
                            <td style=" padding-left: 100px;">
                                <div style="font-weight: 700; color: #0e506e; font-size: 14px; margin-bottom: 5px;">[헌법기초] 홍길동 수강생</div>
                                <div style="color: #24272b; font-size: 14px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 550px;">
                                    교수님 설명이 너무 명쾌해서 비전공자인데도 이해가 잘 됩니다. 감사합니다!
                                </div>
                            </td>
                            <td style="text-align: center;">
                                <span style="font-size: 13px; color: #24272b; margin-right: 15px;">2026-03-18</span>
                                <button type="button" style="background: #fff; border: 1px solid #d1d1d1; padding: 6px 12px; border-radius: 4px; font-size: 12px; cursor: pointer;">상세보기</button>
                            </td>
                        </tr>

                        <!-- for 문 -->
                    </tbody>
                </table>

            	</div>
                <!-- 페이지네이션 -->
                <div class="pagination_wrapper" >
						<!-- pagination -->
						<%@ include file="/WEB-INF/views/modules/pagination.jsp"%>
				</div>
        	</div>
    	</div>
	</body>

</html>
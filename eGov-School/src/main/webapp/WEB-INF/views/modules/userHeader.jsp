<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <meta charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="../../../resources/css/user/commons.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="../../../resources/bootstrap/dist/css/adminlte.min.css">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<header>
    <div class="logo">
        <a href="${pageContext.request.contextPath}/main">
            <img src="${pageContext.request.contextPath}/resources/images/dashboardLogo.png" alt="로고">
        </a>
    </div>
    <nav class="menu">
        <ul>
            <li><a href="${pageContext.request.contextPath}/user/dashBoard"><span>My 메인</span></a></li>
            <li><a href="${pageContext.request.contextPath}/user/myKang"><span>My 강좌</span></a></li>
            <li><a href="${pageContext.request.contextPath}/user/exam"><span>My 평가</span></a></li>
        </ul>
    </nav>
</header>

<div class="content">
    <div class="top">
        <div class="icon"><i class="fa-regular fa-user"></i></div>
        <div class="state_bar">
           <p><strong>${loginUser.userName}</strong>님의 대시보드</p>
        </div>
        <div class="logout_dash">
            <div class="mes" onclick="fetchReceivedList()">
                <i class="fa-regular fa-envelope"></i>
                <span id="unreadBadge">0</span>
            </div>
            <div class="out">
                <button type="button" class="btn btn-sm btn-info" 
                        onclick="location.href='/commons/logout'">로그아웃</button>
            </div>
        </div>
    </div>

    <div class="modal fade" id="msgBoxModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content custom-modal-content">
                <div class="modal-header custom-modal-header">
                    <h5 class="modal-title custom-modal-title">
                        <i class="fa-solid fa-paper-plane"></i> 받은 쪽지함
                    </h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body p-0 msg-list-body" id="msgListContainer">
                </div>
            </div>
        </div>
  

    <script>
    var ctx = "${pageContext.request.contextPath}";

    $(document).ready(function() {
        updateBadgeCount();
    });

    function updateBadgeCount() {
        $.get(ctx + '/user/unreadCount', function(count) {
            if (parseInt(count) > 0) $('#unreadBadge').text(count).show();
            else $('#unreadBadge').hide();
        });
    }

    function fetchReceivedList() {
        $.get(ctx + '/user/receivedList', function(data) {
            var html = '';
            if (!data || data.length === 0) {
                html = '<div class="msg-empty"><i class="fa-regular fa-folder-open"></i><p>새로운 쪽지가 없습니다.</p></div>';
            } else {
                data.forEach(function(msg) {
                    var isUnread = (msg.msCheck === 'N');
                    var cardClass = isUnread ? 'msg-card unread-card' : 'msg-card read-card';
                    var iconClass = isUnread ? 'fa-envelope' : 'fa-envelope-open';
                    var badgeHtml = isUnread ? '<span class="msg-new-badge">N</span>' : '';
                    var dateStr = !isNaN(msg.msSenddate) ? new Date(msg.msSenddate).toLocaleDateString() : msg.msSenddate;

                    html += '<div class="' + cardClass + '" onclick="openMsgDetail(\''+msg.msNum+'\')">';
                    html += '  <div class="msg-icon"><i class="fa-solid ' + iconClass + '"></i></div>';
                    html += '  <div class="msg-info">';
                    html += '    <div class="msg-card-header">';
                    html += '      <span class="msg-sender">' + msg.msSenderName + badgeHtml + '</span>';
                    html += '      <span class="msg-date">' + dateStr + '</span>';
                    html += '    </div>';
                    html += '    <div class="msg-preview">' + msg.msContent + '</div>';
                    html += '  </div>';
                    html += '</div>';
                });
            }
            $('#msgListContainer').html(html);
            $('#msgBoxModal').modal('show');
        });
    }

    function openMsgDetail(msNum) {
        $.post(ctx + '/user/detail', { msNum: msNum }, function(msg) {
            if(msg) {
                Swal.fire({ 
                    title: '<span style="font-size:18px; color:#0e506e;">보낸 사람: ' + msg.msSenderName + '</span>', 
                    html: '<div style="background:#f8fafc; padding:20px; border-radius:12px; font-size:15px; color:#334155; text-align:left; border:1px solid #e2e8f0;">' + msg.msContent + '</div>',
                    confirmButtonColor: '#0e506e',
                    confirmButtonText: '확인'
                }).then(function() { 
                    fetchReceivedList(); 
                    updateBadgeCount(); 
                });
            }
        });
    }
    </script>
</div>
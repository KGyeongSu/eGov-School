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
        <a href="${pageContext.request.contextPath}/user/dashBoard">
            <img src="${pageContext.request.contextPath}/resources/images/dashboardLogo.png" alt="로고">
        </a>
    </div>
    <nav class="menu">
        <ul>
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
            <div class="mes" style="position:relative; cursor:pointer;" onclick="fetchReceivedList()">
                <i class="fa-regular fa-envelope" style="font-size: 40px; color: #595959; line-height: 75px;"></i>
                <span id="unreadBadge" style="position:absolute; top:10px; right:5px; background-color:#d9534f; color:#fff; font-size:11px; padding:2px 6px; border-radius:50%; display:none; line-height:1; z-index:10;">0</span>
            </div>
            <div class="out">
                <button type="button" class="btn btn-sm btn-info" 
                        style="background-color: #1a6d91; border: none;"
                        onclick="location.href='${pageContext.request.contextPath}/main'">로그아웃</button>
            </div>
        </div>
    </div>

    <div class="modal fade" id="msgBoxModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header" style="background:#0e506e; color:#fff; display:flex; justify-content:space-between; align-items:center;">
                    <h5 class="modal-title" style="margin:0;"><i class="fa-regular fa-envelope"></i> 받은 쪽지함</h5>
                    <button type="button" class="close" data-dismiss="modal" style="color:#fff; opacity:1; border:none; background:none; font-size:28px;">&times;</button>
                </div>
                <div class="modal-body p-0" id="msgListContainer" style="max-height:400px; overflow-y:auto;">
                </div>
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
                html = '<div class="p-4 text-center">받은 쪽지가 없습니다.</div>';
            } else {
                data.forEach(function(msg) {
                    var style = (msg.msCheck === 'N') ? 'background:#f1f8fb; font-weight:bold; border-left:4px solid #1a6d91;' : '';
                    var dateStr = !isNaN(msg.msSenddate) ? new Date(msg.msSenddate).toLocaleDateString() : msg.msSenddate;

                    html += '<div style="padding:15px; border-bottom:1px solid #eee; cursor:pointer; ' + style + '" onclick="openMsgDetail(\''+msg.msNum+'\')">';
                    html += '  <div style="display:flex; justify-content:space-between;">';
                    html += '    <span style="color:#0e506e;">' + msg.msSenderName + '</span>';
                    html += '    <small style="color:#888;">' + dateStr + '</small>';
                    html += '  </div>';
                    html += '  <div style="font-size:13px; color:#666; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">' + msg.msContent + '</div>';
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
                Swal.fire({ title: 'From: ' + msg.msSenderName, text: msg.msContent, confirmButtonColor: '#0e506e' })
                .then(function() { fetchReceivedList(); updateBadgeCount(); });
            }
        });
    }
    </script>
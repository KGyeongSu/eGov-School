/* admin.js - 관리자 대시보드 공통 스크립트 */

/* ========================
   페이지(사이드 메뉴) 전환
======================== */
function showPage(pageId, el) {
    // 모든 페이지 숨기기
    var pages = document.querySelectorAll('.page-content');
    for (var i = 0; i < pages.length; i++) {
        pages[i].classList.remove('active');
    }
    // 해당 페이지 보이기
    document.getElementById(pageId).classList.add('active');

    // 사이드바 on 표시
    var links = document.querySelectorAll('.sidebar .side-menu a');
    for (var j = 0; j < links.length; j++) {
        links[j].classList.remove('on');
    }
    el.classList.add('on');
}

/* ========================
   탭 전환
======================== */
function showTab(tabId, el) {
    // 같은 탭바 안의 탭 콘텐츠 모두 숨기기
    var tabBar = el.closest('.tab-bar');
    var tabGroup = tabBar.getAttribute('data-group');
    var contents = document.querySelectorAll('.tab-content[data-group="' + tabGroup + '"]');
    for (var i = 0; i < contents.length; i++) {
        contents[i].classList.remove('active');
    }
    // 선택한 탭 콘텐츠 보이기
    var target = document.getElementById(tabId);
    if (target) target.classList.add('active');

    // 탭 버튼 on 표시
    var tabs = tabBar.querySelectorAll('a');
    for (var j = 0; j < tabs.length; j++) {
        tabs[j].classList.remove('on');
    }
    el.classList.add('on');
}

/* ========================
   모달 열기 / 닫기
======================== */
function openModal(id) {
    document.getElementById(id).classList.add('show');
}
function closeModal(id) {
    document.getElementById(id).classList.remove('show');
}
// 모달 바깥 클릭 시 닫기
document.addEventListener('DOMContentLoaded', function() {
    var overlays = document.querySelectorAll('.modal-overlay');
    for (var i = 0; i < overlays.length; i++) {
        overlays[i].addEventListener('click', function(e) {
            if (e.target === this) this.classList.remove('show');
        });
    }
});

/* ========================
   전체 체크박스 선택/해제
======================== */
function toggleAll(masterCb, bodyId) {
    var checkboxes = document.querySelectorAll('#' + bodyId + ' input[type="checkbox"]');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = masterCb.checked;
    }
}

/* ========================
   선택 항목 삭제 확인
======================== */
function deleteSelected(bodyId) {
    var checked = document.querySelectorAll('#' + bodyId + ' input[type="checkbox"]:checked');
    if (checked.length === 0) {
        alert('삭제할 항목을 선택하세요.');
        return;
    }
    if (confirm(checked.length + '개 항목을 삭제하시겠습니까?')) {
        for (var i = 0; i < checked.length; i++) {
            checked[i].closest('tr').remove();
        }
        alert('삭제되었습니다.');
    }
}

/* ========================
   테이블 행 필터링
======================== */
function filterTable(bodyId, filters) {
    // filters: [{inputId, colIndex}, ...]
    // 예) filterTable('myBody', [{inputId:'searchInput', colIndex:1}])
    var rows = document.querySelectorAll('#' + bodyId + ' tr');
    var count = 0;
    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        var show = true;
        for (var j = 0; j < filters.length; j++) {
            var val = document.getElementById(filters[j].inputId).value.trim();
            if (!val) continue;
            var cell = row.querySelectorAll('td')[filters[j].colIndex];
            if (!cell) continue;
            if (cell.textContent.indexOf(val) === -1) {
                show = false;
                break;
            }
        }
        row.style.display = show ? '' : 'none';
        if (show) count++;
    }
    return count;
}

/* ========================
   테이블 필터 초기화
======================== */
function resetFilter(inputIds, bodyId) {
    for (var i = 0; i < inputIds.length; i++) {
        var el = document.getElementById(inputIds[i]);
        if (el) el.value = '';
    }
    var rows = document.querySelectorAll('#' + bodyId + ' tr');
    for (var j = 0; j < rows.length; j++) {
        rows[j].style.display = '';
    }
}

/* ========================
   로그아웃
======================== */
function doLogout() {
    if (confirm('로그아웃 하시겠습니까?')) {
        location.href = 'login.html';
    }
}

/* ========================
   엑셀 다운로드 (알림만)
======================== */
function exportExcel() {
    alert('엑셀 파일로 다운로드합니다.\n(실제 서비스에서는 서버에서 파일 생성 후 다운로드)');
}
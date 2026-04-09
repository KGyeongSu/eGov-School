$(document).ready(function () {

    /* ===== 이미지 슬라이드 (메인페이지) dd===== */
    if ($('.img_slide').length) {
        let current = 0;
        const total = 3;

        // 슬라이드 하단 dot 활성화
        function updateDots() {
            $('.dot').removeClass('active');
            $('.dot').eq(current).addClass('active');
        }

        // 슬라이드 이동
        function goSlide(n) {
            current = (n + total) % total;
            var width = $('.img_slide').width();
            $('.slide_list ul').animate({ marginLeft: -(width * current) }, 500);
            updateDots();
        }

        // 3초마다 자동 슬라이드
        setInterval(function () {
            goSlide(current + 1);
        }, 3000);

        // 좌우 버튼 클릭
        $('.next').click(function () { goSlide(current + 1); });
        $('.prev').click(function () { goSlide(current - 1); });

        // dot 클릭으로 슬라이드 이동
        $('.dot').each(function (i) {
            $(this).click(function () { goSlide(i); });
        });

        // 창 크기 변경 시 슬라이드 위치 재계산
        $(window).resize(function () {
            var width = $('.img_slide').width();
            $('.slide_list ul').css('marginLeft', -(width * current));
        });
    }

    /* ===== 필터 버튼 (메인페이지 교육과정) ===== */
    if ($('.filter_btn').length) {
        $('.filter_btn button').click(function () {
            $('.filter_btn button').removeClass('active');
            $(this).addClass('active');
        });
    }

    /* ===== 이용약관 모달 바깥 클릭 시 닫기 (회원가입) ===== */
    var termsModal = document.getElementById('termsModal');
    if (termsModal) {
        termsModal.addEventListener('click', function (e) {
            if (e.target === this) closeTermsModal();
        });
    }

    /* ===== 수강신청 상세보기 모달 바깥 클릭 시 닫기 ===== */
    var courseModal = document.getElementById('courseModal');
    if (courseModal) {
        courseModal.addEventListener('click', function (e) {
            if (e.target === this) closeCourseModal();
        });
    }

    /* ===== Flatpickr 달력 초기화 (수강신청) ===== */
    var datePicker = document.getElementById('datePicker');
    if (datePicker) {
        flatpickr("#datePicker", {
            locale: "ko",
            dateFormat: "Y.m.d"
        });
    }
});


/* ===== 이용약관 모달 (회원가입) ===== */

// 모달 열기
function openTermsModal() {
    document.getElementById('termsModal').style.display = 'flex';
}

// 모달 닫기
function closeTermsModal() {
    document.getElementById('termsModal').style.display = 'none';
}

// 전체 동의 체크박스 토글
function toggleAll(checkbox) {
    var checks = document.querySelectorAll('.term_check');
    for (var i = 0; i < checks.length; i++) {
        checks[i].checked = checkbox.checked;
    }
    checkAgree();
}

// 필수 약관 체크 여부 확인 → 동의 버튼 활성화
function checkAgree() {
    var btn = document.getElementById('agreeBtn');
    if (!btn) return;

    var required = document.querySelectorAll('.term_check[data-required="true"]');
    var allChecked = true;
    for (var i = 0; i < required.length; i++) {
        if (!required[i].checked) {
            allChecked = false;
            break;
        }
    }

    btn.disabled = !allChecked;
    if (allChecked) {
        btn.classList.add('active');
    } else {
        btn.classList.remove('active');
    }

    // 전체동의 체크 상태 동기화
    var agreeAll = document.getElementById('agreeAll');
    if (!agreeAll) return;

    var allTerms = document.querySelectorAll('.term_check');
    var totalChecked = true;
    for (var i = 0; i < allTerms.length; i++) {
        if (!allTerms[i].checked) {
            totalChecked = false;
            break;
        }
    }
    agreeAll.checked = totalChecked;
}

// 동의 확인 → 모달 닫고 약관 체크박스 체크
function confirmAgree() {
    document.getElementById('terms_agree').checked = true;
    closeTermsModal();
}

// 약관 상세 내용 토글 (내용보기/접기)
function toggleDetail(btn) {
    var detail = btn.nextElementSibling;
    if (detail.style.display === 'none') {
        detail.style.display = 'block';
        btn.textContent = '접기 ▲';
    } else {
        detail.style.display = 'none';
        btn.textContent = '내용보기 ▼';
    }
}


/* ===== 수강신청 상세보기 모달 ===== */

// 테이블 row 데이터를 읽어서 모달에 채우고 열기
function openCourseModal(row) {
    var cells = row.querySelectorAll('td');
    var no = cells[0].textContent;
    var title = cells[1].textContent;
    var teacher = cells[2].textContent;
    var eduDate = cells[3].textContent;
    var regDate = cells[4].textContent;
    var status = cells[5].textContent;

    document.querySelector('.cm_no').textContent = '강좌번호 : ' + String(no).padStart(3, '0');
    document.querySelector('.cm_title').textContent = title;
    document.querySelector('.cm_teacher').textContent = teacher;
    document.querySelector('.cm_date').textContent = eduDate;
    document.querySelector('.cm_receipt').textContent = regDate;
    document.querySelector('.cm_status').textContent = status + '명';
    document.querySelector('.cm_goal').textContent = title + '의 핵심 내용을 학습합니다.';

    // 썸네일 초기화 (테이블에는 썸네일 없음)
    var modalThumb = document.querySelector('.cm_thumb');
    modalThumb.innerHTML = '';

    document.getElementById('courseModal').style.display = 'flex';
}

// 상세보기 모달 닫기
function closeCourseModal() {
    document.getElementById('courseModal').style.display = 'none';
}
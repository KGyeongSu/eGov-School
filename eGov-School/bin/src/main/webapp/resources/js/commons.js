/** 비디오 업로드 시 미리보기 */
function previewVideo(input) {
    const file = input.files[0];
    const videoPlayer = document.getElementById('video_player');
    const placeholder = document.getElementById('preview_placeholder');

    if (file) {
        const fileURL = URL.createObjectURL(file);
        videoPlayer.src = fileURL;
        videoPlayer.style.display = 'block'; // 비디오 보이기
        placeholder.style.display = 'none';  // 안내문구 숨기기
        videoPlayer.load();
    }
}


const fileInput = document.getElementById('file_up');

// 요소가 존재할 때만 이벤트 리스너 등록
if (fileInput) {
    fileInput.addEventListener('change', function(e) {
        const fileList = e.target.files;
        const listElement = document.getElementById('attached_file_list');
        const countElement = document.getElementById('file_count');
        
        // 리스트와 카운트 요소도 존재하는지 한 번 더 확인 (안전장치)
        if (!listElement || !countElement) return;

        listElement.innerHTML = ''; // 초기화
        
        if (fileList.length > 0) {
            countElement.innerText = fileList.length + '개';
            
            for (let i = 0; i < fileList.length; i++) {
                const li = document.createElement('li');
                li.className = 'file_item';
                li.innerHTML = `
                    <span><i class="fa-regular fa-file"></i> ${fileList[i].name}</span>
                    <small>(${(fileList[i].size / 1024).toFixed(1)} KB)</small>
                `;
                listElement.appendChild(li);
            }
        } else {
            countElement.innerText = '0개';
            listElement.innerHTML = '<li class="empty_msg">선택된 파일이 없습니다.</li>';
        }
    });
}

/** 커리큘럼 추가 */
function addCurriculum() {
            const container = document.getElementById('curriculum_list');
            const nextNum = container.getElementsByClassName('curri_item').length + 1;

            const newItem = document.createElement('div');
            newItem.className = 'curri_item';
            newItem.innerHTML = `
                <span class="step_badge">${nextNum}강</span>
                <input type="text" class="input_control" placeholder="강의 주제를 입력하세요">
                <button type="button" class="remove_btn" onclick="removeCurri(this)"><i class="fa-solid fa-xmark"></i></button>
            `;

            container.appendChild(newItem);
            container.scrollTop = container.scrollHeight; // 추가 시 자동 스크롤 하단 이동
        }

        function removeCurri(btn) {
            const container = document.getElementById('curriculum_list');
            if(container.getElementsByClassName('curri_item').length > 1) {
                btn.closest('.curri_item').remove();
                // 번호 재정렬
                const items = container.getElementsByClassName('step_badge');
                Array.from(items).forEach((badge, index) => {
                    badge.innerText = (index + 1) + "강";
                });
            } else {
                alert("최소 1강 이상 입력해야 합니다.");
            }
        }

// 강의실 생성 제출 시 달력 아이콘 누르면 나오는 미니달력
const dateInput = document.getElementById('datePicker');
const dateIcon = document.getElementById('calendarIcon');

	if (dateInput && dateIcon) {
		
		    const fp = flatpickr(dateInput, {
				
		        locale: "ko",
		        dateFormat: "Y.m.d",
		        disableMobile: true,
		        static: false, 
		        onOpen: function(selectedDates, dateStr, instance) {
					
		            const rect = dateIcon.getBoundingClientRect();
		            
		            setTimeout(() => {
		                instance.calendarContainer.style.setProperty("top", (window.pageYOffset + rect.bottom + 5) + "px", "important");
		                instance.calendarContainer.style.setProperty("left", (window.pageXOffset + rect.left - 230) + "px", "important");
		            }, 0);
		        }
		    });

		    dateIcon.addEventListener('click', function() {
		        fp.open();
		    });
		}
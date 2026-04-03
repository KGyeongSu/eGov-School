// 윈도우 창
function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight) {

    winleft = (screen.width - WinWidth) / 2;
    wintop = (screen.height - WinHeight) / 2;
    var win = window.open(UrlStr, WinTitle, "width=" + WinWidth
        + ",height=" + WinHeight + ", top=" + wintop + ", left="
        + winleft + ", status=yes");

    win.focus();

}


//팝업창 닫기
function CloseWindow() {

    window.opener.location.reload(true);
    window.close();

}

/** 비디오 업로드 시 미리보기 */
function previewVideo(input) {
	
    const videoPlayer = document.getElementById('video_player');
    const placeholder = document.getElementById('preview_placeholder');
    const deleteInput = document.getElementById('deleteFiles'); 

    if (!videoPlayer) return;

    // 새로운 파일이 선택되었을 때만
    if (input.files && input.files[0]) {
        
        // 기존 동영상이 확인 후 삭제 리스트에 추가 
         if (videoPlayer.src && videoPlayer.src.includes('/upload/lesson/')) {
            
            // URL에서 파일명만 추출 (예: uuid_filename.mp4)
            const oldVideoSaveName = videoPlayer.src.split('/').pop();
            
            // 삭제 리스트(hidden input)에 중복되지 않게 추가
            let currentDeleted = deleteInput.value;
            if (!currentDeleted.includes(oldVideoSaveName)) {
                deleteInput.value = currentDeleted === "" 
                                 ? oldVideoSaveName 
                                 : currentDeleted + "," + oldVideoSaveName;
                
                console.log("기존 동영상 삭제 예약:", oldVideoSaveName);
            }
        }

        /* 새로운 파일 프리뷰 */
        const file = input.files[0];

        const fileURL = URL.createObjectURL(file);

        videoPlayer.src = fileURL;
        videoPlayer.style.display = 'block'; 
        
        if (placeholder) {
			
            placeholder.style.display = 'none'; 
        }

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

            for (let i = 0;i < fileList.length;i++) {
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
	const currentIndex = container.getElementsByClassName('curri_item').length;
	const newItem = document.createElement('div');
	newItem.className = 'curri_item';
		
	newItem.innerHTML = `
	        <span class="step_badge">${currentIndex + 1}강</span>
	        <input type="text" name="lessonList[${currentIndex}].lsnTitle" class="input_control" placeholder="강의 주제를 입력하세요">
	        <button type="button" class="remove_btn" onclick="removeCurri(this)">
	            <i class="fa-solid fa-xmark"></i>
	        </button>
	    `;
		
	container.appendChild(newItem);
	container.scrollTop = container.scrollHeight;
}

function removeCurri(btn) {
	
    const container = document.getElementById('curriculum_list');
    const items = container.getElementsByClassName('curri_item');

    if (items.length > 1) {
		
	        btn.closest('.curri_item').remove();
	        
	        const updatedItems = container.getElementsByClassName('curri_item');
			
	        Array.from(updatedItems).forEach((item, index) => {
	
	        item.querySelector('.step_badge').innerText = (index + 1) + "강";
            
            const input = item.querySelector('input');
			
            if(input) {
				
                input.name = `lessonList[${index}].lsnTitle`;
				
            }
        });
		
    } else {
		
        alert("최소 1강 이상 입력해야 합니다.");
		
    }
}

// 강사 프로필 등록 시 사진 미리보기 (DOMContentLoaded: js 내장객체로 document 를 선구성한 후 html 잘읽게 해줌)
document.addEventListener('DOMContentLoaded', () => {
	
    const placeholder = document.querySelector('.pimg .upload-placeholder');
    const input = document.getElementById('photo');

    if (!placeholder || !input) return;

    // 이미지를 읽고 미리보기
    const displayImage = (file) => {
		
        if (!file) return;
        if (!file.type.startsWith('image/')) return alert('이미지 파일만 가능합니다.');

        const reader = new FileReader();
		
        reader.onload = function(ev) {
			
            placeholder.innerHTML = `<img src="${ev.target.result}" style="width: 100%; height: 100%; object-fit: contain;">`;
			
			const pimgBox = document.querySelector('.pimg');
			
			        if (pimgBox) {
						
			            pimgBox.style.border = 'none';
			            pimgBox.style.backgroundColor = 'transparent';
			        }
			
        };
		
        reader.readAsDataURL(file);
		
    };

    // 위쪽 박스 클릭 시 -> 아래 input 클릭
    placeholder.addEventListener('click', () => input.click());

    // 아래쪽 버튼으로 파일을 선택했을 때
    input.addEventListener('change', (e) => {
		
        displayImage(e.target.files[0]);
		
    });

    // 드래그 & 드롭
    const pimgBox = document.querySelector('.pimg');
	
    if (pimgBox) {
		
        pimgBox.addEventListener('dragover', (e) => {
			
            e.preventDefault();
            pimgBox.style.borderColor = '#0D435F';
			
        });

        pimgBox.addEventListener('dragleave', (e) => {
			
            e.preventDefault();
            pimgBox.style.borderColor = '#145A7D';
			
        });

        pimgBox.addEventListener('drop', (e) => {
			
            e.preventDefault();
            pimgBox.style.borderColor = '#145A7D';
			
            const file = e.dataTransfer.files[0];
			
            if (file) {
				
                const dataTransfer = new DataTransfer();
                dataTransfer.items.add(file);
				
                input.files = dataTransfer.files; // 파일을 input에 넣어줌
                displayImage(file);
            }
        });
    }
});
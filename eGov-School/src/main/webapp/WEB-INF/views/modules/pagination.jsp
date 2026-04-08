<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<nav aria-label="Navigation" style="margin-bottom: 40px;">
	<ul class="pagination justify-content-center m-0">
		<li class="page-item">
			<a class="page-link" href="javascript:search_list(1);"> 
				<i class="fas fa-angle-double-left"></i>
			</a>
		</li>
		<li class="page-item">
			<a class="page-link" href="javascript:search_list(${pageMaker.page > 1 ? pageMaker.page - 1 : 1 });">
				<i class="fas fa-angle-left"></i>
			</a>
		</li>
		
		<c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			<li class="page-item ${pageMaker.page == pageNum ? 'active' : ''}">
				<a class="page-link" href="javascript:search_list(${pageNum});">
					${pageNum} 
				</a>
			</li>
		</c:forEach>

		<li class="page-item">
			<a class="page-link" href="javascript:search_list(${pageMaker.page < pageMaker.realEndPage ? pageMaker.page + 1 : pageMaker.realEndPage });">
				<i class="fas fa-angle-right"></i>
			</a>
		</li>
		<li class="page-item">
			<a class="page-link" href="javascript:search_list(${pageMaker.realEndPage});"> 
				<i class="fas fa-angle-double-right"></i>
			</a>
		</li>
	</ul>
</nav>

<form id="jobForm" style="display: none;">
	<input type='text' name="page" value="1" /> 
	<input type='text' name="perPageNum" value="" /> 
	<input type='text' name="searchType" value="" /> 
	<input type='text' name="keyword" value="" />
	<c:choose>
	
        <%-- 1. 객체에 값이 있는 경우 우선순위 --%>
        <c:when test="${not empty roomDetail.claNum}">
        
            <input type='hidden' name="claNum" value="${roomDetail.claNum}" /> 
            
        </c:when>
        <%-- 2. 객체는 없지만 URL 파라미터에 있는 경우 --%>
        <c:when test="${not empty param.claNum}">
        
            <input type='hidden' name="claNum" value="${param.claNum}" />
            
        </c:when>
    </c:choose>
</form>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- REQUIRED SCRIPTS -->
<script>
	function search_list(page) {
		
		// 검색 결과 없으면 기본 페이지는 1
		if (!page) page = 1;
		
		// 폼객체 먼저 가져오기
		let form = document.querySelector("#jobForm");
		
		// perPageNum 있으면 그거 우선 사용
		let serverValue = "${pageMaker.perPageNum}";
		
		// 서버에도  perPageNum 이 비어있는 경우 대비
		if (!form.perPageNum.value || form.perPageNum.value == "") {
			
			form.perPageNum.value = (serverValue && serverValue != 0) ? serverValue : 10;
			
		}
		
		// 화면에 있는 검색창에서 값 가져오기 (각 페이지에 id="keywordInput" 주기)
		let keywordInput = document.querySelector("#keywordInput");
		
		if (keywordInput) {
			
			// 검색어 비었나 확인
			if (keywordInput.value.trim() == "") {
				
				// 전체 검색이 되도록
				form.searchType.value = "";
				form.keyword.value = "";
				
			} else {
				
				// 검색어 있으면
				form.keyword.value = keywordInput.value;
				
			}
			
		}
		
		// perPageNum이 화면에 있으면 가져오고 없는 경우 유지
		let perPageSelect = document.querySelector ('select[name="perPageNum"]');
		
		if (perPageSelect) {
			
			form.perPageNum.value = perPageSelect.value;
			
		}
		
		// 페이지 번호 세팅
		form.page.value = page;
		
		// 현재 브라우저 경로로 전송 : 비동기
		$.ajax({
			
			// 지금 경로
	        url: window.location.pathname,
	        type: "get",
	     	// 폼 안의 모든 값(page, keyword, perPageNum 등)을 한 번에 보냄
	        data: $(form).serialize(),
	     	// 서버에서 HTML 조각을 받아옴
	        dataType: "html",             
	        success: function(result) {
	        	
	            let newList = $(result).find("#userListArea").html();
	            
	            if (newList) {
	            	
	                $("#userListArea").html(newList);
	                console.log("리스트 및 페이지네이션 교체 완료");
	                
	            } else {
	            	
	                console.error("서버 응답에서 #userListArea를 찾을 수 없습니다.");
	                
	            }
	            
	            window.scrollTo(0, 0); 
	            
	        },
	        
	        error: function(xhr) {
	        	
	            console.log("에러 발생: " + xhr.status);
	            
	        }
	    });
		
	}
</script>

<script>

    document.addEventListener("input", function(e) {
    	
        const keywordInput = document.querySelector("#keywordInput");
        
        if (keywordInput) {
        	
        	// 이벤트가 진행된 타겟이 키워드가 맞으면
        	if (e.target && e.target.id === "keywordInput") {
                
                if (e.target.value.trim() == "") {
                	
                    search_list(1);
                }
            }
        }
    });
    
</script>

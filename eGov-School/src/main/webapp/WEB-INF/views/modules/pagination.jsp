<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${not empty pageMaker and pageMaker.endPage gt 0}">
<nav aria-label="Navigation" style="margin-top: 40px;">
	<ul class="pagination justify-content-center m-0">
		<li class="page-item">
			<a class="page-link" href="javascript:search_list(1);"> 
				<i class="fas fa-angle-double-left"></i>
			</a>
		</li>
		<li class="page-item">
			<a class="page-link" href="javascript:search_list(${pageMaker.prev ? pageMaker.startPage-1 : 1});">
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
			<a class="page-link" href="javascript:search_list(${pageMaker.next ? pageMaker.endPage+1 : pageMaker.page});">
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
	<input type='hidden' name="page" value="${pageMaker.page}" /> 
	<input type='hidden' name="perageNum" value="${pageMaker.perpageNum}" /> 
</form>

<script>
	function search_list(page) {
		if(!page) page = 1;
		let form = document.querySelector("#jobForm");
		form.page.value = page;
		form.action = "myKang";
		form.submit();
	}
</script>
</c:if>
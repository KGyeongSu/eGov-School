package com.school.cmd;

public class PageMaker {
	
	private String searchType ="";
	private String keyword="";
	
	private int page=1;
	private int perPageNum=10;
	private int totalCount;
	private int displayPageNum=10;
	
	private int startPage=1;
	private int endPage=1;
	private int realEndPage;
	
	private boolean prev;
	private boolean next;
	
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public void setPage(int page) {
		this.page = page;
		calcData();
	}
	public void setPerpageNum(int perpageNum) {
		this.perPageNum = perpageNum;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	
	public String getSearchType() {
		return searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public int getPage() {
		return page;
	}
	public int getPerpageNum() {
		return perPageNum;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public int getStargPage() {
		return startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public int getRealEndPage() {
		return realEndPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public boolean isNext() {
		return next;
	}
	
	private void calcData() {
		
		endPage = (int) (Math.ceil(page / (double) displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;
		
		realEndPage = (int) (Math.ceil(totalCount / (double) perPageNum));
		
		if (startPage < 1) startPage=1;
		
		if (endPage > realEndPage) endPage = realEndPage;
		
		prev = startPage == 1 ? false : true;
		next = endPage < realEndPage ? true : false;
		
	}
	
	public int getStartRow () {
		
		return (this.page - 1) * this.perPageNum + 1;
		
	}
	
}

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>수강생 관리</title>
<!-- sweet alert import -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<script type="text/javascript">
   
    var pagesize = 5;
    var pageblocksize = 5;
   
	/** OnLoad event */ 
	$(function() {		
		lectureSearch();			
		fRegisterButtonClickEvent();
	});	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchbtn").click(function(e) {
			e.preventDefault();			
			lectureSearch();				
		});
		
		$("#searchpfsbtn").click(function(e){
			e.preventDefault();
			lectureStudentSearch();
		});

		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
          
			switch (btnId) {
				case 'btnSave' :
					Save();
					break;
				case 'btnDelete' :
					Delete();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;

			}
		}); 
	}

	//강의 목록
	function lectureSearch(cpage) {
		
		cpage = cpage || 1;
		
		var param = {
				searchLecKey : $("#searchLecKey").val(),
				keywordLec : $("#keywordLec").val(),
				cpage : cpage,
				pagesize : pagesize,
		}
		
		var listcallback = function(respose) {
			$("#listLecturetbody").empty().append(respose);			
			var paginationHtml = getPaginationHtml(cpage, $("#listCnt").val(), pagesize, pageblocksize, 'lectureSearch');			
			$("#lecturePagination").empty().append( paginationHtml );			
			$("#cpage").val(cpage);
		}
		
		callAjax("/tut/lectureList.do", "post", "text" , false, param, listcallback);
		
	}	
	
	//수강생 목록
	function lectureStudentSearch(lec_no, cpage) {
		
		cpage = cpage || 1;
		
		if(lec_no == null){
			var lec_no = $("#lec_no").val();
		}
		
		var param = {
					cpage 							: cpage
				,	pagesize 					: pagesize
				,	lec_no						: lec_no
				,	searchStudentKey	:	$("#searchStudentKey").val()
				,	keywordStudent		:	$("#keywordStudent").val()
		}
		
		var resultCallback = function(response) {
			console.log(response)
			$("#lectureStudenttbody").empty().append(response);					
			var paginationHtml = getPaginationHtml(cpage, $("#totalCount").val(), pagesize, pageblocksize, 'lectureStudentSearch');
			$("#lectureStudentPagination").empty().append( paginationHtml );				
			$("#cpage").val(cpage);
		}
		
		callAjax("/tut/lectureStudentList.do", "post", "text" , false, param, resultCallback);
		
	}	
	
	function updateApv(user_no, lec_no, apv){
		
		var param = {				
					user_no		:	user_no
				,	lec_no		:	lec_no
				,	apv				:	apv
		}
		
		var apvCallback = function(response) {
			alert("요청 완료");
			history.go(0);
		}
		
		callAjax("/tut/updateApv.do", "post", "text" , true, param, apvCallback);
	}
	
</script>
</head>

<body>

<form id="myForm" action=""  method="">
    <input type="hidden"  id="action"  name="action"  value="" />
    <input type="hidden"  id="lec_no"  name="lec_no"  value="" />
    <input type="hidden"  id="cpage"  name="cpage"  value="" />

	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<span class="btn_nav bold">학습관리</span> 
							<span class="btn_nav bold">수강생 정보</span>
								<a href="../tut/lectureStudentInfo.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>강의 정보</span> 
							<span class="fr">			
  	                         	<select id="searchLecKey" name="searchLecKey" style="width: 100px;">
  	                         		<option value="all">전체</option>
  	                         		<option value="lec_nm">강의분류</option>
  	                         		<option value="lec_content">강의명</option>
  	                         	</select>
  	                          <input type="text" class="inputTxt 100" id="keywordLec" name="keywordLec" style="width: 200px;"/>  	                          	
							  <a class="btnType blue" href="" name="searchbtn"  id="searchbtn"><span>검색</span></a>
							</span>
						</p>
       
						<div class="divList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width=*>
									<col width="20%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">강의분류</th>
										<th scope="col">강의명</th>
										<th scope="col">기간</th>
										<th scope="col">정원</th>
									</tr>
								</thead>
								<tbody id="listLecturetbody"></tbody>
							</table>
						</div>
	                    
						<div class="paging_area"  id="lecturePagination"> </div>
					<br>
					<div class="studentDiv">	
						<p class="conTitle">
							<span>수강생 목록</span> <span class="fr">		
  	                         	<select id="searchStudentKey" name="searchStudentKey" style="width: 100px;">
  	                         		<option value="all">전체</option>
  	                         		<option value="name">학생명</option>
  	                         		<option value="apv">승인여부</option>
  	                         	</select>
  	                          <input type="text" id="keywordStudent" name="keywordStudent" class="inputTxt 100" style="width: 200px;"/>  	                          	
							  <a class="btnType blue" href="" name="searchpfsbtn"  id="searchpfsbtn"><span>검색</span></a>
							</span>
						</p>
       
						<div class="divList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학생번호</th>
										<th scope="col">학생명</th>
										<th scope="col">전화번호</th>
										<th scope="col">이메일</th>
										<th scope="col">승인여부</th>
										<th scope="col">승인 상태 변경</th>
									</tr>
								</thead>
								<tbody id="lectureStudenttbody">
									<tr>
										<td colspan="6">강의를 선택해주세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
	                    
						<div class="paging_area"  id="lectureStudentPagination"> </div>
					</div>	
			
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

</form>
</body>
</html>
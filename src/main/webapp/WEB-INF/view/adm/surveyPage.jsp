<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>설문조사</title>
<!-- sweet alert import -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	var pagesize = 5;
	var pageblocksize = 10;
   
	/** OnLoad event */ 
	$(function(){
		surveyList();
	});
	
	function surveyList(cpage){
		
		cpage = cpage || 1;
		
		//alert($("#searchPfsName").val());
		
		var param = {
				searchPfsName : $("#searchPfsName").val(),
				cpage : cpage,
				pagesize : pagesize
		}
		
		var listcallback = function(response){
			console.log(response);
			$("#listProfessorBody").empty().append(response);
			
			var paginationHtml = getPaginationHtml(cpage, $("#listcnt").val(), pagesize, pageblocksize, 'surveyList');
			console.log("paginationHtml : " + paginationHtml);
	
			$("#pfsListPagination").empty().append( paginationHtml );
			
			$("#cpage").val(cpage);
		}
		
		callAjax("/adm/professorList.do", "post", "text" , false, param, listcallback);
		
	}
	
	function lectureDetail(user_no, currentPage){
		
		currentPage = currentPage || 1;
		
		var param = {
				user_no : user_no,
				currentPage : currentPage,
				pagesize : pagesize,
		}
		
		var resultCallback = function(data){
			console.log(data);
			
			pfsLectureResult(data, currentPage,user_no);
		};
		
		callAjax("/adm/listPfsLecture.do", "post", "text", true, param, resultCallback);
	}
	
	function pfsLectureResult(data, currentPage,user_no){
		
		// 목록 초기화
		$("#listLecEquip").empty().append(data);
		
		var paginationHtml = getPaginationHtml(currentPage, $("#leclistcnt").val(), pagesize, pageblocksize, 'lectureDetail',[user_no]);
		console.log("paginationHtml : " + paginationHtml);

		$("#lecturePagination").empty().append( paginationHtml );
		
		
		
	}
    
</script>

</head>
<body>
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<span class="btn_nav bold">학습관리</span> 
							<span class="btn_nav bold">설문조사관리</span>
								<a href="../adm/surveyControl.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>설문조사</span>
							<span class="fr">
							<!-- <select id="areasel" name="areasel"></select> -->						
								강 사 명
								<input type="text" id="searchPfsName" name="searchPfsName" />
								<a class="btnType red" href="javascript:surveyList()" name="searchbtn"  id="searchbtn"><span>검색</span></a>
							</span>
						</p>
       
						<div class="divList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="30%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강사 ID</th>									
										<th scope="col">강사명</th>
										<th scope="col">전화번호</th>
										<th scope="col">이메일</th>
										<th scope="col">강사 등록일</th>
									</tr>
								</thead>
								<tbody id="listProfessorBody"></tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="pfsListPagination"> </div>
						
						<!-- 장비내역 -->
						<p class="conTitle mt10">
							<span>강의 목록</span>
						</p>
						<div class="lectureList" id="lectureList">
							<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
									</colgroup>
								<thead>
									<tr>
										<th scope="col">과목</th>
										<th scope="col">강사명</th>
										<th scope="col">강의 시작일</th>
										<th scope="col">강의 종료일</th>
										<th scope="col">수강인원</th>
									</tr>
								</thead>
								<tbody id="listLecEquip">
									<tr>
										<td colspan="12">강사명을 선택해 주세요.</td>
									</tr>
								</tbody>
							</table>
							<div class="paging_area" id="lecturePagination"></div> 
						</div>
						
					</div> 
					
					 
					
				</li>
			</ul>
		</div>
	</div>
	
	
</body>
</html>
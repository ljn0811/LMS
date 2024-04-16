<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>학생수강목록</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style type="text/css">

</style>
<script type="text/javascript">

//과제목록페이지
var pageSize = 9;
var pageBlockSize = 5;

$( function(){
	//$('#svybtn').hide();
    //$('#svybtn2').hide();
	//var param;
	lecList();
	// 셀렉트박스 선택시 리스트 호출
	/* $('#searchStatus').change(function() {
		alert($("#searchStatus".val()));
        // 리스트 조회 함수 호출
        testApplicationsList(); // 페이지를 1로 초기화하여 첫 페이지에서 조회
    }); */
	
});

//메인 리스트 callAjax
function lecList(currentPage){

		
		currentPage = currentPage || 1;
		
		var param = {
				currentPage : currentPage,
				pageSize : pageSize,
		}
		
		
		function listcallback(response){	
			//alert(response);
			console.log(response);
			
			$("#registerListBody").empty().append(response);
			
			var paginationHtml = getPaginationHtml(currentPage, $("#listcnt").val(), pageSize, pageBlockSize, "lecList");
			console.log("paginationHtml : " + paginationHtml);

			$("#registerListPagination").empty().append(paginationHtml);

			$("#currentPage").val(currentPage); 
		}
		
	
	callAjax("/std/testApplicationsListBody.do", "post", "text", false, param, listcallback)
}



//메인 리스트 callAjax
function testApplicationsList(lec_no, currentPage, searchStatus){
	
	currentPage = currentPage || 1;
	
	var param = {
			lec_no : lec_no,
			searchStatus : $("#searchStatus").val(),
			currentPage : currentPage,
			pageSize : pageSize,
	}
	
	function listcallback(response){	
		//alert(response);
		console.log(response);
		
		$("#testApplicationListBody").empty().append(response);
		
		var paginationHtml = getPaginationHtml(currentPage, $("#testListCnt").val(), pageSize, pageBlockSize, "testApplicationsList");
		console.log("paginationHtml : " + paginationHtml);

		$("#testApplicationsPagination").empty().append(paginationHtml);

		$("#currentPage").val(currentPage); 
	}
	
	callAjax("/std/testApplicationsDetail.do", "post", "text", false, param, listcallback);
}

function applyTest(){
	alert("시험 응시");
}



function surveyModal(){
	//gfModalPop("#modalForm");
	gfModalPop("#survey_modal");
}



//설문지 제출 필요값 lec_id
function fsubmitSvy(){
	if(confirm("정말 제출하시겠습니까?")){
		var resultCallback = function(data) {
			if(data.result=="SUCCESS"){
				gfCloseModal();
				location.reload();
			}else{
				alert("설문조사 에러");
			}
		};
	}else {
		return;
	}
	/* if(fcheckvalue()){
		if(confirm("정말 제출하시겠습니까?")){
			var resultCallback = function(data) {
				submitSvyResult(data);
			};
		} else {
			return;
		}
	} else {
		alert("모든 항목에 답을 입력해주세요");
		return;		
	} */
	
	callAjax("/std/surveyInsert.do", "post", "json", true, $("#modalForm").serialize(), resultCallback);
}


</script>
</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPage" value="1">
	
	<!-- <input type="hidden" id="lec_id"> -->
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
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					<!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
						<p class="Location">
							<a href="/dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<a href="javascript:void(0)" class="btn_nav">학습 관리</a> 
							<span class="btn_nav bold">시험 응시</span> 
							<a href="/std/testApplications.do" class="btn_set refresh">새로고침</a>
						</p>
						<br/>
						<div class="conTitle">
							
						</div>
						
						
						<div class="testApplicationList" id="registList">
							<table class="col" id="title">
								<caption>caption</caption>
								<colgroup>
								    <col width="30%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">과정명</th>
										<th scope="col">강사</th>
										<th scope="col">강의 기간</th>
										<th scope="col">강의실</th>										
									</tr>
								</thead>
							<tbody id="registerListBody"></tbody>
							</table>
							<div class="paging_area"  id="registerListPagination"></div>
							<br/><br/><br/>	
							
							<table class="col" id="titleDetail">
								<caption>caption</caption>
								<colgroup>
								    <col width="30%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">과정명</th>
										<th scope="col">시험명</th>
										<th scope="col">구분</th>
										<th scope="col">상태</th>
										<th scope="col">시험응시</th>
																			
									</tr>
								</thead>
								<tbody id="testApplicationListBody"></tbody>				
								
							</table>
							<!-- <div class="paging_area"  id="testApplicationsPagination"></div> -->
							
							
						</div>
					</div>
				<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>		
		</div>
	</div>
</form>

<!-- 설문조사 모달팝업시작 -->
<form id="modalForm">
	<input type="hidden" id="currentPage" name="currentPage" value="1" />
	<input type="hidden" id="lec_no" name="lec_no" value="${lec_no}" />
	<input type="hidden" id="que_no" name="que_no" value="${que_no}" />
	<input type="hidden" id="user_no" name="user_no" value="${user_no}" />
  <div id="survey_modal" class="layerPop layerType2" style="width: 800px; ">
     <dl>
     	<dt>
			<strong>설문지</strong>
		</dt>
        <dd class="content" >
           <!-- s : 여기에 내용입력 -->
           <div class="sidescroll" style="height:700px; overflow: auto !important;">
           <table class="row" id="surveyQue">
           	<caption>caption</caption>
           	<tbody>
           		<th id="que"></th>
           		<tr>
           			<td style="text-align:center;">
           				<input id="que_one" type="radio" name="select_num" value="1" />: <label for="que_one"></label>&nbsp;&nbsp;&nbsp;&nbsp;
           				<input id="que_two" type="radio" name="select_num" value="2" />: <label for="que_two"></label>&nbsp;&nbsp;&nbsp;&nbsp;
           				<input id="que_two" type="radio" name="select_num" value="3" />: <label for="que_three"></label>&nbsp;&nbsp;&nbsp;&nbsp;
           				<input id="que_four" type="radio" name="select_num" value="4" />: <label for="que_four"></label>&nbsp;&nbsp;&nbsp;&nbsp;
           				<input id="que_five" type="radio" name="select_num" value="5" />: <label for="que_five"></label> 
           			</td>           			
           		</tr>
           	</tbody>
            </table>
           <table class="row" id="surveyRv">
          	<caption>caption</caption>
				<tr>
	             	<th scope="row" style="width: 357px;" id="lec_review""></th>
					<td colspan="6">
						<textarea class="inputTxt p100" name="review_result" id="review_result" placeholder="내용을 입력하세요" style="resize: none; padding: 5px;"></textarea>
					</td>
				</tr>
           </table>
		  </div>
          <!--  <div class="paging_area" id="Pagination_svy"></div> -->
           <!-- e : 여기에 내용입력 -->
           <div class="btn_areaC mt30">
              <a href="javascript:fsubmitSvy()" class="btnType blue" id="btnSaveSvy" name="btn"><span>제출</span></a> 
              <a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
           </div>
        </dd>
     </dl>
     <a href="" class="closePop"><span class="hidden">닫기</span></a>
  </div>
  </form> 
<!-- 모달팝업끝 -->

</body>
</html>
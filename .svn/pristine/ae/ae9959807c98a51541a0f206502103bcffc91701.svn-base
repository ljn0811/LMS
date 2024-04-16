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
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/learn_mng/registerList.css" />
<style type="text/css">

</style>
<script type="text/javascript">

//과제목록페이지
var pageSize = 10;
var pageBlockSize = 10;


$( function(){
	$('#svybtn').hide();
    $('#svybtn2').hide();
	var param;
	lecList();
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
		
	
	callAjax("/std/registerListBody.do", "post", "text", false, param, listcallback)
}

//강의 상세내용 callAjax 
function lecListDtl(lec_no, currentPage){
	$("#lec_no").val(lec_no);
	if(lec_no != null){
		$('#svybtn').show();
		$('#svybtn2').show();			
	}else {
		$('#svybtn').hide();
        $('#svybtn2').hide();
	}
	currentPage = currentPage || 1;
	var param = {
			currentPage : currentPage,
			pageSize : pageSize,
			lec_no : lec_no,			
		};
	
	var resultCallback = function(data) {
		$("#lec_no").val(data.surveyQueData.lec_no);
		$("#que_no").val(data.surveyQueData.que_no);
		$("#que").text(data.surveyQueData.que);
		$("label[for='que_one']").text(data.surveyQueData.que_one);
		$("label[for='que_two']").text(data.surveyQueData.que_two);
		$("label[for='que_three']").text(data.surveyQueData.que_three);
		$("label[for='que_four']").text(data.surveyQueData.que_four);
		$("label[for='que_five']").text(data.surveyQueData.que_five);
		$("#lec_review").text(data.surveyQueData.lec_review);
		 if(data.surveyAnswer && data.surveyAnswer.que_no != null){
			$('#svybtn').hide();
			$('#svybtn2').show();						
		}else {
			$('#svybtn').show();
			$('#svybtn2').hide();
		}

		if(data.dtlData.attendance_notice == null){
			$("#lec_content").empty().val("출석 관련 공지가 없습니다.");
		}else{
			$("#attendance_notice").empty().val(data.dtlData.attendance_notice);
		}
		
		if(data.dtlData.learn_goal == null){
			$("#lec_content").empty().val("강의 목표가 없습니다.");
		}else{
			$("#learn_goal textarea").empty().val(data.dtlData.learn_goal);
		}
		
		if(data.dtlData.lec_content == null){
			$("#lec_content").empty().val("강의 내용이 없습니다.");
		}else{
			$("#lec_content").empty().val(data.dtlData.lec_content);	
		}
		
		if(data.dtlData.learn_plan == null){
			$("#lec_content").empty().val("강의 계획이 없습니다.");
		}else{
			$("#learn_plan textarea").empty().val(data.dtlData.learn_plan);
		}
		
		
	};
	
	callAjax("/std/registerListDtl.do", "post", "json", true, param, resultCallback);
}

function surveyModal(){
	//gfModalPop("#modalForm");
	gfModalPop("#survey_modal");
	
}



//설문지 제출
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
							<span class="btn_nav bold">수강 목록</span> 
							<a href="/std/registerList.do" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle">
							<span>수강 목록</span>
						</p>
						<div class="registList" id="registList">
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
								<tbody id="registerListBody">
									<%-- <c:if test="${listcnt > 0 }"> --%>
									<%--	<c:forEach items="${listdata}" var="list">
											<tr>
												<td><a href="javascript:lecListDtl('${list.lec_no}');">${list.lec_nm}</a></td>
												<td>${list.user_nm}</td>
												<td>${list.lec_start} ~ ${list.lec_end}</td>
												<td>${list.classroom_nm}</td>												
											</tr>
										</c:forEach> --%>
									<%-- </c:if> --%>
							
							
									<!-- <tr>
										<td id="lec_name"></td>
										<td id="tutor_name"></td>
										<td id="term"></td>
										<td id="lecrm_name"></td>
									</tr> -->
								</tbody>							
							</table>
<%-- 							<input type="hidden" id="listcnt" name="listcnt" value ="${listcnt}"/>
 --%>							
 							<div class="paging_area"  id="registerListPagination"></div>
							<table class="col"> 
								<thead>
									<tr>
										<th class="left_content">출석 관련 공지</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="left_content" id="atd_plan">
											<textarea id="attendance_notice" name="attendance_notice" style="width:100%; border:0; resize:none;" readonly></textarea>
										</td>
									</tr>
								</tbody>
							</table>
							<table class="col"> 
								<thead>
									<tr>
										<th class="left_content">강의 목표</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="left_content" id="learn_goal">
											<textarea name="learn_goal" style="width:100%; border:0; resize:none;" readonly></textarea>
										</td>
									</tr>
								</tbody>
							</table>
							<table class="col"> 
								<thead>
									<tr>
										<th class="left_content">강의 내용</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="left_content">
											<textarea id="lec_content" name="lec_content" style="width:100%; border:0; resize:none;" readonly></textarea>
										</td>
									</tr>
								</tbody>
							</table>
							
							<table class="col">
								<thead>
									<tr>
										<th class="left_content">강의 계획</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="left_content" id="learn_plan">
											<textarea name="learn_plan" style="width:100%; border:0; resize:none;" readonly></textarea>
									<!-- 	<input type="button" id="svybtn2" value="설문 완료" style="float:right" class="hidden" disabled="disabled" />-->
									

 											<!-- <a class="btnType blue" href="javascript:fstartSurvey()" style="float:right" name="svybtn"> -->
	 									 		<a class="btnType blue" href="javascript:surveyModal()" style="float:right" name="svybtn">
									 				<span id="svybtn" >설문 조사</span>
									 			</a>
									 			<a class="btnType blue" href="javascript:void(0)" style="float:right" name="svybtn2">
									 				<span id="svybtn2">설문 완료</span>
									 			</a>

										</td>
									</tr>
								</tbody>
							</table>
							
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Q&A</title>
<!-- sweet alert import -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
   
    var pageSize = 10;
    var pageBlockSize = 10;
   
	/** OnLoad event */ 
	$(function() {
		qnaSearch();	
		fRegisterButtonClickEvent();
	});	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		//검색 버튼 클릭
		$("#searchBtn").click(function(e) {
			e.preventDefault();
			qnaSearch();				
		});
		
		//작성 버튼 클릭
		$("#writeBtn").click(function(e) {
			e.preventDefault();	
			init();
			gfModalPop("#layer1");	
		});
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
          
			switch (btnId) {
				case 'btnSave' :
					Save();
					break;
				case 'btnModify' :
					Modify();
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
	
	//검색
	function qnaSearch(cPage) {
		
		cPage = cPage || 1;
		
		var param = {
					searchKey 		: $("#searchKey").val()
				,	keyword 		: $("#keyword").val()
				,	cPage 				: cPage
				,	pageSize 		: pageSize
		}
		
		var listCallback = function(respose) {
			
			$("#listQnatbody").empty().append(respose);			
			var paginationHtml = getPaginationHtml(cPage, $("#listcnt").val(), pageSize, pageBlockSize, 'qnaSearch');			
			$("#qnaPagination").empty().append( paginationHtml );			
			$("#cPage").val(cPage);
		}
		
		callAjax("/qanda/qandaListA.do", "post", "text" , false, param, listCallback);
		
	}
	
	function init(data) {
		if(data != null) {
			$("#qna_id").val(data.qnaInfo.qna_id);
			$("#qnaName").val(data.qnaInfo.name);
			$("#qna_title").val(data.qnaInfo.qna_title);
			$("#qna_content").val(data.qnaInfo.qna_content);
			$("#btnDelete").show();			
			$("#created_at").val(data.qnaInfo.created_at);
			$("#action").val("U");
			
		} else {
			$("#qnaTitle").val("");
			$("#qnaContent").val("");
			$("#qnaId").val("");
			$("#action").val("I");			
		}
	}
	
	//상세 조회
	function qnaDetail(qna_id) {
		
		var param = {
				qnaId : qna_id
		}		
		
		var delCallback = function(response) {
			/* console.log(JSON.stringify(response));		 */	
			init(response);
			gfModalPop("#layer2");	
			
			if(response.commentList != null){				
			
				var  result  =  "<tr>";
						result += "<th scope='row'> 댓글작성자 </th>";
						result += "<th scope='row'> 댓글내용 </th>";
						result += "<th scope='row'> 댓글작성일</th>";
						result += "<th scope='row'></th>";
						result += "</tr>";		
			
				//댓글
				for(var i=0; i<response.commentList.length; i++){
					result +=	"<tr>";
					result += 	"<td>"	+	response.commentList[i].name	+	"</td>";
					result += 	"<td>" +  response.commentList[i].comment_content + "</td>";
					result += 	"<td>" +  response.commentList[i].created_at + "</td>";
					result += 	"<td><a style='cursor:pointer;' onclick='commentDelete(" + response.commentList[i].comment_no+ ")' class='btnTypeBox' name='btn'><span>삭제</span></a></td>";
					result +=	"</tr>";
				}			
			
				$("#qnaComment").empty();
				$("#qnaComment").append(result);
			
			}
			
		}
		
		callAjax("/qanda/qnaDtl.do", "post", "json" , false, param, delCallback);		
	}
	
	//저장
	function Save() {		
		
		if($("#action").val() == "U" || $("#action").val() == "D" ){
			var param = {
					qnaId : $("#qna_id").val(),
					qnaTitle : $("#qna_title").val(),
					qnaContent : $("#qna_content").val(),
					qnaName : $("#qnaName").val(),
					action : $("#action").val(),
			}
		}else{

			if(!fValidate()) {
				return;
			}
			
			var param = {
					qnaId : $("#qnaId").val(),
					qnaTitle : $("#qnaTitle").val(),
					qnaContent : $("#qnaContent").val(),
					loginId : $("#loginId").val(),
					action : $("#action").val(),
			}
		}	
		
		var saveCallback = function(response) {
			
			alert(response.resultMsg);
			
			if(response.result == "S") {
				gfCloseModal();
				if($("#action").val() == "I") {
					qnaSearch();
				} else {
					qnaSearch($("#cPage").val());
				}
			}
		}
		
		callAjax("/qanda/qnaSave.do", "post", "json" , false, param, saveCallback);		
	}
	
	//수정
	function Modify() {
		$("#action").val("U");		
		Save();		
	}
	
	//삭제
	function Delete() {		
		$("#action").val("D");		
		Save();
	}
	
	//작성 내용 확인
	function fValidate() {

		var chk = checkNotEmpty(
				[
						[ "qnaTitle", "제목를 입력해 주세요." ]
					,	[ "qnaContent", "내용을 입력해 주세요" ]
				]
		);
		if (!chk) {
			return;
		}
		return true;		
	}
	
	//댓글 작성
	function commentSave(){
		var param = {
					qnaId			:	$("#qna_id").val()
				,	comment 	: 	$('#comment').val()
				,	loginId		: 	$('#loginId').val()
		}
		
		var commSaveCallback = function(response){
			alert(response.resultMsg);
			window.location.reload();
		}
		
		callAjax("/qanda/qnaCommentSave.do", "post", "json" , false, param, commSaveCallback);
	}
	
	//댓글 삭제
	function commentDelete(comment_no){
		var param = {
					qnaId				:	$("#qna_id").val()
				,	commentNo	: 	comment_no
		}
		
		var commDelCallback = function(response){
			alert(response.resultMsg);
			window.location.reload();
		}
		
		callAjax("/qanda/commentDelete.do", "post", "json", false, param, commDelCallback);
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
    <input type="hidden"  id="action"  name="action"  value="" />
    <input type="hidden"  id="qnaId"  name="qnaId"  value="" />
    <input type="hidden"  id="cPage"  name="cPage"  value="" />
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container" class="input-group">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					<!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> 
					<!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<span class="btn_nav bold">커뮤니티</span> 
							<span class="btn_nav bold">Q&A</span> 
							<a href="../qanda/qandaA.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>Q&A</span> <span class="fr">													
  	                          <select style="width: 75px; height: 30px" id="searchKey" name="searchKey">
  	                          	<option value="all">전체</option>
  	                          	<option value="qnaTitle">제목</option>
  	                          	<option value="qnaName">작성자</option>
  	                          </select>
  	                          <input type="text" id="keyword" name="keyword" style="width: 300px; height: 28.5px"/>
							  <a class="btnType red" href="" name="searchBtn"  id="searchBtn"  class="searchBtn"><span>검색</span></a>
							  <a class="btnType red" href="" name="writeBtn"  id="writeBtn"><span>작성</span></a>
							</span>
						</p>
       
						<div class="divList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="40%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">작성일</th>										
									</tr>
								</thead>
								<tbody id="listQnatbody"></tbody>
							</table>
						</div>
	                    
						<div class="paging_area"  id="qnaPagination"> </div>
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 등록 팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>Q&A 작성</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">글제목 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="qnaTitle" id="qnaTitle" /></td>
							<th scope="row">작성자 <span class="font_red">*</span></th>
							<td>${loginId}<input type="hidden" name="loginId" id="loginId" value="${loginId}"></td>
						</tr>
						<tr>							
							<th scope="row">글내용 <span class="font_red">*</span></th>
							<td colspan=3><textarea type="text" class="inputTxt p100" name="qnaContent" id="qnaContent"></textarea></td>
						</tr>				
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
		<!-- 상세조회 팝업 -->
	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>Q&A</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">글제목 <span class="font_red">*</span></th>
							<td colspan=3><input type="text" class="inputTxt p100" name="qna_title" id="qna_title"/><input type="hidden" class="inputTxt p100" name="qna_id" id="qna_id"/></td>
						</tr>
						<tr>
							<th scope="row">작성자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="qnaName" id="qnaName" readonly/></td>
							<th scope="row">등록일 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="created_at" id="created_at" /></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan=3><textarea id=qna_content name="qna_content">${qna_content}</textarea></td>
						</tr>
						<tr class="btn_areaC">
							<td></td>
							<td><a href="" class="btnType blue" id="btnSave" name="btn"><span>수정</span></a></td>
							<td><a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a></td>
							<td></td>
						</tr>	
					</tbody>
				</table>
				<!-- 댓글 테이블 -->
				<div style="height: 80px; overflow-y: auto">
					<table class="row" >
						<caption>caption</caption>
						<colgroup>
							<col width="90px">
							<col width="*">
							<col width="100px">
							<col width="40px">
						</colgroup>
						<tbody  id="qnaComment">
						</tbody>
					</table>					
				</div>
				<div>
					<input type='text' id='comment' style="width: 480px; height: 28px"/></td>
					<a class='btnType3' style='cursor:pointer' onclick='commentSave()' name='btn'><span>작성</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
</form>
</body>
</html>
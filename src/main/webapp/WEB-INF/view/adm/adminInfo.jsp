<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>관리자 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	var pagesize = 10;
	var pageblocksize = 5;

	/** OnLoad event */
	$(function() {
		fRegisterButtonClickEvent();
		adminInfoSearch();
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchBtn").click(function(e) {
			e.preventDefault();
			adminInfoSearch();				
		});
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnModify':
				adminInfoModify();
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			}
		});
	}

	//목록 및 검색 리스트
	function adminInfoSearch(cpage) {

		cpage = cpage || 1;
		
		var param = {
				searchKey	: $("#searchKey").val()
			,	keyword 	: $("#keyword").val()
			,	cpage 			: cpage
			,	pagesize 	: pagesize
		}

		var listCallback = function(response) {
			$("#adminInfoBody").empty().append(response);
			var paginationHtml = getPaginationHtml(cpage, $("#listCnt").val(), pagesize, pageblocksize, 'adminInfoSearch');
			$("#adminInfoPagination").empty().append(paginationHtml);
			$("#cpage").val(cpage);
		}

		callAjax("/adm/adminList.do", "post", "text", false, param, listCallback);

	}	
	
	//기간별 리스트
	function dateList(cpage){
		cpage = cpage || 1;
		
		var param = {
				searchstdate 	: 	$("#searchstdate").val()
			,	searcheddate	:	$("#searcheddate").val()
			,	cpage 			: 	cpage
			,	pagesize 		: 	pagesize
		}

		var listCallback = function(response) {
			$("#adminInfoBody").empty().append(response);
			var paginationHtml = getPaginationHtml(cpage, $("#listCnt").val(), pagesize, pageblocksize, 'dateList');
			$("#adminInfoPagination").empty().append(paginationHtml);
			$("#cpage").val(cpage);
		}

		callAjax("/adm/adminList.do", "post", "text", false, param, listCallback);
		
	}
	
	function init(response) {
		if(response != null) {
			$("#userNo").val(response.adminInfo.user_no);
			$("#name").val(response.adminInfo.name);
			$("#userPhone").val(response.adminInfo.user_phone);
			$("#userEmail").val(response.adminInfo.user_email);
			$("#userLocation").val(response.adminInfo.user_location);
			$("#action").val("U");
			
		} else {
			$("#userNo").val();
			$("#name").val("");
			$("#userPhone").val("");
			$("#userEmail").val("");
			$("#userLocation").val("");		
			$("#action").val("U");		
		}
	}
	
	function adminInfoDetail(user_no){
		
		var param = {

			user_no : user_no
		}
		
		var detailCallback = function(response){
			gfModalPop("#layer1");
			init(response);			
		}
		
		callAjax("/adm/adminDetail.do", "post", "json", false, param, detailCallback);
		
	}
	
	function adminInfoModify(){
		var param = {
				action					: $("#action").val("U").val()
			,	user_no 			: $("#userNo").val()
			,	name					: $("#name").val()
			,	userPhone		: $("#userPhone").val()
			,	userLocation	: $("#userLocation").val()
			,	userEmail			: $("#userEmail").val()
		}
		
		var modCallback = function(response) {
			console.log(JSON.stringify(response));
			alert(response.resultMsg);
			history.go(0);
		}

		callAjax("/adm/adminModify.do", "post", "json", false, param, modCallback);
	}
	
	function adminInfoDelete(user_no) {
		var param = {
				action	: $("#action").val("D").val()
			,	user_no : user_no
		}

		var delCallback = function(response) {
			console.log(JSON.stringify(response));
			alert(response.resultMsg);
			history.go(0);
		}

		callAjax("/adm/adminModify.do", "post", "json", false, param, delCallback);
	}
	

</script>
</head>

<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="tutorNo" name="tutorNo" value=""> 
		<input type="hidden" id="action" name="action" value="">
		<input type="hidden" id="cpage" name="cpage" value="">

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
						<div class="content" style="min-height: 250px !important;">

							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">인원 관리</span> 
								<span class="btn_nav bold">관리자 관리</span> 
								<a href="../adm/adminControl.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>대표 목록</span>
								<span class="fr">
									<span>대표명</span>												
  	                          		<!-- <select id="searchKey" name="searchKey" style="width: 80px;">
  	                          			<option value="all">전체</option>
  	                          			<option value="userName">대표명</option>
  	                          		</select> -->
  	                          		<input type="text" id="keyword" name="keyword" style="width: 150px; height: 28.5px"/>
							  		<a class="btnType blue" href="" name="searchBtn"  id="searchBtn"  class="searchBtn"><span>검색</span></a>
								</span>
							</p>
							
							<div>								
								<span class="fr">					
									기간 <input type="date" id="searchstdate" name="searchstdate" /> ~ <input type="date" id="searcheddate" name="searcheddate" />
									<a class="btnType" href="javascript:dateList()" name="searchpfsbtn"  id="searchpfsbtn"><span>검색</span></a>
								</span>	
							</div>
							<br><br>
							
							<div class="divAdminInfo">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="5%">
										<col width="20%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">회사No</th>
											<th scope="col">대표명 (ID)</th>
											<th scope="col">연락처</th>
											<th scope="col">이메일</th>
											<th scope="col">가입일자</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<tbody id="adminInfoBody"></tbody>
								</table>
							</div>

							<div class="paging_area" id="adminInfoPagination"></div>

						</div> <!--// content -->					

						<h3 class="hidden">풋터 영역</h3> 
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>회사 정보</strong>					
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
								<th scope="row">회사명</th>
								<td>
									<input type="text" id="name" name="name" class="inputTxt p100"/>
									<input type="hidden" id="userNo" name="userNo" class="inputTxt p100"/>
								</td>
								<th scope="row">회사 연락처</th>
								<td scope="row">
									<input type="text" id="userPhone" name="userPhone" class="inputTxt p100"/>							
								</td>
							</tr>
							<tr>
								<th scope="row">회사 주소</th>
								<td colspan="3">
									<input type="text" id="userLocation" name="userLocation" class="inputTxt p100"/>
								</td>								
							</tr>
							<tr>								
								<th scope="row">이메일</th>
								<td colspan="3">
									<input type="email" id="userEmail" name="userEmail" class="inputTxt p100"/>
								</td>
							</tr>
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnModify" name="btn"><span>수정</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>강사 관리</title>
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
		tutorInfoSearch();
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchBtn").click(function(e) {
			e.preventDefault();
			tutorInfoSearch();				
		});
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnDelete':
				Delete();
				break;
			case 'btnSearch':
				board_search();
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			}
		});
	}

	//목록 및 검색 리스트
	function tutorInfoSearch(cpage) {

		cpage = cpage || 1;
		
		var param = {
				keyword 	: $("#keyword").val()
			,	cpage 		: cpage
			,	pagesize 	: pagesize
		}

		var listCallback = function(response) {
			$("#tutorInfoBody").empty().append(response);
			var paginationHtml = getPaginationHtml(cpage, $("#listCnt").val(), pagesize, pageblocksize, 'tutorInfoSearch');
			$("#tutorInfoPagination").empty().append(paginationHtml);
			$("#cpage").val(cpage);
		}

		callAjax("/adm/tutorList.do", "post", "text", false, param, listCallback);

	}
	
	function tutorInfoModify(user_no) {
		var param = {
				action : $("#action").val("U").val(),
				user_no : user_no
		}

		var modCallback = function(response) {			
			console.log(JSON.stringify(response));
			alert(response.resultMsg);
			history.go(0);
		}

		callAjax("/adm/tutorModify.do", "post", "json", false, param, modCallback);
	}
	

	function tutorInfoDelete(user_no) {
		var param = {
			action : $("#action").val("D").val(),
			user_no : user_no
		}

		var delCallback = function(response) {
			console.log(JSON.stringify(response));
			alert(response.resultMsg);
			history.go(0);
		}

		callAjax("/adm/tutorModify.do", "post", "json", false, param, delCallback);
	}
	
	//유저 타입별 리스트
	function userTypeList(userType, cpage){
		cpage = cpage || 1;
		
		var param = {
				userType 	: userType
			,	cpage 		: cpage
			,	pagesize 	: pagesize
		}

		var listCallback = function(response) {
			$("#tutorInfoBody").empty().append(response);
			var paginationHtml = getPaginationHtml(cpage, $("#listCnt").val(), pagesize, pageblocksize, 'userTypeList');
			$("#tutorInfoPagination").empty().append(paginationHtml);
			$("#cpage").val(cpage);
		}

		callAjax("/adm/tutorList.do", "post", "text", false, param, listCallback);
		
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
			$("#tutorInfoBody").empty().append(response);
			var paginationHtml = getPaginationHtml(cpage, $("#listCnt").val(), pagesize, pageblocksize, 'dateList');
			$("#tutorInfoPagination").empty().append(paginationHtml);
			$("#cpage").val(cpage);
		}

		callAjax("/adm/tutorList.do", "post", "text", false, param, listCallback);
		
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
								<span class="btn_nav bold">강사 관리</span> 
								<a href="../adm/tutorControl.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>강사 목록</span><span class="fr">													
  	                          	<span>강사명</span>
  	                          	<input type="text" id="keyword" name="keyword" style="width: 150px; height: 28.5px"/>
							  	<a class="btnType blue" href="" name="searchBtn"  id="searchBtn"  class="searchBtn"><span>검색</span></a>
								</span>
							</p>
							
							<div>
								<a class="btnType" href="javascript:userTypeList('D')" name="userType" id="userType" class="userType" ><span>미승인강사</span></a>
								<a class="btnType blue" href="javascript:userTypeList('B')" name="userType" id="userType" class="userType"><span>승인강사</span></a>
								<span class="fr">					
									기간 <input type="date" id="searchstdate" name="searchstdate" /> ~ <input type="date" id="searcheddate" name="searcheddate" />
									<a class="btnType red" href="javascript:dateList()" name="searchpfsbtn"  id="searchpfsbtn"><span>검색</span></a>
								</span>	
							</div>
							<br>
							
							<div class="divTutorInfo">
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
											<th scope="col">강사No</th>
											<th scope="col">강사명 (ID)</th>
											<th scope="col">연락처</th>
											<th scope="col">가입일자</th>
											<th scope="col">승인여부</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<tbody id="tutorInfoBody"></tbody>
								</table>
							</div>

							<div class="paging_area" id="tutorInfoPagination"></div>

						</div> <!--// content -->					

						<h3 class="hidden">풋터 영역</h3> 
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<%-- <!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>취업 등록</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>

						<tbody>
							<tr>
								<th scope="row">학생명</th>
								<td><span id="name"></span></td>

							</tr>
							<tr>
								<th scope="row">회사명</th>
								<td><input type="text" class="inputTxt p100"
									name="company_name" id="company_name" /> <input type="hidden"
									id="user_no" name="user_no" value="" /></td>
							</tr>
							<tr>
								<th scope="row">연락처</th>
								<td><span id="user_phone"></span></td>

							</tr>
							<tr>
								<th scope="row">입사일</th>
								<td><input type="date" class="inputTxt p100"
									name="employment_day" id="employment_day" style="font-size:12px;" /></td>

							</tr>
							<tr>
								<th scope="row">퇴사일</th>
								<td><input type="date" class="inputTxt p100"
									name="leaving_date" id="leaving_date" style="font-size:12px;" /></td>

							</tr>
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div> --%>

	</form>
</body>
</html>
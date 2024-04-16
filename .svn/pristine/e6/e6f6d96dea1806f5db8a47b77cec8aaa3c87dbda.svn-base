<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>취업정보</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	var pagesize = 5;
	var pageSizeEmploy = 5;
	var pageBlockSizeEmploy = 5;
	var pageblocksize = 5;

	/** OnLoad event */
	$(function() {
		fRegisterButtonClickEvent();
		employmentInfoSearch();
		lectureUserListSearch();
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchBtnA").click(function(e) {
			e.preventDefault();
			employmentInfoSearch();				
		});
		
		$("#searchBtnB").click(function(e) {
			e.preventDefault();
			lectureUserListSearch();				
		});
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSave':
				Save();
				break;
			case 'btnDelete':
				Delete();
				break;
			case 'btnSaveDtl':
				SaveDtl();
				break;
			case 'btnDeleteDtl':
				DeleteDtl();
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

	function employmentInfoSearch(cpage) {

		cpage = cpage || 1;
		
		var param = {
				searchKey : $("#searchKey").val(),
				keyword : $("#keywordA").val(),
				cpage : cpage,
				pagesize : pagesize,
		}

		var listcallback = function(respose) {
			console.log(respose);
			$("#employInfoBody").empty().append(respose);

			var paginationHtml = getPaginationHtml(cpage, $("#listCnt").val(),
					pagesize, pageblocksize, 'employmentInfoSearch');
			console.log("paginationHtml : " + paginationHtml);

			$("#employInfoPagination").empty().append(paginationHtml);

			$("#cpage").val(cpage);
		}

		callAjax("/adm/employmentList.do", "post", "text", false, param,
				listcallback);

	}

	function lectureUserListSearch(cpage) {

		cpage = cpage || 1;

		var param = {
				searchKey : $("#searchKey").val(),
				keyword : $("#keywordB").val(),
				cpage : cpage,
				pagesize : pageSizeEmploy,
		}

		var listcallback = function(respose) {
			console.log(respose);
			$("#lectureUserBody").empty().append(respose);

			var paginationHtml = getPaginationHtml(cpage, $("#listCntUser").val(),
					pageSizeEmploy, pageBlockSizeEmploy,
					'lectureUserListSearch');
			console.log("paginationHtml : " + paginationHtml);

			$("#lectureUserPagination").empty().append(paginationHtml);

			$("#cpage").val(cpage);
		}

		callAjax("/adm/lectureUserList.do", "post", "text", false, param,
				listcallback);

	}

	function lectureUserdtl(user_no) {
		init();
		var param = {
			user_no : user_no
		}

		var userDtlcollback = function(response) {
			$("span#name").text(response.selinfo.name);
			$("span#user_phone").text(response.selinfo.user_phone);
			$("input#name").val(response.selinfo.name);
			$("input#user_phone").val(response.selinfo.user_phone);
			$("#user_no").val(user_no);

			gfModalPop("#layer1");
		}

		callAjax("/adm/lectureUserdtl.do", "post", "json", false, param,
				userDtlcollback);
	}
	
	function Userdtl(user_no) {
		init();
		var param = {
				user_no : user_no
		}
		
		var dtlcollback = function(response) {
			$("span#nameA").text(response.selinfo.name);
			$("span#user_phoneA").text(response.selinfo.user_phone);
			$("span#user_no").text(response.selinfo.user_no);
			$("span#loginID").text(response.selinfo.loginID);
			$("span#user_location").text(response.selinfo.user_location);
			$("span#user_birth").text(response.selinfo.user_birth);
			$("span#user_email").text(response.selinfo.user_email);
			$("span#user_gender").text(response.selinfo.user_gender);
			$("span#lec_no").text(response.selinfo.lec_no);
			$("span#lec_nm").text(response.selinfo.lec_nm);
// 			$("span#lec_date").text(response.selinfo.lec_no);

			gfModalPop("#layer2");
		}
		
		callAjax("/adm/lectureUserdtl.do", "post", "json", false, param,
				dtlcollback);
	}

	function init(data) {
		if (data != null) {
			$("#employment_no").val(data.employment_no);
			$("#employment_state").val(data.employment_state);
			$("#company_name").val(data.company_name);
			$("#employment_day").val(data.employment_day);
			$("#leaving_date").val(data.leaving_date);
			$("#action").val("U");
		} else {
			$("#employment_state").val("");
			$("#company_name").val("");
			$("#employment_day").val("");
			$("#leaving_date").val("");
			$("#action").val("I");
		}
	}

	function employInfoDelete(employment_no) {
		var param = {
			action : $("#action").val("D").val(),
			employment_no : employment_no
		}

		var savecollback = function(response) {
			console.log(JSON.stringify(response));
			// {"result":"S","resultmsg":"저장 되었습니다."}
			alert(response.resultmsg);

			if (response.result == "S") {
				gfCloseModal();
				if ($("#action").val() == "I") {
					employmentInfoSearch();
					lectureUserListSearch();
				} else {
					employmentInfoSearch($("#cpage").val());
					lectureUserListSearch($("#cpage").val());
				}
			}
		}

		callAjax("/adm/employInfoSave.do", "post", "json", false, param,
				savecollback);
	}

	function Save() {

		if($("#leaving_date").val() != null && $("#leaving_date").val() != ''){
			$("#employment_state").val("L");
		}
		
		if (!fValidate()) {
			return;
		}

		var param = {
			employment_no : $("#employment_no").val(),
			user_no : $("#user_no").val(),
			name : $("input#name").val(),
			company_name : $("#company_name").val(),
			employment_day : $("#employment_day").val(),
			employment_state : $("#employment_state").val(),
			leaving_date : $("#leaving_date").val(),
			user_phone : $("input#user_phone").val(),
			action : $("#action").val(),
		}

		var savecollback = function(response) {
			console.log(JSON.stringify(response));
			// {"result":"S","resultmsg":"저장 되었습니다."}
			alert(response.resultmsg);

			if (response.result == "S") {
				gfCloseModal();
				if ($("#action").val() == "I") {
					employmentInfoSearch();
					lectureUserListSearch();
				} else {
					employmentInfoSearch($("#cpage").val());
					lectureUserListSearch($("#cpage").val());
				}
			}
		}
		callAjax("/adm/employInfoSave.do", "post", "json", false, param,
				savecollback);
	}

	function fValidate() {

		var chk = checkNotEmpty([ [ "company_name", "회사명을 입력해 주세요." ],
				[ "employment_day", "입사일을 입력해 주세요." ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	function employInfoModify(employment_no) {

		var param = {
			employment_no : employment_no
		}
		
		var modcollback = function(response) {
			init(response.selinfo);
			$("span#name").text(response.selinfo.name);
			$("span#user_phone").text(response.selinfo.user_phone);
			gfModalPop("#layer1");
		}

		callAjax("/adm/employInfodtl.do", "post", "json", false, param,
				modcollback);
	}
	
</script>


</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="name" name="name" value=""> <input
			type="hidden" id="action" name="action" value=""> <input
			type="hidden" id="user_phone" name="user_phone" value=""> <input
			type="hidden" id="employment_state" name="employment_state" value="">
			<input
			type="hidden" id="employment_no" name="employment_no" value="">

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
						<div class="content" style="min-height: 250px !important;">

							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">취업 관리</span> <span
									class="btn_nav bold">취업정보 관리</span> <a
									href="../adm/employmentList.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>취업정보</span><span class="fr">													
  	                          <select style="width: 75px; height: 30px" id="searchKey" name="searchKey">
  	                          	<option value="all">전체</option>
  	                          	<option value="userNo">학번</option>
  	                          	<option value="userName">학생명</option>
  	                          	<option value="companyName">업체명</option>
  	                          </select>
  	                          <input type="text" id="keywordA" name="keyword" style="width: 150px; height: 28.5px"/>
							  <a class="btnType red" href="" name="searchBtn"  id="searchBtnA"  class="searchBtn"><span>검색</span></a>
							</span>
							</p>

							<div class="divEmployInfo">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="5%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="12%">
										<col width="12%">
										<col width="16%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">학번</th>
											<th scope="col">학생명</th>
											<th scope="col">연락처</th>
											<th scope="col">입사일</th>
											<th scope="col">퇴사일</th>
											<th scope="col">업체명</th>
											<th scope="col">재직여부</th>
											<th scope="col">수정/삭제</th>
										</tr>
									</thead>
									<tbody id="employInfoBody"></tbody>
								</table>
							</div>

							<div class="paging_area" id="employInfoPagination"></div>




						</div> <!--// content -->
						<div class="content">


							<p class="conTitle">
								<span>취업 정보 등록</span>
<!-- 								<span class="fr">													 -->
<!--   	                          <select style="width: 75px; height: 30px" id="searchKey" name="searchKey"> -->
<!--   	                          	<option value="all">전체</option> -->
<!--   	                          	<option value="userNo">학번</option> -->
<!--   	                          	<option value="userName">학생명</option> -->
<!--   	                          	<option value="lectureName">강의명</option> -->
<!--   	                          </select> -->
<!--   	                          <input type="text" id="keywordB" name="keyword" style="width: 150px; height: 28.5px"/> -->
<!-- 							  <a class="btnType red" href="" name="searchBtn"  id="searchBtnB"  class="searchBtn"><span>검색</span></a> -->
<!-- 							</span> -->
							</p>

							<div class="divLectureUserList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="7%">
										<col width="13%">
										<col width="20%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">학번</th>
											<th scope="col">학생명</th>
											<th scope="col">연락처</th>
											<th scope="col">강의명</th>
											<th scope="col">가입일자</th>
											<th scope="col">등록</th>
										</tr>
									</thead>
									<tbody id="lectureUserBody"></tbody>
								</table>
							</div>

							<div class="paging_area" id="lectureUserPagination"></div>




						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!-- 모달팝업 -->
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

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

		<!--// 모달팝업 -->
		
		<!-- 모달팝업 -->
		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>취업 등록</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">ID</th>
								<td><span id="loginID"></span></td>
								<th scope="row">학번</th>
								<td><span id="user_no"></span></td>
							</tr>
							<tr>
								<th scope="row">이름</th>
								<td><span id="nameA"></span></td>
								<th scope="row">생년월일</th>
								<td><span id="user_birth"></span></td>
							</tr>
							<tr>
								<th scope="row">전화번호</th>
								<td><span id="user_phoneA"></span></td>
								<th scope="row">성별</th>
								<td><span id="user_gender"></span></td>
							</tr>
							<tr>
								<th scope="row">주소</th>
								<td><span id="user_location"></span></td>
								<th scope="row">이메일</th>
								<td><span id="user_email"></span></td>
							</tr>
						</tbody>
					</table>
					<br><br>
					<h1>수강 내역</h1>
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="15%">
							<col width="20%">
							<col width="50%">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">강의ID</th>
								<th scope="row">강의명</th>
								<th scope="row">기간</th>
							</tr>
							<tr>
								<td><span id="lec_no"></span></td>
								<td><span id="lec_nm"></span></td>
								<td><span id="lec_date"></span></td>
							</tr>
						</tbody>
						</table>
					
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

		<!--// 모달팝업 -->
	</form>
</body>
</html>
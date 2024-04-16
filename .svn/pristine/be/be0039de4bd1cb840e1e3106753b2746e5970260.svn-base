<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>강의실관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	var pagesize = 10;
	var pageSizeEquip = 5;
	var pageBlockSizeEquip = 5;
	var pageblocksize = 10;

	/** OnLoad event */
	$(function() {

		classroomSearch();
		fRegisterButtonClickEvent();
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {

		$("#searchbtn").click(function(e) {
			e.preventDefault();

			classroomSearch();

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
			case 'btnClose':
				gfCloseModal();
				break;
			case 'btnSavefile':
				fSave();
				break;
			case 'btnDeletefile':
				fDelete();
				break;
			}
		});
	}

	function Save() {

		if (!fValidate()) {
			return;
		}

		var param = {
			classroom_no : $(".classroom_no").val(),
			classroom_nm : $("#classroom_nm").val(),
			seat_cnt : $("#seat_cnt").val(),
			classroom_size : $("#classroom_size").val(),
			classroom_etc : $("#classroom_etc").val(),
			action : $("#action").val(),
		}

		var savecollback = function(response) {
			console.log(JSON.stringify(response));
			// {"result":"S","resultmsg":"저장 되었습니다."}
			alert(response.resultmsg);

			if (response.result == "S") {
				gfCloseModal();
				if ($("#action").val() == "I") {
					classroomSearch();
				} else {
					classroomSearch($("#cpage").val());
				}
			}
		}
		callAjax("/adm/classroomSave.do", "post", "json", false, param,
				savecollback);
	}

	function Delete() {
		$("#action").val("D");
		Save();
	}

	function fValidate() {

		var chk = checkNotEmpty([ [ "classroom_nm", "강의실명을 입력해 주세요." ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	function classroomSearch(cpage) {

		cpage = cpage || 1;

		var param = {
			searchClassroom : $("#searchClassroom").val(),
			cpage : cpage,
			pagesize : pagesize,
		}
		console.log("짱짱짱" + param.searchClassroom);

		var listcallback = function(respose) {
			console.log(respose);
			$("#classroomtbody").empty().append(respose);

			var paginationHtml = getPaginationHtml(cpage, $("#listCnt").val(),
					pagesize, pageblocksize, 'classroomSearch');
			console.log("paginationHtml : " + paginationHtml);

			$("#classroomPagination").empty().append(paginationHtml);

			$("#cpage").val(cpage);
		}

		callAjax("/adm/classroomList.do", "post", "text", false, param,
				listcallback);

	}

	function newClassroom() {
		init();
		gfModalPop("#layer1");
	}

	function classroomModify(classroom_no) {

		var param = {
			classroom_no : classroom_no
		}

		console.log(classroom_no);

		var modcallback = function(response) {
			console.log(JSON.stringify(response));

			init(response.selinfo);
			gfModalPop("#layer1");
		}

		callAjax("/adm/classroomdtl.do", "post", "json", false, param,
				modcallback);

	}

	function init(data) {
		if (data != null) {
			$(".classroom_no").val(data.classroom_no);
			$("#classroom_nm").val(data.classroom_nm);
			$("#seat_cnt").val(data.seat_cnt);
			$("#btnDelete").show();
			$("#classroom_size").val(data.classroom_size);
			$("#classroom_etc").val(data.classroom_etc);
			$("#action").val("U");
		} else {
			$("#classroom_nm").val("");
			$("#seat_cnt").val("");
			$("#classroom_size").val("");
			$("#classroom_etc").val("");
			$("#btnDelete").hide();
			$("#action").val("I");
		}
	}

	function classroomEquipment(classroom_no, currentPage) {

		currentPage = currentPage || 1;

		$("#classroom_no").val(classroom_no);

		var param = {
			classroom_no : classroom_no,
			currentPage : currentPage,
			pageSize : pageSizeEquip
		}

		var resultCallback = function(data) {
			classroomEquipmentResult(data, currentPage);
		};

		callAjax("/adm/listClsEquip.do", "post", "text", true, param,
				resultCallback);
	}

	function classroomEquipmentResult(data, currentPage) {

		$('#listClsEquip').empty();

		var $data = $($(data).html());

		var $listClsEquip = $data.find("#listClsEquip");
		$("#listClsEquip").append($listClsEquip.children());

		var $totalCntClsEquip = $data.find("#totalCntClsEquip");
		var totalCntClsEquip = $totalCntClsEquip.text();

		var classroom_no = $("#classroom_no").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCntClsEquip,
				pageSizeEquip, pageBlockSizeEquip, 'classroomEquipment',
				[ classroom_no ]);
		$("#EquipPagination").empty().append(paginationHtml);

		$("#currentPageEquipDtl").val(currentPage);
	}
</script>

</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="action" name="action" value="" /> <input
			type="hidden" class="classroom_no" name="classroom_no" value="" /> <input
			type="hidden" id="currentPageEquipDtl" value="1">


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
								<span class="btn_nav bold">시설관리</span> <span
									class="btn_nav bold">강의실 관리</span> <a
									href="../adm/classroom.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>강의실 관리</span> <span class="fr"> <b>강 의 실
										명&nbsp;</b> <input type="text" id="searchClassroom"
									name="searchClassroom" style="height: 29px;" /> <a
									class="btnType red" href="" name="searchbtn" id="searchbtn"><span>검색</span></a>
									<a class="btnType blue" href="javascript:newClassroom();"
									name="modal"><span>신규등록</span></a>
								</span>
							</p>

							<div class="divClassroomList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="35%">
										<col width="17%">
										<col width="17%">
										<col width="16%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th colspan="5">강의실 목록</th>
										</tr>
										<tr>
											<th scope="col">강의실명</th>
											<th scope="col">크기</th>
											<th scope="col">자리수</th>
											<th scope="col">비고</th>
											<th scope="col">수정</th>
										</tr>
									</thead>
									<tbody id="classroomtbody"></tbody>
								</table>
							</div>

							<div class="paging_area" id="classroomPagination"></div>

							<!-- 장비내역 -->
							<p class="conTitle mt50">
								<span>강의실 장비 목록</span>
							</p>
							<div class="divEquipList" id="divEquipList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="30%">
										<col width="10%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">장비명</th>
											<th scope="col">갯수</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody id="listClsEquip">
										<tr>
											<td colspan="12">강의실을 선택해 주세요.</td>
										</tr>
									</tbody>
								</table>
								<div class="paging_area" id="EquipPagination"></div>
							</div>


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
					<strong>강의실 관리</strong>
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
								<th scope="row">강의실명 <span class="font_red">*</span></th>
								<td><input type="hidden" class="classroom_no"
									name="classroom_no" value="" /> <input type="text"
									class="inputTxt p100" name="classroom_nm" id="classroom_nm" /></td>
								<th scope="row">자리수</th>
								<td><input type="text" class="inputTxt p100"
									name="seat_cnt" id="seat_cnt" /></td>
							</tr>
							<tr>
								<th scope="row">크기</th>
								<td><input type="text" class="inputTxt p100"
									name="classroom_size" id="classroom_size" /></td>
								<th scope="row">비고</th>
								<td><input type="text" class="inputTxt p100"
									name="classroom_etc" id="classroom_etc" /></td>
							</tr>

						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

		<!--// 모달팝업 -->
	</form>
</body>
</html>
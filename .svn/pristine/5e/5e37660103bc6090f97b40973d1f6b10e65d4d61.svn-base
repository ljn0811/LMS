<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>장비관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	var pagesize = 10;
	var pageblocksize = 10;
	var pageSizeDtl= 5;
	var pageBlockSizeDtl = 10;

	/** OnLoad event */
	$(function() {

		equipmentSearch();
		fRegisterButtonClickEvent();
		selectComCombo("cls", "clslist", "all", "", "");
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchbtn").click(function(e) {
			e.preventDefault();

			equipmentSearch();

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

	function equipmentSearch(cpage) {

		cpage = cpage || 1;

		var param = {
			searchEquipment : $("#searchEquipment").val(),
			cpage : cpage,
			pagesize : pagesize,
		}

		var listcallback = function(respose) {
			console.log(respose);
			$("#equipmenttbody").empty().append(respose);

			var paginationHtml = getPaginationHtml(cpage, $("#listCnt").val(),
					pagesize, pageblocksize, 'equipmentSearch');
			console.log("paginationHtml : " + paginationHtml);

			$("#equipmentPagination").empty().append(paginationHtml);

			$("#cpage").val(cpage);
		}

		callAjax("/adm/equipmentList.do", "post", "text", false, param,
				listcallback);

	}

	function equipmentDtlList(cpage, tool_nm) {
		
		cpage = cpage || 1;
		
		$("#tool_nm").val(tool_nm);
		
		var param = {
				tool_nm : tool_nm
				,	cpage : cpage
				,	pagesize : pageSizeDtl
		}
		
		var resultCallback = function(response) {
			
			alert(response);
			alert(JSON.stringify(response));
			

			$('#listEquiDtlCod').empty();
			$("#totalCntEquiDtl").val(response.totalCntEquiDtl);
			$.each(response.equipmentDtlModel, function(index, item) {
        $('#listEquiDtlCod').append('<tr>' +
            '<td>' + item.tool_nm + '</td>' +
            '<td>' + item.classroom_nm + '</td>' +
            '<td>' + item.tool_cnt + '</td>' +
            '<td>' + item.tool_etc + '</td>' +
            '<td>' +
            '<a class="btnType3 color1" href="javascript:fPopModalEquipmentDtl(\'' + item.tool_no + '\');"><span>수정</span></a>&nbsp;' +
            '<a class="btnType3 color1" href="javascript:deleteEquipment(\'' + item.tool_no + '\');"><span>삭제</span></a>' +
            '</td>' +
            '</tr>');
    });
			
			 var paginationHtml = getPaginationHtml(cpage, $("#totalCntEquiDtl").val(),
					 pagesize, pageBlockSizeDtl, 'equipmentDtlList');
			console.log("cpage : " + cpage);
			console.log("totalCntEquiDtl : " +  $("#totalCntEquiDtl").val());
			console.log("pagesize : " + pagesize);
			console.log("pageBlockSizeDtl : " + pageBlockSizeDtl);

			$("#equiDtlPagination").empty().append(paginationHtml);
			gfModalPop("#layer2");
			$("#cpage").val(response.currentPageEquiDtlCod);
			
			
		};
		
		callAjax("/adm/equipmentDtlList.do", "post", "json", false, param, resultCallback);
	}
	
	function Save() {

		if (!fValidate()) {
			return;
		}

		var param = {
			tool_no : $("#tool_no").val(),
			tool_nm : $("#tool_nm").val(),
			tool_cnt : $("#tool_cnt").val(),
			tool_etc : $("#tool_etc").val(),
			classroom_no : $("#clslist").val(),
			action : $("#action").val(),
		}

		var savecollback = function(response) {
			console.log(JSON.stringify(response));
			// {"result":"S","resultmsg":"저장 되었습니다."}
			alert(response.resultmsg);

			if (response.result == "S") {
				gfCloseModal();
				if ($("#action").val() == "I") {
					equipmentSearch();
				} else {
					equipmentSearch($("#cpage").val());
				}
			}
		}
		callAjax("/adm/equipmentSave.do", "post", "json", false, param,
				savecollback);
	}
	
	function deleteEquipment(tool_no) {
		
		var param = {
		action : "D",
		tool_no : tool_no
		}
		
		var deletecollback = function(response) {
			console.log(JSON.stringify(response));
			// {"result":"S","resultmsg":"저장 되었습니다."}
			alert(response.resultmsg);

			if (response.result == "S") {
				gfCloseModal();
				if ($("#action").val() == "I") {
					equipmentSearch();
				} else {
					equipmentSearch($("#cpage").val());
				}
			}
		}
		
		callAjax("/adm/equipmentSave.do", "post", "json", false, param,
				deletecollback);
	}

	function fPopModalEquipmentDtl(tool_no){
		
		var param ={
				tool_no : tool_no
		}
		
		var modcallback = function(response) {
			console.log(JSON.stringify(response));

			init(response.selinfo);
			gfModalPop("#layer1");
		}

		
		callAjax("/adm/equipmentdtl.do", "post", "json", false, param,
				modcallback);
		
	}
	
	function fValidate() {

		var chk = checkNotEmpty([ [ "tool_nm", "장비명을 입력해 주세요." ],
				[ "clslist", "강의실명을 선택해 주세요." ], [ "tool_cnt", "갯수를 입력해 주세요." ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	function newEquipment() {
		init();
		gfModalPop("#layer1");

	}

	function init(data) {
		if (data != null) {
			$("#tool_no").val(data.tool_no);
			$("#tool_nm").val(data.tool_nm);
			$("#tool_cnt").val(data.tool_cnt);
			$("#tool_etc").val(data.tool_etc);
			$("#clslist").val(data.classroom_no);
			$("#btnDelete").show();
			$("#action").val("U");
		} else {
			$("#tool_no").val("");
			$("#tool_nm").val("");
			$("#tool_cnt").val("");
			$("#tool_etc").val("");
			$("#btnDelete").hide();
			$("#action").val("I");
		}
	}
</script>

</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="action" name="action" value="" /> 
		<input type="hidden" id="currentPageEquiDtlCod" value="1">
		<input type="hidden" id="tool_no" name="tool_no" value="" />
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
									class="btn_nav bold">장비 관리</span> <a
									href="../adm/equipmentControl.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>장비 관리</span> <span class="fr"> <b>장 비 
										명&nbsp;</b> <input type="text" id="searchEquipment"
									name="searchEquipment" style="height: 29px;" /> <a
									class="btnType red" href="" name="searchbtn" id="searchbtn"><span>검색</span></a>&nbsp;<a
									class="btnType blue" href="javascript:newEquipment();"
									name="modal"><span>신규등록</span></a>
								</span>
							</p>

							<div class="divEquipmentList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="50%">
										<col width="25%">
										<col width="25%">
									</colgroup>

									<thead>
										<tr>
											<th colspan="3">장비 관리</th>
										</tr>
										<tr>
											<th scope="col">장비명</th>
											<th scope="col">갯수</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody id="equipmenttbody"></tbody>
								</table>
							</div>

							<div class="paging_area" id="equipmentPagination"></div>




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
					<strong>장비 관리</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>

						<tbody>
							<tr>
								<th scope="row">장비명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="tool_nm"
									id="tool_nm" /></td>
								<th scope="row">강의실 <span class="font_red">*</span></th>
								<td><select id="clslist" name="classroom_no"></select></td>
							</tr>
							<tr>
								<th scope="row">갯수 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="tool_cnt" id="tool_cnt" /></td>
								<th scope="row">비고</th>
								<td><input type="text" class="inputTxt p100"
									name="tool_etc" id="tool_etc" /></td>
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
		<div id="layer2" class="layerPop layerType2" style="width: 1000px;">
		<dl>
				<dt>
					<strong>장비 상세</strong>
				</dt>
				<dd class="content">
						<input type="hidden" id="totalCntEquiDtl" name="totalCntEquiDtl" value ="${totalCntEquiDtl}"/>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">장비명</th>
									<th scope="col">강의실명</th>
									<th scope="col">개수</th>
									<th scope="col">비고</th>
									<th scope="col">수정/삭제</th>
								</tr>
							</thead>
							<tbody id="listEquiDtlCod">
							<tr></tr>
							</tbody>
						</table>
						<div class="paging_area"  id="equiDtlPagination"> </div>
					</dd>
					</dl>
					<a href="" class="closePop"><span class="hidden">닫기</span></a>
					</div>
					
		
	</form>
</body>
</html>
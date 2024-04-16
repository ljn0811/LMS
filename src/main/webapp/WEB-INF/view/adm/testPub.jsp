<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>시험 문제 관리</title>
<!-- sweet alert import -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
   
    var pagesize = 5;
    var pageblocksize = 10;
    
    var testListpagesize =5;
    var testListpageblocksize =10;
   
	/** OnLoad event */ 
	$(function() {
		
		
		testPubSeach();	
		
		fRegisterButtonClickEvent();
		selectComCombo("leclist","lecblist","all","","");  
		selectComCombo("test","testlist","all","","");   	
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchbtn").click(function(e) {
			e.preventDefault();
			
			testPubSeach();	
			
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
				case 'btnUpdate' :
					Update();
					break;	
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnSaveque' :
					QueSave();
					break;
				case 'btnUpdateque' :
					QueUpdate();
					break;
				case 'btnDeleteque' :
					QueDelete();
					break;
			}
		}); 
	}
	
	function testPubSeach(cpage) {
		
		cpage = cpage || 1;
		
		var param = {
				searchtitle : $("#searchtitle").val(),
				cpage : cpage,
				pagesize : pagesize,
		}
		
		var listcallback = function(respose) {
			console.log(respose);		
			$("#listTestPubBody").empty().append(respose);
			
			var paginationHtml = getPaginationHtml(cpage, $("#listcnt").val(), pagesize, pageblocksize, 'testPubSeach');
			console.log("paginationHtml : " + paginationHtml);
	
			$("#testPubPagination").empty().append( paginationHtml );
			
			$("#cpage").val(cpage);
		}
		
		callAjax("/adm/listTestPub.do", "post", "text" , false, param, listcallback);
		
	}
	
	
	
	
	function testListPub(currentPage,lec_no){
		currentPage = currentPage || 1;
	
		
		
		var param = {
				lec_no : lec_no,
				currentPage : currentPage,
				pageSize : testListpagesize,
		}
		
		var listcallback = function(data) {
			testListPubResult(data, currentPage);
			console.log(data);
			
		};
		callAjax("/adm/testListPub.do", "post", "text" , false, param, listcallback);
	}
	
	/** 상세코드 조회 콜백 함수 */
	function testListPubResult(data, currentPage) {
	
		// 기존 목록 삭제
		$('#testListPub').empty().append(data); 
		
		//var $data = $( $(data).html() );

		// 신규 목록 생성
		//var $testListPub = $data.find("#testListPub");		
		//$("#testListPub").append($testListPub.children());
		
		// 총 개수 추출
	//	var totalTestListPub = data.find("#totalTestListPub");
	//	var totalTestListPub = totalTestListPub.text(); 
		
	
	/* 	
		// 페이지 네비게이션 생성
		var test_no = $("#test_no").val();
		var paginationHtml = getPaginationHtml(currentPage, listcnt, testListpagesize, testListpageblocksize, 'testListPub',[test_no]);
		$("#testListPubPagination").empty().append( paginationHtml ); */
		
		// 현재 페이지 설정
		$("#currentPageTestListPub").val(cpage);
	}
    
	
	function newreg(lec_no) {
		// gfCloseModal();\
		// alert(lec_no);
		init();
		 var selectedLecNo = $("#lecblist").val(); // 선택된 강의 번호
	        $("#lecblist").val(lec_no).prop('selected', true); // 해당 강의 
		gfModalPop("#layer1");
		
		
	}
	
	function modify(test_no) {
		
		var param = {
				test_no : test_no
		}
		
		console.log(test_no);
		
		var delcallback = function(response) {
			console.log(JSON.stringify(response));
			
			
			init(response.selinfo);
			gfModalPop("#layer1");
		}
		
		callAjax("/adm/testListPubDtl.do", "post", "json" , false, param, delcallback);
		
		
	}
function Save() {
		
		// console.log($("#ititle").val());
		// console.log($("#icontent").val());
		
	//	if(!fValidate()) {
	//		return;
	//	}
		
		var param = {
				test_no : $("#test_no").val(),
				ititle : $("#ititle").val(),
				itype : $("#itype").val(),
				istart : $("#istart").val(),
				iend : $("#iend").val(),
				action : $("#action").val(),
				lec_no : $("#lecblist").val()
		}
		
		var savecollback = function(response) {
			console.log(JSON.stringify(response));
			// {"result":"S","resultmsg":"저장 되었습니다."}
			alert(response.resultmsg);
			
			if(response.result == "S") {
				gfCloseModal();
				if($("#action").val() == "I") {
					testPubSeach();
					testListPub();
				} else {
					testPubSeach($("#cpage").val());
					testListPub($("#cpage").val());
				}
			}
		}
		
		callAjax("/adm/testListPubSave.do", "post", "json" , false, param, savecollback);
		
		
	}
	
function Delete() {		
	$("#action").val("D");		
	Save();		
}
	
	function init(data) {	

		console.log("data 확인", data);
		if(data != null) {
			$("#ititle").val(data.test_nm);
			$("#itype").val(data.test_type);
			$("#istart").val(data.test_start);
			$("#iend").val(data.test_end);
			$("#btnDelete").show();
			$("#btnSave").show();	
			$("#test_no").val(data.test_no);
			$("#lecblist").val(data.lec_no);
			$("#action").val("U");			
		} else {
			$("#ititle").val("");
			$("#itype").val("");
			$("#istart").val("");
			$("#iend").val("");
			$("#test_no").val("");
			$("#btnDelete").hide();
			$("#action").val("I");			
		}
	}
	
	function testQueModal(test_no) {
		// gfCloseModal();\
		 queInit(); 
		 var selectedTestNo = $("#testlist").val(); // 선택된 시험 번호
	        $("#testlist").val(test_no).prop('selected', true); // 해당 시험  
		gfModalPop("#testQue");
		
		
	}
	
	
	function queInit(data){
		// alert(data)
		if(data != null){ 
			console.log(data.test_que_no)
			$("#testlist").val(data.test_no);
			$("#que_ans").val(data.que_ans);
			$("#test_no").val(data.test_no);
			$("#test_que").val(data.test_que);
			$("#test_que_no").val(data.test_que_no);
			$("#que_ex1").val(data.que_ex1);
			$("#que_ex2").val(data.que_ex2);
			$("#que_ex3").val(data.que_ex3);
			$("#que_ex4").val(data.que_ex4);
			$("#btnDeleteque").show();
			$("#btnSaveque").show();	
			$("#action").val("U");
		}else{
			$("#que_ans").val("");
			$("#test_que").val("");
			$("#que_ex1").val("");
			$("#que_ex2").val("");
			$("#que_ex3").val("");
			$("#que_ex4").val("");
			$("#btnDeleteque").hide();	
			$("#action").val("I");				
		} 
	}
	
function QueSave() {
		
		// console.log($("#ititle").val());
		// console.log($("#icontent").val());
		
	//	if(!fValidate()) {
	//		return;
	//	}
		
		var param = {
				action : $("#action").val(),
				test_no : $("#testlist").val(),
				test_que_no : $("#test_que_no").val(),
				test_que : $("#test_que").val(),
				que_ans : $("#que_ans").val(),
				que_ex1 : $("#que_ex1").val(),
				que_ex2 : $("#que_ex2").val(),
				que_ex3 : $("#que_ex3").val(),
				que_ex4 : $("#que_ex4").val(),
				
		}
		
		var savecollback = function(response) {
			console.log(JSON.stringify(response));
			// {"result":"S","resultmsg":"저장 되었습니다."}
			alert(response.resultmsg);
			
			if(response.result == "S") {
				gfCloseModal();
				if($("#action").val() == "I") {
					testPubSeach();
					testListPub();
				} else {
					testPubSeach($("#cpage").val());
					testListPub($("#cpage").val());
				}
			}
		}
		
		callAjax("/adm/testQueSave.do", "post", "json" , false, param, savecollback);
		
		
	}
function QueDelete() {		
	$("#action").val("D");		
	QueSave();		
}

function testQueList() {
	
    var param = {
    		
    };

    var listcallback = function(response) {
        console.log(response); // 응답 확인용 로그
        $("#testQueListBody").empty().append(response);
    };

    callAjax("/adm/listTestQue.do", "post", "text", false, param, listcallback);
}

function testQueListModal(){
	
	
	gfModalPop("#testQueList");
	testQueList();
}

function queModify(test_que_no) {
	
	var param = {
			test_que_no : test_que_no
	}
	
	console.log(test_que_no);
	
	var delcallback = function(response) {
		console.log(JSON.stringify(response));
		
		
		queInit(response.selinfo);
		gfModalPop("#testQue");
	}
	
	callAjax("/adm/testQueDtl.do", "post", "json" , false, param, delcallback);
	
	
}

  
</script>

</head>
<body>
<form id="myForm" action=""  method="">
    <input type="hidden"  id="action"  name="action"  value="" />
   <input type="hidden"  id="test_no"  name="test_no"  value="" />
   <input type="hidden"  id="test_que_no"  name="test_que_no"  value="" />
    <input type="hidden"  id="cpage"  name="cpage"  value="" />  
	<input type="hidden" id="currentPageTestListPub" value="1">
	
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">시험 문제 관리</span> <a href="../notice/notice.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>시험 문제 관리</span> <span class="fr">
							<a class="btnType blue" href="javascript:testQueListModal();" name="modal">
   								 <span>문제리스트</span>
							</a>
							<div>
  	                          <strong>과정명</strong>
  	                          <input type="text" id="searchtitle" name="searchtitle" style="width: 300px; height: 25px;" />
							  <a class="btnType red" href="" name="searchbtn"  id="searchbtn"><span>검색</span></a>
							  </div>
							</span>
						</p>
						<div class="divTestPubList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="40%">
									<col width="40%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">과정명</th>
										<th scope="col">기간</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="listTestPubBody"></tbody>
							</table>
						</div>
	                    
						<div class="paging_area"  id="testPubPagination"> </div>
						
						
						
						
						<!-- 시험목록 창 -->
					<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                          
                          
                           
                        </tr>
                     </table> 
                     
						<p class="conTitle mt50">
							<span>시험 목록</span> <span class="fr">
							</span>
						</p>
	
						<div class="divComDtlCodList" id="divComDtlCodList">
						 	<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="25%">
									<col width="15%">
									<col width="20%">
									<col width="10%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">과정명</th>
										<th scope="col">시험명</th>
										<th scope="col">구분</th>
										<th scope="col">대상자수</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="testListPub">
									<tr>
										<td colspan="5">과정을 선택해 주세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="testListPubPagination"> </div>
						
			
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
				<strong>시험 등록</strong>
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
							<th scope="row">과정명 <span class="font_red">*</span></th>
							<td colspan=3><select  name="lec_no" id="lecblist" > </select></td>
						</tr>
						<tr>
							<th scope="row">시험명 <span class="font_red">*</span></th>
							<td colspan=3><input type="text" class="inputTxt p100" name="ititle" id="ititle" /></td>
						</tr>
						<tr>
							<th scope="row">시험분류 <span class="font_red">*</span></th>
							<td colspan=3><input type="text" class="inputTxt p100" name="itype" id="itype" /></td>					
						</tr>
						<tr>
							<th scope="row">시작날짜 <span class="font_red">*</span></th>
							<td colspan=3><input type="date" class="inputTxt p100" name="istart" id="istart" /></td>
						</tr>
						<tr>
							<th scope="row">마감날짜 <span class="font_red">*</span></th>
							<td colspan=3><input type="date" class="inputTxt p100" name="iend" id="iend" /></td>
						</tr>				
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 		
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	
	<div id="testQue" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>시험 문제 등록 </strong>
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
						<!-- <tr>
							<th scope="row">과정명 <span class="font_red">*</span></th>
							<td colspan=3><select  name="lec_no" id="lecblist" > </select></td>
						</tr> -->
						<tr>
							<th scope="row">시험명 <span class="font_red">*</span></th>
							<td colspan=3><select  name="test_no" id="testlist" > </select></td>						
						</tr>				
						<tr>
							<%-- <th scope="row">문제번호<span class="font_red">*</span> </th>
							<td>
							<input type="hidden" id="test_id" name="test_id" value="${test_id}">
							<input type="text" class="inputTxt p100" id="que_num" name="que_num" /></td> --%>
							
							<th scope="row">정답<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" id="que_ans" name="que_ans" /></td>
						</tr>
						<tr>
							<th scope="row">문제<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="test_que" name="test_que" /></td>
						</tr>
						<tr>
							<th scope="row">보기1<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="que_ex1" name="que_ex1"/></td>
						</tr>
						<tr>
							<th scope="row">보기2<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="que_ex2" name="que_ex2"/></td>
						</tr>
						<tr>
							<th scope="row">보기3<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="que_ex3" name="que_ex3"/></td>
						</tr>
						<tr>
							<th scope="row">보기4<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="que_ex4" name="que_ex4"/></td>
						</tr>		
					</tbody> 
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveque" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteque" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	

	<!--// 모달팝업 -->
	
	<div id="testQueList" class="layerPop layerType2"  style="width: 1500px;">
		<dl>
			<dt>
				<strong>시험 문제 리스트 </strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
					<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="5%">
									<col width="5%">
									<col width="15%">
									<col width="5%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="5%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의명</th>
										<th scope="col">시험종류</th>
										<th scope="col">시험분류</th>
										<th scope="col">문제</th>
										<th scope="col">정답</th>
										<th scope="col">보기1번</th>
										<th scope="col">보기2번</th>
										<th scope="col">보기3번</th>
										<th scope="col">보기4번</th>
										<th scope="col">비고</th>
										
									</tr>
								</thead>
								<tbody id="testQueListBody">
								</tbody>
							</table>			

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
			<!--<a href="" class="btnType blue" id="btnSaveque" name="btn"><span>저장</span></a> 
				<a href="" class="btnType blue" id="btnDeleteque" name="btn"><span>삭제</span></a> -->	
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
	
</form>
</body>
</html>
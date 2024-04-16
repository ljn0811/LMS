<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>학생관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

    var studentData; // 전역 변수로 응답 데이터를 저장할 변수 선언
    
    // 그룹코드 페이징 설정
	var pageSizeComnGrpCod = 5;
	var pageBlockSizeComnGrpCod = 5;
	
	// 상세코드 페이징 설정
	var pageSizeComnDtlCod = 5;
	var pageBlockSizeComnDtlCod = 10;
	
	/** OnLoad event */ 
	$(function() {
	
		// 목록조회
		fListComnGrpCod();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
          
			switch (btnId) {
				case 'btnSaveGrpCod' :
					fSaveGrpCod();
					break;
				case 'btnDeleteGrpCod' :
					fDeleteGrpCod();
					break;
				case 'btnSaveDtlCod' :
					fSaveDtlCod();
					break;
				case 'btnDeleteDtlCod' :
					fDeleteDtlCod();
					break;
				case 'btnSearchGrpcod':
					board_search();
					break;
				case 'btnInsert':
					stdLecReg();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
   /** 강의목록 조회*/
	function fListComnGrpCod(currentPage) {
		
		currentPage = currentPage || 1;
		
		 var searchTitle = $('#searchtitle').val(); // 강의명
		 var startDate = $('#searchstdate').val(); // 강의 시작일
		 var endDate = $('#searcheddate').val();   // 강의 종료일
		
		
		console.log("currentPage : " + currentPage);
		
		var param = {	
				
				    searchTitle: searchTitle
		        ,   startDate: startDate
		        ,   endDate: endDate
				,	currentPage : currentPage
				,	pageSize : pageSizeComnGrpCod
		}
		
		console.log(param);
		
		var resultCallback = function(data) {
			flistGrpCodResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/adm/studentLectureList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 강의목록 조회 콜백 함수 */
	function flistGrpCodResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listComnGrpCod').empty();
		
		// 신규 목록 생성
		$("#listComnGrpCod").append(data);
		
		// 총 개수 추출
		
		var totalCntComnGrpCod = $("#totalCntComnGrpCod").val();
		
		
		//swal(totalCntComnGrpCod);
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(currentPage, totalCntComnGrpCod, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListComnGrpCod');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageComnGrpCod").val(currentPage);
	}
	
	 // 강의목록 검색기능
	function board_search(currentPage) {
		
	    var searchTitle = $('#searchtitle').val(); // 강의명
	  
	
	    currentPage = currentPage || 1;
	
	    console.log("currentPage : ", currentPage);     
	
	    var param = {
	        searchtitle: searchTitle, 
	        currentPage: currentPage,
	        pageSize: pageSizeComnGrpCod
	    };
	
	    console.log("param : ", param);    
	    
	    var resultCallback = function(data) {
	        flistGrpCodResult(data, currentPage); 
	    };
	
	    callAjax("/adm/studentLectureList.do", "post", "text", true, param, resultCallback);
	}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
	/** 학생목록 조회 */
	function fListComnDtlCod(currentPage, lec_nm) {
		
		currentPage = currentPage || 1;
		
		// 그룹코드 정보 설정
		$("#tmpGrpCodNm").val(lec_nm);
		
		var param = {
				
			        lec_nm : lec_nm
				,	currentPage : currentPage
				,	pageSize : pageSizeComnDtlCod
		}
		
		var resultCallback = function(data) {
			flistDtlCodResult(data, currentPage);
		};
		
		callAjax("/adm/studentList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 학생목록 조회 콜백 함수 */
	function flistDtlCodResult(data, currentPage) {
		
		// 기존 목록 삭제
		$('#listComnDtlCod').empty(); 
		
		var $data = $( $(data).html() );

		// 신규 목록 생성
		var $listComnDtlCod = $data.find("#listComnDtlCod");		
		$("#listComnDtlCod").append($listComnDtlCod.children());
		
		// 총 개수 추출
		var $totalCntComnDtlCod = $data.find("#totalCntComnDtlCod");
		var totalCntComnDtlCod = $totalCntComnDtlCod.text(); 
		
	   // 페이지 네비게이션 생성
		var grp_cod = $("#tmpGrpCod").val();
		var grp_cod_nm = $("#tmpGrpCodNm").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCntComnDtlCod, pageSizeComnDtlCod, pageBlockSizeComnDtlCod, 'fListComnDtlCod', [grp_cod]);
		$("#comnDtlCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageComnDtlCod").val(currentPage);
	}
	
	 // 학생목록 검색기능
	function board_search2(currentPage) {
		
	    var searchTitle = $('#searchStudent').val(); // 학생명
	    var startDate = $('#searchstdate').val(); // 가입일자
	    var endDate = $('#searcheddate').val();   // 가입일자
	   
        currentPage = currentPage || 1;
	
	    console.log("currentPage : ", currentPage);     
	
	    var param = {
	    	
	        searchStudent: searchTitle, 
	    	searchstdate: startDate, 
		    searcheddate: endDate,  
	        currentPage: currentPage,
	        pageSize: pageSizeComnDtlCod
	    };
	
	    console.log("param : ", param);    
	    
	    var resultCallback = function(data) {
	    	flistDtlCodResult(data, currentPage); 
	    };
	
	    callAjax("/adm/studentList.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 학생관리 모달 실행 */
	function fPopModalComnDtlCod(user_no) {
		
		    // Tranjection type 설정
			$("#action").val("I");
			
			// 모달 팝업
			gfModalPop("#layer1");

			// 상세코드 단건 조회
			fSelectDtlCod(user_no);
		
	}
	
	
	/** 학생정보 단건 조회 */
	function fSelectDtlCod(user_no) {

		var param = {
				user_no : user_no
		};
		
		var resultCallback = function(data) {
			studentData = data; // 응답 데이터를 전역 변수에 저장
			fSelectDtlCodResult(data);
			console.log("studentData:", studentData); // studentData 값 출력
		};
		
		callAjax("/adm/selectStudent.do", "post", "json", true, param, resultCallback);
	}
	
	
	/** 학생정보 조회 콜백 함수*/
	function fSelectDtlCodResult(data) {

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");
			
			// 그룹코드 폼 데이터 설정
			fInitFormDtlCod(data.selectData);
			
		   console.log("data.selectData",data.selectData);
			
			//수강내역조회
			lectureList(data.selectData.user_no);
			
			console.log("data.selectData.user_no", data.selectData.user_no);
			
	} else {
			swal(data.resultMsg);
		}	
	}
	
	/** 학생정보 폼 초기화 */
	function fInitFormDtlCod(data) {

		if(data != null) {
			
	        $("#loginID").text(data.loginID);
	        $("#user_no").text(data.user_no);
	        $("#name").text(data.name);
	        $("#user_birth").text(data.user_birth);
	        $("#user_phone").text(data.user_phone);
	        $("#user_gender").text(data.user_gender);
	        $("#user_email").text(data.user_email);
	        $("#user_location").text(data.user_location);
	        
		} else {
			
			  $("#loginID").text("");
		      $("#user_no").text("");
		      $("#name").text("");
		      $("#user_birth").text("");
		      $("#user_phone").text("");
		      $("#user_gender").text("");
		      $("#user_email").text("");
		      $("#user_location").text("");
		}
	}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/**수강내역 */
	function lectureList(user_no) {
	
		var param = {
	        user_no : user_no
	    };

		var resultCallback = function(data) {
			lectureListResult(data);
		};

		callAjax("/adm/selectLectureList.do", "post", "text", true, param,
				resultCallback);
	}

	/**수강내역 콜백함수 */
	function lectureListResult(data) {
	
       // 기존 목록 삭제
		$('#slec_list').empty();

		// 신규 목록 생성
		$('#slec_list').append(data);
	}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/** 수강등록 모달 실행 */
	function fPopModal_std_lec_reg() {
		
		
			// Tranjection type 설정
			$("#action").val("I");
			
			// 모달 팝업
			gfModalPop("#layer2");
			
			// 미수강 목록조회
			notLectureList(studentData.selectData.user_no);
			console.log("studentData.selectData.user_no", studentData.selectData.user_no);
	}
	
	/** 미수강 목록조회 */
	function notLectureList(data) {
		
		console.log("data", data)
		
	    var param = {
				
			   user_no : data
		}
		
		var resultCallback = function(data) {
	         notLectureListResult(data);
		};
		
		callAjax("/adm/notLectureList.do", "post", "json", true, param, resultCallback);
	}
	
	/** 미수강 목록 콜백 함수 */
	function notLectureListResult(dataResult) {
	    console.log("dataResult", dataResult);
	
	    // 기존 목록 삭제
	    $('#reg_lec').empty();
	
	    // 옵션 요소 생성 및 추가
	    $.each(dataResult.listdata, function(index, item) {
	        var option = $('<option>').val(item.lec_no).text(item.lec_nm + ' (' + item.lec_date + ')');
	        $('#reg_lec').append(option);
	    });
	    
	    //$('#user_no2').val(dataResult.listdata.user_no);
	    $('#lec_no').val(dataResult.listdata.lec_no);
	   }
	
	/** 선택한 lec_no를 가져오기*/
	  $(document).ready(function() {
          // #reg_lec의 변경 이벤트 핸들러 등록
          $('#reg_lec').change(function() {
              var selectedLecNo = $(this).val(); // 선택한 강의 번호 가져오기
              console.log("선택한 강의 번호:", selectedLecNo); // 콘솔에 선택한 강의 번호 출력
              $('#lec_no').val(selectedLecNo); // 선택한 강의 번호를 감춘 input 필드에 설정
          });
      });
	  
	/** 학생 수강등록 저장 */
	function stdLecReg(){
		
	// 학생 데이터에서 user_no 가져오기
	 var userNo = studentData.selectData.user_no;
	   
	 console.log("선택한 유저 번호:", userNo); 
	
    // user_no 값을 hidden 필드로 설정
	$('#user_select').val(userNo);
		
	 var resultCallback = function(response) {
			std_lec_reg_result(response);
		}
		callAjax("/adm/adminLectureSave.do", "post", "json", true, $("#lec_reg_form").serialize(), resultCallback);
	}
	

	/** 수강등록 저장 콜백 함수 */
	function std_lec_reg_result(response) {
		
		//수강신청 성공
    	if (response.result == "S") { 
    		 
    		alert("정말로 등록하시겠습니까?");
        	alert(response.resultmsg);
        	gfCloseModal();
           
        //수강인원 마감
    	} else if (response.result == "E") {
            alert(response.resultmsg);
            
        //수강신청 실패
    	} else {
        	alert("수강신청에 실패하였습니다.");
        }
    } 
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageComnGrpCod" value="1">
	<input type="hidden" id="currentPageComnDtlCod" value="1">
	<input type="hidden" id="tmpGrpCod" value="">
	<input type="hidden" id="tmpGrpCodNm" value="">
	<input type="hidden" name="action" id="action" value="">
	
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
								class="btn_nav bold">인원관리</span> <span class="btn_nav bold">학생관리
								</span> <a href="../adm/studentControl.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>강의목록</span> <span class="fr"> 
							<div>
	  	                          <strong>강의명 : </strong>
	  	                          <input type="text" id="searchtitle" name="searchtitle" style="height: 25px; margin-right: 10px;"/>
	  	                         <a class="btnType blue" href="javascript:board_search(1);" ><span>검색</span></a>
							</div>	
							</span>
						</p>
						<br>
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="45%">
									<col width="45%">
							  </colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">강의명</th>
										<th scope="col">기간</th>
									</tr>
								</thead>
								<tbody id="listComnGrpCod"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
						
					
                       <p class="conTitle mt50">
							<span>학생관리</span> <span class="fr"> 
							<div>
	  	                          <strong>학생명 : </strong>
	  	                          <input type="text" id="searchStudent" name="searchStudent" style="height: 25px; margin-right: 10px;"/>
	  	                          <strong>가입일자 : </strong>
	  	                          <input type="date" id="searchstdate" name="searchstdate" style="height:28px;" /> ~ 
	  	                          <input type="date" id="searcheddate" name="searcheddate" style="height: 28px; margin-right: 10px;" />
	  	                          <a class="btnType blue" href="javascript:board_search2(1);" ><span>검색</span></a>
							  </div>	
							</span>
						</p>
	                   <br>
	                   
						<div class="divComDtlCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="10%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">회원번호</th>
										<th scope="col">수강강의</th>
										<th scope="col">학생명</th>
										<th scope="col">휴대전화</th>
										<th scope="col">가입일자</th>
									</tr>
								</thead>
								<tbody id="listComnDtlCod">
								</tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="comnDtlCodPagination"> </div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</form>
	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>학생 정보</strong>
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
							<th scope="row">ID <span class="font_red">*</span></th>
							<td colspan="3"><span id="loginID" ></span></td>
							<th scope="row">회원번호 <span class="font_red">*</span></th>
							<td colspan="3"><span id="user_no" ></span></td>
						</tr>
						<tr>
							<th scope="row">이름 <span class="font_red">*</span></th>
							<td colspan="3"><span id="name" ></span></td>
							<th scope="row">생년월일 <span class="font_red">*</span></th>
							<td colspan="3"><span id="user_birth" ></span></td>
						</tr>
						<tr>
							<th scope="row">전화번호 <span class="font_red">*</span></th>
							<td colspan="3"><span id="user_phone" ></span></td>
							<th scope="row">성별 <span class="font_red">*</span></th>
							<td colspan="3"><span id="user_gender" ></span></td>
						</tr>
						<tr>
							<th scope="row">이메일 <span class="font_red">*</span></th>
							<td colspan="5"><span id="user_email" ></span></td>
						</tr>
						<tr>
							<th scope="row">거주지역 <span class="font_red">*</span></th>
							<td colspan="5"><span id="user_location" ></span></td>
						</tr>
						<tr>
								<td colspan="6">
									<p class="conTitle mt20">
										<span>수강 내역</span>
										<span class="fr" style="margin-right:20px"> 
									<a class="btnType3 color2" href="javascript:fPopModal_std_lec_reg()"><span>수강 등록</span></a>
									</span>
									</p>
									
									<table class="col">
										<caption>caption</caption>
										<colgroup>
											<col width="10%">
											<col width="15%">
											<col width="20%">
											<col width="10%">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">강의번호</th>
												<th scope="col">강의명</th>
												<th scope="col">기간</th>
												<th scope="col">승인여부</th>
											</tr>
										</thead>
										<tbody id="slec_list"></tbody>
									</table>
								</td>
							</tr>
					</tbody>
				</table>
		<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
	</div>
	<!--// 모달팝업 -->
	
	<!-- 모달팝업2 -->
	<form id="lec_reg_form">
       <div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" name="action" id="" value="U">
		<input type="hidden" name="user_no" id="user_select" >
			<dl>
				<dt>
					<strong>수강 등록</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tbody>
							<tr>
								<th>과정선택</th>
								<td colspan="4">
								<select id="reg_lec" name="lec_no" style="width:350px">
									<c:forEach items="${listdata}" var="item">
										<option value="${item.lec_no}"> ${item.lec_nm} (${item.lec_date})</option>
									</c:forEach>
								</select>
								</td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->
                    <div class="btn_areaC mt30">
						<a href="" id="btnInsert" class="btnType blue" name="btn"><span>수강 등록</span></a>
						<a href="" class="btnType gray" id="btnCloseDtlCod" ><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
	<!--// 모달팝업2 -->

</body>
</html>

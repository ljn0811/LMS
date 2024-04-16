<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>
<!-- sweet alert import -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- sweet swal import -->

<style>

	.center {
    	display: flex;
    	align-items: center;
	}    
  
	#searchgrouptype,
	#searchTitle,
	#searchStartDate,
	#searchEndDate,
	#searchbtn {
    	height: 35px; /* 원하는 높이로 설정하세요 */
    	margin-right: 20px; /* 원하는 간격으로 조정하세요 */
	}
	
	#searchbtn {
        margin-left: auto; /* 오른쪽으로 정렬 */
    }

	tbody th, 
	tbody td {
    	font-family: 'Arial', Nunito; /* 사용할 폰트명 설정 */
    	font-size: 14px; /* 폰트 크기 설정 */
    /* 추가적인 스타일링을 원하면 여기에 추가하세요 */
	}

	span, th, td {
    	color: #000; /* 진한 색상 코드를 여기에 입력하세요 */
	}
	
	body, select, input, textarea {
    	font-family: 'Arial', 'Nunito', sans-serif;
        font-size: 14px;
    }

	.error-message {
		color: red;
	}
</style>

<script type="text/javascript">
   
    var pagesize = 10;
    var pageblocksize = 10;
   
	/** OnLoad event */ 
	$(function() {
		registerListControlSearch();	
		
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchbtn").click(function(e) {
			e.preventDefault();
			
			registerListControlSearch();	
			
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
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnUpdate' :
					Save();
					break;
			}
		}); 
		
	}

	function registerListControlSearch(cpage) {
		
	    cpage = cpage || 1;

	    var searchType = $("#searchgrouptype").val();
	    var searchValue = $("#searchTitle").val();
	    var searchStartDate = $("#searchStartDate").val();
	    var searchEndDate = $("#searchEndDate").val();
	    
	    // 각 검색 조건에 해당하는 변수 설정
	    var searchUserName = null;
	    var searchLectureName = null;

	    // 검색 조건 설정
	    switch (searchType) {
	        case "searchUserName":
	            searchUserName = searchValue;
	            break;
	        case "searchLectureName":
	            searchLectureName = searchValue;
	            break;
	        // 추가 검색 조건이 있을 경우 여기에 추가
	        default:
	            break;
	    }

	    var param = {
	        searchUserName: searchUserName,
	        searchLectureName: searchLectureName,
	        searchStartDate: searchStartDate,
	        searchEndDate: searchEndDate,
	        cpage: cpage,
	        pagesize: pagesize,
	    }
		
		var listcallback = function(respose) {
			console.log(respose);		
			$("#listRegisterListControltbody").empty().append(respose);
			
			var paginationHtml = getPaginationHtml(cpage, $("#listCnt").val(), pagesize, pageblocksize, 'registerListControlSearch');
			console.log("paginationHtml : " + paginationHtml);
	
			$("#registerListControlPagination").empty().append( paginationHtml );
			
			$("#cpage").val(cpage);
		}
		
		callAjax("/adm/registerListControlList.do", "post", "text" , false, param, listcallback);
		
	}
	
	/*강의계획서 등록*/
	function registerListControlSave() {
		// gfCloseModal();\
		init();
		gfModalPop("#registerListControlDetail");
	}

	function init(data) {
		
	    var classroomSelect = $("#classroom_no");
	    console.log(classroomSelect);
	    
		if(data != null) {
			$("#lec_no").val(data.lec_no);
			$("#user_name").val(data.name);
			$("#lec_nm").val(data.lec_nm);
			$("#lec_type").val(data.lec_type);
			$("#classroom_no").val("${classroomList.classroom_no}");
			$("#user_email").val(data.user_email);			
			$("#user_phone").val(data.user_phone);
			$("#lec_start").val(data.lec_start);
			$("#lec_end").val(data.lec_end);
			$("#learn_goal").val(data.learn_goal);
			$("#attendance_notice").val(data.attendance_notice);
			$("#learn_plan").val(data.learn_plan);
			$("#btnDelete").show();
			$("#btnUpdate").show();
			$("#btnSave").hide();
			$("#action").val("U");	
		} else {
			$("#lec_no").val("");
			$("#user_name").val("${lecUserInfo.name}");
 			$("#lec_nm").val("");
 			$("#lec_nm2").hide();
			$("#lec_type").val("");
			$("#classroom_no").val("");
			$("#user_email").val("");	
			$("#user_phone").val(""); 
			$("#lec_start").val("");
			$("#lec_end").val("");
			$("#learn_goal").val("");
			$("#attendance_notice").val("");
			$("#learn_plan").val("");
			$("#btnDelete").hide();
			$("#btnUpdate").hide();
			$("#btnSave").show();
			$("#action").val("I");	
			
			gfModalPop("#registerListControlDetail");
		}
	}
	

	function modify(lec_no) {

		var param = {
			lec_no : lec_no
		}
			
		console.log(lec_no);
			
		var detailCallback = function(response) {
			console.log(JSON.stringify(response));

			init(response.selinfo);
			/*alert("데이터보여줘" + classroom_no); */
			gfModalPop("#registerListControlDetail");
		}
		
		callAjax("/adm/registerListControlDetail.do", "post", "json" , false, param, detailCallback);
		
	}
	
	function Save() {
		
		if(!fValidate()) {
			return;
		}
		
		var param = {
			lec_no : $("#lec_no").val(),
			lec_nm : $("#lec_nm").val(),
			lec_type : $("#lec_type").val(),
			user_no : $("#user_no").val(),
            lec_start : $("#lec_start").val(),
            lec_end : $("#lec_end").val(),
            user_phone : $("#user_phone").val(),
            user_email : $("#user_email").val(),
			classroom_no : $("#classroom_no").val(),
			learn_goal : $("#learn_goal").val(),
			attendance_notice : $("#attendance_notice").val(),
			action : $("#action").val(),
		} 
		
		var saveCallback = function(response) {
			console.log(JSON.stringify(response));
			// {"result":"S","resultmsg":"저장 되었습니다."}
			alert(response.resultmsg);
			
			if(response.result == "S") {
				gfCloseModal();
				if($("#action").val() == "I") {
					registerListControlSearch();
				} else {
					registerListControlSearch($("#cpage").val());
				}
			}
		}
		
		callAjax("/adm/registerListControlSave.do", "post", "json" , false, param, saveCallback);
	
	}
	
	function fValidate() {

		var chk = checkNotEmpty(
				[	
				 		[ "lec_start" , "강의 시작일을 입력해 주세요."]
				 	,	[ "lec_end"   , "강의 종료일을 입력해 주세요."]	
				 	,	[ "learn_goal", "수업목표를 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	function Delete() {		
		$("#action").val("D");		
		Save();		
	}

</script>

</head>
<body>

<form id="myForm" action=""  method="">
    <input type="hidden"  id="action"  name="action"  value="" />
    <input type="hidden"  id="lec_no"  name="lec_no"  value="" />
    <input type="hidden"  id="user_no"  name="user_no"  value="${lecUserInfo.user_no}" />
    <input type="hidden"  id="cpage"  name="cpage"  value="" />


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
							 <span class="btn_nav bold">학습지원</span> <span class="btn_nav bold">강의 관리</span> 
							<a href="../adm/registerListControlList.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle">
							<span>강의 관리</span>
						</p>
						
						<div class="center">
							<select id="searchgrouptype" name="searchgrouptype" style="width: 100px;">
								<option value="searchLectureName">과목명</option>
								<option value="searchUserName">강사명</option>
							</select>
 						
 							<input type="text" id="searchTitle" name="searchTitle" style="width: 400px;" 
 								onkeydown="if (event.keyCode === 13) document.getElementById('searchbtn').click()">
								작성일 &nbsp;&nbsp;&nbsp;
    						<input type="date" id="searchStartDate" name="searchStartDate" />
    						<input type="date" id="searchEndDate" name="searchEndDate" />
   								<a class="btnType red" href="" name="searchbtn" id="searchbtn">
									<span>검색</span>
								</a>
						</div>
					
					<br> <!-- 공백 추가 -->
					
					<div style="text-align: right;">
   						<a class="btnType blue" href="javascript:void(0);" onclick="modify()">
        					<span>강의 등록</span>
   						</a>
					</div>
					
					<br> <!-- 공백 추가 -->
					
						<div class="lecturePlanList">
							<table class="col" >
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="20%">
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="8%">
									<col width="5%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">분류</th>
										<th scope="col">과목</th>
										<th scope="col">강사명</th>
										<th scope="col">강의시작일</th>
										<th scope="col">강의종료일</th>
										<th scope="col">신청인원</th>
										<th scope="col">정원</th>
									</tr>
								</thead>
								<tbody id="listRegisterListControltbody"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="registerListControlPagination"> </div>
	
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>



	<!-- 강의계획서 등록 -->
	<div id="registerListControlDetail" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>강의 관리</strong>
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
					<th>과목</th>
					<td>
						<select value="list"  id="lec_nm" >
							<option style = "width: 100px;">자바</option>
							<option style = "width: 100px;">자바스크립트</option>
							<option style = "width: 100px;">React</option>
							<option style = "width: 100px;">뷰</option>	
						</select>
					</td>
					<th>분류</th>
					<td>
						<select value="list"  id="lec_type" >
							<option style = "width: 100px;">실업자교육</option>
							<option style = "width: 100px;">직장인교육</option>	
						</select>
					</td>
				</tr>
				<tr style="padding-bottom: 200px;">
            		<th scope="row" >강사명</th>
            		<td>
            			<input type="text" class="inputTxt p100" name="user_name" id="user_name" />
					</td>
            		<th scope="row" >강의실</th>
 					<td>
						<%-- <select id="classroom_no" name="classroom_no">
							<!-- 강의실 정보를 받아온 경우 -->
							<c:if test="${not empty classroomList}">
							<!-- 강의실 리스트를 반복하면서 옵션을 생성 -->
								<c:forEach items="${classroomList}" var="classList">
  									<option value="${classList.classroom_no}">${classList.classroom_nm}</option>
								</c:forEach>
							</c:if>
							<!-- 강의실 정보를 받아오지 못한 경우 -->
        					<c:if test="${empty classroomList}">
								<option value="">강의실 정보를 불러올 수 없습니다.</option>
							</c:if>
						</select> --%>
					</td> 
				</tr>	
				<tr>
					<th scope="row">이메일</th>
					<td>
						<input type="text" style="font-size: 14px;" class="inputTxt p100"  name="user_email" id="user_email" placeholder="example@example.com" />  
					</td>	
					<th scope="row">연락처</th>
					<td>
						<input type="text" class="inputTxt p100" name="user_phone" id="user_phone" placeholder="010-1234-5678" />
					</td>							
				</tr>
				<tr>
    				<th scope="row">강의시작일</th>
    				<td><input type="date" class="inputTxt p100" style="font-size: 14px;" name="lec_start" id="lec_start"></td>
    				<th scope="row">강의종료일</th>
    				<td><input type="date" class="inputTxt p100" style="font-size: 14px;" name="lec_end" id="lec_end"></td>
				</tr>	
				<tr>
					<th scope="row">수업목표</th>
 					<td colspan="3"><textarea  name="learn_goal" id="learn_goal"  cols="40" rows="5"> </textarea>							
        		</tr>	
        		<tr>
					<th scope="row">출결공지</th>
					<td colspan="3"><textarea  name="attendance_notice" id="attendance_notice"  cols="40" rows="5"> </textarea>							
				</tr>
			</tbody>
			</table>
			
			<div id="error-message" class="error-message" style="display: none;"></div>
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

</form>
</body>
</html>
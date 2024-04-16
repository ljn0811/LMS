<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>수강생 관리</title>
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
	
	body, select, textarea {
    	font-family: 'Arial', 'Nunito', sans-serif;
        font-size: 14px;
    }

	.error-message {
		color: red;
	}
	
	td input {
    	width: 100%;
    	 height: 100%;
	}

</style>

<script type="text/javascript">
   
    var pagesize = 10;
    var pageblocksize = 10;
   
	/** OnLoad event */ 
	$(function() {
		lecturePlanSearch();	
		
		fRegisterButtonClickEvent();
		
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchbtn").click(function(e) {
			e.preventDefault();
			
			lecturePlanSearch();	
			
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
				case 'btnWeekDelete' :
					weekDelete();
					break;
				case 'btnWeekAdd' :
					weekAdd();
					break;
				case 'btnWeekSave':
					lecturePlanWeekPlanSave();
					gfCloseModal();
					break;
			}
		}); 
	}

	function lecturePlanSearch(cpage) {
	    
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
			$("#listLecturePlantbody").empty().append(respose);
			
			var paginationHtml = getPaginationHtml(cpage, $("#listCnt").val(), pagesize, pageblocksize, 'lecturePlanSearch');
			console.log("paginationHtml : " + paginationHtml);
	
			$("#lecturePlanPagination").empty().append( paginationHtml );
			
			$("#cpage").val(cpage);
		}
		
		callAjax("/tut/lecturePlanList.do", "post", "text" , false, param, listcallback);
		
	}
	
	/*강의계획서 등록*/
	function lecturePlanSave() {
		// gfCloseModal();\
		init();
		gfModalPop("#lecturePlanDetail");
	}

	function init(data) {
							
		if(data != null) {
			$("#lec_no").val(data.lec_no);
			$("#user_name").val(data.name);
			$("#lec_nm").val(data.lec_nm);
			$("#lec_type").val(data.lec_type);
			$("#classroom_no").val(data.classroom_no);
			$("#user_email").val(data.user_email);			
			$("#user_phone").val(data.user_phone);
			$("#lec_start").val(data.lec_start);
			$("#lec_end").val(data.lec_end);
			$("#learn_goal").val(data.learn_goal);
			$("#attendance_notice").val(data.attendance_notice);
			$("#learn_plan").val(data.learn_plan);
			$("#learn_content").val(data.learn_content);
			$("#btnDelete").show();
			$("#action").val("U");
			$("#weekPlan").empty();
		} else {
			$("#lec_no").val("");
			$("#user_name").val("");
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
			$("#action").val("I");	
			
			gfModalPop("#lecturePlanDetail");
		}
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
			/* classroom_no : $("#iclassroom_no").val(), */
			learn_goal : $("#learn_goal").val(),
			attendance_notice : $("#attendance_notice").val(),
			learn_plan : $("#learn_plan").val(),
			action : $("#action").val(),
		} 
		
		var saveCallback = function(response) {
			console.log(JSON.stringify(response));
			// {"result":"S","resultmsg":"저장 되었습니다."}
			alert(response.resultmsg);
			
			if(response.result == "S") {
				gfCloseModal();
				if($("#action").val() == "I") {
					lecturePlanSearch();
				} else {
					lecturePlanSearch($("#cpage").val());
				}
			}
		}
		
		callAjax("/tut/lecturePlanSave.do", "post", "json" , false, param, saveCallback);
	
	}
	
	function Delete() {		
		$("#action").val("D");		
		Save();		
	}

	function fValidate() {

		var chk = checkNotEmpty(
				[	
				 		[ "lec_start" , "강의 시작일을 입력해 주세요."]
				 	,	[ "lec_end"   , "강의 종료일을 입력해 주세요."]	
				 	,	[ "learn_goal", "수업목표를 입력해 주세요" ]
					,	[ "attendance_notice", "출결공지를 입력해 주세요" ]
					,	[ "learn_plan", "강의계획을 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	function modify(lec_no) {

	    var param = {
	            lec_no: lec_no
	        };

	    var detailCallback = function(response) {
	        console.log(JSON.stringify(response));
	        alert("checkWeek"+response.checkWeek);
	        // 모달 팝업 내용을 초기화합니다.
	        clearModalContent();

	        // 새로운 내용으로 모달 팝업을 채웁니다.
	        init(response.selinfo);
	        fillWeekPlan(response.weekPlan);
	        if(response.checkWeek>0){
	        	alert("0보다 큽니다.");
	        	$("#action").val("X");
	        }

	        // 모달 팝업을 엽니다.
	        gfModalPop("#lecturePlanDetail");
	    };
		
		callAjax("/tut/lecturePlanDetail.do", "post", "json" , false, param, detailCallback);
		
	}
	
	function clearModalContent() {
	    // 예시: 주간 계획 테이블을 비웁니다.
	    $('#weekPlan').empty();
	}

	// 주간 계획 정보를 모달 팝업에 채우는 함수
	function fillWeekPlan(weekPlan) {
		var tableBody = $('#weekPlan');
    	
		$.each(weekPlan, function(index, plan) {
        	var row = $('<tr>');
        	row.append($('<td>').attr('class', 'week').attr('name','week').text(plan.week).css('color', 'red'));
        	row.append($('<td>').append($('<input>').attr('type', 'text').attr('name', 'learn_plan').attr('class', 'learn_plan').val(plan.learn_plan)));
        	row.append($('<td>').append($('<input>').attr('type', 'text').attr('name', 'learn_content').attr('class', 'learn_content').val(plan.learn_content)));
        	tableBody.append(row);
    	});
	}

	/* 주차 계획 추가  */
	function weekAdd() {
		var trCnt = $('#week_table tr').length;

		var innerHtml = "";
		innerHtml += '<tr>';
		innerHtml += '    <td class="week">' + trCnt + "주차" + '</td>';
		innerHtml += '    <td><input type="text" name="learn_plan" class="inputTxt p100 learn_plan"></td>';
		innerHtml += '    <td><input type="text" name="learn_content" class="inputTxt p100 learn_content"></td>';
		innerHtml += '</tr>';

		$('#week_table > tbody:last').append(innerHtml);
	}

	//주간 계획 저장
	function lecturePlanWeekPlanSave() {
	    if (!fValidate()) {
	        return;
	    }

	    
	    var lec_no = $("#lec_no").val();
	    var week = [];
	    var learn_plan = [];
	    var learn_content = [];
	
	    
	    
	    $(".week").each(function() {
	        week.push($(this).text());
	    });

	    alert("week"+ week);
	    
	    
	    $(".learn_plan").each(function() {
	        learn_plan.push($(this).val());
	    });

	    $(".learn_content").each(function() {
	        learn_content.push($(this).val());
	    });
		alert($("#action").val());
	    var param = {
	        lec_no: lec_no,
	        week : week,
	        learn_plan: learn_plan,
	        learn_content: learn_content,
	        action : $("#action").val()
	    };

	    var wSaveCallback = function(response) {
	        console.log(JSON.stringify(response));
	        
	        alert(response.resultMsg);

	        if ($("#action").val() == "I") {
	                lecturePlanSearch();
	            } else {
	                lecturePlanSearch($("#cpage").val());
	            }
	        }

	    callAjax("/tut/lecturePlanWeekPlanSave.do", "post", "json", false, param, wSaveCallback);
	}
		
	//주간 계획 삭제
	function weekDelete() {
		var trCnt = $('#week_table tr').length;

		if ($("#action").val() != "I") {
			alert($("#lec_no").val());
			var lec_no = $("#lec_no").val();
			var week = $('#week_table > tbody:last > tr:last td:first-child').text();
			console.log("week:" + $('#week_table > tbody:last > tr:last .week').text());

			$.ajax({
				url : "lecturePlanWeekPlanDelete.do",
				type : "post",
				data : {
					lec_no : lec_no,
					week : week
				},
				success : function(result) {
					alert(result.resultMsg);
				}

			});
			$('#week_table > tbody:last > tr:last').remove();
		} else {
			$('#week_table > tbody:last > tr:last').remove();
		}
	}

</script>

</head>
<body>

<form id="myForm" action=""  method="">
    <input type="hidden"  id="action"  name="action"  value="" />
    <input type="hidden"  id="lec_no"  name="lec_no"  value="" />
    <input type="hidden" id="tmp_lec"  name="lec_no"  value="">
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
							 <span class="btn_nav bold">학습지원</span> <span class="btn_nav bold">강의계획서 관리</span> 
							<a href="../tut/lecturePlan.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle">
							<span>강의계획서 관리</span> 
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
					
<!-- 					<div style="text-align: right;">
   						<a class="btnType blue" href="javascript:void(0);" onclick="modify()">
        					<span>강의계획서 등록</span>
   						</a>
					</div> -->
					
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
								<tbody id="listLecturePlantbody"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="lecturePlanPagination"> </div>
	
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 강의계획서 등록 -->
	<div id="lecturePlanDetail" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>강의계획서 관리</strong>
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
						<!-- 등록 -->
						<select id="classroom_no" name="classroom_no">	
							<c:forEach items="${listData}" var="list">
									<option value="${list.classroom_no}">${list.classroom_no}</option>
							</c:forEach>
						</select>
					</td>		
				</tr>	
        		<tr>
					<th scope="row">이메일</th>
            		<td>
                		<input type="text" style="font-size: 14px;" class="inputTxt p100"  name="user_email" id="user_email" />  
            		</td>	
	                    <th scope="row">연락처</th>
					<td>
						<input type="text" class="inputTxt p100" name="user_phone" id="user_phone" />
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
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			
			<dl>
			<dd class="content">
				<a href="" class="btnType blue" id="btnWeekAdd" name="btn">
					<span>주차 추가</span>
				</a>
				<a href="" class="btnType red" id="btnWeekDelete" name="btn">
					<span>주차 삭제</span>
				</a>

				<table id="week_table" class="col2 mb10">
					<thead>
						<tr>
							<th scope="col">주차수</th>
							<th scope="col">학습목표</th>
							<th scope="col">학습내용</th>
						</tr>
					</thead>
				<tbody id="weekPlan">
				<!-- 주차 목록 데이터를 여기에 동적으로 추가 -->
					<c:forEach var="week" items="${weekPlan}">
						<tr>
            			<td>
                			<input type="text" class="inputTxt p100 week" name="week" value="${week.week}" style="border:1px solid red;"/>
            			</td>
           				<td>
                			<input type="text" class="inputTxt p100 learn_plan" name="learn_plan" value="${week.learn_plan}" style="border:1px solid red;"/>
            			</td>
            			<td>
                			<input type="text" class="inputTxt p100 learn_content" name= "learn_content" value="${week.learn_content}" style="border:1px solid red;"/>
            			</td>
       					</tr>
					</c:forEach>
				</tbody>
				</table>

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnWeekSave" name="btn"><span>저장</span></a>
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
			</dl>
				<!-- e : 여기에 내용입력 -->
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->
</form>
</body>
</html>
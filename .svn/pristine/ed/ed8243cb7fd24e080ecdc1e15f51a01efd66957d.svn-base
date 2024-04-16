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

</style>


<script type="text/javascript">
   
    var pagesize = 10;
    var pageblocksize = 10;
   
	/** OnLoad event */ 
	$(function() {
	
		learningMaterialsSearch();	
		
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchbtn").click(function(e) {
			e.preventDefault();
			
			learningMaterialsSearch();	
			
		});
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
          
			switch (btnId) {
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnSaveFile' :
					fSave();
					break;	
				case 'btnDeleteFile' :
					fDelete();
					break;	
			}
		}); 
	}
	
	function learningMaterialsSearch(cpage) {
		
		cpage = cpage || 1;
		
		var param = {
				searchTitle : $("#searchTitle").val(),
				searchStartDate : $("#searchStartDate").val(),
				searchEndDate : $("#searchEndDate").val()	,
				cpage : cpage,
				pagesize : pagesize,
		}
		
		var listCallback = function(respose) {
			console.log(respose);		
			
			$("#listLearningMaterialstbody").empty().append(respose);
					
			var paginationHtml = getPaginationHtml(cpage, $("#listCnt").val(), pagesize, pageblocksize, 'learningMaterialsSearch');
			console.log("paginationHtml : " + paginationHtml);
	
			$("#learningMaterialsPagination").empty().append( paginationHtml );
			
			$("#cpage").val(cpage);
		}
		
		callAjax("/tut/learningMaterialsList.do", "post", "text" , false, param, listCallback);
		
	}

   /*학습자료 등록*/
  	function learningMaterialsRegisterFile() {
	   finit();
	   gfModalPop("#fiflePopup");
   }
   
	function finit(data) {		
				
		if(data != null) {
			$("#material_title").val(data.material_title);	
			$("#material_content").val(data.material_content);
			$("#file_name2").val(data.file_name);
			$("#btnDeleteFile").show();
			$("#material_no").val(data.material_no);
			$("#action").val("U");	
			$("#file_name").val("");
			
			if(data.file_name != null) {
				//alert("파일선택");
				var ext = data.file_ext.toLowerCase();
				var imgpath = "";
	
				if(ext == "jpg" || ext == "gif" || ext == "png") {
					imgpath = data.relative_path;					
					///alert(imgpath);	
				}
			}
		
		} else {
			$("#material_title").val("");
			$("#material_content").val("");
			$("#material_no").val("");
			$("#btnDeleteFile").hide();
			$("#action").val("I");		
			$("#file_name").val("");
			$("#file_name2").val("");
		}
	}
   
	function fSave() {
		
		if(!fValidatefile()) {
			return;
		}
/* 		
		var param = {
				notice_no : $("#notice_no").val(),
				ititle : $("#ititle").val(),
				icontent : $("#icontent").val(),
				action : $("#action").val(),
		}
		 */
		 var frm = document.getElementById("myForm");
		 frm.enctype = 'multipart/form-data';
		 var fileData = new FormData(frm);		 
		 
		var saveFileCallback = function(response) {
			console.log(JSON.stringify(response));
			// {"result":"S","resultmsg":"저장 되었습니다."}
			alert(response.resultmsg);
			
			if(response.result == "S") {
				
				gfCloseModal();
				if($("#action").val() == "I") {
					learningMaterialsSearch();
				} else {
					learningMaterialsSearch($("#cpage").val());
				}
			}
		}
		
		callAjaxFileUploadSetFormData("/tut/learningMaterialsSaveFile.do", "post", "json" , false, fileData, saveFileCallback);
		
	}
	
	function fValidatefile() {

		var chk = checkNotEmpty(
				[
						[ "material_title", "제목를 입력해 주세요." ]
					,	[ "material_content", "내용을 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	function fmodify(material_no) {
		
		var param = {
				material_no : material_no
		}
		
		console.log(material_no);
		
		var deleteCallback = function(response) {
			console.log(JSON.stringify(response));
			
			finit(response.selinfo);
			gfModalPop("#fiflePopup");
		}
		
		callAjax("/tut/learningMaterialsDetail.do", "post", "json" , false, param, deleteCallback);
	
	}
	
	function fDelete() {
		$("#action").val("D");		
		fSave();
	}


	$(document).ready(function() {
	    $("#file_name2").click(function() {
	        download();
	    });
	});
	
	function download() {	    
	    var material_no = $("#material_no").val();
	    
		var params = "<input type='hidden' name='material_no' value='"+ material_no +"' />";
	
/* 		alert("다운로드 폼이 눌러질까?"); */
		
		$("<form action='learningMaterialsDownload.do' method='post' id='fileDownload'>" + params + "</form>"
		).appendTo('body').submit().remove();
	
	} 
  ///////////////////////////////     파일 O    End //////////////////////////////////////
   
</script>

</head>
<body>
<form id="myForm" action=""  method="">
    <input type="hidden"  id="action"  name="action"  value="" />
    <input type="hidden"  id="material_no"  name="material_no"  value="" />
    <input type="hidden"  id="user_no"  name="user_no"  value="${learningMaterialsUserinfo.user_no}" />
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로 </a>
							 <span class="btn_nav bold">학습지원</span> 
							 <span class="btn_nav bold">학습자료 관리</span>
							 	<a href="../tut/learningMaterials.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>학습자료 관리</span> 
						</p>
						
					<div class="center">
						<select id="searchgrouptype" name="searchgrouptype" style="width: 100px;">
							<option value="material_title">제목</option>
    					</select>
    						<input type="text" id="searchTitle" name="searchTitle" style="width: 400px;" 
 								onkeydown="if (event.keyCode === 13) document.getElementById('searchbtn').click()">
   								작성일
   								&nbsp;&nbsp;&nbsp;
   						<input type="date" id="searchStartDate" name="searchStartDate" />
    					<input type="date" id="searchEndDate" name="searchEndDate" />
    					<a class="btnType red" href="" name="searchbtn" id="searchbtn">
        					<span>검색</span>
   			 			</a>
					</div>
					
					<br> <!-- 공백 추가 -->
					
					<div style="text-align: right;">
   						<a class="btnType blue" href="javascript:learningMaterialsRegisterFile();" name="modal">
        					<span>학습자료 등록</span>
   						</a>
					</div>
       
					<br> <!-- 공백 추가 -->
					
						<div class="learningMaterialsList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="50%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">작성일</th>
										<th scope="col">작성자</th>
									</tr>
								</thead>
								<tbody id="listLearningMaterialstbody"></tbody>
							</table>
						</div>
	                    
						<div class="paging_area"  id="learningMaterialsPagination"> </div>
						
					
						
			
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<div id="fiflePopup" class="layerPop layerType2" style="width: 700px;">
		<dl>
			<dt>
				<strong>학습자료 등록</strong>

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
 							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="material_title" id="material_title" /></td>
						</tr>
   						<tr>
        					<th scope="row">내용 <span class="font_red">*</span></th>
        					<td colspan="3"><textarea  name="material_content" id="material_content"  cols="40" rows="5"> </textarea></td>							
  				  		</tr>
						<tr>
							<th scope="row">파일</th>
							<td>
								<input type="file" class="inputTxt p100" name="file_name" id="file_name" />  
							</td>	
							<th scope="row">등록된 파일이름</th>
							<td>
								<input type="text" class="inputTxt p100" name="file_name2" id="file_name2" style="border: none;">
							</td>							
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveFile" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteFile" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	

	<!--// 모달팝업 -->
</form>
</body>
</html>
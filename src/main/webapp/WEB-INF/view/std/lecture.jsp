<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>강의목록</title>
<!-- sweet alert import -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
   
    var pagesize = 10;
    var pageblocksize = 10;
   
	/** OnLoad event */ 
	$(function() {
		comcombo("areaCD", "areasel", "sel", "");
		
		noticeseach();	
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchbtn").click(function(e) {
			e.preventDefault();
			
			noticeseach();	
			
		});
		
		$("#ffile").change(function(e) {
			e.preventDefault();
			
			//alert($("#ffile").val());
			// 파일선택  안할때
			// 파일이 이미지 경우, 아닌 경우
			// C:\fakepath\해피잡.jpg
			
			if($(this)[0].files[0]) {
				//alert("파일선택");
				var selfile = $("#ffile").val();
				var selfilearr = selfile.split(".");
				var ext = selfilearr[1].toLowerCase();
				var imgpath = "";
				var previewhtml = "";
				
				if(ext == "jpg" || ext == "gif" || ext == "png") {
					imgpath = window.URL.createObjectURL($(this)[0].files[0]);					
					///alert(imgpath);					
					previewhtml = "<img src='" + imgpath + "' id='imgFile' style='width: 100px; height: 100px;' />";					  
				} else {
					previewhtml = "";
				}
			} else {
				//alert("파일  선택  안함");
				previewhtml = "";
			}			
			  
			$("#preview").empty().append(previewhtml);		
			$('input:checkbox[id="fcheck"]').attr("checked", false); 
		});
		
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
          
			switch (btnId) {
				case 'btnSave' :
					Save();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnUpdate' :
					fUpdate();
					break;	
				case 'btnDelete' :
					fDelete();
					break;	
			}
		}); 
	}
	
	function noticeseach(cpage) {
		
		cpage = cpage || 1;
		
		var param = {
				searchtitle : $("#searchtitle").val(),
				searchstdate : $("#searchstdate").val(),
				searcheddate : $("#searcheddate").val(),
				searchstatus : $("#searchstatus").val(),
				cpage : cpage,
				pagesize : pagesize,
		}
		
		console.log(param);
		
		var listcallback = function(respose) {
			console.log(respose);		
			$("#listlecturebody").empty().append(respose);
			
			var paginationHtml = getPaginationHtml(cpage, $("#listcnt").val(), pagesize, pageblocksize, 'noticeseach');
			console.log("paginationHtml : " + paginationHtml);
	
			$("#lecturePagination").empty().append( paginationHtml );
			
			$("#cpage").val(cpage);
		}
		
		callAjax("/std/lecture.do", "post", "text" , false, param, listcallback);
		
	}
	

	function newreg() {
		init();
		gfModalPop("#layer1");
	}
	
	function modify(lec_no) {
		
		var param = {
				lec_no : lec_no
		}
		
		console.log(lec_no);
		
		var modifycallback = function(response) {
			console.log(JSON.stringify(response));
			
			// {"selinfo":{"lec_no":0,"test_no":0,"classroom_no":201,"user_no":0,"lec_nm":"자바강의","lec_max_cnt":50,"lec_cnt":16,"lec_etc":null,"lec_start":"2024-03-18","lec_end":"2024-04-17","lec_content":null,"learn_goal":0,"learn_plan":null,"name":"스티븐잡스"}}
			init(response.selinfo);
			gfModalPop("#layer1");
		}
		
		callAjax("/std/lectureDtl.do", "post", "json" , false, param, modifycallback);
		
		
	}
	
	function init(data) {	
		
		if(data != null) {
			$("#lec_no").text(data.lec_no);
			$("#lec_nm").text(data.lec_nm);
			$("#name").text(data.name);
			$("#classroom_no").text(data.classroom_no);
			$("#lec_cnt").text(data.lec_cnt);
			$("#lec_max_cnt").text(data.lec_max_cnt);
			$("#lec_start").text(data.lec_start);
			$("#lec_end").text(data.lec_end);
			$("#lec_content").text(data.lec_content);
			$("#learn_goal").text(data.learn_goal);
			$("#learn_plan").text(data.learn_plan);
			$("#btnDelete").show();
			$("#action").val("U");			
		} else {
			$("#lec_no").text("");
			$("#lec_nm").text("");
			$("#name").text("");
			$("#classroom_no").text("");
			$("#lec_cnt").text("");
			$("#lec_max_cnt").text("");
			$("#lec_start").text("");
			$("#lec_end").text("");
			$("#lec_content").text("");
			$("#learn_goal").text("");
			$("#learn_plan").text("");
		    $("#btnDelete").hide();
			$("#action").val("I");			
		}
	}
	
	function fSave(lec_no) {
		
	  var param = {
	        lec_no: lec_no,
	        action: 'U',
	    };

	    var saveCallback = function(response) {
	        
	    	//수강신청 성공
	    	if (response.result == "S") { 
	    		 alert("정말로 신청하시겠습니까?");
	        	alert(response.resultmsg);
	            if ($("#action").val() == "U") {
	                noticeseach();
	            } else {
	                noticeseach($("#cpage").val());
	            }
	        //수강인원 마감
	    	} else if (response.result == "E") {
	            alert(response.resultmsg);
	        //수강신청 실패
	    	} else {
	        	alert("수강신청에 실패하였습니다.");
	        }
	    };

	    // AJAX 요청 보내기
	    callAjax("/std/lectureSave.do", "post", "json", false, param, saveCallback);
	}
  
  function fDelete(lec_no) {
	  
		 alert("정말로 취소하시겠습니까?")
			
		var param = {
				    lec_no : lec_no,
				    action : 'D',
	   }
		
		   console.log(param);
			 
			var deleteCallback = function(response) {
			
				alert(response.resultmsg);
				
				if(response.result == "S") {
					gfCloseModal();
					if($("#action").val() == "D") {
						noticeseach();
					} else {
						noticeseach($("#cpage").val());
					}
				}
			}
			
			callAjax("/std/lectureDelete.do", "post", "json" , false, param, deleteCallback);
			
		}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
    <input type="hidden"  id="action"  name="action"  value="" />
    <input type="hidden"  id="lec_no"  name="lec_no"  value="" />
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
							<span class="btn_nav bold">학습지원</span> 
							<span class="btn_nav bold">강의목록</span> 
							<a href="../std/lectureList.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>강의목록</span> <span class="fr">
							<div>
	  	                          <strong>강의명 : </strong>
	  	                          <input type="text" id="searchtitle" name="searchtitle" style="height: 25px; margin-right: 10px;"/>
	  	                          <strong>강의기간 : </strong>
	  	                          <input type="date" id="searchstdate" name="searchstdate" style="height:28px;" /> ~ 
	  	                          <input type="date" id="searcheddate" name="searcheddate" style="height: 28px; margin-right: 10px;" />
	  	                          <strong>승인여부</strong>
							      <select id="searchstatus" name="searchstatus" style="height: 28px;">
							        <option value="">전체</option>
							        <option value="N">승인대기</option>
							        <option value="Y">승인완료</option>
							       </select>
								  <a class="btnType blue" href="" name="searchbtn"  id="searchbtn"><span>검색</span></a>
							  </div>	
							</span>
						</p>
						<br>
       
						<div class="divList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의명</th>
										<th scope="col">담당강사</th>
										<th scope="col">강의실</th>
										<th scope="col">신청인원</th>
										<th scope="col">최대인원</th>
										<th scope="col">강의시작일</th>
										<th scope="col">강의종료일</th>
										<th scope="col">신청여부</th>
										<th scope="col">승인여부</th>
									</tr>
								</thead>
								<tbody id="listlecturebody"></tbody>
							</table>
						</div>
	                    
						<div class="paging_area"  id="lecturePagination"> </div>
						
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
				<strong>강의계획서</strong>
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
							<th scope="row">강의명 <span class="font_red">*</span></th>
							<td colspan=3><span id="lec_nm"></span></td>
						</tr>
						<tr>
							<th scope="row">담당강사 <span class="font_red">*</span></th>
							<td colspan="3"><span id="name"></span></td>				
						</tr>		
						<tr>
							<th scope="row">강의실 <span class="font_red">*</span></th>
							<td colspan="3"><span id="classroom_no"></span></td>				
						</tr>		
						<tr>
							<th scope="row">수강인원 <span class="font_red">*</span></th>
							<td colspan="1"><span id="lec_cnt"></span> </td>
							<th scope="row">최대인원 <span class="font_red">*</span></th>
							<td colspan="1"><span id="lec_max_cnt"></span></td>				
						</tr>	
						<tr>
							<th scope="row">강의시작일 <span class="font_red">*</span></th>
							<td colspan="1"><span id="lec_start"></span></td>	
							<th scope="row">강의종료일 <span class="font_red">*</span></th>
							<td colspan="1"><span id="lec_end"></span></td>				
						</tr>
						<tr>
							<th scope="row">강의목표 <span class="font_red">*</span></th>
							<td colspan="3"><span id="learn_goal"></span></td>				
						</tr>	
						<tr>
							<th scope="row">강의계획 <span class="font_red">*</span></th>
							<td colspan="3"><span id="learn_plan"></span></td>				
						</tr>	
						<tr>
							<th scope="row">강의내용 <span class="font_red">*</span></th>
							<td colspan="3"><span id="lec_content"></span></td>				
						</tr>	
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<!--// 모달팝업 -->
</form>
</body>
</html>
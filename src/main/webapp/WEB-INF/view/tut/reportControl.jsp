<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>과제 관리</title>
	<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
	<style type="text/css">
		.searchBtn{
			cursor: pointer;
		}
	</style>
	
	<script type="text/javascript">

	/** OnLoad event */ 
	
	
	$(function() {
	
		// 3) 전체 강의 목록
		selectComCombo("leclist","lecblist","all","","");  
		noticeseach();
		noticepfssearch();
	});
function noticeseach(cpage) {
    var pagesize = 5;
    var pageblocksize = 10;
    
		cpage = cpage || 1;
		var param = {
				cpage : cpage,
				pagesize : pagesize,
		};
		
		var listcallback = function(respose) {
			console.log(respose);		
			$("#lectureInfo").empty().append(respose);
			
			var paginationHtml = getPaginationHtml(cpage, $("#totalLecccnt").val(), pagesize, pageblocksize, 'noticeseach');
			console.log("paginationHtml : " + paginationHtml);
	
			$("#noticePagination").empty().append( paginationHtml );
			
			$("#cpage").val(cpage);
		}
		
		callAjax("/tut/reportLecListControl.do", "post", "text" , false, param, listcallback);
		
	}
function noticepfssearch(cpage){
    var pagesize = 5;
    var pageblocksize = 10;
	cpage = cpage || 1;
	
	var param = {
			cpage : cpage,
			pagesize : pagesize,
	}
	
	var listcallback = function(response){
		console.log(response);
		 var projectInfo = response;
		$("#projectInfo").empty().append(response);


        // 페이징 영역에 HTML 추가
		var paginationHtml = getPaginationHtml(cpage, $("#totalLecccnt2").val(), pagesize, pageblocksize, "noticepfssearch");
		console.log("paginationHtml : " + paginationHtml);
		
		$("#noticepfsPagination").empty().append(paginationHtml);
		
		$("#cpage").val(cpage);
	}
	
	callAjax("/tut/reportListControl.do", "post", "text" , false, param, listcallback);
}
	
		function sending_task_id(data1) {
			var param = {
				"task_id" : data1
				
			
			};
		    var resultCallback = function(param) {
		    	$('#layer1').empty().append(param);
		        gfModalPop("#layer1");
		    };
		   	callAjax("/tut/submitInfo.do", "post", "text", true, param, resultCallback);
		}
		
		function sending_task_id2(data1){
			var param = {
				"task_id" : data1
			};
			var resultCallback = function(param) {
			    $('#layer1').empty().append(param);
			    gfModalPop("#layer1");
			};
			callAjax("/tut/projectInfo2.do", "post", "text", true, param, resultCallback);
		}

		function fValidate() {

			var chk = checkNotEmpty(
					[
							[ "task_name", "과제명를 입력해 주세요." ]
					]
			);

			if (!chk) {
				return;
			}

			return true;
		}
		
		function makeProject(){
		
			if(!fValidate()) {
				return;
			}
			
			var frm = document.getElementById("myForm2");
			frm.enctype = 'multipart/form-data';
			var fileData = new FormData(frm);
			
			var resultCallback = function(param) {
				makeProjectCallback(param);
			};
			callAjaxFileUploadSetFormData("/tut/makeProject.do", "post", "json", true, fileData, resultCallback);
		}
		
		function makeProjectCallback(param){
			alert("등록 완료 되었습니다");
			location.href="/tut/reportControl.do";
		}
		
		window.onload = function(){
			$("#btn").click(function(){
				 lec_no= $("#lectureList").val();
				 if(lec_no ==""){
					 
				 }else{
					 $("#lecture_List").submit();
				 }
			});
		}

	</script>
</head>

<!-------------------------------------------------------------------------------------------------------------->
<body>

    <!--  모달 배경 -->
	<div id="mask"> </div>
	
   	<div id="wrap_area">
   		<h2 class="hidden">header 영역</h2>
    	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
    	<h2 class="hidden">컨텐츠 영역</h2>
    	
    	<div id="container">
    		<ul>
    			<li class="lnb">
    				<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
            	</li>
            
            	<li class="contents">
            		<h3 class="hidden">contents 영역</h3>
            		<div class="dashboard2 mb20">
                  		<div class="content">
            				<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<a href="" class="btn_nav">학습 관리</a>
								<span class="btn_nav bold">과제 관리</span>
								<a href="reportControl.do" class="btn_set refresh">새로고침</a>
							</p>
					<ul>
                        <li>
	<!--강사가 강의하는 수업목록 셀렉트박스-->
							<form action="reportControl.do" name="lecture_List" id="lecture_List">
    					<input type="hidden"  id="cpage"  name="cpage"  value="" />
								<p class="conTitle"><span>강의 목록</span>
	                            	<span class="fr">
	                              		<select id="lecblist"" name="lecblist"">
	                                		<option value="" id="all" selected="selected">강의 선택</option>
	                                	<c:forEach var="n" items="${lectureList}">
	                                    	<option value="${n.lec_no}">${n.lec_nm}</option>
	                                 	</c:forEach>
	                              		</select>
	                              		<a class="btnType blue" name="btn" id="btn"><span id="searchEnter" class="searchBtn">검색</span></a>
									</span>
								</p>
							</form>
	<!-- 강의번호가 있어야 과제올리기 버튼이 보인다 -->	
						
							 
							<div class="col">
								<br>
								<p class="tit">
                            		<em>강의 정보</em>
                              	</p>
                              
                            	<table class="col2 mb10" >
                                	<colgroup>
                                	    <col width="20%"> 
                                    	<col width="10%">
                                    	<col width="20%">
                                    	<col width="20%">
                                    	<col width="10%">
                                    	<col width="7.5%">
                                    	<col width="7.5%">
                                    	<col width="15%">
                                    	
                                 	</colgroup>
                                 
                                 <thead>
                                    <tr>
                                       <th style="display:none;">강의번호</th>                 
                                       <th>강의명</th>
                                       <th>강사명</th>
                                       <th>개강일</th>
                                       <th>종강일</th>
                                       <th>강의실</th>
                                       <th>현재인원</th>
                                       <th>정원</th>
                                       <th>비고</th>
                                    </tr>
                                 </thead>
 <!-- 선택한 강의정보를 불러온다 -->                                
                                 <tbody id="lectureInfo">
                                 </tbody>
                              </table>
                           </div>
                       <div class="paging_area"  id="noticePagination"> </div>
                           
                           
                           <div class="col">
    <input type="hidden"  id="cpage"  name="cpage"  value="" />
                           
                           		<br>
                               <p class="tit">
                                   <em>과제 관리</em>
                               </p>                      
								<table class="col2 mb10" >
                                	<colgroup>
                                    	<col width="10%">
                                    	<col width="60%">
                                    	<col width="10%">
                                    	<col width="10%">
                                    	<col width="10%">
                                 	</colgroup>
	
	<!--select box 클릭하면 해당 강의 과제 목록 불러오기-->
                                 <thead>
                                    <tr>
                                    
                                       <th>과제 번호</th>
                                       <th>과제 이름</th>
                                       <th>제출일</th>
                                       <th>마감일</th>
                                       <th>제출 현황</th>
                                    </tr>
                                 </thead>
                                 
                                <tbody id="projectInfo">
                               	</tbody>
                          	</table>
                          	</div>
                          					<div class="paging_area"  id="noticepfsPagination"> </div>
                          
                        </li>
                     </ul>
                  </div>
               </div>
            </li>
         </ul>
      </div>
   </div>
 

 <!-- 과제만들기 버튼 누르면 생성되는 모달 -->
 	<form id="myForm2" action="javascript:makeProject();" method="post" enctype="multipart/form-data">
    <input type="hidden"  id="cpage"  name="cpage"  value="" />

  		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>과제 등록하기</strong>
				</dt>
				<dd class="content">
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>
						<p align="center">※<strong style="color:red">제출일</strong>과 <strong style="color:red">마감일</strong>을 반드시 입력하세요※</p><br>
						<tbody>
							<tr>
								<th scope="row">과제명</th>
								<td><input type="text" class="inputTxt p100" name="task_name" id="task_name" /></td>
							</tr>
							<tr>
								<th scope="row">과제 내용</th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="task_content" id="task_content" /></td>
							</tr>
							<tr>
								<th scope="row">제출일</th>
								<td colspan="3"><input type="date" class="inputTxt p100" name="task_start" id="task_start" /></td>
							</tr>
							<tr>
								<th scope="row">마감일</th>
								<td colspan="3"><input type="date" class="inputTxt p100" name="task_end" id="task_end" /></td>
							</tr>
							<tr>
								<th scope="row">파일업로드</th>
								<td>
									<input type="file" id="task_files" name="task_files" class="upload-hidden">
								</td>
							</tr>
						</tbody>
					</table>
				
				<!-- cccc : lec_no  // 저장버튼 누르면 form의 action으로 이동 // makeProject -->
				<div class="btn_areaC mt30">
					<input type="hidden"  name="cccc" id="cccc" value="${cccc}" />
					<a href="javascript:makeProject('${a.lec_no}');" class="btnType blue"><span>저장</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
  </form>	
</body>
</html>
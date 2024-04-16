<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>학습자료</title>
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
				cpage : cpage,
				pagesize : pagesize,
		}
		
		console.log(param);
		
		var listcallback = function(respose) {
			console.log(respose);		
			$("#listlearningbody").empty().append(respose);
			
			var paginationHtml = getPaginationHtml(cpage, $("#listcnt").val(), pagesize, pageblocksize, 'noticeseach');
			console.log("paginationHtml : " + paginationHtml);
	
			$("#learningPagination").empty().append( paginationHtml );
			
			$("#cpage").val(cpage);
		}
		
		callAjax("/std/learningMaterialsList.do", "post", "text" , false, param, listcallback);
		
	}
	
	function newreg() {
		init();
		gfModalPop("#layer1");
	}
	
	function modify(material_no) {
	    var param = {
	        material_no: material_no
	    }

	    console.log(material_no);

	    var modifycallback = function (response) {
	        console.log(JSON.stringify(response));

	        init(response.selinfo);
	        gfModalPop("#layer1");

	     }
	    callAjax("/std/learningMaterialsDtl.do", "post", "json", false, param, modifycallback);
	}
	
	function init(data) {	
		
	    if(data != null) {
	        $("#material_title").text(data.material_title);
	        $("#created_at").text(data.created_at);
	        $("#material_content").text(data.material_content);
	        if (data.file_name != null) {
	            $("#file_name").attr("href", "javascript:downloadStd('" + data.file_path + "', '" + data.file_name + "', " + data.material_no + ")");
	            $("#file_name").text(data.file_name);
	        } else {
	            $("#file_name").text("첨부파일없음");
	        }
	        $("#material_no").text(data.material_no);
	        $("#btnDelete").show();
	        $("#action").val("U");			
	    } else {
	        $("#material_title").text("");
	        $("#created_at").text("");
	        $("#material_content").text("");
	        $("#file_name").text("첨부파일없음");
	        $("#material_no").text("");
	        $("#btnDelete").hide();
	        $("#action").val("I");			
	    }
	}
	
	function downloadStd(url, fname, material_no){
		 alert("정말로 다운로드 하시겠습니까?")
	     $("#material_no").val(material_no);
	    
		var params = "<input type='hidden' name='material_no' value='"+ material_no +"' />";
            params += "<input type='hidden' name='file_path' value='"+ url +"' />";
            params += "<input type='hidden' name='file_name' value='"+ fname +"' />";
            $("<form action='downloadStd.do' method='post' id='fileDownload'>" + params + "</form>").appendTo('body').submit().remove();
            console.log(params);
	        alert("다운로드 성공");
	}
</script>

</head>
<body>
<form id="myForm" action=""  method="">
    <input type="hidden"  id="action"  name="action"  value="" />
    <input type="hidden"  id="material_no"  name="material_no"  value="" />
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
							<span class="btn_nav bold">학습자료</span> 
							<a href="../std/learningMaterials.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>학습자료</span> <span class="fr">
							<div>
	  	                          <strong>학습자료명 : </strong>
	  	                          <input type="text" id="searchtitle" name="searchtitle" style="height: 25px; margin-right: 10px;"/>
	  	                          <strong>등록일 : </strong>
	  	                          <input type="date" id="searchstdate" name="searchstdate" style="height:28px;" /> ~ 
	  	                          <input type="date" id="searcheddate" name="searcheddate" style="height: 28px; margin-right: 10px;" />
	  	                          <a class="btnType blue" href="" name="searchbtn"  id="searchbtn"><span>검색</span></a>
							  </div>	
							</span>
						</p>
						<br>
       
						<div class="divList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="50%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
							   </colgroup>
	
								<thead>
									<tr>
										<th scope="col">등록번호</th>
										<th scope="col">학습자료명</th>
										<th scope="col">등록일</th>
										<th scope="col">작성자</th>
										<th scope="col">조회수</th>
									</tr>
								</thead>
								<tbody id="listlearningbody"></tbody>
							</table>
						</div>
	                    
						<div class="paging_area"  id="learningPagination"> </div>
						
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
				<strong>학습자료 상세</strong>
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
							<td colspan="1"><span id="material_title"></span></td>
							<th scope="row">등록일자 <span class="font_red">*</span></th>
							<td colspan="1"><span id="created_at"></span></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan="3"><span id="material_content"></span></td>		
						</tr>		
						<tr>
							<th scope="row">첨부파일</th>
							<td colspan="3" >
							<a href="#" id="file_name"></a>
							</td>		
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
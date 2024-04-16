<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Sample</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	
	/** OnLoad event */ 
	$(function() {
	
		// 1) usertype별 사용자 정보    "A" <== Usertype     value : loginID 사용자ID 
		userCombo("usr","userlist","all","A","");   
	
		// 2) 현재 로그인한 사용자가 강의하는 강의    value : lec_cd lec_nm
		selectComCombo("lecbyuser","lecbyuserlist","all","","");   
		
		// 3) 전체 강의 목록
		selectComCombo("leclist","lecblist","all","","");  
		
		// 4) 강사명 (tb_lec > loginID 제외 조건 // tb_userinfo > user_no,, name)   
		userCombo("lusr","luserlist","all","N","");   // 강의 유무별  사용자(강사) 정보    "Y"(강의중")   "N"(강의없음)  ""(전체)   <== 구분자     value : loginID 사용자ID
		
		// 5) 강의실 (tb_classromm_mgt)
		selectComCombo("cls","clslist","all","","");   // 강의실 목록    value : cls_room_cd 
		
		// 6) 현재 종료되지 않은 강의명(tb_classromm_mgt > classroom_no, classroom_nm ,, 조건   "Y" : 종료  "N" : 진행 중)  
		selectComCombo("lecyn","lecynlist","all","N","");   // 강의실 목록    value : classroom_no      

		// 7) 테이블명 : tb_testinfo 시험코드 test_cd int (pk) 시험지명 test_paper_nm (varchar100)
		selectComCombo("test","testlist","all","","");   // 테스트 목록    value : test_cd 	
		
	});
	

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
								class="btn_nav bold">기준정보</span> <span class="btn_nav bold">Sample</span> <a href="../system/sample.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>Sample Page</span> <span class="fr">
							</span>
						</p>
						
						<div> 
						    <table>
						        <caption>caption</caption>
								<colgroup>
									<col width="12%">
									<col width="13%">
									<col width="12%">
									<col width="13%">
									<col width="12%">
									<col width="13%">
									<col width="12%">
									<col width="13%">
								</colgroup>
						        <tbody>
						             <tr> 
						                  <td> 
						                       사용자
						                  </td>
						                  <td> 
						                       <select id="userlist" name="userlist" ></select>
						                  </td>
						                  <td> 
						                     강사(현 로그인) 담당 강의
						                  </td>						                      					                  
						                  <td> 
						                       <select id="lecbyuserlist" name="lecbyuserlist" ></select>
						                  </td>
						                  <td> 
						                     전체 강의 목록
						                  </td>						                      					                  
						                  <td> 
						                       <select id="lecblist" name="lecblist" ></select>
						                  </td>
						                  <td> 
						                     강의현황강사
						                  </td>						                      					                  
						                  <td> 
						                       <select id="luserlist" name="luserlist" ></select>
						                  </td>
						             </tr>
                                     <tr> 
                                          <td> 
						                       강의실
						                  </td>
						                  <td> 
						                       <select id="clslist" name="clslist" ></select>
						                  </td>
						                  <td> 
						                      진행/미진행 강의
						                  </td>
						                  <td> 
						                     <select id="lecynlist" name="lecynlist" ></select>
						                  </td>
						                  <td> 
						                      테스트
						                  </td>
						                  <td> 
						                     <select id="testlist" name="testlist" ></select>
						                  </td>	
						                  <td> 
						                       
						                  </td>						                      					                  
						                  <td> 
						                     
						                  </td>
						                  <td> 
						                      
						                  </td>
						                  <td> 
						                     
						                  </td>
						             </tr>
						        </tbody>
						    </table>
						
						
						</div>
						 

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
				<strong>그룹코드 관리</strong>
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
							<th scope="row">그룹 코드 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="grp_cod" id="grp_cod" /></td>
							<th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="grp_cod_nm" id="grp_cod_nm" /></td>
						</tr>
						<tr>
							<th scope="row">코드 설명 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="grp_cod_eplti" id="grp_cod_eplti" /></td>
						</tr>
				
						<tr>
							<th scope="row">사용 유무 <span class="font_red">*</span></th>
							<td colspan="3"><input type="radio" id="radio1-1"
								name="grp_use_poa" id="grp_use_poa_1" value='Y' /> <label for="radio1-1">사용</label>
								&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="radio1-2"
								name="grp_use_poa" id="grp_use_poa_2" value="N" /> <label for="radio1-2">미사용</label></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveGrpCod" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteGrpCod" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>상세코드 관리</strong>
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
							<th scope="row">그룹 코드 ID <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="dtl_grp_cod" name="dtl_grp_cod" /></td>
							<th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="dtl_grp_cod_nm" name="dtl_grp_cod_nm" /></td>
						</tr>
						<tr>
							<th scope="row">상세 코드 ID <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="dtl_cod" name="dtl_cod" /></td>
							<th scope="row">상세 코드 명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="dtl_cod_nm" name="dtl_cod_nm" /></td>
						</tr>
						
						<tr>
							<th scope="row">코드 설명</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="dtl_cod_eplti" name="dtl_cod_eplti" /></td>
						</tr>
					
						<tr>
							<th scope="row">사용 유무 <span class="font_red">*</span></th>
							<td colspan="3"><input type="radio" id="dtl_use_poa_1"
								name="dtl_use_poa" value="Y" /> <label for="radio1-1">사용</label>
								&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="dtl_use_poa_2"
								name="dtl_use_poa" value="N" /> <label for="radio1-2">미사용</label></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveDtlCod" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnDeleteDtlCod" name="btn"><span>삭제</span></a>  
					<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업 -->
</form>
</body>
</html>
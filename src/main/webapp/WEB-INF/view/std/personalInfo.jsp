<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>개인정보 수정</title>
<!-- sweet alert import -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
   
    var pagesize = 10;
    var pageblocksize = 10;
    var userData = null; // 전역 변수로 선언
   
	/** OnLoad event */ 
	$(function() {
		comcombo("areaCD", "areasel", "sel", "");
		modify();
		fRegisterButtonClickEvent();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchbtn").click(function(e) {
			modify();
			e.preventDefault();
	});
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

	       var btnId = $(this).attr('id');
          
			switch (btnId) {
				case 'btnUpdatePass' :
					updatePass();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnUpdate' :
					update();
					break;	
				case 'btnDelete' :
					deleteUser();
					break;	
			}
		}); 
	}
	
	function newreg() {
		init();
		
	}
	
	// 개인정보 가져오기
	function modify() {
		
		var user_no = '${sessionScope.user_no}';
		
		var param = {
				user_no : user_no
		}
		
		console.log("user_no"+     user_no);
		
		var modifycallback = function(response) {
			userData = response; // 받아온 데이터를 전역 변수에 저장
			console.log(JSON.stringify(response));
			
			// {"selinfo":{"lec_no":0,"test_no":0,"classroom_no":201,"user_no":0,"lec_nm":"자바강의","lec_max_cnt":50,"lec_cnt":16,"lec_etc":null,"lec_start":"2024-03-18","lec_end":"2024-04-17","lec_content":null,"learn_goal":0,"learn_plan":null,"name":"스티븐잡스"}}
			init(response.selinfo);
		}
		
		callAjax("/std/personalInfoDtl.do", "post", "json" , false, param, modifycallback);
	}
	
	//모달창
	function open() {
		gfModalPop("#layer1");
	}
	
	//데이터폼
	function init(data) {	
		
		if(data != null) {
			$("#name").val(data.name);
			$("#password").val(data.password);
			$("#user_gender").val(data.user_gender);
			$("#user_birth").val(data.user_birth);
			$("#user_email").val(data.user_email);
			$("#user_phone").val(data.user_phone);
			$("#user_location").val(data.user_location);
			$("#action").val("U");		
			
		} else {
			$("#name").val("");
			$("#password").val("");
			$("#user_gender").val("");
			$("#user_birth").val("");
			$("#user_email").val("");
			$("#user_phone").val("");
			$("#user_location").val("");
			$("#action").val("I");			
		}
	}
	
	//개인정보 수정
	function update() {
	    // 이메일 유효성 검사
	    if (!validateEmail()) {
	        // 이메일이 유효하지 않으면 업데이트를 막음
	        return;
	    }

	    // 전화번호 유효성 검사
	    if (!validatePhoneNumber()) {
	        // 전화번호가 유효하지 않으면 업데이트를 막음
	        return;
	    }
	    
	 // 이메일 중복 체크 요청
	    var user_email = $("#user_email").val();
	    
	    var checkEmailCallback = function(response) {
	        if (response.emailCnt > 0) {
	            swal("중복된 이메일입니다. 다른 이메일을 사용해주세요.").then(function() {
	                $("#user_email").focus();
	            });
	        } else {
	            // 이메일이 중복되지 않으면 개인정보 업데이트 요청 보냄
	            var updateCallback = function(response) {
	                if (response.result == "S") { 
	                    alert("정말로 수정하시겠습니까?");
	                    alert(response.resultmsg);
	                    // 수정 성공 시 개인정보 수정화면 리다이렉트
	                    window.location.href = "/std/personalInfo.do";
	                } else {
	                    alert("개인정보 수정에 실패했습니다.");
	                }
	            };
	            callAjax("/std/personalInfoUpdate.do", "post", "json", false, $("#myForm").serialize(), updateCallback);
	        }
	    };
	    callAjax("/std/checkEmail.do", "post", "json", false, {user_email : user_email}, checkEmailCallback);
	}
	
	
	//비밀번호변경
	function updatePass() {
		
	    // 비밀번호 유효성 검사
	    if (!validatePassword()) {
	       return;
	    }
	    
	  // 비밀번호 일치확인
	    if (!confirmPass()) {
	        return;
	    } 
	    
	 // 기존 비밀번호와 일치확인
	    if (!confirmPassOld()) {
	        return;
	    }

	    // Ajax 요청 보내기
	    var updateCallback = function(response) {
	        if (response.result == "S") { 
	            alert("정말로 변경하시겠습니까?");
	            alert(response.resultmsg);
	            // 비밀번호 변경 성공 시 맨 처음 화면으로 리다이렉트
	            window.location.href = "/login.do"; 
	            
	        } else {
	            alert("비밀번호 변경에 실패했습니다.");
	        }
	    };
	    // Ajax 요청 보내기
	    callAjax("/std/personalInfoUpdatePwd.do", "post", "json", false, $("#pwdForm").serialize(), updateCallback);
	}
	  
	// 전화번호 유효성 검사
	function validatePhoneNumber() {
	    var phoneNumber = $("#user_phone").val();
	    var phoneRegex = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;

	    if (!phoneRegex.test(phoneNumber)) {
	        swal("전화번호 형식을 확인해주세요. 000-0000-0000입니다.").then(function() {
	            $("#user_phone").focus();
	        });
	        return false;
	    }
	    return true;
	}
	
	// 이메일 유효성 검사
	function validateEmail() {
	    var email = $("#user_email").val();
	    var emailRegex = /^[A-Za-z][a-zA-Z0-9]*[0-9]+[a-zA-Z0-9]@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	
	    if (!emailRegex.test(email)) {
	    	 swal("이메일 형식을 확인해주세요. 이메일은 영문자, 숫자 조합 5자 이상입니다.").then(function() {
	            $("#user_email").focus();
	        });
	        return false;
	    }
	    return true;
	}
 
	// 비밀번호 유효성 검사
	function validatePassword() {
	    // 비밀번호 입력란에서 비밀번호 값을 가져옴
	    var password = $("#changePass1").val();
	    
	    // 비밀번호 유효성을 검사하기 위한 정규 표현식
	    var passwordRegex =/^[A-Za-z](?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&+])[A-Za-z\d@$!%*?&+]{7,14}$/

	    // 정규 표현식과 일치하는지 검사
	    if (!passwordRegex.test(password)) {
	        swal("비밀번호는 영문자, 숫자, 특수문자 조합으로 최소 8자 이상이어야 합니다.").then(function() {
	        $("#changePass1").focus();
	        });
	        return false; 
	    }
	    return true; 
	}
	
	// 비밀번호 일치확인
	function confirmPass() {
	    var pass1 = $("#changePass1").val();
	    var pass2 = $("#changePass2").val();

	    if (pass1 !== pass2) {
	        alert("입력한 비밀번호가 일치하지 않습니다.");
	        return false;
	    } else {
	        // 비밀번호가 일치하는 경우에는 추가 작업 수행
	        // 예를 들어, 비밀번호 변경 로직 등을 여기에 추가할 수 있습니다.
	        return true;
	    }
	} 
	
	// 기존비밀번호와 일치확인
	function confirmPassOld() {
	    var pass1 = $("#changePass1").val();
	    var pass2 = $("#password").val();

	    if (pass1 == pass2) {
	        alert("기존 비밀번호와 일치합니다. 새로운 비밀번호를 입력해주세요.");
	        return false;
	    } else {
	        // 비밀번호가 일치하는 경우에는 추가 작업 수행
	        // 예를 들어, 비밀번호 변경 로직 등을 여기에 추가할 수 있습니다.
	        return true;
	    }
	}
	
	//비밀번호 체크
	$(document).ready(function() {
		$('#changePass1').keyup(function() {
	        var registerPwd = $(this).val();
	        var registerPwdRegex = /^[A-Za-z](?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&+])[A-Za-z\d@$!%*?&+]{7,14}$/
	        
	        if (registerPwd === '') {
	            $('#passwordMatch').hide(); // 입력란이 비어있으면 메시지를 숨김
	        } else {
	            if (registerPwdRegex.test(registerPwd)) {
	                $('#passwordMatch').text('사용 가능한 비밀번호입니다.').css('color', 'green').show();
	            } else {
	                $('#passwordMatch').text('사용 불가능한 비밀번호입니다.').css('color', 'red').show();
	            }
	        }
	    });
	 });

	//비밀번호 확인체크
	$(document).ready(function() {
		$('#changePass2').keyup(function() {
	        var password = $('#changePass1').val();
	        var confirmPassword = $(this).val();
	        
	        if (confirmPassword === '') {
	            $('#passwordOkMatch').hide(); // 입력란이 비어있으면 메시지를 숨김
	        } else {
	            if (password === confirmPassword) {
	                $('#passwordOkMatch').text('비밀번호가 일치합니다.').css('color', 'green').show();
	            } else {
	                $('#passwordOkMatch').text('비밀번호가 일치하지 않습니다.').css('color', 'red').show();
	            }
	        }
	    });
	});
	
	// 회원탈퇴
	function deleteUser() {
		
		var user_no = $("#user_no").val(); // hidden input에서 user_no 값을 가져옴
		var action = 'D';
	    
	    // 파라미터 생성
	    var param = {
	        user_no: user_no,
	        action: action
	    };
		
	    // Ajax 요청 보내기
	    var deleteCallback = function(response) {
	        if (response.result == "S") { 
	            alert("정말로 탈퇴하시겠습니까?");
	            alert(response.resultmsg);
	             // 탈퇴 성공 시 맨 처음 화면으로 리다이렉트
	            window.location.href = "/login.do"; 
	    } else {
	            alert("탈퇴에 실패했습니다.");
	        }
	    };
	    // Ajax 요청 보내기
	    callAjax("/std/deleteUser.do", "post", "json", false, param, deleteCallback);
	}
	
	// 비밀번호 변경 취소 눌렀을 때 폼초기화
	function gfCloseModalAndResetForm() {
	    $("#changePass1").val('');
	    $("#changePass2").val('');
	    $('#passwordMatch').hide();
	    $('#passwordOkMatch').hide(); 
	    gfCloseModal();
	}
</script>

</head>
<body>
<form id="myForm" action=""  method="">
    <input type="hidden"  id="action"  name="action"  value="U" />
    <input type="hidden"  id="user_no"  name="user_no"  value="${sessionScope.user_no}" />

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
							<span class="btn_nav bold">학습관리</span> 
							<span class="btn_nav bold">개인정보 수정</span> 
							<a href="../std/personalInfo.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>개인정보 수정</span> <span class="fr">
							</span>
						</p>
				
				   <table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="12px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row" style="text-align: center;">이름</th>
							<td colspan=1><input type="text" name="name" id="name" style="height:28px;"/></td>
						</tr>
						<tr>
						    <th scope="row" style="text-align: center;">비밀번호</th>
						    <td colspan=1>
						        <input type="password" id="password" style="height:28px;" readonly/>
						         <a href="javascript:open();" class="btnType blue"><span>비밀번호 변경</span></a>
						    </td>
						  </tr>
					    <tr>
							<th scope="row" style="text-align: center;">성별</th>
							<td colspan="1">
							<select name="user_gender" id="user_gender" style="width: 128px; height: 28px;">
										<option value="" selected="selected">선택</option>
										<option value="M">남자</option>
										<option value="F">여자</option>
							</select>
							</td>				
						</tr>		
						<tr>
							<th scope="row" style="text-align: center;">생년월일</th>
							<td colspan="1"><input type="date" name="user_birth" id="user_birth" style="height:28px;"/></td>				
						</tr>		
						<tr>
							<th scope="row" style="text-align: center;">이메일</th>
							<td colspan="1"><input type="text" name="user_email" id="user_email" style="height:28px;"/></td>
						</tr>
						<tr>
						<th scope="row" style="text-align: center;">연락처</th>
							<td colspan="1"><input type="text" name="user_phone" id="user_phone" style="height:28px;"/></td>		
						</tr>
						<tr>
							<th scope="row" style="text-align: center;">거주지역</th>
							<td colspan="1">
							<select name="user_location" id="user_location" style="width: 128px; height: 28px;">
										<option value="">선택</option>
										<option value="서울">서울</option>
										<option value="경기">경기</option>
										<option value="강원">강원</option>
										<option value="충청">충청</option>
										<option value="전라">전라</option>
										<option value="경상">경상</option>
										<option value="제주">제주</option>
								</select>
							</td>	
						</tr>
					</tbody>
				</table>
				<div class="btn_areaC mt30">
					<a href=""	class="btnType blue"  id="btnUpdate" name="btn" style="margin-right: 3px;"><span>수정</span></a>
					<a href=""	class="btnType red"  id="btnDelete" name="btn"><span>회원탈퇴</span></a>
				</div>
			</div>	
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</form>

	<!-- modal 영역 -->
	<form id="pwdForm" action=""  method="">
	 <input type="hidden"  id="action2"  name="action"  value="U" />
     <input type="hidden"  id="user_no2"  name="user_no"  value="${sessionScope.user_no}" />
		<div id="layer1" class="layerPop layerType2 changeModal" style="width: 400px; height:330px; text-align: center;">
			
			<div class="hidden"></div>
			<dl>
				<dt>
					<strong>비밀번호변경</strong>
				</dt>
				<dd class="changeModal">
							<div class="font_red" style="margin-bottom: 10px;">
								<h2>* 기존 비밀번호와 다른 새로운 비밀번호로 변경해주세요 *</h2>
							</div>
							
							<div style="margin-bottom: 1px;">
								<input type="password"  name="password" placeholder="새 비밀번호" id="changePass1" style="height:28px;">
							    <div id="passwordMatch"></div>
							</div>
							<div>
								<input type="password" placeholder="새 비밀번호 확인" id="changePass2" style="height:28px;">
								 <div id="passwordOkMatch"></div>
							</div>
		
					<div style="text-align: center; margin: 20px;">
						<a href="javascript:updatePass();" class="btnType blue " id="btnUpdatePass"><span>변경</span></a>
						<a href="javascript: gfCloseModalAndResetForm();" class="btnType blue"><span>취소</span></a>
					</div>

				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		</form>
		<!-- modal end -->
  </body>
</html>
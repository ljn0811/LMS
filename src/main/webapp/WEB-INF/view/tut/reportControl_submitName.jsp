<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 과제 제출한 학생 명단 -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<style type="text/css">
	</style>

	<script>
		function showStudentSubject(user_no, task_id) {
			var param = {
				user_no : user_no,
				task_id : task_id
			};
			
			
		    var resultCallback = function(param) {
		    	$('#layer1').empty().append(param);
		        gfModalPop("#layer1");
		    };
		   	callAjax("/tut/studentProjectCon.do", "post", "text", true, param, resultCallback);
		}
	</script>
</head>
<body>
<dl>
	<dt>
    	<strong>제출 명단</strong>
    </dt>
    <dd class="content">
    	<table class="col2 mb10" id="adv_info">
        	<caption>caption</caption>
            	<colgroup>
                	<col width="50%">
                	<col width="50%">
                </colgroup>
				
			<thead>
				<tr>
					<th>이름</th>
					<th>학번</th>
				</tr>
			</thead>
			
            <tbody id="submitInfo">
            	<c:forEach var="list" items="${submitInfo}">
	                <tr>
	                	<td>
	                		<a href="javascript:showStudentSubject('${list.user_no}', '${list.task_id}');"><strong>${list.name}</strong></a>
	                	</td>
	                	<td>${list.user_no}</td>
	                </tr> 
                </c:forEach>                 
           	</tbody>
          </table>
     </dd>
</dl>
  		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
</div>
<a href="" class="closePop"><span class="hidden">닫기</span></a>
</body>
</html>
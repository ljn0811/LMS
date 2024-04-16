<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	<c:if test="${listCnt eq 0 }">
		<tr>
			<td colspan="5">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
							 
	<c:if test="${listCnt > 0 }">
		<c:forEach items="${listData}" var="list">
			<tr>
				<td>${list.user_no}</td>
				<td>${list.name}</td>
				<td>${list.user_phone}</td>
				<td>${list.employment_day}</td>
				<td>${list.leaving_date}</td>
				<td>${list.company_name}</td>
				<td>
				<c:if test="${list.employment_state == 'W'}">재직중</c:if>
				<c:if test="${list.employment_state == 'L'}">퇴사</c:if>
				</td>
				<td>
				<a class="btnType3 color1" href="javascript:employInfoModify('${list.employment_no}');"><span>수정</span></a>
				<a class="btnType3 color1" href="javascript:employInfoDelete('${list.employment_no}');"><span>삭제</span></a>
				</td>
			</tr>
		</c:forEach>
	</c:if>
							
<input type="hidden" id="listCnt" name="listCnt" value ="${listCnt}"/>
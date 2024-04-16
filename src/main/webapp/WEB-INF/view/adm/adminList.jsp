<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
				<td><a href="javascript:adminInfoDetail('${list.user_no }')">${list.name} (${list.loginID })</a></td>
				<td>${list.user_phone}</td>
				<td>${list.user_email}</td>
				<td>${list.created_at}</td>
				<td>
					<a class="btnType3 color1" href="javascript:adminInfoDelete('${list.user_no}');"><span>탈퇴</span></a>
				</td>
			</tr>
		</c:forEach>
	</c:if>
							
<input type="hidden" id="listCnt" name="listCnt" value ="${listCnt}"/>
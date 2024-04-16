<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:if test="${listcnt eq 0}">
		<tr>
			<td colspan="12">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	<c:forEach items="${listData}" var="list">
		<tr>
			<td>${list.loginID}</td>
			<td><a href="javascript:lectureDetail('${list.user_no}', 1);">${list.name}</a></td>
			<td>${list.user_phone}</td>
			<td>${list.user_email}</td>
			<td>${list.created_at}</td>
		</tr>
	</c:forEach>
		
	<input type="hidden" id="listcnt" name="listcnt" value ="${listcnt}"/>
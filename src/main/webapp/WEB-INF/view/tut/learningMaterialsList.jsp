<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	
		<!-- 갯수가 0인 경우  -->
		<c:if test="${listCnt eq 0 }">
			<tr>
				<td colspan="4">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
						 
		<c:if test="${listCnt > 0 }">
		<c:forEach items="${listData}" var="list">
			<tr>
				<td>${list.material_no}</td>
				<td>
					<a href="javascript:fmodify('${list.material_no}');">${list.material_title}</a>
				</td>
				<td>${list.created_at}</td>
				<td>${list.name}</td>
			</tr>
		</c:forEach>
	</c:if>

<input type="hidden" id="listCnt" name="listCnt" value="${listCnt}"/>












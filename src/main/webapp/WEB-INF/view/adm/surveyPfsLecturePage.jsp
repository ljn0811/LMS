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
		    <td>${list.lec_nm}</td>
			<td>${list.name}</td>
			<td>${list.lec_start}</td>
			<td>${list.lec_end}</td>
			<td>
			    <c:choose>
					<c:when test="${list.cnt eq 0}">
						<span>0</span>
					</c:when>
					<c:otherwise>
						<span>${list.cnt}</span>
					</c:otherwise>
				</c:choose>
				<span>/ ${list.max_cnt}</span>
		    </td>
		</tr>
	</c:forEach>
		
	<input type="hidden" id="leclistcnt" name="leclistcnt" value ="${listcnt}"/>
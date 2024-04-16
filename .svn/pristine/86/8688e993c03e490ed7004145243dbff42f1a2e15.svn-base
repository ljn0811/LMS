<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
<c:if test="${listcnt eq 0 }">
	<tr>
		<td colspan="5">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
							 
<c:if test="${listcnt > 0 }">
	<c:forEach items="${listdata}" var="list">
		<tr>
			<td>${list.qna_id}</td>
			<td><a href="javascript:qnaDetail('${list.qna_id}');">${list.qna_title}</a></td>
			<td>${list.name}</td>
			<td>${list.created_at}</td>			
		</tr>
	</c:forEach>
</c:if>
							
<input type="hidden" id="listcnt" name="listcnt" value ="${listcnt}"/>
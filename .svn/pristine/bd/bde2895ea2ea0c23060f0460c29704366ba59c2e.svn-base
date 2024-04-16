<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
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
				<td>${list.lec_no}</td>
				<td>${list.lec_nm}</td>				
				<td>
					<a href="javascript:lectureStudentSearch('${list.lec_no}');">${list.lec_content}</a>
				</td>
				<td>${list.lec_start} ~ ${list.lec_end}</td>				
				<td>${list.lec_max_cnt}</td>
			</tr>
		</c:forEach>
	</c:if>
							
<input type="hidden" id="listCnt" name="listCnt" value ="${listCnt}"/>
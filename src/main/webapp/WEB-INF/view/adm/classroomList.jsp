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
				<td><a href="javascript:classroomEquipment('${list.classroom_no}', 1);">${list.classroom_nm}</a></td>
				<td>${list.classroom_size}</td>
				<td>${list.seat_cnt}</td>
				<td>${list.classroom_etc}</td>
				<td>
				<a class="btnType3 color1" href="javascript:classroomModify('${list.classroom_no}');"><span>수정</span></a>
				</td>
			</tr>
		</c:forEach>
	</c:if>
							
<input type="hidden" id="listCnt" name="listCnt" value ="${listCnt}"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	<c:if test="${listCntUser eq 0 }">
		<tr>
			<td colspan="5">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
							 
	<c:if test="${listCntUser > 0 }">
		<c:forEach items="${listData}" var="list">
			<tr>
				<td>${list.user_no}</td>
				<td><a href="javascript:Userdtl('${list.user_no }');">${list.name}</a></td>
				<td>${list.user_phone}</td>
				<td>${list.lec_nm}</td>
				<td>${list.created_at}</td>
				<td>
				<a class="btnType3 color1" href="javascript:lectureUserdtl('${list.user_no}');"><span>등록</span></a>
				</td>
			</tr>
		</c:forEach>
	</c:if>
							
<input type="hidden" id="listCntUser" name="listCntUser" value ="${listCntUser}"/>
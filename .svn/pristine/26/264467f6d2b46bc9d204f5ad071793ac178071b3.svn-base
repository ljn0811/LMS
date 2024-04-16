<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
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
										<td>${list.notice_no}</td>
										<td><a href="javascript:modify('${list.notice_no}', '${list.user_no}');">${list.notice_title}</a></td>
										<td>${list.name}</td>
										<td>${list.created_at}</td>
										<td>${list.notice_views}</td>
										<td>
										    <c:if test="${gridtype == 'C' && sessionScope.userType =='C'}">
										        <a class="btnType3 color1" href="javascript:fmodify('${list.notice_no}');"><span>수정</span></a>
										    </c:if>
										    <c:if test="${gridtype == 'B' && sessionScope.userType =='B'}">
										        <a class="btnType3 color1" href="javascript:fmodify('${list.notice_no}');"><span>수정</span></a>
										    </c:if>											
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="listcnt" name="listcnt" value ="${listcnt}"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${listcnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							 <c:forEach items="${listdata}" var="list">
										    <tr>
										            <td>${list.material_no}</td>
													<td><strong><a href="javascript:modify('${list.material_no}');">${list.material_title}</a></strong></td>
													<td>${list.created_at}</td>
													<td>${list.name}</td>
													<td>${list.material_views}</td>
											</tr>
								</c:forEach>
								
							<input type="hidden" id="listcnt" name="listcnt" value ="${listcnt}"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

									<c:if test="${listcnt eq 0 }">
										<tr>
											<td colspan="4">데이터가 존재하지 않습니다.</td>
										</tr>
									</c:if>

									 <c:if test="${listcnt > 0 }">
										<c:forEach items="${listdata}" var="list">
											<tr>
												<td><a href="javascript:lecListDtl('${list.lec_no}');">${list.lec_nm}</a></td>
												<td>${list.user_nm}</td>
												<td>${list.lec_start} ~ ${list.lec_end}</td>
												<td>${list.classroom_nm}</td>												
											</tr>
										</c:forEach>
									</c:if>
									<input type="hidden" id="listcnt" name="listcnt" value ="${listcnt}"/>
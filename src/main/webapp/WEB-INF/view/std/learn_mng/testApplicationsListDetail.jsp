<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

									<c:if test="${testListCnt eq 0 }">
										<tr>
											<td colspan="5">데이터가 존재하지 않습니다.</td>
										</tr>
									</c:if>

									 <c:if test="${testListCnt > 0 }">
										<c:forEach items="${listdata}" var="list">
											<tr>
												<td>${list.lec_nm}</td>
												<td>${list.test_nm}</td>
												<td>${list.test_type}</td>
												<td>${list.test_etc}</td>
												<td><a class="btnType blue" href="javascript:applyTest('${list.test_no}');"><span>시험응시</span></a></td>																		
											</tr>
										</c:forEach>
									</c:if>
									<input type="hidden" id="testListCnt" name="testListCnt" value ="${testListCnt}"/>
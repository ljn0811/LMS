<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					<%-- 
						<tr class="hiddenData">
							  <td id="totalTestListPub">${totalTestListPub}</td>
						</tr>
							 --%>
							<c:if test="${totalTestListPub eq 0 }">
								<tr>
									<td colspan="6"> 과정을 선택해 주세요.</td>
								</tr>
							</c:if>
							 <c:set var="nRow" value="${pageSize*(currentPageTestListPub-1)}" /> 
							<c:forEach items="${testListPub}" var="list">
								<tr>
									<td>${totalTestListPub - nRow}</td>
									<td>${list.lec_nm}</td>
									<td><a href="javascript:modify('${list.test_no}')">${list.test_nm}</a></td>
									<td>${list.test_type}</td>
									<td>${list.lec_cnt}</td>
									
									<td><a class="btnType3 color1" href="javascript:testQueModal('${list.test_no }');"><span>문제등록</span></a></td>
								</tr>
								 <c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
		
						
				
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${listcnt eq 0 }">
								<tr>
									<td colspan="3">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${listcnt > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1)}" />
								<c:forEach items="${listdata}" var="list">
									<tr>
										<td>${list.lec_no}</td>
										<td><strong><a href="javascript:fListComnDtlCod(1, '${list.lec_nm}');">${list.lec_nm}</a></strong></td>
										<td>${list.lec_date}</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntComnGrpCod" name="totalCntComnGrpCod" value ="${listcnt}"/>
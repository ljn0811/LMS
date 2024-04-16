<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					<div class="divEmpty">
						<div class="hiddenData">
							  <span id="totalCntComnDtlCod">${listcnt}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">회원번호</th>
									<th scope="col">수강강의</th>
									<th scope="col">학생명</th>
									<th scope="col">휴대전화</th>
									<th scope="col">가입일자</th>
								</tr>
							</thead>
							<tbody id="listComnDtlCod">
							<c:if test="${listcnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPageComnDtlCod-1)}" />
							<c:forEach items="${listdata}" var="list">
								<tr>
									<td>${list.user_no}</td>
									<td>${list.lec_nm}</td>
									<td><strong><a href="javascript:fPopModalComnDtlCod('${list.user_no}');">${list.name}</a></strong></td>
									<td>${list.user_phone}</td>
									<td>${list.created_at}</td>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>
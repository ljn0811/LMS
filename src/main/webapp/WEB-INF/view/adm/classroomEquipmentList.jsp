<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					<div class="divEmpty">
						<div class="hiddenData">
							  <span id="totalCntClsEquip">${totalCntClsEquip}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">장비명</th>
									<th scope="col">갯수</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody id="listClsEquip">
							<c:if test="${totalCntClsEquip eq 0 }">
								<tr>
									<td colspan="12">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPageClsEquip-1)}" />
							<c:forEach items="${listClassroomEquipment}" var="list">
								<tr>
									<td>${totalCntClsEquip - nRow}</td>
									<td>${list.tool_nm}</td>
									<td>${list.tool_cnt}</td>
									<td>${list.tool_etc}</td>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>
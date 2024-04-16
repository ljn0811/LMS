<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${listcnt eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							 <c:forEach items="${listdata}" var="list">
										    <tr>
													<td><strong><a href="javascript:modify('${list.lec_no}');">${list.lec_nm}</a></strong></td>
													<td>${list.name}</td>
													<td>${list.classroom_no}호</td>
													<td>${list.lec_cnt}명</td>
													<td>${list.lec_max_cnt}명</td>
													<td>${list.lec_start}</td>
													<td>${list.lec_end}</td>
													<td>
													   <c:if test="${list.apv == null}">
														    <a class="btnType3 color2" href="javascript:fSave('${list.lec_no}');"><span>수강신청</span></a>
														</c:if>
														 <c:if test="${list.apv eq 'N'}">
														      <a class="btnType3 color1" href="javascript:fDelete('${list.lec_no}');"><span>신청취소</span></a>
														 </c:if>
													</td>
											        <td>
											           <c:if test="${list.apv eq 'N'}">
														    <span style="color: red;">승인대기</span>
													   </c:if>
											           <c:if test="${list.apv eq 'Y'}">
											                 <span>승인완료</span>
											            </c:if>
											        </td>
												</tr>
								</c:forEach>
								
							<input type="hidden" id="listcnt" name="listcnt" value ="${listcnt}"/>
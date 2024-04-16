<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
						   <c:if test="${totalLecccnt eq 0 }">
								<tr>
									<td colspan="8">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
						   <c:if test="${totalLecccnt > 0 }">
						       <c:forEach var="a" items="${lectureInfo}">
                                          <tr>
											  <td style="display:none;"><input type="hidden" name="lec_no" value="${a.lec_no}" />${a.lec_no}</td>
	                                          <td>${a.lec_nm}</td>
	                                          <td>${a.user_no}</td>
	                                          <td>${a.lec_start}</td>
	                                          <td>${a.lec_end}</td>
	                                          <td>${a.classroom_no}</td>
	                                          <td>${a.lec_cnt}</td>
	                                          <td>${a.lec_max_cnt}</td>
	                                          <td><a href="javascript:gfModalPop('#layer1');" class="btnType blue" name="btn" id="btn"><span id="">과제 올리기</span></a></td>
                                          </tr>
                                       </c:forEach>
                                       </c:if>
                                       
                        	<input type="hidden" id="totalLecccnt" name="totalLecccnt" value ="${totalLecccnt}"/>
                                       
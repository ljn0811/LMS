<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						
							
								<c:forEach items="${listdata}" var="list">
									<tr>
										<td>${list.lec_nm}</td>
										<td>${list.test_nm}</td>
										<td>${list.test_type}</td>
										<td><a href="javascript:queModify('${list.test_que_no}')" name="modal">${list.test_que}</a></td>
										<td>${list.que_ans}</td>
										<td>${list.que_ex1}</td>
										<td>${list.que_ex2}</td>
										<td>${list.que_ex3}</td>
										<td>${list.que_ex4}</td>
										<td>
											<a class="btnType3 color1" href="javascript:queModify('${list.test_que_no}');" name="modal"><span>수정</span></a>
										</td>
									</tr>
								</c:forEach>
									
							
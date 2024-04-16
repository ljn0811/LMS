
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:if test="${totalLecccnt2 eq 0 }">
								<tr>
									<td colspan="8">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
						   <c:if test="${totalLecccnt2 > 0 }">
<c:forEach var="b" items="${projectInfo}">
	<tr>
		<td>${b.task_id}</td>
		<!--          과제 제목 클릭하면 해당과제 상세정보, 수정과 삭제 가능    -->
		<td><a href="javascript:sending_task_id2('${b.task_id}');"><strong>${b.task_name}</strong></a></td>
		<td>${b.task_start}</td>
		<td>${b.task_end}</td>
		<td>
			<!--          제출현황 클릭하면 hwk_id전송해서 제출한 학생 명단 불러오기 --> <a
			href="javascript:sending_task_id('${b.task_id}');"><span><strong>자세히
						보기</strong></span></a>
		</td>
	</tr>
</c:forEach>
</c:if>

		<input type="hidden" id="totalLecccnt2" name="totalLecccnt2" value ="${totalLecccnt2}"/>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	<c:if test="${empty deleted_pno}">
		alert("${param.bno} 는 삭제가 불가합니다.");
	</c:if>
	<c:if test="${!empty deleted_pno}">
	alert("${deleted_pno} 가 삭제되었습니다.");
	</c:if>
	location.href="list.do${pageMaker.makeQuery(param.page)}";
</script>
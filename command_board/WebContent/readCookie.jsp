<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<body>
<% 
	Cookie[] cookies = request.getCookies();
	if (cookies != null && cookies.length > 0) {
		out.println("<ul>");
		for (int i = 0 ; i < cookies.length ; i++) {			
			out.println("<li>name :"+cookies[i].getName()
					    +", value="+cookies[i].getValue()+"</li>");
		}
		out.println("</ul>");
	}

%>
</body>
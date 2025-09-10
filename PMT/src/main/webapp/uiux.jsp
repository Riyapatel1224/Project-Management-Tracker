<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

		<%
		    Boolean loggedIn = (Boolean) session.getAttribute("userLoggedIn");
		    String role = (String) session.getAttribute("userRole");
		
		    if (loggedIn == null || !loggedIn) {
		        response.sendRedirect("Login.jsp"); 
		        return;
		    }
		
		    if (!"ui/ux".equals(role)) {
		        response.sendRedirect("Login.jsp"); 
		        return;
		    }
		%>

	<h1>uiux</h1>
</body>
</html>
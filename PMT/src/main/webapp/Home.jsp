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
	
	    if ("admin".equals(role)) {
	        response.sendRedirect("admin.jsp"); 
	        return;
	    }
	%>

	

	<h1>SUCCESS</h1>
	
	<form action="LogoutController" method="post">
    	<button type="submit">Logout</button>
	</form>

</body>
</html>
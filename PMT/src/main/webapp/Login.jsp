<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Project Management Tracker - Login</title>
    <script>
	    history.pushState(null, null, location.href);
	    window.onpopstate = function () {
	        history.go(1);
	    };
	</script>
	
	<%--for stubborn brower to prevent caching  --%>
	
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	
    
    <%
    
		//prevent caching 
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		//no-cache : Don’t serve from cache without rechecking with the server.
		//no-store: Don’t store any copy of this page at all.
		//must-revalidate : Always check with the server before showing the page.
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		//Means the page is already expired
		
		
		
		if(session!=null){
			//Check if the user is logged in succesfully 
			Boolean loggedIn = (Boolean) session.getAttribute("userLoggedIn");
			String role = (String) session.getAttribute("userRole");
			
			if (loggedIn != null && loggedIn) {
				if ("admin".equalsIgnoreCase(role)) {
		            response.sendRedirect("admin.jsp");
		        } else if ("manager".equalsIgnoreCase(role)) {
		            response.sendRedirect("manager.jsp");
		        } else if ("frontend".equalsIgnoreCase(role)) {
		            response.sendRedirect("frontend.jsp");
		        } else if ("backend".equalsIgnoreCase(role)) {
		            response.sendRedirect("backend.jsp");
		        } else if ("devops".equalsIgnoreCase(role)) {
		            response.sendRedirect("devops.jsp");
		        } else if ("fullstack".equalsIgnoreCase(role)) {
		            response.sendRedirect("fullstack.jsp");
		        } else if ("database administrator".equalsIgnoreCase(role)) {
		            response.sendRedirect("databaseAdministrator.jsp");
		        } else if ("qa/engineer".equalsIgnoreCase(role)) {
		            response.sendRedirect("qaEngineer.jsp");
		        } else if ("ui/ux".equalsIgnoreCase(role)) {
		            response.sendRedirect("uiux.jsp");
		        }
		        return;
		    }
		}
		
		
	%>
    
    
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #1cc88a, #4e73df);
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .container {
            background: #fff;
            padding: 2rem 2.5rem;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            width: 400px;
            max-width: 90%;
            text-align: center;
        }

        h1 {
            margin-bottom: 1rem;
            color: #333;
            font-size: 1.6rem;
        }

        .form-group {
            margin-bottom: 1rem;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 0.3rem;
            font-size: 0.9rem;
            color: #555;
        }

        input {
            width: 100%;
            padding: 0.7rem;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 0.95rem;
            transition: border-color 0.2s;
        }

        input:focus {
            outline: none;
            border-color: #1cc88a;
            box-shadow: 0 0 5px rgba(28, 200, 138, 0.3);
        }

        .btn {
            width: 100%;
            padding: 0.8rem;
            margin-top: 0.5rem;
            border: none;
            border-radius: 8px;
            background: #1cc88a;
            color: white;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.2s;
        }

        .btn:hover {
            background: #17a673;
        }

        .new-user {
            margin-top: 1rem;
            font-size: 0.9rem;
            color: #555;
        }

        .new-user a {
            color: #4e73df;
            text-decoration: none;
            font-weight: bold;
        }

        .new-user a:hover {
            text-decoration: underline;
        }

        /* 🔹 Error messages */
        .error {
            color: #e74a3b;
            font-size: 0.8rem;
            margin-top: 0.3rem;
        }
    </style>
</head>
<body>

	

    <div class="container">
        <h1>Project Management Tracker</h1>
        <form action="LoginController" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" 
                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                <p class="error"><%= request.getAttribute("emailError") != null ? request.getAttribute("emailError") : "" %></p>
            </div>

            <div class="form-group">
                <label for="pass">Password</label>
                <input type="password" id="pass" name="password">
                <p class="error"><%= request.getAttribute("passwordError") != null ? request.getAttribute("passwordError") : "" %></p>
            </div>

            <button type="submit" class="btn">Login</button>

            <div class="new-user">
                Don’t have an account? <a href="Signup.jsp">Sign Up</a>
            </div>
        </form>
    </div>
</body>
</html>

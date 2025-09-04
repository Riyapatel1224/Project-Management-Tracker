<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Project Management Tracker - Sign Up</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #4e73df, #1cc88a);
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
            border-color: #4e73df;
            box-shadow: 0 0 5px rgba(78, 115, 223, 0.3);
        }

        .btn {
            width: 100%;
            padding: 0.8rem;
            margin-top: 0.5rem;
            border: none;
            border-radius: 8px;
            background: #4e73df;
            color: white;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.2s;
        }

        .btn:hover {
            background: #2e59d9;
        }

        .already {
            margin-top: 1rem;
            font-size: 0.9rem;
            color: #555;
        }

        .already a {
            color: #1cc88a;
            text-decoration: none;
            font-weight: bold;
        }

        .already a:hover {
            text-decoration: underline;
        }


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
        <form action="SignupController" method="post">
            <div class="form-group">
                <label for="fname">First Name</label>
                <input type="text" id="fname" name="firstName" value="<%= request.getParameter("firstName") != null ? request.getParameter("firstName") : "" %>">
                <p class="error"><%= request.getAttribute("firstNameError") != null ? request.getAttribute("firstNameError") : "" %></p>
            </div>

            <div class="form-group">
                <label for="lname">Last Name</label>
                <input type="text" id="lname" name="lastName" value="<%= request.getParameter("lastName") != null ? request.getParameter("lastName") : "" %>">
                <p class="error"><%= request.getAttribute("lastNameError") != null ? request.getAttribute("lastNameError") : "" %></p>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                <p class="error"><%= request.getAttribute("emailError") != null ? request.getAttribute("emailError") : "" %></p>
            </div>

            <div class="form-group">
                <label for="pass">Password</label>
                <input type="password" id="pass" name="password">
                <p class="error"><%= request.getAttribute("passwordError") != null ? request.getAttribute("passwordError") : "" %></p>
            </div>

            <button type="submit" class="btn">Sign Up</button>

            <div class="already">
                Already have an account? <a href="Login.jsp">Login</a>
            </div>
        </form>
    </div>
</body>
</html>

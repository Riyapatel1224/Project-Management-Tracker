<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Project Management Tracker</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #1cc88a, #4e73df);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .container {
            background: #fff;
            padding: 2rem 2.5rem;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            width: 85%;
            max-width: 1100px;
            text-align: center;
        }

        h1 {
            margin-bottom: 1rem;
            color: #333;
            font-size: 1.8rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        th, td {
            padding: 0.8rem;
            border: 1px solid #ccc;
            text-align: center;
        }

        th {
            background: #4e73df;
            color: white;
        }

        tr:nth-child(even) {
            background: #f8f9fc;
        }

        tr:hover {
            background: #eaf2fd;
        }

        .btn {
            margin-top: 1rem;
            padding: 0.7rem 1.2rem;
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

        .delete-btn {
            background: #e74a3b;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
        }

        .delete-btn:hover {
            background: #c0392b;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Admin Dashboard</h1>
        <p>All registered users (excluding Admins):</p>

        <table>
            <tr>
                <th>ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Action</th>
            </tr>

            <%
                try (Connection conn = DBConnection.getConnection()) {
                    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM users WHERE role <> 'admin'");
                    ResultSet rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int userId = rs.getInt("id");
            %>
                        <tr>
                            <td><%= userId %></td>
                            <td><%= rs.getString("firstName") %></td>
                            <td><%= rs.getString("lastName") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("role") %></td>
                            <td>
                                <form action="DeleteUserController" method="post" style="display:inline;">
                                    <input type="hidden" name="userId" value="<%= userId %>">
                                    <button type="submit" class="delete-btn">Delete</button>
                                </form>
                            </td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='6'>Error fetching users: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>

        <form action="LogoutController" method="post">
            <button type="submit" class="btn">Logout</button>
        </form>
    </div>
</body>
</html>

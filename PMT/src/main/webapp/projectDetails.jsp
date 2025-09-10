<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Project Details</title>

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
            width: 80%;
            max-width: 1000px;
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
            text-align: left;
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
    </style>

</head>
<body>

<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);

    if (session == null || session.getAttribute("userLoggedIn") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    int projectId = Integer.parseInt(request.getParameter("projectId"));

    try (Connection conn = DBConnection.getConnection()) {
        PreparedStatement projectStmt = conn.prepareStatement("SELECT * FROM Project WHERE projectId = ?");
        projectStmt.setInt(1, projectId);
        ResultSet projectRs = projectStmt.executeQuery();

        if (projectRs.next()) {
%>

<div class="container">
    <h1>Project Details</h1>

    <table>
        <tr><th>Title</th><td><%= projectRs.getString("title") %></td></tr>
        <tr><th>Description</th><td><%= projectRs.getString("description") %></td></tr>
        <tr><th>Technology</th><td><%= projectRs.getString("technology") %></td></tr>
        <tr><th>Estimated Hours</th><td><%= projectRs.getInt("estimatedHours") %></td></tr>
        <tr><th>Start Date</th><td><%= projectRs.getDate("startDate") %></td></tr>
        <tr><th>Completion Date</th><td><%= projectRs.getDate("completionDate") != null ? projectRs.getDate("completionDate") : "In Progress" %></td></tr>
    </table>

    <h2>Team Members</h2>
    <table>
        <tr>
            <th>User ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Role</th>
        </tr>

        <%
            PreparedStatement teamStmt = conn.prepareStatement(
                "SELECT u.id, u.firstName, u.lastName, u.email, u.role " +
                "FROM Project_team pt JOIN users u ON pt.userId = u.id " +
                "WHERE pt.projectId = ?");
            teamStmt.setInt(1, projectId);
            ResultSet teamRs = teamStmt.executeQuery();

            while (teamRs.next()) {
        %>
            <tr>
                <td><%= teamRs.getInt("id") %></td>
                <td><%= teamRs.getString("firstName") %></td>
                <td><%= teamRs.getString("lastName") %></td>
                <td><%= teamRs.getString("email") %></td>
                <td><%= teamRs.getString("role") %></td>
            </tr>
        <%
            }
        %>
    </table>

    <form action="manager.jsp" method="get">
        <button type="submit" class="btn">Back to Projects</button>
    </form>
</div>

<%
        } else {
            out.println("<p>Project not found.</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>

</body>
</html>

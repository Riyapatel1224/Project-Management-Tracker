<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Project Management Tracker - Manager Dashboard</title>

    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

    <script>
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
        };
    </script>

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
            width: 90%;
            max-width: 1200px;
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

        .details-btn {
            background: #4e73df;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            transition: background 0.2s;
        }

        .details-btn:hover {
            background: #2e59d9;
        }
    </style>
</head>
<body>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    Boolean loggedIn = (Boolean) session.getAttribute("userLoggedIn");
    String role = (String) session.getAttribute("userRole");

    if (loggedIn == null || !loggedIn || !"manager".equalsIgnoreCase(role)) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<div class="container">
    <h1>Manager Dashboard - Projects</h1>

    <form action="createProject.jsp" method="get">
        <button type="submit" class="btn">Create New Project</button>
    </form>

    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Technology</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <%
            try (Connection conn = DBConnection.getConnection()) {
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM Project");
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    int projectId = rs.getInt("projectId");
                    String title = rs.getString("title");
                    String technology = rs.getString("technology");
                    String status = (rs.getDate("completionDate") == null) ? "Active" : "Completed";
        %>
                    <tr>
                        <td><%= projectId %></td>
                        <td><%= title %></td>
                        <td><%= technology %></td>
                        <td><%= status %></td>
                        <td>
                            <form action="projectDetails.jsp" method="get" style="display:inline;">
                                <input type="hidden" name="projectId" value="<%= projectId %>">
                                <button type="submit" class="details-btn">View Details</button>
                            </form>
                        </td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='5'>Error loading projects: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>

    <form action="LogoutController" method="post">
        <button type="submit" class="btn">Logout</button>
    </form>
</div>

</body>
</html>

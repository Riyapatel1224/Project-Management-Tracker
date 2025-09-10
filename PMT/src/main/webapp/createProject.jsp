<%@ page import="java.sql.*, com.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create New Project - Project Management Tracker</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #4e73df, #1cc88a);
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
            max-width: 1000px;
            text-align: center;
        }

        h1 {
            margin-bottom: 1rem;
            color: #333;
            font-size: 1.8rem;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            text-align: left;
        }

        label {
		    font-weight: 600;
		    color: #555;  
		    margin-bottom: 0.3rem;
		    display: block;
		}

        input, textarea, select {
             width: 100%;
			 padding: 0.7rem;
			 border-radius: 8px;
			 border: 1px solid #ccc;
			 font-size: 0.95rem;
			 box-sizing: border-box;
			 transition: all 0.2s ease;
        }
        
        input:focus, textarea:focus, select:focus {
		    border-color: #4e73df;          
		    box-shadow: 0 0 6px rgba(78, 115, 223, 0.4); 
		    outline: none;                  
		}

        .submit-btn {
            padding: 0.5rem 1.5rem; 
            border: none; 
            border-radius: 8px; 
            background: #4e73df; 
            color: white; 
            font-size: 1rem; 
            cursor: pointer; 
            transition: background 0.2s; 
            margin: 1rem auto 1rem;
            display: inline-block;
        }

        .submit-btn:hover {
            background: #2e59d9;
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


        .add-btn {
            background: #e74a3b;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
        }

        .add-btn:hover {
            background: #c0392b;
        }

        .added {
            background: #17a673;
            cursor: default;
        }

        h2 {
            margin-top: 2rem; 
            margin-bottom: 1rem;
            text-align: center;
            color: #333;
        }
    </style>

    <script>
	    function toggleAddRemove(button, userId) {
	        const form = document.getElementById('projectForm');
	        const existingInput = form.querySelector('input[value="' + userId + '"]');
	
	        if (button.classList.contains('added')) {
	            if (existingInput) {
	                form.removeChild(existingInput);
	            }
	            button.classList.remove('added');
	            button.innerText = 'Add';
	        } else {

	            if (!existingInput) {
	                const input = document.createElement('input');
	                input.type = 'hidden';
	                input.name = 'teamMemberIds';
	                input.value = userId;
	                form.appendChild(input);
	            }
	            button.classList.add('added');
	            button.innerText = 'Remove';
	        }
	    }
	</script>

</head>
<body>

    <div class="container">
        <h1>Create New Project</h1>

        <form id="projectForm" action="createProjectController" method="post">
            <div>
                <label for="title">Project Title</label>
                <input type="text" id="title" name="title" placeholder="Enter project title" required />
            </div>

            <div>
                <label for="description">Project Description</label>
                <textarea id="description" name="description" rows="4" placeholder="Enter description" required></textarea>
            </div>

            <div>
                <label for="technology">Technologies</label>
                <input type="text" id="technology" name="technology" placeholder="e.g. Java, Spring, MySQL" required />
            </div>

            <div>
                <label for="estimatedHours">Estimated Hours</label>
                <input type="number" id="estimatedHours" name="estimatedHours" placeholder="e.g. 120" required />
            </div>

            <div>
                <label for="startDate">Start Date</label>
                <input type="date" id="startDate" name="startDate" required />
            </div>

            <div>
                <label for="completionDate">Completion Date</label>
                <input type="date" id="completionDate" name="completionDate" />
            </div>

            <h2>Select Team Members</h2>

            <table>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Add</th>
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
    								<button type="button" class="add-btn" onclick="toggleAddRemove(this, '<%= userId %>')">Add</button>
								</td>

                            </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6'>Error fetching users: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </table>

            <button type="submit" class="submit-btn">Create Project</button>
        </form>
    </div>
</body>
</html>

package com.controller;

import java.io.IOException;
import java.security.Provider.Service;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.cj.Session;
import com.util.DBConnection;

@WebServlet("/SignupController")
public class SignupController extends HttpServlet{
	

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		
		System.out.println("fn : "+firstName);
		System.out.println("ls : "+lastName);
		System.out.println("e : "+email);
		System.out.println("ps : "+password);
		
		
		boolean isError = false;
		String error = " ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		


		if(firstName == null || firstName.trim().length() == 0)
		{
			isError = true;
			error+="Enter the First Name";
			request.setAttribute("firstNameError", "Please Enter FirstName");

		}
		if(lastName == null || lastName.trim().length() == 0)
		{
			isError = true;
			error+="Enter the First Name";
			request.setAttribute("lastNameError", "Please Enter lastName");

		}
		if(email == null || email.isBlank() )
		{
			isError = true;
			error += "Enter the Email";
			request.setAttribute("emailError", "Please Enter email");

		}
		
		if(password == null || password.isBlank())
		{
			isError = true;
			error += "Enter the Password";
			request.setAttribute("passwordError", "Please Enter password");

		}
		if(isError == true) {
            RequestDispatcher rd = request.getRequestDispatcher("Signup.jsp");
            rd.forward(request, response);
            
        } 
		
		else {
			
			//Get Database connection
			conn = DBConnection.getConnection();
			
			if(conn!= null) {
				String sql = "INSERT INTO users (firstName,lastName, email, password,role) VALUES (?,?,?,?,?)";
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, firstName);
					pstmt.setString(2, lastName);
					pstmt.setString(3, email);
					pstmt.setString(4, password);
					pstmt.setString(5, role);
					
					int rows = pstmt.executeUpdate();
					
					if (rows > 0) {
		                System.out.println("Success: User Registered");
		                System.out.println();
		                response.sendRedirect("Login.jsp");
		                
		                

		            } else {
		                request.setAttribute("signupError", "Registration failed. Please try again.");
		                RequestDispatcher rd = request.getRequestDispatcher("Signup.jsp");
		                rd.forward(request, response);
		            }
					
				} catch (SQLException e) {
					e.printStackTrace();
					response.sendRedirect("Signup.jsp?error=db");
				}
			}
		}
		
		
		
		
	}


}

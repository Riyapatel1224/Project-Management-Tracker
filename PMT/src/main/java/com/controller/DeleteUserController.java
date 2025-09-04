package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.DBConnection;

@WebServlet("/DeleteUserController")
public class DeleteUserController extends HttpServlet{
	

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int userId = Integer.parseInt(request.getParameter("userId"));
		
		try(Connection conn = DBConnection.getConnection()){
			
			PreparedStatement pstmt = conn.prepareStatement("delete from users where id = ?");
			pstmt.setInt(1, userId);
			
			int rows = pstmt.executeUpdate();
			
			if(rows>0) {
				System.out.println("User Deleted : "+userId);
			}
			else {
				System.out.println("No user found : "+userId);
			}
			
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("admin.jsp");
	}
	
}

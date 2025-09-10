package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.DBConnection;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        

        boolean isError = false;


        if (email == null || email.trim().isEmpty()) {
            isError = true;
            request.setAttribute("emailError", "Email is required");
        }

        if (password == null || password.trim().isEmpty()) {
            isError = true;
            request.setAttribute("passwordError", "Password is required");
        }

        if (isError) {
            RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
            rd.forward(request, response);
            return;
        }


        try (Connection conn = DBConnection.getConnection()) {


            PreparedStatement checkEmail = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
            checkEmail.setString(1, email);
            ResultSet emailResult = checkEmail.executeQuery();

            if (!emailResult.next()) {
                // Email not found
                request.setAttribute("emailError", "Email not found");
                RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
                rd.forward(request, response);
                return;
            } else {

                String dbPassword = emailResult.getString("password");
                String role = emailResult.getString("role");

                if (!dbPassword.equals(password)) {
                    request.setAttribute("passwordError", "Incorrect password");
                    RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
                    rd.forward(request, response);
                    return;
                }

                if (dbPassword.equals(password)) {
                    // Set session attributes
                    request.getSession().setAttribute("userLoggedIn", true);
                    request.getSession().setAttribute("userRole", role);  // Save user role in session

                    if ("admin".equalsIgnoreCase(role)) {
                        response.sendRedirect("admin.jsp");
                    }
                    
                    else if ("manager".equalsIgnoreCase(role)) {
                        response.sendRedirect("manager.jsp");
                    }
                    
                    else if ("frontend".equalsIgnoreCase(role)) {
                        response.sendRedirect("frontend.jsp");
                    }
                    
                    else if ("backend".equalsIgnoreCase(role)) {
                        response.sendRedirect("backend.jsp");
                    }
                    
                    else if ("devops".equalsIgnoreCase(role)) {
                        response.sendRedirect("devops.jsp");
                    }
                    
                    else if ("fullstack".equalsIgnoreCase(role)) {
                        response.sendRedirect("fullstack.jsp");
                    }
                    
                    else if ("database administrator".equalsIgnoreCase(role)) {
                        response.sendRedirect("databaseAdministrator.jsp");
                    }
                    
                    else if ("qa/engineer".equalsIgnoreCase(role)) {
                        response.sendRedirect("qaEngineer.jsp");
                    }
                    
                    else if ("ui/ux".equalsIgnoreCase(role)) {
                        response.sendRedirect("uiux.jsp");
                    }
                    
                    else {
                        response.sendRedirect("Login.jsp");
                    }
                }

            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred");
            RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
            rd.forward(request, response);
        }
    }
}

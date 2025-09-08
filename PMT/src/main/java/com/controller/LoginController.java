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


                if ("admin".equalsIgnoreCase(role)) {
                    RequestDispatcher rd = request.getRequestDispatcher("admin.jsp");
                    rd.forward(request, response);
                }
                else if("manager".equalsIgnoreCase(role)) {
                	 RequestDispatcher rd = request.getRequestDispatcher("manager.jsp");
                     rd.forward(request, response);
                }
                else if("frontend".equalsIgnoreCase(role)) {
                	RequestDispatcher rd = request.getRequestDispatcher("frontend.jsp");
                    rd.forward(request, response);
                }
                else if("backend".equalsIgnoreCase(role)) {
                	RequestDispatcher rd = request.getRequestDispatcher("backend.jsp");
                    rd.forward(request, response);
                }
                else if("devops".equalsIgnoreCase(role)) {
                	RequestDispatcher rd = request.getRequestDispatcher("devops.jsp");
                    rd.forward(request, response);
                }
                else if("fullstack".equalsIgnoreCase(role)) {
                	RequestDispatcher rd = request.getRequestDispatcher("fullstack.jsp");
                    rd.forward(request, response);
                }
                else if("database administrator".equalsIgnoreCase(role)) {
                	RequestDispatcher rd = request.getRequestDispatcher("databaseAdministrator.jsp");
                    rd.forward(request, response);
                }
                else if("qa/engineer".equalsIgnoreCase(role)) {
                	RequestDispatcher rd = request.getRequestDispatcher("qa/engineer.jsp");
                    rd.forward(request, response);
                }
                else if("ui/ux".equalsIgnoreCase(role)) {
                	RequestDispatcher rd = request.getRequestDispatcher("uiux.jsp");
                    rd.forward(request, response);
                }
                
               
                else {
                    RequestDispatcher rd = request.getRequestDispatcher("Home.jsp");
                    rd.forward(request, response);
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

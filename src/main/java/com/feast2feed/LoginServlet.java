package com.feast2feed;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/food_donation_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String role = request.getParameter("role");
        String emailOrUsername = request.getParameter("email");
        String password = request.getParameter("password");

        if (role == null || role.isEmpty() || 
            emailOrUsername == null || emailOrUsername.isEmpty() || 
            password == null || password.isEmpty()) {
            out.print("{\"success\":false,\"message\":\"Missing credentials\"}");
            return;
        }

        // Trim and clean inputs
        role = role.trim().toLowerCase();
        emailOrUsername = emailOrUsername.trim();

        String sql;
        boolean isAdmin = "admin".equals(role);

        // Build SQL depending on role
        if ("donor".equals(role)) {
            sql = "SELECT id, password, email FROM donors WHERE email = ?";
        } else if ("ngo".equals(role)) {
            sql = "SELECT id, password, email FROM ngos WHERE email = ?";
        } else if (isAdmin) {
            sql = "SELECT id, password, username FROM admins WHERE username = ?";
        } else {
            out.print("{\"success\":false,\"message\":\"Invalid role\"}");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, emailOrUsername);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String hashedPassword = rs.getString("password");
                        if (BCrypt.checkpw(password, hashedPassword)) {
                            HttpSession session = request.getSession(true);
                            session.setAttribute("userId", rs.getInt("id"));
                            session.setAttribute("role", role); // Use cleaned role
                            
                            // Set session timeout to 30 minutes
                            session.setMaxInactiveInterval(30 * 60);

                            if ("donor".equals(role) || "ngo".equals(role)) {
                                String email = rs.getString("email");
                                session.setAttribute("email", email);
                                System.out.println("LoginServlet: Setting session for " + role + " - email: " + email);
                            } else if (isAdmin) {
                                String username = rs.getString("username");
                                session.setAttribute("username", username);
                                System.out.println("LoginServlet: Setting session for admin - username: " + username);
                            }

                            // Debug session attributes
                            System.out.println("LoginServlet: Session attributes set - userId: " + 
                                session.getAttribute("userId") + ", role: " + session.getAttribute("role") +
                                ", email: " + session.getAttribute("email"));

                            out.print("{\"success\":true,\"message\":\"Login successful\"}");
                        } else {
                            out.print("{\"success\":false,\"message\":\"Invalid password\"}");
                        }
                    } else {
                        out.print("{\"success\":false,\"message\":\"User not found\"}");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Server error: " 
                      + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }
}
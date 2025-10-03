package com.feast2feed;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.regex.Pattern;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/food_donation_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("userRole"); // "donor" or "ngo"
        String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String errorMessage = null;

        // Basic validation
        if (name == null || name.trim().isEmpty()) {
            errorMessage = "Name is required";
        } else if (mobile == null || !Pattern.matches("\\d{10}", mobile)) {
            errorMessage = "Enter a valid 10-digit mobile number";
        } else if (email == null || !Pattern.matches("\\S+@\\S+\\.\\S+", email)) {
            errorMessage = "Please enter a valid email address";
        } else if (password == null || password.length() < 6) {
            errorMessage = "Password must be at least 6 characters";
        } else if (!password.equals(confirmPassword)) {
            errorMessage = "Passwords do not match";
        } else if (!("donor".equals(role) || "ngo".equals(role))) {
            errorMessage = "Invalid role selected";
        }

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String tableName = "donors";
        if ("ngo".equals(role)) {
            tableName = "ngos";
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
                String checkQuery = "SELECT id FROM " + tableName + " WHERE email = ? OR mobile = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                    checkStmt.setString(1, email);
                    checkStmt.setString(2, mobile);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (rs.next()) {
                            errorMessage = "Email or Mobile already registered";
                            request.setAttribute("errorMessage", errorMessage);
                            request.getRequestDispatcher("register.jsp").forward(request, response);
                            return;
                        }
                    }
                }

                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

                String insertQuery = "INSERT INTO " + tableName + " (name, email, mobile, password) VALUES (?, ?, ?, ?)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                    insertStmt.setString(1, name);
                    insertStmt.setString(2, email);
                    insertStmt.setString(3, mobile);
                    insertStmt.setString(4, hashedPassword);
                    int rows = insertStmt.executeUpdate();
                    if (rows > 0) {
                        request.setAttribute("successMessage", "Registration successful! You can now login.");
                    } else {
                        request.setAttribute("errorMessage", "Registration failed. Please try again.");
                    }
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMessage = "Database error: " + e.getMessage();
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}

package com.feast2feed;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.*;
import java.time.LocalTime;

@WebServlet("/DonationServlet")
public class DonationServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/food_donation_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");

        try (PrintWriter out = resp.getWriter()) {
            // Session validation
            HttpSession session = req.getSession(false);
            if (session == null || !"donor".equals(session.getAttribute("role")) || session.getAttribute("email") == null) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"success\":false,\"message\":\"Unauthorized. Please login as donor.\"}");
                return;
            }

            // Time restriction: 8 AM to 11 PM
            LocalTime now = LocalTime.now();
            LocalTime start = LocalTime.of(8, 0);
            LocalTime end = LocalTime.of(23, 59, 0);
            if (now.isBefore(start) || now.isAfter(end)) {
                resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
                out.print("{\"success\":false,\"message\":\"Donations allowed only between 8 AM and 11 PM.\"}");
                return;
            }

            // Get params
            String donorName = req.getParameter("donorName");
            String mobile = req.getParameter("mobile");
            String pickupAddress = req.getParameter("pickupAddress");
            String foodTypes = req.getParameter("foodTypes"); // Comma-separated food types
            String notes = req.getParameter("notes");
            String email = (String) session.getAttribute("email");

            // Validate input parameters
            if (donorName == null || donorName.trim().isEmpty() ||
                mobile == null || !mobile.matches("\\d{10}") ||
                pickupAddress == null || pickupAddress.trim().isEmpty() ||
                foodTypes == null || foodTypes.trim().isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"Validation failed. Please check all required fields.\"}");
                return;
            }

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
                    // Check if donor exists
                    String checkSql = "SELECT email FROM donors WHERE email = ?";
                    try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                        checkStmt.setString(1, email);
                        try (ResultSet rs = checkStmt.executeQuery()) {
                            if (!rs.next()) {
                                resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
                                out.print("{\"success\":false,\"message\":\"Donor email not authorized.\"}");
                                return;
                            }
                        }
                    }

                    // Insert donation record with multiple food types
                    String insertSql = "INSERT INTO donations (donor_email, donor_name, mobile, pickup_address, food_type, notes, status) VALUES (?, ?, ?, ?, ?, ?, 'waiting')";
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setString(1, email);
                        insertStmt.setString(2, donorName.trim());
                        insertStmt.setString(3, mobile.trim());
                        insertStmt.setString(4, pickupAddress.trim());
                        insertStmt.setString(5, foodTypes.trim());
                        insertStmt.setString(6, notes != null ? notes.trim() : "");
                        int inserted = insertStmt.executeUpdate();

                        if (inserted > 0) {
                            out.print("{\"success\":true,\"message\":\"Donation submitted successfully.\"}");
                        } else {
                            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                            out.print("{\"success\":false,\"message\":\"Failed to save donation.\"}");
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                StringWriter sw = new StringWriter();
                e.printStackTrace(new PrintWriter(sw));
                String exceptionAsString = sw.toString().replace("\"", "\\\"");
                out.print("{\"success\":false,\"message\":\"Server error: " + exceptionAsString + "\"}");
            }
        }
    }
}
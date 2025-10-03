package com.feast2feed;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.*;

@WebServlet("/CancelDeliveryServlet")
public class CancelDeliveryServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/food_donation_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(false);
        if (session == null || !"ngo".equals(session.getAttribute("role")) || session.getAttribute("email") == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"success\":false,\"message\":\"Unauthorized. Please login as NGO.\"}");
            return;
        }

        String ngoEmail = (String) session.getAttribute("email");
        String donationIdStr = req.getParameter("donationId");

        if (donationIdStr == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\":false,\"message\":\"Missing donation ID.\"}");
            return;
        }

        try {
            int donationId = Integer.parseInt(donationIdStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
                
                // Verify NGO owns this donation and it's in picked_up status
                if (!isDonationValidForCancellation(conn, donationId, ngoEmail)) {
                    resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    out.print("{\"success\":false,\"message\":\"You can only cancel deliveries that are currently in transit.\"}");
                    return;
                }

                // Update status to street_distributed
                String updateSql = "UPDATE donations SET status = 'street_distributed', delivered_at = CURRENT_TIMESTAMP WHERE id = ?";
                
                try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                    stmt.setInt(1, donationId);
                    
                    int rowsUpdated = stmt.executeUpdate();

                    // Send cancellation email to donor
                    if (rowsUpdated > 0) {
                        try {
                            sendCancellationEmail(conn, donationId);
                        } catch (Exception e) {
                            e.printStackTrace();
                            // Log but don't fail the response
                        }
                    }

                    if (rowsUpdated > 0) {
                        out.print("{\"success\":true,\"message\":\"Delivery cancelled successfully. Donation redirected to street distribution.\"}");
                    } else {
                        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        out.print("{\"success\":false,\"message\":\"Failed to cancel delivery.\"}");
                    }
                }
            }
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\":false,\"message\":\"Invalid donation ID.\"}");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Server error: \" + e.getMessage()}");
        }
    }

    private boolean isDonationValidForCancellation(Connection conn, int donationId, String ngoEmail) throws SQLException {
        String sql = "SELECT d.status FROM donations d " +
                   "JOIN ngos n ON d.ngo_id = n.id " +
                   "WHERE d.id = ? AND n.email = ? AND d.status = 'picked_up'";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, donationId);
            stmt.setString(2, ngoEmail);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    private void sendCancellationEmail(Connection conn, int donationId) throws Exception {
        String query = "SELECT d.donor_email, dr.name AS donor_name, d.food_type " +
                       "FROM donations d " +
                       "LEFT JOIN donors dr ON d.donor_email = dr.email " +
                       "WHERE d.id = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, donationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String donorEmail = rs.getString("donor_email");
                    String donorName = rs.getString("donor_name");
                    String foodType = rs.getString("food_type");

                    if (donorEmail != null && !donorEmail.isEmpty()) {
                        // Send email asynchronously to avoid blocking
                        new Thread(() -> {
                            try {
                                EmailUtil.sendCancellationEmail(donorEmail, donorName, foodType);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }).start();
                    }
                }
            }
        }
    }
}
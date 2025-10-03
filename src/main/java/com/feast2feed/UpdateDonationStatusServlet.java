package com.feast2feed;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.*;
import jakarta.mail.MessagingException;

@WebServlet("/UpdateDonationStatusServlet")
public class UpdateDonationStatusServlet extends HttpServlet {
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
        String newStatus = req.getParameter("newStatus");

        if (donationIdStr == null || newStatus == null || 
            !(newStatus.equals("picked_up") || newStatus.equals("delivered"))) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\":false,\"message\":\"Invalid parameters.\"}");
            return;
        }

        try {
            int donationId = Integer.parseInt(donationIdStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
                
                // Verify NGO owns this donation
                if (!isDonationOwnedByNgo(conn, donationId, ngoEmail)) {
                    resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    out.print("{\"success\":false,\"message\":\"You don't have permission to update this donation.\"}");
                    return;
                }

                // Verify status transition is valid
                if (!isValidStatusTransition(conn, donationId, newStatus)) {
                    resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"success\":false,\"message\":\"Invalid status transition.\"}");
                    return;
                }

                // Update status
                String timestampColumn = newStatus.equals("picked_up") ? "picked_up_at" : "delivered_at";
                String updateSql = "UPDATE donations SET status = ?, " + timestampColumn + " = CURRENT_TIMESTAMP WHERE id = ?";
                
                try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                    stmt.setString(1, newStatus);
                    stmt.setInt(2, donationId);
                    
                    int rowsUpdated = stmt.executeUpdate();

                    // After successful update and if delivered, send thank you email
                    if ("delivered".equals(newStatus) && rowsUpdated > 0) {
                        try {
                            sendThankYouEmail(conn, donationId);
                        } catch (MessagingException e) {
                            e.printStackTrace();
                            // Log but don't fail the response
                        }
                    }

                    if (rowsUpdated > 0) {
                        out.print("{\"success\":true,\"message\":\"Status updated successfully.\"}");
                    } else {
                        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        out.print("{\"success\":false,\"message\":\"Failed to update status.\"}");
                    }
                }
            }
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\":false,\"message\":\"Invalid donation ID.\"}");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Server error: " + e.getMessage() + "\"}");
        }
    }

    private boolean isDonationOwnedByNgo(Connection conn, int donationId, String ngoEmail) throws SQLException {
        String sql = "SELECT d.id FROM donations d " +
                   "JOIN ngos n ON d.ngo_id = n.id " +
                   "WHERE d.id = ? AND n.email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, donationId);
            stmt.setString(2, ngoEmail);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    private boolean isValidStatusTransition(Connection conn, int donationId, String newStatus) throws SQLException {
        String sql = "SELECT status FROM donations WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, donationId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String currentStatus = rs.getString("status");
                    return (currentStatus.equals("claimed") && newStatus.equals("picked_up")) ||
                           (currentStatus.equals("picked_up") && newStatus.equals("delivered"));
                }
            }
        }
        return false;
    }

    private void sendThankYouEmail(Connection conn, int donationId) throws Exception {
        String query = "SELECT d.donor_email, dr.name AS donor_name, o.name AS orphanage_name, o.address AS orphanage_address " +
                       "FROM donations d " +
                       "LEFT JOIN donors dr ON d.donor_email = dr.email " +
                       "LEFT JOIN orphanages o ON d.orphanage_id = o.id " +
                       "WHERE d.id = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, donationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String donorEmail = rs.getString("donor_email");
                    String donorName = rs.getString("donor_name");
                    String orphanageName = rs.getString("orphanage_name");
                    String orphanageAddress = rs.getString("orphanage_address");

                    if (donorEmail != null && !donorEmail.isEmpty()) {
                        // Send email asynchronously to avoid blocking
                        new Thread(() -> {
                            try {
                                EmailUtil.sendThankYouEmail(donorEmail, donorName, orphanageName, orphanageAddress);
                            } catch (jakarta.mail.MessagingException e) {
                                e.printStackTrace();
                            } catch (UnsupportedEncodingException e) {
								e.printStackTrace();
							}
                        }).start();
                    }
                }
            }
        }
    }
}
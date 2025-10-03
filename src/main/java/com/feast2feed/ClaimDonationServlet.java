package com.feast2feed;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/ClaimDonationServlet")
public class ClaimDonationServlet extends HttpServlet {
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
        String orphanageIdStr = req.getParameter("orphanageId");

        if (donationIdStr == null || orphanageIdStr == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\":false,\"message\":\"Missing required parameters.\"}");
            return;
        }

        try {
            int donationId = Integer.parseInt(donationIdStr);
            int orphanageId = Integer.parseInt(orphanageIdStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
                
                // Get NGO ID
                int ngoId = getNgoId(conn, ngoEmail);
                if (ngoId == -1) {
                    resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    out.print("{\"success\":false,\"message\":\"NGO not found.\"}");
                    return;
                }

                // Check if donation is still available
                if (!isDonationAvailable(conn, donationId)) {
                    resp.setStatus(HttpServletResponse.SC_CONFLICT);
                    out.print("{\"success\":false,\"message\":\"Donation has already been claimed.\"}");
                    return;
                }

                // Check if orphanage exists
                if (!isOrphanageValid(conn, orphanageId)) {
                    resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"success\":false,\"message\":\"Invalid orphanage selected.\"}");
                    return;
                }

                // Claim the donation
                String updateSql = "UPDATE donations SET status = 'claimed', ngo_id = ?, orphanage_id = ?, claimed_at = CURRENT_TIMESTAMP WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                    stmt.setInt(1, ngoId);
                    stmt.setInt(2, orphanageId);
                    stmt.setInt(3, donationId);
                    
                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.print("{\"success\":true,\"message\":\"Donation claimed successfully.\"}");
                    } else {
                        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        out.print("{\"success\":false,\"message\":\"Failed to claim donation.\"}");
                    }
                }
            }
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\":false,\"message\":\"Invalid parameters.\"}");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Server error: \" + e.getMessage()}");
        }
    }

    private int getNgoId(Connection conn, String ngoEmail) throws SQLException {
        String sql = "SELECT id FROM ngos WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, ngoEmail);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? rs.getInt("id") : -1;
            }
        }
    }

    private boolean isDonationAvailable(Connection conn, int donationId) throws SQLException {
        String sql = "SELECT status FROM donations WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, donationId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && "waiting".equals(rs.getString("status"));
            }
        }
    }

    private boolean isOrphanageValid(Connection conn, int orphanageId) throws SQLException {
        String sql = "SELECT id FROM orphanages WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orphanageId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }
}
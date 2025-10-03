package com.feast2feed;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/NgoDonationServlet")
public class NgoDonationServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/food_donation_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        System.out.println("=== NGO Donation Servlet Debug ===");
        System.out.println("Session: " + session);
        
        if (session != null) {
            System.out.println("Session role: " + session.getAttribute("role"));
            System.out.println("Session email: " + session.getAttribute("email"));
            System.out.println("Session user ID: " + session.getAttribute("userId"));
            
            // Debug all session attributes
            java.util.Enumeration<String> attributeNames = session.getAttributeNames();
            while (attributeNames.hasMoreElements()) {
                String name = attributeNames.nextElement();
                System.out.println("Session attr - " + name + ": " + session.getAttribute(name));
            }
        }

        // Improved session validation
        if (session == null) {
            System.out.println("Redirecting to login - No session found");
            resp.sendRedirect("login.jsp");
            return;
        }
        
        String role = (String) session.getAttribute("role");
        String email = (String) session.getAttribute("email");
        
        if (role == null || !role.equals("ngo") || email == null) {
            System.out.println("Redirecting to login - Invalid session attributes");
            System.out.println("Role: " + role + ", Email: " + email);
            session.invalidate();
            resp.sendRedirect("login.jsp");
            return;
        }

        System.out.println("NGO Email from session: " + email);
        
        List<Donation> availableDonations = new ArrayList<>();
        List<Donation> myClaims = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
                
                // Get NGO ID with better error handling
                int ngoId = getNgoId(conn, email);
                System.out.println("NGO ID found: " + ngoId);
                
                if (ngoId == -1) {
                    System.out.println("NGO not found in database, invalidating session and redirecting to login");
                    session.invalidate();
                    resp.sendRedirect("login.jsp");
                    return;
                }

                // Load available donations (status = 'waiting')
                String availableSql = "SELECT d.* FROM donations d WHERE d.status = 'waiting' ORDER BY d.created_at DESC";
                System.out.println("Executing available donations query: " + availableSql);
                
                try (PreparedStatement stmt = conn.prepareStatement(availableSql)) {
                    try (ResultSet rs = stmt.executeQuery()) {
                        int count = 0;
                        while (rs.next()) {
                            count++;
                            availableDonations.add(createDonationFromResultSet(rs));
                        }
                        System.out.println("Found " + count + " available donations");
                    }
                }

                // Load my claims - UPDATED to include street_distributed status
                String myClaimsSql = "SELECT d.*, o.name as orphanage_name FROM donations d " +
                                   "LEFT JOIN orphanages o ON d.orphanage_id = o.id " +
                                   "WHERE d.ngo_id = ? AND d.status IN ('claimed', 'picked_up', 'delivered', 'street_distributed') " +
                                   "ORDER BY d.claimed_at DESC";
                System.out.println("Executing my claims query with NGO ID: " + ngoId);
                
                try (PreparedStatement stmt = conn.prepareStatement(myClaimsSql)) {
                    stmt.setInt(1, ngoId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        int count = 0;
                        while (rs.next()) {
                            count++;
                            Donation donation = createDonationFromResultSet(rs);
                            donation.setOrphanageName(rs.getString("orphanage_name"));
                            myClaims.add(donation);
                        }
                        System.out.println("Found " + count + " my claims");
                    }
                }
                
                System.out.println("Total available donations: " + availableDonations.size());
                System.out.println("Total my claims: " + myClaims.size());
                
            }
        } catch (Exception e) {
            System.out.println("Error in NgoDonationServlet: " + e.getMessage());
            e.printStackTrace();
            // Don't redirect on error, just show empty lists
        }

        req.setAttribute("availableDonations", availableDonations);
        req.setAttribute("myClaims", myClaims);
        req.getRequestDispatcher("request.jsp").forward(req, resp);
    }

    private int getNgoId(Connection conn, String ngoEmail) throws SQLException {
        String sql = "SELECT id FROM ngos WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, ngoEmail);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        }
        return -1;
    }

    private Donation createDonationFromResultSet(ResultSet rs) throws SQLException {
        Donation donation = new Donation();
        donation.setId(rs.getInt("id"));
        donation.setFoodType(rs.getString("food_type"));
        donation.setPickupAddress(rs.getString("pickup_address"));
        donation.setNotes(rs.getString("notes"));
        donation.setStatus(rs.getString("status"));
        donation.setCreatedAt(rs.getTimestamp("created_at"));
        donation.setDonorName(rs.getString("donor_name"));
        donation.setMobile(rs.getString("mobile"));
        donation.setDonorEmail(rs.getString("donor_email"));
        return donation;
    }
}
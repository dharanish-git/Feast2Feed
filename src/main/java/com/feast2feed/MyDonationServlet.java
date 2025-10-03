package com.feast2feed;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/MyDonationServlet")
public class MyDonationServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/food_donation_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"donor".equals(session.getAttribute("role")) || session.getAttribute("email") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String donorEmail = (String) session.getAttribute("email");
        List<Donation> donations = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
                String sql = "SELECT d.id, d.food_type, d.pickup_address, d.notes, d.status, d.created_at, " +
                             "o.name AS orphanage_name, dr.name AS donor_name, dr.mobile AS donor_mobile " +
                             "FROM donations d " +
                             "LEFT JOIN orphanages o ON d.orphanage_id = o.id " +
                             "LEFT JOIN donors dr ON d.donor_email = dr.email " +
                             "WHERE d.donor_email = ? ORDER BY d.created_at DESC";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, donorEmail);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            Donation donation = new Donation();
                            donation.setId(rs.getInt("id"));
                            donation.setFoodType(rs.getString("food_type"));
                            donation.setPickupAddress(rs.getString("pickup_address"));
                            donation.setNotes(rs.getString("notes"));
                            donation.setStatus(rs.getString("status"));
                            donation.setCreatedAt(rs.getTimestamp("created_at"));
                            donation.setOrphanageName(rs.getString("orphanage_name"));
                            donation.setDonorName(rs.getString("donor_name"));
                            donation.setMobile(rs.getString("donor_mobile"));
                            donations.add(donation);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("donations", donations);
        req.getRequestDispatcher("mydonation.jsp").forward(req, resp);
    }
}

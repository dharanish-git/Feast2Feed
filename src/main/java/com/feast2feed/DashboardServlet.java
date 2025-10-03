package com.feast2feed;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.LocalDate;
import org.json.JSONObject;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/food_donation_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        resp.setHeader("Access-Control-Allow-Origin", "*");
        
        JSONObject responseJson = new JSONObject();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
                
                // Get total donations
                int totalDonations = getTotalDonations(conn);
                
                // Get today's donations
                int todayDonations = getTodayDonations(conn);
                
                // Get monthly donations
                int monthlyDonations = getMonthlyDonations(conn);
                
                // Get total orphanages
                int totalOrphanages = getTotalOrphanages(conn);

                responseJson.put("success", true);
                responseJson.put("totalDonations", totalDonations);
                responseJson.put("todayDonations", todayDonations);
                responseJson.put("monthlyDonations", monthlyDonations);
                responseJson.put("totalOrphanages", totalOrphanages);

            }
        } catch (Exception e) {
            e.printStackTrace();
            responseJson.put("success", false);
            responseJson.put("message", "Error retrieving dashboard data: " + e.getMessage());
        }

        try (PrintWriter out = resp.getWriter()) {
            out.print(responseJson.toString());
        }
    }

    private int getTotalDonations(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) as count FROM donations";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt("count") : 0;
        }
    }

    private int getTodayDonations(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) as count FROM donations WHERE DATE(created_at) = CURDATE()";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt("count") : 0;
        }
    }

    private int getMonthlyDonations(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) as count FROM donations WHERE MONTH(created_at) = MONTH(CURDATE()) AND YEAR(created_at) = YEAR(CURDATE())";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt("count") : 0;
        }
    }

    private int getTotalOrphanages(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) as count FROM orphanages";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt("count") : 0;
        }
    }
}
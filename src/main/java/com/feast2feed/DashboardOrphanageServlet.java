package com.feast2feed;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/DashboardOrphanageServlet")
public class DashboardOrphanageServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/food_donation_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        resp.setHeader("Access-Control-Allow-Origin", "*");
        PrintWriter out = resp.getWriter();

        System.out.println("DashboardOrphanageServlet: GET request received");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("JDBC Driver loaded successfully");
            
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
                System.out.println("Database connection established");
                
                String action = req.getParameter("action");
                System.out.println("Action parameter: " + action);
                
                if ("get".equals(action)) {
                    String idParam = req.getParameter("id");
                    System.out.println("Get single orphanage ID: " + idParam);
                    if (idParam != null && !idParam.isEmpty()) {
                        int id = Integer.parseInt(idParam);
                        getOrphanage(conn, id, out);
                    } else {
                        sendError(out, "Missing orphanage ID");
                    }
                } else {
                    System.out.println("Getting all orphanages");
                    getAllOrphanages(conn, out);
                }
            } catch (SQLException e) {
                System.err.println("Database error: " + e.getMessage());
                e.printStackTrace();
                sendError(out, "Database error: " + e.getMessage());
            }
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found: " + e.getMessage());
            e.printStackTrace();
            sendError(out, "JDBC Driver error: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            sendError(out, "Unexpected error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        resp.setHeader("Access-Control-Allow-Origin", "*");
        PrintWriter out = resp.getWriter();

        System.out.println("DashboardOrphanageServlet: POST request received");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
                
                String action = req.getParameter("action");
                System.out.println("POST Action: " + action);
                
                if ("delete".equals(action)) {
                    String idParam = req.getParameter("id");
                    System.out.println("Delete orphanage ID: " + idParam);
                    if (idParam == null || idParam.isEmpty()) {
                        sendError(out, "Missing orphanage ID");
                        return;
                    }
                    
                    int id = Integer.parseInt(idParam);
                    JSONObject result = deleteOrphanage(conn, id);
                    out.print(result.toString());
                    return;
                }
                
                // Handle add/update
                String idParam = req.getParameter("id");
                String name = req.getParameter("name");
                String address = req.getParameter("address");
                String city = req.getParameter("city");
                String contactPerson = req.getParameter("contactPerson");
                String contactNumber = req.getParameter("contactNumber");
                String capacityParam = req.getParameter("capacity");

                System.out.println("Received parameters - id: " + idParam + ", name: " + name + ", capacity: " + capacityParam);

                // Validate required parameters
                if (name == null || name.trim().isEmpty() ||
                    address == null || address.trim().isEmpty() ||
                    city == null || city.trim().isEmpty() ||
                    contactPerson == null || contactPerson.trim().isEmpty() ||
                    contactNumber == null || contactNumber.trim().isEmpty() ||
                    capacityParam == null || capacityParam.trim().isEmpty()) {
                    sendError(out, "All fields are required");
                    return;
                }

                int capacity;
                try {
                    capacity = Integer.parseInt(capacityParam);
                } catch (NumberFormatException e) {
                    sendError(out, "Invalid capacity value");
                    return;
                }

                JSONObject result;
                if (idParam == null || idParam.isEmpty()) {
                    System.out.println("Adding new orphanage");
                    result = addOrphanage(conn, name, address, city, contactPerson, contactNumber, capacity);
                } else {
                    System.out.println("Updating orphanage ID: " + idParam);
                    int id = Integer.parseInt(idParam);
                    result = updateOrphanage(conn, id, name, address, city, contactPerson, contactNumber, capacity);
                }

                out.print(result.toString());
            }
        } catch (Exception e) {
            System.err.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            sendError(out, "Server error: " + e.getMessage());
        }
    }

    private void getAllOrphanages(Connection conn, PrintWriter out) throws SQLException {
        System.out.println("Executing getAllOrphanages query");
        String sql = "SELECT id, name, address, city, contact_person, contact_number, capacity FROM orphanages ORDER BY id asc";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            JSONArray orphanages = new JSONArray();
            int count = 0;
            
            while (rs.next()) {
                JSONObject orphanage = new JSONObject();
                orphanage.put("id", rs.getInt("id"));
                orphanage.put("name", rs.getString("name"));
                orphanage.put("address", rs.getString("address"));
                orphanage.put("city", rs.getString("city"));
                orphanage.put("contactPerson", rs.getString("contact_person"));
                orphanage.put("contactNumber", rs.getString("contact_number"));
                orphanage.put("capacity", rs.getInt("capacity"));
                orphanages.put(orphanage);
                count++;
            }
            
            System.out.println("Returning " + count + " orphanages");
            out.print(orphanages.toString());
        } catch (SQLException e) {
            System.err.println("SQL Error in getAllOrphanages: " + e.getMessage());
            throw e;
        }
    }

    private void getOrphanage(Connection conn, int id, PrintWriter out) throws SQLException {
        String sql = "SELECT id, name, address, city, contact_person, contact_number, capacity FROM orphanages WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    JSONObject orphanage = new JSONObject();
                    orphanage.put("id", rs.getInt("id"));
                    orphanage.put("name", rs.getString("name"));
                    orphanage.put("address", rs.getString("address"));
                    orphanage.put("city", rs.getString("city"));
                    orphanage.put("contactPerson", rs.getString("contact_person"));
                    orphanage.put("contactNumber", rs.getString("contact_number"));
                    orphanage.put("capacity", rs.getInt("capacity"));
                    out.print(orphanage.toString());
                } else {
                    sendError(out, "Orphanage not found");
                }
            }
        }
    }

    private JSONObject addOrphanage(Connection conn, String name, String address, String city, 
                                   String contactPerson, String contactNumber, int capacity) throws SQLException {
        String sql = "INSERT INTO orphanages (name, address, city, contact_person, contact_number, capacity) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setString(2, address);
            stmt.setString(3, city);
            stmt.setString(4, contactPerson);
            stmt.setString(5, contactNumber);
            stmt.setInt(6, capacity);
            
            int rows = stmt.executeUpdate();
            JSONObject result = new JSONObject();
            if (rows > 0) {
                result.put("success", true);
                result.put("message", "Orphanage added successfully");
            } else {
                result.put("success", false);
                result.put("message", "Failed to add orphanage");
            }
            return result;
        }
    }

    private JSONObject updateOrphanage(Connection conn, int id, String name, String address, String city,
                                      String contactPerson, String contactNumber, int capacity) throws SQLException {
        String sql = "UPDATE orphanages SET name = ?, address = ?, city = ?, contact_person = ?, contact_number = ?, capacity = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setString(2, address);
            stmt.setString(3, city);
            stmt.setString(4, contactPerson);
            stmt.setString(5, contactNumber);
            stmt.setInt(6, capacity);
            stmt.setInt(7, id);
            
            int rows = stmt.executeUpdate();
            JSONObject result = new JSONObject();
            if (rows > 0) {
                result.put("success", true);
                result.put("message", "Orphanage updated successfully");
            } else {
                result.put("success", false);
                result.put("message", "Failed to update orphanage");
            }
            return result;
        }
    }

    private JSONObject deleteOrphanage(Connection conn, int id) throws SQLException {
        String sql = "DELETE FROM orphanages WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            
            int rows = stmt.executeUpdate();
            JSONObject result = new JSONObject();
            if (rows > 0) {
                result.put("success", true);
                result.put("message", "Orphanage deleted successfully");
            } else {
                result.put("success", false);
                result.put("message", "Failed to delete orphanage");
            }
            return result;
        }
    }

    private void sendError(PrintWriter out, String message) {
        JSONObject error = new JSONObject();
        error.put("success", false);
        error.put("message", message);
        out.print(error.toString());
        System.err.println("Sending error: " + message);
    }
}
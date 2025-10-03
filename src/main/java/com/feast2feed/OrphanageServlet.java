package com.feast2feed;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.Gson;

@WebServlet("/OrphanageServlet")
public class OrphanageServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/food_donation_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
                
                String sql = "SELECT id, name, address, city, contact_person, contact_number, capacity FROM orphanages ORDER BY name";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    try (ResultSet rs = stmt.executeQuery()) {
                        List<Orphanage> orphanages = new ArrayList<>();
                        while (rs.next()) {
                            Orphanage orphanage = new Orphanage();
                            orphanage.setId(rs.getInt("id"));
                            orphanage.setName(rs.getString("name"));
                            orphanage.setAddress(rs.getString("address"));
                            orphanage.setCity(rs.getString("city"));
                            orphanage.setContactPerson(rs.getString("contact_person"));
                            orphanage.setContactNumber(rs.getString("contact_number"));
                            orphanage.setCapacity(rs.getInt("capacity"));
                            orphanages.add(orphanage);
                        }
                        
                        Gson gson = new Gson();
                        out.print(gson.toJson(orphanages));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("[]");
        }
    }
}

class Orphanage {
    private int id;
    private String name;
    private String address;
    private String city;
    private String contactPerson;
    private String contactNumber;
    private int capacity;

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public String getContactPerson() { return contactPerson; }
    public void setContactPerson(String contactPerson) { this.contactPerson = contactPerson; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }
}
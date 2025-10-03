package com.feast2feed;

import java.sql.Timestamp;
import java.util.Map;

public class Donation {
    private int id;
    private String foodType;
    private String pickupAddress;
    private String notes;
    private String status;
    private Timestamp createdAt;
    private String orphanageName;
    private String donorName;
    private String donorEmail;
    private Map<Integer, String> nearbyOrphanages;
    private String mobile;

    // --- Getters and Setters ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFoodType() { return foodType; }
    public void setFoodType(String foodType) { this.foodType = foodType; }

    public String getPickupAddress() { return pickupAddress; }
    public void setPickupAddress(String pickupAddress) { this.pickupAddress = pickupAddress; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getOrphanageName() { return orphanageName; }
    public void setOrphanageName(String orphanageName) { this.orphanageName = orphanageName; }

    public String getDonorName() { return donorName; }
    public void setDonorName(String donorName) { this.donorName = donorName; }

    public String getDonorEmail() { return donorEmail; }
    public void setDonorEmail(String donorEmail) { this.donorEmail = donorEmail; }

    public Map<Integer, String> getNearbyOrphanages() { return nearbyOrphanages; }
    public void setNearbyOrphanages(Map<Integer, String> nearbyOrphanages) { this.nearbyOrphanages = nearbyOrphanages; }
    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }
}

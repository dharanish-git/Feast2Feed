<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.feast2feed.Donation, jakarta.servlet.http.HttpSession" %>
<%
    // Check if NGO is logged in
    HttpSession sessionCheck = request.getSession(false);
    if (sessionCheck == null || !"ngo".equalsIgnoreCase((String) sessionCheck.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Redirect to servlet if attributes are missing (defensive)
    if (request.getAttribute("availableDonations") == null && request.getAttribute("myClaims") == null) {
        response.sendRedirect(request.getContextPath() + "/NgoDonationServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Community Food Donation - NGO Requests</title>
    <link rel="icon" type="image/x-icon" href="images/icon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        :root {
            --primary-color: #ED145B;
            --secondary-color: #FF8E3C;
            --dark-color: #222;
            --light-color: #f9f9fd;
            --accent-color: #2CB67D;
            --text-color: #333;
            --shadow: 0 5px 15px rgba(0,0,0,0.08);
            --transition: all 0.3s ease;
        }
        
        body {
            font-family: 'Montserrat', Arial, sans-serif;
            background: #fff;
            color: var(--text-color);
            line-height: 1.6;
            padding-top: 76px;
        }
        
        /* Navbar - matching home.jsp */
        .navbar {
            background: #fff;
            box-shadow: 0 2px 8px rgba(80,80,80,0.03);
            transition: var(--transition);
            padding: 15px 0;
        }
        
        .navbar.scrolled {
            padding: 10px 0;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .navbar-brand {
            color: var(--primary-color) !important;
            font-weight: 700;
            font-size: 2rem;
            letter-spacing: -1px;
            display: flex;
            align-items: center;
        }
        
        .navbar-brand i {
            margin-right: 8px;
            font-size: 1.8rem;
        }
        
        .navbar-nav .nav-link {
            color: var(--text-color) !important;
            font-size: 1.07rem;
            margin-right: 12px;
            font-weight: 500;
            position: relative;
            transition: var(--transition);
        }
        
        .navbar-nav .nav-link:hover,
        .navbar-nav .nav-link.active {
            color: var(--primary-color) !important;
        }
        
        .navbar-nav .nav-link:after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: var(--primary-color);
            transition: var(--transition);
        }
        
        .navbar-nav .nav-link:hover:after,
        .navbar-nav .nav-link.active:after {
            width: 100%;
        }
        
        .btn-logout {
            background-color: var(--primary-color);
            color: #fff;
            border-radius: 30px;
            font-weight: 600;
            padding: 8px 23px;
            border: none;
            transition: var(--transition);
        }
        
        .btn-logout:hover {
            background: #c8104a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(237,20,91,0.3);
        }
        
        /* Page header */
        .page-header {
            background: linear-gradient(135deg, var(--light-color) 0%, #fff 100%);
            padding: 40px 0;
            margin-bottom: 30px;
            border-radius: 0 0 20px 20px;
            text-align: center;
            box-shadow: var(--shadow);
        }
        
        .page-header h1 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 15px;
            font-size: 2.5rem;
        }
        
        .page-header p {
            font-size: 1.2rem;
            color: var(--text-color);
            max-width: 600px;
            margin: 0 auto;
        }
        
        /* Section title - matching home.jsp */
        .section-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 40px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
            font-size: 2.2rem;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }
        
        /* Tabs styling */
        .nav-tabs {
            border-bottom: 2px solid #eee;
            margin-bottom: 30px;
        }
        
        .nav-tabs .nav-link {
            color: #666;
            font-weight: 600;
            border: none;
            padding: 12px 25px;
            transition: var(--transition);
        }
        
        .nav-tabs .nav-link.active {
            color: var(--primary-color);
            background: transparent;
            border-bottom: 3px solid var(--primary-color);
        }
        
        .nav-tabs .nav-link:hover {
            color: var(--primary-color);
            border-color: transparent;
        }
        
        /* Donation cards - matching home.jsp styling */
        .donation-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: var(--shadow);
            margin-bottom: 25px;
            border-top: 4px solid var(--primary-color);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }
        
        .donation-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(237,20,91,0.05), transparent);
            transition: var(--transition);
        }
        
        .donation-card:hover:before {
            left: 100%;
        }
        
        .donation-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        
        .donation-card h5 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .donation-card h5 i {
            margin-right: 10px;
            font-size: 1.2rem;
        }
        
        .status-badge {
            font-weight: 600;
            padding: 8px 15px;
            border-radius: 30px;
            font-size: 0.85rem;
            display: inline-block;
            margin-bottom: 15px;
        }
        
        .status-waiting {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .status-claimed {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        .status-picked_up {
            background: #cce5ff;
            color: #004085;
            border: 1px solid #b3d7ff;
        }
        
        .status-delivered {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .status-street_distributed {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .btn-action {
            background-color: var(--primary-color);
            color: #fff;
            border: none;
            border-radius: 30px;
            padding: 10px 20px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-action:hover {
            background-color: #c8104a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(237,20,91,0.3);
        }
        
        .btn-action:disabled {
            background-color: #d16f87;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .btn-action i {
            margin-right: 8px;
        }
        
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
            border: none;
            border-radius: 30px;
            padding: 10px 20px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-warning:hover {
            background-color: #e0a800;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255,193,7,0.3);
        }
        
        .btn-warning i {
            margin-right: 8px;
        }
        
        /* Modal styling */
        .modal-content {
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        
        .modal-header {
            background: var(--primary-color);
            color: white;
            border-radius: 15px 15px 0 0;
            padding: 20px 25px;
        }
        
        .modal-title {
            font-weight: 700;
            font-size: 1.5rem;
        }
        
        .modal-body {
            padding: 25px;
        }
        
        .modal-footer {
            border-top: 1px solid #eee;
            padding: 20px 25px;
            border-radius: 0 0 15px 15px;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            border: none;
            border-radius: 30px;
            padding: 8px 20px;
            font-weight: 600;
            transition: var(--transition);
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
        }
        
        /* Orphanage list styling */
        .orphanage-list {
            max-height: 300px;
            overflow-y: auto;
            margin-top: 15px;
        }
        
        .orphanage-item {
            padding: 15px;
            border: 1px solid #eee;
            border-radius: 10px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
        }
        
        .orphanage-item:hover {
            border-color: var(--primary-color);
            background: #fff5f7;
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
        }
        
        .orphanage-item.selected {
            border-color: var(--primary-color);
            background: #ffeef2;
        }
        
        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        /* Alert styling */
        .alert {
            border-radius: 10px;
            border: none;
            padding: 20px;
            margin-bottom: 25px;
            text-align: center;
        }
        
        .alert h5 {
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        /* Welcome message */
        .welcome-message {
            text-align: center;
            margin-bottom: 30px;
            color: #666;
            background: var(--light-color);
            padding: 25px;
            border-radius: 15px;
            box-shadow: var(--shadow);
        }
        
        .welcome-message h2 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 2rem;
            }
            
            .section-title {
                font-size: 1.8rem;
            }
            
            .navbar-brand {
                font-size: 1.5rem;
            }
            
            .btn-action, .btn-secondary, .btn-warning {
                padding: 8px 15px;
                font-size: 0.9rem;
                width: 100%;
                margin-bottom: 10px;
            }
            
            .donation-card .text-end {
                text-align: left !important;
                margin-top: 20px;
            }
        }
        
        @media (max-width: 576px) {
            .page-header h1 {
                font-size: 1.8rem;
            }
            
            .section-title {
                font-size: 1.5rem;
            }
            
            .nav-tabs .nav-link {
                padding: 10px 15px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="home.jsp"><i class="fas fa-utensils"></i> Feast2Feed</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="donation.jsp">Donate</a></li>
                <li class="nav-item">
                    <a class="nav-link active" href="<%= request.getContextPath() %>/NgoDonationServlet">Request</a>
                </li>
                <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
            </ul>
            <span class="navbar-text me-3">
    Welcome, <%= ((String)sessionCheck.getAttribute("email")).split("@")[0] %>
</span>

            <button class="btn btn-logout" id="logoutBtn">Logout</button>
        </div>
    </div>
</nav>

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <h1>Food Donation Requests</h1>
        <p>Claim available donations and help distribute food to orphanages in need</p>
    </div>
</div>

<div class="container">
    <!-- Welcome Message -->
    <div class="welcome-message">
        <h2>Available Food Donations</h2>
        <p>Browse available donations below and claim those you can deliver to orphanages</p>
    </div>
    
    <!-- Bootstrap Nav tabs -->
    <ul class="nav nav-tabs" id="donationTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <a class="nav-link active" id="available-tab" data-bs-toggle="tab" href="#available" role="tab" aria-controls="available" aria-selected="true">
                <i class="fas fa-gift"></i> Available Donations
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link" id="myClaims-tab" data-bs-toggle="tab" href="#myClaims" role="tab" aria-controls="myClaims" aria-selected="false">
                <i class="fas fa-hand-holding-heart"></i> My Claims
            </a>
        </li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content mt-4">
        <!-- Available Donations Tab -->
        <div class="tab-pane fade show active" id="available" role="tabpanel" aria-labelledby="available-tab">
            <%
                List<Donation> availableDonations = (List<Donation>) request.getAttribute("availableDonations");
                if (availableDonations == null) {
            %>
                <div class="alert alert-warning text-center">
                    <h5>Unable to load donations</h5>
                    <p>Please refresh the page or try again later.</p>
                    <button class="btn btn-action" onclick="window.location.reload()">
                        <i class="fas fa-redo"></i> Refresh Page
                    </button>
                </div>
            <%
                } else if (availableDonations.isEmpty()) {
            %>
                <div class="alert alert-info text-center">
                    <h5>No available donations at the moment</h5>
                    <p>Check back later for new donation opportunities.</p>
                </div>
            <%
                } else {
                    for (Donation donation : availableDonations) {
            %>
                <div class="donation-card">
                    <div class="row">
                        <div class="col-md-8">
                            <h5><i class="bi bi-box-seam"></i> <%= donation.getFoodType() %></h5>
                            <p><strong>Donor:</strong> <%= donation.getDonorName() %> | <strong>Mobile:</strong> <%= donation.getMobile() %></p>
                            <p><strong>Pickup Address:</strong> <%= donation.getPickupAddress() %></p>
                            <p><strong>Notes:</strong> <%= donation.getNotes() != null ? donation.getNotes() : "None" %></p>
                            <p><small>Donated on: <%= donation.getCreatedAt() %></small></p>
                        </div>
                        <div class="col-md-4 text-end">
                            <span class="status-badge status-waiting">Waiting for Claim</span>
                            <br>
                            <button class="btn-action mt-2" onclick="openClaimModal(<%= donation.getId() %>, '<%= donation.getFoodType().replace("'", "\\'") %>')">
                                <i class="bi bi-hand-thumbs-up"></i> Claim Donation
                            </button>
                        </div>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
        
        <!-- My Claims Tab -->
        <div class="tab-pane fade" id="myClaims" role="tabpanel" aria-labelledby="myClaims-tab">
            <%
                List<Donation> myClaims = (List<Donation>) request.getAttribute("myClaims");
                if (myClaims == null) {
            %>
                <div class="alert alert-warning text-center">
                    <h5>Unable to load your claims</h5>
                    <p>Please refresh the page or try again later.</p>
                    <button class="btn btn-action" onclick="window.location.reload()">
                        <i class="fas fa-redo"></i> Refresh Page
                    </button>
                </div>
            <%
                } else if (myClaims.isEmpty()) {
            %>
                <div class="alert alert-info text-center">
                    <h5>You haven't claimed any donations yet</h5>
                    <p>Start by claiming available donations from the 'Available Donations' tab.</p>
                </div>
            <%
                } else {
                    for (Donation claim : myClaims) {
                        String statusClass = "status-" + claim.getStatus();
                        String statusText = "";
                        switch (claim.getStatus()) {
                            case "claimed": statusText = "Claimed - Waiting for Pickup"; break;
                            case "picked_up": statusText = "Picked Up - On the way to " + (claim.getOrphanageName() != null ? claim.getOrphanageName() : "orphanage"); break;
                            case "delivered": statusText = "Delivered to " + (claim.getOrphanageName() != null ? claim.getOrphanageName() : "orphanage"); break;
                            case "street_distributed": statusText = "Distributed to Street Underprivileged"; break;
                            default: statusText = "Waiting for Claim"; break;
                        }
            %>
                <div class="donation-card">
                    <div class="row">
                        <div class="col-md-8">
                            <h5><i class="bi bi-box-seam"></i> <%= claim.getFoodType() %></h5>
                            <p><strong>Donor:</strong> <%= claim.getDonorName() %> | <strong>Mobile:</strong> <%= claim.getMobile() %></p>
                            <p><strong>Pickup Address:</strong> <%= claim.getPickupAddress() %></p>
                            <p><strong>Assigned Orphanage:</strong> <%= claim.getOrphanageName() != null ? claim.getOrphanageName() : "Not assigned" %></p>
                            <p><strong>Notes:</strong> <%= claim.getNotes() != null ? claim.getNotes() : "None" %></p>
                            <p><small>Donated on: <%= claim.getCreatedAt() %></small></p>
                        </div>
                        <div class="col-md-4 text-end">
                            <span class="status-badge <%= statusClass %>"><%= statusText %></span>
                            <div class="mt-2">
                                <% if ("claimed".equals(claim.getStatus())) { %>
                                    <button class="btn-action" onclick="updateStatus(<%= claim.getId() %>, 'picked_up')">
                                        <i class="bi bi-check-circle"></i> Mark as Picked Up
                                    </button>
                                <% } else if ("picked_up".equals(claim.getStatus())) { %>
                                    <button class="btn-action" onclick="updateStatus(<%= claim.getId() %>, 'delivered')">
                                        <i class="bi bi-truck"></i> Mark as Delivered
                                    </button>
                                    <button class="btn-warning mt-2" onclick="cancelDelivery(<%= claim.getId() %>)">
                                        <i class="bi bi-x-circle"></i> Cancel Delivery
                                    </button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</div>

<!-- Claim Donation Modal -->
<div class="modal fade" id="claimModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Claim Donation</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p><strong>Food Type:</strong> <span id="modalFoodType"></span></p>
                <div class="form-group">
                    <label><strong>Select Orphanage for Delivery:</strong></label>
                    <div class="orphanage-list" id="orphanageList">
                        <!-- Orphanages will be loaded here -->
                    </div>
                    <div id="noOrphanages" class="alert alert-warning" style="display: none;">
                        No orphanages available. Please contact administrator.
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn-action" id="confirmClaimBtn" onclick="confirmClaim()">Confirm Claim</button>
            </div>
        </div>
    </div>
</div>

<script>
    const contextPath = '<%= request.getContextPath() %>';
    let currentDonationId = null;
    let selectedOrphanageId = null;

    // Open claim modal
    function openClaimModal(donationId, foodType) {
        currentDonationId = donationId;
        document.getElementById('modalFoodType').textContent = foodType;
        selectedOrphanageId = null;
        
        // Load orphanages
        loadOrphanages();
        
        const modal = new bootstrap.Modal(document.getElementById('claimModal'));
        modal.show();
    }

    // Load orphanages for selection
    async function loadOrphanages() {
        try {
            const response = await fetch(contextPath + '/OrphanageServlet');
            if (!response.ok) {
                throw new Error('Failed to load orphanages');
            }
            const orphanages = await response.json();
            
            console.log('Loaded orphanages:', orphanages); // Debug log
            
            const orphanageList = document.getElementById('orphanageList');
            const noOrphanages = document.getElementById('noOrphanages');
            
            orphanageList.innerHTML = '';
            
            if (!orphanages || orphanages.length === 0) {
                noOrphanages.style.display = 'block';
                document.getElementById('confirmClaimBtn').disabled = true;
                return;
            }
            
            noOrphanages.style.display = 'none';
            document.getElementById('confirmClaimBtn').disabled = false;
            
            orphanages.forEach(orphanage => {
                console.log('Processing orphanage:', orphanage); // Debug log
                
                // Safely extract values with fallbacks
                const id = orphanage.id || '';
                const name = orphanage.name || 'Unknown Name';
                const address = orphanage.address || 'No Address';
                const city = orphanage.city || 'No City';
                const contactPerson = orphanage.contactPerson || 'No Contact Person';
                const contactNumber = orphanage.contactNumber || 'No Contact Number';
                
                const div = document.createElement('div');
                div.className = 'orphanage-item';
                
                // Use safer string concatenation instead of template literals
                div.innerHTML = 
                    '<div class="form-check">' +
                        '<input class="form-check-input" type="radio" name="orphanageSelect" ' +
                               'id="orphanage-' + id + '" value="' + id + '" onchange="selectOrphanage(event, ' + id + ')">' +
                        '<label class="form-check-label" for="orphanage-' + id + '">' +
                            '<strong>' + name + '</strong><br>' +
                            '<small>' + address + ', ' + city + '</small><br>' +
                            '<small>Contact: ' + contactPerson + ' (' + contactNumber + ')</small>' +
                        '</label>' +
                    '</div>';
                
                orphanageList.appendChild(div);
            });
            
            console.log('Orphanage list populated successfully'); // Debug log
            
        } catch (error) {
            console.error('Error loading orphanages:', error);
            const orphanageList = document.getElementById('orphanageList');
            const noOrphanages = document.getElementById('noOrphanages');
            noOrphanages.style.display = 'block';
            noOrphanages.innerHTML = 'Error loading orphanages. Please try again.';
            document.getElementById('confirmClaimBtn').disabled = true;
        }
    }

    // Select orphanage (pass event to avoid JS error)
    function selectOrphanage(e, orphanageId) {
        selectedOrphanageId = orphanageId;
        document.querySelectorAll('.orphanage-item').forEach(item => {
            item.classList.remove('selected');
        });
        const item = e.target.closest('.orphanage-item');
        if (item) item.classList.add('selected');
    }

    // Confirm claim
    async function confirmClaim() {
        // fallback: read checked radio if selectedOrphanageId not set
        if (!selectedOrphanageId) {
            const checked = document.querySelector('input[name="orphanageSelect"]:checked');
            if (checked) selectedOrphanageId = parseInt(checked.value, 10);
        }

        if (!selectedOrphanageId) {
            Swal.fire('Warning', 'Please select an orphanage', 'warning');
            return;
        }

        const confirmBtn = document.getElementById('confirmClaimBtn');
        confirmBtn.disabled = true;
        confirmBtn.textContent = 'Claiming...';

        try {
            const response = await fetch(contextPath + '/ClaimDonationServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({
                    donationId: currentDonationId,
                    orphanageId: selectedOrphanageId
                })
            });

            const result = await response.json();

            if (result.success) {
                Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: 'Donation claimed successfully!',
                    confirmButtonColor: '#ED145B'
                }).then(() => {
                    window.location.reload();
                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: result.message || 'Failed to claim donation',
                    confirmButtonColor: '#ED145B'
                });
            }
        } catch (error) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Network error occurred. Please check your connection.',
                confirmButtonColor: '#ED145B'
            });
        } finally {
            confirmBtn.disabled = false;
            confirmBtn.textContent = 'Confirm Claim';
        }
    }

    // Update donation status
    async function updateStatus(donationId, newStatus) {
        Swal.fire({
            title: 'Are you sure?',
            text: `Do you want to mark this donation as ${newStatus.replace('_', ' ')}?`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#ED145B',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Yes, update status!'
        }).then(async (result) => {
            if (result.isConfirmed) {
                try {
                    const response = await fetch(contextPath + '/UpdateDonationStatusServlet', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: new URLSearchParams({
                            donationId: donationId,
                            newStatus: newStatus
                        })
                    });

                    const result = await response.json();

                    if (result.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: 'Status updated successfully!',
                            confirmButtonColor: '#ED145B'
                        }).then(() => {
                            window.location.reload();
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: result.message || 'Failed to update status',
                            confirmButtonColor: '#ED145B'
                        });
                    }
                } catch (error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Network error occurred. Please check your connection.',
                        confirmButtonColor: '#ED145B'
                    });
                }
            }
        });
    }

    // Cancel delivery function
    async function cancelDelivery(donationId) {
        Swal.fire({
            title: 'Cancel Delivery?',
            html: 'This will mark the donation as distributed to street underprivileged people.<br><strong>This action cannot be undone.</strong>',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#ffc107',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Yes, cancel delivery',
            cancelButtonText: 'Go back'
        }).then(async (result) => {
            if (result.isConfirmed) {
                try {
                    const response = await fetch(contextPath + '/CancelDeliveryServlet', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: new URLSearchParams({
                            donationId: donationId
                        })
                    });

                    const result = await response.json();

                    if (result.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Delivery Cancelled',
                            text: 'Donation has been marked as distributed to street underprivileged people.',
                            confirmButtonColor: '#ED145B'
                        }).then(() => {
                            window.location.reload();
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: result.message || 'Failed to cancel delivery',
                            confirmButtonColor: '#ED145B'
                        });
                    }
                } catch (error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Network error occurred. Please check your connection.',
                        confirmButtonColor: '#ED145B'
                    });
                }
            }
        });
    }

    // Logout function
    function logout() {
        Swal.fire({
            title: 'Logout?',
            text: 'Are you sure you want to logout?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#ED145B',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Yes, logout!'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = contextPath + '/logout.jsp'; // Create logout.jsp or use your logout servlet
            }
        });
    }

    // Initialize tabs and event listeners
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize Bootstrap tabs
        const triggerTabList = [].slice.call(document.querySelectorAll('#donationTabs a'));
        triggerTabList.forEach(function (triggerEl) {
            const tabTrigger = new bootstrap.Tab(triggerEl);
            triggerEl.addEventListener('click', function (event) {
                event.preventDefault();
                tabTrigger.show();
            });
        });

        // Add logout event listener
        document.getElementById('logoutBtn').addEventListener('click', logout);
        
        // Navbar scroll effect (matching home.jsp)
        window.addEventListener('scroll', function() {
            if (window.scrollY > 50) {
                document.querySelector('.navbar').classList.add('scrolled');
            } else {
                document.querySelector('.navbar').classList.remove('scrolled');
            }
        });
        
        // Auto-refresh page every 2 minutes to get latest donations only if Available tab is active
        setInterval(() => {
            const activeTab = document.querySelector('#donationTabs .nav-link.active');
            if (activeTab && activeTab.getAttribute('href') === '#available') {
                console.log('Auto-refreshing available donations...');
                window.location.reload();
            }
        }, 120000); // 2 minutes
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
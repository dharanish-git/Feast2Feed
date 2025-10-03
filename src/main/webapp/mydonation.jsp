<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.feast2feed.Donation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Donations - Feast2Feed</title>
    <link rel="icon" type="image/x-icon" href="images/icon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Google Fonts: Montserrat for clean bold headings -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet"/>
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
        
        /* Navbar */
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
        
        .btn-login {
          background-color: var(--primary-color);
          color: #fff;
          border-radius: 30px;
          font-weight: 600;
          padding: 8px 23px;
          border: none;
          transition: var(--transition);
        }
        
        .btn-login:hover {
            background: #c8104a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(237,20,91,0.3);
        }
        
        /* Page Title */
        .page-title {
          color: var(--primary-color);
          font-weight: 700;
          margin-bottom: 40px;
          text-align: center;
          position: relative;
          padding-bottom: 15px;
          font-size: 2.2rem;
        }
        
        .page-title:after {
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
        
        /* Donation Cards */
        .donation-card { 
            background: #fff;
            border-radius: 15px;
            box-shadow: var(--shadow);
            padding: 25px;
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
        
        .status-badge { 
            font-weight: 600; 
            padding: 8px 15px; 
            border-radius: 20px; 
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
        
        .donation-info {
            margin-bottom: 12px;
            display: flex;
            align-items: flex-start;
        }
        
        .donation-info strong {
            color: var(--primary-color);
            min-width: 150px;
            display: inline-block;
            font-weight: 600;
        }
        
        .timeline {
            position: relative;
            padding-left: 30px;
            margin: 15px 0;
        }
        
        .timeline::before {
            content: '';
            position: absolute;
            left: 10px;
            top: 5px;
            bottom: 5px;
            width: 2px;
            background: var(--primary-color);
            opacity: 0.3;
        }
        
        .timeline-item {
            position: relative;
            margin-bottom: 10px;
            font-size: 0.9rem;
        }
        
        .timeline-item::before {
            content: '';
            position: absolute;
            left: -20px;
            top: 6px;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--primary-color);
        }
        
        .timeline-date {
            font-size: 0.8rem;
            color: #666;
            margin-left: 10px;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
            background: var(--light-color);
            border-radius: 15px;
            margin: 30px 0;
            box-shadow: var(--shadow);
        }
        
        .empty-state i {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 20px;
            opacity: 0.7;
        }
        
        .empty-state h4 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 15px;
        }
        
        .btn-refresh {
            background-color: var(--primary-color);
            color: #fff;
            border: none;
            border-radius: 30px;
            font-weight: 600;
            padding: 10px 20px;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-refresh:hover {
            background-color: #c8104a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(237,20,91,0.3);
        }
        
        .donation-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .food-type-badge {
            background: #ffeef2;
            color: var(--primary-color);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .action-buttons {
            margin-top: 20px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .btn-action {
            background-color: var(--primary-color);
            color: #fff;
            border: none;
            border-radius: 30px;
            padding: 8px 16px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .btn-action:hover {
            background-color: #bb1150;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(237,20,91,0.3);
        }
        
        .btn-action:disabled {
            background-color: #d16f87;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .contact-info {
            background: #f8f9fa;
            padding: 12px;
            border-radius: 8px;
            margin-top: 10px;
            font-size: 0.9rem;
            border-left: 3px solid var(--secondary-color);
        }
        
        .ngo-info {
            background: #e7f3ff;
            padding: 12px;
            border-radius: 8px;
            margin-top: 10px;
            font-size: 0.9rem;
            border-left: 3px solid var(--accent-color);
        }
        
        /* Footer */
        footer {
            background: var(--dark-color);
            color: white;
            padding: 50px 0 20px;
            margin-top: 50px;
        }
        
        .footer-logo {
            color: white;
            font-weight: 700;
            font-size: 1.8rem;
            margin-bottom: 20px;
            display: inline-block;
        }
        
        .footer-links h5 {
            color: var(--secondary-color);
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        .footer-links ul {
            list-style: none;
            padding: 0;
        }
        
        .footer-links ul li {
            margin-bottom: 10px;
        }
        
        .footer-links ul li a {
            color: #ccc;
            text-decoration: none;
            transition: var(--transition);
        }
        
        .footer-links ul li a:hover {
            color: var(--secondary-color);
            padding-left: 5px;
        }
        
        .social-icons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        
        .social-icons a {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            transition: var(--transition);
        }
        
        .social-icons a:hover {
            background: var(--primary-color);
            transform: translateY(-3px);
        }
        
        .copyright {
            text-align: center;
            padding-top: 30px;
            margin-top: 30px;
            border-top: 1px solid rgba(255,255,255,0.1);
            color: #aaa;
            font-size: 0.9rem;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .page-title {
                font-size: 1.8rem;
            }
            
            .donation-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn-action {
                width: 100%;
                justify-content: center;
            }
        }
        
        @media (max-width: 576px) {
            .page-title {
                font-size: 1.5rem;
            }
            
            .navbar-brand {
                font-size: 1.5rem;
            }
            
            .donation-info {
                flex-direction: column;
            }
            
            .donation-info strong {
                min-width: auto;
                margin-bottom: 5px;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="home.jsp"><i class="fas fa-utensils"></i> Feast2Feed</a>
        <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav"
        >
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="MyDonationServlet">My Donations</a></li>
                <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="donation.jsp">Donate</a></li>
                <li class="nav-item"><a class="nav-link" href="request.jsp">Request</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
            </ul>
            <button class="btn btn-login ms-3" id="logoutBtn">Logout</button>
        </div>
    </div>
</nav>
<br/>

<!-- Main Content -->
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="page-title">My Donation History</h1>
        <button class="btn-refresh" onclick="refreshDonations()">
            <i class="fas fa-sync-alt"></i> Refresh
        </button>
    </div>

    <%
        List<Donation> donations = (List<Donation>) request.getAttribute("donations");
        if (donations == null || donations.isEmpty()) {
    %>
        <div class="empty-state">
            <i class="fas fa-inbox"></i>
            <h4>No Donations Yet</h4>
            <p>You haven't made any donations yet. Start by donating food to help those in need.</p>
            <a href="donation.jsp" class="btn-action" style="justify-content: center; width: auto; margin: 0 auto;">Make Your First Donation</a>
        </div>
    <%
        } else {
            for (Donation d : donations) {
                String statusClass = "status-" + d.getStatus();
                String statusText = "";
                String timelineHtml = "";
                
                switch (d.getStatus()) {
                    case "waiting": 
                        statusText = "Donated – Waiting for NGO to claim";
                        timelineHtml = "<div class='timeline-item'>Donation submitted and waiting for NGO claim</div>";
                        break;
                    case "claimed": 
                        statusText = "NGO claimed – Waiting for pickup";
                        timelineHtml = "<div class='timeline-item'>Donation submitted</div>" +
                                      "<div class='timeline-item'>Claimed by NGO - Waiting for pickup</div>";
                        break;
                    case "picked_up": 
                        statusText = "Food picked up – On the way to " + (d.getOrphanageName() != null ? d.getOrphanageName() : "selected orphanage");
                        timelineHtml = "<div class='timeline-item'>Donation submitted</div>" +
                                      "<div class='timeline-item'>Claimed by NGO</div>" +
                                      "<div class='timeline-item'>Food picked up - On the way to orphanage</div>";
                        break;
                    case "delivered": 
                        statusText = "Food delivered to " + (d.getOrphanageName() != null ? d.getOrphanageName() : "selected orphanage");
                        timelineHtml = "<div class='timeline-item'>Donation submitted</div>" +
                                      "<div class='timeline-item'>Claimed by NGO</div>" +
                                      "<div class='timeline-item'>Food picked up</div>" +
                                      "<div class='timeline-item'>Food delivered to orphanage</div>";
                        break;
                    default: 
                        statusText = d.getStatus();
                        timelineHtml = "<div class='timeline-item'>Donation submitted</div>";
                        break;
                }
    %>
        <div class="donation-card">
            <div class="donation-header">
                <div>
                    <span class="status-badge <%= statusClass %>">
                        <i class="fas fa-<%= getStatusIcon(d.getStatus()) %>"></i> <%= statusText %>
                    </span>
                    <span class="food-type-badge">
                        <i class="fas fa-box"></i> <%= d.getFoodType() %>
                    </span>
                </div>
                <small class="text-muted">Donation ID: #<%= d.getId() %></small>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="donation-info">
                        <strong><i class="fas fa-user"></i> Donor:</strong> <%= d.getDonorName() %>
                    </div>
                    <div class="donation-info">
                        <strong><i class="fas fa-phone"></i> Mobile:</strong> <%= d.getMobile() %>
                    </div>
                    <div class="donation-info">
                        <strong><i class="fas fa-map-marker-alt"></i> Pickup Address:</strong> 
                        <div style="margin-top: 5px;"><%= d.getPickupAddress() %></div>
                    </div>
                    <% if (d.getNotes() != null && !d.getNotes().isEmpty()) { %>
                    <div class="donation-info">
                        <strong><i class="fas fa-sticky-note"></i> Notes:</strong> <%= d.getNotes() %>
                    </div>
                    <% } %>
                    
                    <% if (d.getOrphanageName() != null) { %>
                    <div class="donation-info">
                        <strong><i class="fas fa-home"></i> Assigned Orphanage:</strong> <%= d.getOrphanageName() %>
                    </div>
                    <% } %>
                </div>
                
                <div class="col-md-6">
                    <h6><i class="fas fa-clock"></i> Donation Timeline</h6>
                    <div class="timeline">
                        <%= timelineHtml %>
                    </div>
                    
                    <div class="donation-info">
                        <strong><i class="fas fa-calendar"></i> Donated on:</strong> 
                        <%= d.getCreatedAt() != null ? d.getCreatedAt().toString() : "N/A" %>
                    </div>
                    
                    <% if (!"waiting".equals(d.getStatus())) { %>
                    <div class="ngo-info">
                        <strong><i class="fas fa-hands-helping"></i> NGO Status:</strong><br>
                        Your donation is being handled by our partner NGO network.
                        <% if ("delivered".equals(d.getStatus())) { %>
                        <div class="mt-2 text-success">
                            <i class="fas fa-check-circle"></i> Successfully delivered to beneficiaries!
                        </div>
                        <% } %>
                    </div>
                    <% } %>
                </div>
            </div>

            <div class="action-buttons">
                <% if ("waiting".equals(d.getStatus())) { %>
                    <button class="btn-action" onclick="editDonation(<%= d.getId() %>)">
                        <i class="fas fa-edit"></i> Edit Details
                    </button>
                    <button class="btn-action" onclick="cancelDonation(<%= d.getId() %>)" style="background-color: #dc3545;">
                        <i class="fas fa-times-circle"></i> Cancel Donation
                    </button>
                <% } %>
                <button class="btn-action" onclick="shareDonation(<%= d.getId() %>)">
                    <i class="fas fa-share-alt"></i> Share Status
                </button>
                <button class="btn-action" onclick="viewDonationMap(<%= d.getId() %>)">
                    <i class="fas fa-map-marked-alt"></i> View on Map
                </button>
            </div>
        </div>
    <%
            }
        }
    %>
</div>

<!-- Share Modal -->
<div class="modal fade" id="shareModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Share Donation Status</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Share your donation status with others:</p>
                <div class="input-group mb-3">
                    <input type="text" class="form-control" id="shareUrl" readonly>
                    <button class="btn btn-outline-secondary" onclick="copyShareUrl()">Copy</button>
                </div>
                <div class="social-share">
                    <button class="btn btn-outline-primary btn-sm" onclick="shareOnSocial('facebook')">
                        <i class="fab fa-facebook"></i> Facebook
                    </button>
                    <button class="btn btn-outline-info btn-sm" onclick="shareOnSocial('twitter')">
                        <i class="fab fa-twitter"></i> Twitter
                    </button>
                    <button class="btn btn-outline-success btn-sm" onclick="shareOnSocial('whatsapp')">
                        <i class="fab fa-whatsapp"></i> WhatsApp
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Navbar scroll effect (same as home.jsp)
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            document.querySelector('.navbar').classList.add('scrolled');
        } else {
            document.querySelector('.navbar').classList.remove('scrolled');
        }
    });
    
    const contextPath = '<%= request.getContextPath() %>';

    function refreshDonations() {
        const btn = event.target;
        const originalText = btn.innerHTML;
        btn.innerHTML = '<i class="fas fa-sync-alt spin"></i> Refreshing...';
        btn.disabled = true;
        
        setTimeout(() => {
            window.location.reload();
        }, 1000);
    }

    function editDonation(donationId) {
        Swal.fire({
            title: 'Edit Donation',
            text: 'This feature is coming soon!',
            icon: 'info',
            confirmButtonColor: '#ED145B'
        });
    }

    function cancelDonation(donationId) {
        Swal.fire({
            title: 'Cancel Donation?',
            text: 'Are you sure you want to cancel this donation?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#ED145B',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Yes, cancel it!'
        }).then((result) => {
            if (result.isConfirmed) {
                // Simulate cancellation
                Swal.fire({
                    title: 'Cancelled!',
                    text: 'Your donation has been cancelled.',
                    icon: 'success',
                    confirmButtonColor: '#ED145B'
                }).then(() => {
                    refreshDonations();
                });
            }
        });
    }

    function shareDonation(donationId) {
        const shareUrl = window.location.origin + contextPath + '/donation-status?id=' + donationId;
        document.getElementById('shareUrl').value = shareUrl;
        
        const shareModal = new bootstrap.Modal(document.getElementById('shareModal'));
        shareModal.show();
    }

    function copyShareUrl() {
        const shareUrlInput = document.getElementById('shareUrl');
        shareUrlInput.select();
        shareUrlInput.setSelectionRange(0, 99999);
        document.execCommand('copy');
        
        Swal.fire({
            title: 'Copied!',
            text: 'Share URL copied to clipboard',
            icon: 'success',
            timer: 1500,
            showConfirmButton: false
        });
    }

    function shareOnSocial(platform) {
        const shareUrl = document.getElementById('shareUrl').value;
        let shareWindowUrl = '';
        
        switch(platform) {
            case 'facebook':
                shareWindowUrl = 'https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(shareUrl);
                break;
            case 'twitter':
                shareWindowUrl = 'https://twitter.com/intent/tweet?url=' + encodeURIComponent(shareUrl);
                break;
            case 'whatsapp':
                shareWindowUrl = 'https://wa.me/?text=' + encodeURIComponent('Check out my food donation status: ' + shareUrl);
                break;
        }
        
        window.open(shareWindowUrl, '_blank', 'width=600,height=400');
    }

    function viewDonationMap(donationId) {
        Swal.fire({
            title: 'Delivery Map',
            text: 'Real-time tracking feature is coming soon!',
            icon: 'info',
            confirmButtonColor: '#ED145B'
        });
    }

    // Logout functionality
    document.getElementById('logoutBtn').addEventListener('click', function() {
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
                window.location.href = contextPath + '/login.jsp';
            }
        });
    });

    // Add spinning animation for refresh icon
    const style = document.createElement('style');
    style.textContent = `
        .spin { animation: spin 1s linear infinite; }
        @keyframes spin { 
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .social-share { display: flex; gap: 10px; flex-wrap: wrap; margin-top: 15px; }
        .social-share button { flex: 1; min-width: 100px; }
    `;
    document.head.appendChild(style);
</script>
</body>
</html>

<%!
    // Helper method to get status icons
    private String getStatusIcon(String status) {
        switch (status) {
            case "waiting": return "clock";
            case "claimed": return "check-circle";
            case "picked_up": return "truck";
            case "delivered": return "check-double";
            default: return "question-circle";
        }
    }
%>
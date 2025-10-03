<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if NGO is logged in
    HttpSession sessionCheck = request.getSession(false);
    if (sessionCheck == null || !"admin".equalsIgnoreCase((String) sessionCheck.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard - Feast2Feed</title>
    <link rel="icon" type="image/x-icon" href="images/icon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Google Fonts: Montserrat for clean bold headings -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
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
            padding-top: 20px;
        }
        
        /* Navbar */
        .navbar {
            background: #fff;
            box-shadow: 0 2px 8px rgba(80,80,80,0.03);
            transition: var(--transition);
            padding: 15px 0;
            border-radius: 10px;
            margin: 0 15px;
        }
        
        .navbar.scrolled {
            padding: 10px 0;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .navbar-brand {
            color: var(--primary-color) !important;
            font-weight: 700;
            font-size: 1.8rem;
            letter-spacing: -1px;
            display: flex;
            align-items: center;
        }
        
        .navbar-brand i {
            margin-right: 8px;
            font-size: 1.6rem;
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
        
        /* Dashboard Header */
        .dashboard-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 40px 0;
            border-radius: 15px;
            margin: 20px 0 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .dashboard-header:before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 250px;
            height: 250px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
        }
        
        .dashboard-header:after {
            content: '';
            position: absolute;
            bottom: -30%;
            left: -10%;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
        }
        
        .dashboard-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            position: relative;
            z-index: 2;
        }
        
        .dashboard-header p {
            font-size: 1.2rem;
            opacity: 0.9;
            position: relative;
            z-index: 2;
        }
        
        /* Statistics Cards */
        .stat-card {
            background: #fff;
            border-radius: 15px;
            padding: 30px 20px;
            box-shadow: var(--shadow);
            margin-bottom: 20px;
            text-align: center;
            transition: var(--transition);
            border-top: 4px solid var(--primary-color);
            position: relative;
            overflow: hidden;
        }
        
        .stat-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(237,20,91,0.05), transparent);
            transition: var(--transition);
        }
        
        .stat-card:hover:before {
            left: 100%;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 10px;
            display: block;
        }
        
        .stat-label {
            font-size: 1rem;
            color: var(--text-color);
            font-weight: 500;
        }
        
        /* Section Titles */
        .section-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 30px;
            position: relative;
            padding-bottom: 15px;
            font-size: 2rem;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 80px;
            height: 4px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }
        
        /* Buttons */
        .btn-admin {
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 30px;
            font-weight: 600;
            padding: 10px 25px;
            transition: var(--transition);
        }
        
        .btn-admin:hover {
            background: #c8104a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(237,20,91,0.3);
        }
        
        .btn-outline-admin {
            background: transparent;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            border-radius: 30px;
            font-weight: 600;
            padding: 8px 20px;
            transition: var(--transition);
        }
        
        .btn-outline-admin:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }
        
        /* Table Styling */
        .table-responsive {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--shadow);
        }
        
        .table {
            margin-bottom: 0;
        }
        
        .table thead {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
        }
        
        .table thead th {
            border: none;
            padding: 15px;
            font-weight: 600;
        }
        
        .table tbody tr {
            transition: var(--transition);
        }
        
        .table tbody tr:hover {
            background-color: rgba(237,20,91,0.05);
        }
        
        .table tbody td {
            padding: 15px;
            vertical-align: middle;
            border-color: #f0f0f0;
        }
        
        /* Table Actions Column */
        .table-actions {
            white-space: nowrap;
            text-align: center;
            padding: 10px 5px !important;
        }
        
        .table-actions .btn {
            margin: 2px;
            padding: 6px 12px;
            font-size: 0.85rem;
            min-width: 70px;
            border-radius: 20px;
            font-weight: 600;
            transition: var(--transition);
        }
        
        .btn-action-edit {
            background: var(--primary-color);
            color: white;
            border: none;
        }
        
        .btn-action-edit:hover {
            background: #c8104a;
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(237,20,91,0.3);
        }
        
        .btn-action-delete {
            background: #dc3545;
            color: white;
            border: none;
        }
        
        .btn-action-delete:hover {
            background: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(220,53,69,0.3);
        }
        
        /* Loading and Error States */
        .loading {
            color: #6c757d;
            font-style: italic;
        }
        
        .error {
            color: #dc3545;
        }
        
        /* Modal Styling */
        .modal-content {
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        
        .modal-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            border-radius: 15px 15px 0 0;
            border: none;
            padding: 20px 25px;
        }
        
        .modal-title {
            font-weight: 600;
        }
        
        .btn-close {
            filter: invert(1);
        }
        
        .modal-body {
            padding: 25px;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 8px;
        }
        
        .form-control {
            border-radius: 8px;
            border: 2px solid #e9ecef;
            padding: 10px 15px;
            transition: var(--transition);
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(237,20,91,0.25);
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .dashboard-header h1 {
                font-size: 2rem;
            }
            
            .section-title {
                font-size: 1.6rem;
            }
            
            .stat-number {
                font-size: 2rem;
            }
            
            .navbar-brand {
                font-size: 1.5rem;
            }
            
            .table-actions .btn {
                min-width: 60px;
                padding: 5px 8px;
                font-size: 0.8rem;
            }
        }
        
        @media (max-width: 576px) {
            .dashboard-header {
                padding: 30px 0;
            }
            
            .dashboard-header h1 {
                font-size: 1.8rem;
            }
            
            .section-title {
                font-size: 1.4rem;
            }
            
            .btn-admin, .btn-outline-admin {
                padding: 8px 20px;
                font-size: 0.9rem;
                width: 100%;
                margin-bottom: 10px;
            }
            
            .table-actions {
                text-align: center;
            }
            
            .table-actions .btn {
                display: block;
                width: 100%;
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="home.jsp"><i class="fas fa-utensils"></i> Feast2Feed</a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    <i class="fas fa-user-shield me-2"></i>Admin Dashboard
                </span>
                <a class="nav-link" href="login.jsp"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5 pt-4">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <div class="container">
                <h1><i class="fas fa-tachometer-alt me-3"></i>Admin Dashboard</h1>
                <p>Manage orphanages and monitor donation statistics</p>
            </div>
        </div>
        
        <!-- Statistics Cards -->
        <div class="row">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-number" id="totalDonations">0</div>
                    <div class="stat-label">Total Donations</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-number" id="todayDonations">0</div>
                    <div class="stat-label">Today's Donations</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-number" id="monthlyDonations">0</div>
                    <div class="stat-label">Monthly Donations</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-number" id="totalOrphanages">0</div>
                    <div class="stat-label">Orphanages</div>
                </div>
            </div>
        </div>

        <!-- Orphanage Management -->
        <div class="row mt-5">
            <div class="col-12">
                <h3 class="section-title">Orphanage Management</h3>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <p class="mb-0">Manage all registered orphanages in the system</p>
                    <button class="btn btn-admin" onclick="showAddOrphanageModal()">
                        <i class="fas fa-plus me-2"></i>Add Orphanage
                    </button>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Address</th>
                                <th>City</th>
                                <th>Contact Person</th>
                                <th>Contact Number</th>
                                <th>Capacity</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="orphanagesTable">
                            <tr>
                                <td colspan="8" class="text-center loading">Loading orphanages...</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Add/Edit Orphanage Modal -->
    <div class="modal fade" id="orphanageModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="orphanageModalTitle">Add Orphanage</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="orphanageForm">
                        <input type="hidden" id="orphanageId">
                        <div class="mb-3">
                            <label class="form-label">Orphanage Name *</label>
                            <input type="text" class="form-control" id="orphanageName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Address *</label>
                            <textarea class="form-control" id="orphanageAddress" rows="2" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">City *</label>
                            <input type="text" class="form-control" id="orphanageCity" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contact Person *</label>
                            <input type="text" class="form-control" id="contactPerson" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contact Number *</label>
                            <input type="tel" class="form-control" id="contactNumber" pattern="[0-9]{10}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Capacity *</label>
                            <input type="number" class="form-control" id="capacity" min="1" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-admin" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-admin" onclick="saveOrphanage()">Save Orphanage</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    
    <script>
        // SweetAlert2 configuration
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        });

        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            if (window.scrollY > 50) {
                document.querySelector('.navbar').classList.add('scrolled');
            } else {
                document.querySelector('.navbar').classList.remove('scrolled');
            }
        });

        // Load dashboard data
        function loadDashboard() {
            console.log('Loading dashboard statistics...');
            fetch('DashboardServlet')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Dashboard data:', data);
                    if (data.success) {
                        document.getElementById('totalDonations').textContent = data.totalDonations || 0;
                        document.getElementById('todayDonations').textContent = data.todayDonations || 0;
                        document.getElementById('monthlyDonations').textContent = data.monthlyDonations || 0;
                        document.getElementById('totalOrphanages').textContent = data.totalOrphanages || 0;
                        
                        // Animate numbers
                        animateNumbers();
                    } else {
                        console.error('Dashboard error:', data.message);
                        Toast.fire({
                            icon: 'error',
                            title: 'Error loading dashboard: ' + (data.message || 'Unknown error')
                        });
                    }
                })
                .catch(error => {
                    console.error('Error loading dashboard:', error);
                    Toast.fire({
                        icon: 'error',
                        title: 'Error loading dashboard data: ' + error.message
                    });
                });
        }

        // Animate statistic numbers
        function animateNumbers() {
            const statNumbers = document.querySelectorAll('.stat-number');
            
            statNumbers.forEach(stat => {
                const finalValue = stat.textContent;
                
                // For percentage values
                if (finalValue.includes('%')) {
                    let currentValue = 0;
                    const increment = 1;
                    
                    const timer = setInterval(() => {
                        currentValue += increment;
                        if (currentValue >= parseInt(finalValue)) {
                            stat.textContent = finalValue;
                            clearInterval(timer);
                        } else {
                            stat.textContent = currentValue + '%';
                        }
                    }, 30);
                } 
                // For number values with plus sign
                else if (finalValue.includes('+')) {
                    const numValue = parseInt(finalValue);
                    let currentValue = 0;
                    const increment = numValue / 50;
                    
                    const timer = setInterval(() => {
                        currentValue += increment;
                        if (currentValue >= numValue) {
                            stat.textContent = finalValue;
                            clearInterval(timer);
                        } else {
                            stat.textContent = Math.floor(currentValue) + '+';
                        }
                    }, 30);
                }
                // For regular numbers
                else {
                    const numValue = parseInt(finalValue);
                    let currentValue = 0;
                    const increment = numValue / 50;
                    
                    const timer = setInterval(() => {
                        currentValue += increment;
                        if (currentValue >= numValue) {
                            stat.textContent = finalValue;
                            clearInterval(timer);
                        } else {
                            stat.textContent = Math.floor(currentValue);
                        }
                    }, 30);
                }
            });
        }

        // Load orphanages from DashboardOrphanageServlet
        function loadOrphanages() {
            console.log('Loading orphanages...');
            const tbody = document.getElementById('orphanagesTable');
            tbody.innerHTML = '<tr><td colspan="8" class="text-center loading">Loading orphanages...</td></tr>';
            
            fetch('DashboardOrphanageServlet')
                .then(response => {
                    console.log('Orphanages response status:', response.status);
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    return response.json();
                })
                .then(orphanages => {
                    console.log('Parsed orphanages data:', orphanages);
                    
                    if (!Array.isArray(orphanages)) {
                        console.error('Expected array but got:', typeof orphanages, orphanages);
                        tbody.innerHTML = '<tr><td colspan="8" class="text-center error">Invalid data format received from server</td></tr>';
                        return;
                    }
                    
                    if (orphanages.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="8" class="text-center">No orphanages found.</td></tr>';
                        return;
                    }
                    
                    // Build the table rows with safe property access
                    let tableHTML = '';
                    orphanages.forEach((orphanage, index) => {
                        const id = orphanage.id !== undefined ? orphanage.id : 
                                  orphanage.orphanageId !== undefined ? orphanage.orphanageId : index + 1;
                        
                        const name = orphanage.name !== undefined ? orphanage.name : 
                                    orphanage.orphanageName !== undefined ? orphanage.orphanageName : 'No name';
                        
                        const address = orphanage.address !== undefined ? orphanage.address : 'No address';
                        const city = orphanage.city !== undefined ? orphanage.city : 'No city';
                        
                        const contactPerson = orphanage.contactPerson !== undefined ? orphanage.contactPerson :
                                            orphanage.contact_person !== undefined ? orphanage.contact_person : 'No contact';
                        
                        const contactNumber = orphanage.contactNumber !== undefined ? orphanage.contactNumber :
                                            orphanage.contact_number !== undefined ? orphanage.contact_number : 'No number';
                        
                        const capacity = orphanage.capacity !== undefined ? orphanage.capacity : 0;
                        
                        tableHTML += '<tr>' +
                            '<td>' + id + '</td>' +
                            '<td>' + name + '</td>' +
                            '<td>' + address + '</td>' +
                            '<td>' + city + '</td>' +
                            '<td>' + contactPerson + '</td>' +
                            '<td>' + contactNumber + '</td>' +
                            '<td>' + capacity + '</td>' +
                            '<td class="table-actions">' +
                                '<button class="btn btn-action-edit" onclick="editOrphanage(' + id + ')">' +
                                    '<i class="fas fa-edit me-1"></i>Edit' +
                                '</button>' +
                                '<button class="btn btn-action-delete" onclick="deleteOrphanage(' + id + ')">' +
                                    '<i class="fas fa-trash me-1"></i>Delete' +
                                '</button>' +
                            '</td>' +
                        '</tr>';
                    });
                    
                    tbody.innerHTML = tableHTML;
                })
                .catch(error => {
                    console.error('Error loading orphanages:', error);
                    tbody.innerHTML = '<tr><td colspan="8" class="text-center error">Error loading orphanages: ' + error.message + '</td></tr>';
                });
        }

        function showAddOrphanageModal() {
            document.getElementById('orphanageModalTitle').textContent = 'Add Orphanage';
            document.getElementById('orphanageForm').reset();
            document.getElementById('orphanageId').value = '';
            new bootstrap.Modal(document.getElementById('orphanageModal')).show();
        }

        function editOrphanage(id) {
            console.log('Editing orphanage ID:', id);
            if (!id || id === 'N/A') {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid orphanage ID',
                    text: 'Please select a valid orphanage to edit.'
                });
                return;
            }
            
            fetch('DashboardOrphanageServlet?action=get&id=' + id)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    return response.json();
                })
                .then(orphanage => {
                    console.log('Edit orphanage data:', orphanage);
                    if (orphanage.success === false) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: orphanage.message
                        });
                        return;
                    }
                    
                    document.getElementById('orphanageModalTitle').textContent = 'Edit Orphanage';
                    document.getElementById('orphanageId').value = orphanage.id || '';
                    document.getElementById('orphanageName').value = orphanage.name || '';
                    document.getElementById('orphanageAddress').value = orphanage.address || '';
                    document.getElementById('orphanageCity').value = orphanage.city || '';
                    document.getElementById('contactPerson').value = orphanage.contactPerson || '';
                    document.getElementById('contactNumber').value = orphanage.contactNumber || '';
                    document.getElementById('capacity').value = orphanage.capacity || '';
                    
                    new bootstrap.Modal(document.getElementById('orphanageModal')).show();
                })
                .catch(error => {
                    console.error('Error loading orphanage:', error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Error loading orphanage details: ' + error.message
                    });
                });
        }

        function saveOrphanage() {
            // Get form values
            const id = document.getElementById('orphanageId').value;
            const name = document.getElementById('orphanageName').value.trim();
            const address = document.getElementById('orphanageAddress').value.trim();
            const city = document.getElementById('orphanageCity').value.trim();
            const contactPerson = document.getElementById('contactPerson').value.trim();
            const contactNumber = document.getElementById('contactNumber').value.trim();
            const capacity = document.getElementById('capacity').value.trim();

            // Validate required fields
            if (!name || !address || !city || !contactPerson || !contactNumber || !capacity) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Validation Error',
                    text: 'Please fill in all required fields'
                });
                return;
            }

            // Validate contact number format
            if (!/^[0-9]{10}$/.test(contactNumber)) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Invalid Contact Number',
                    text: 'Please enter a valid 10-digit contact number'
                });
                return;
            }

            // Validate capacity
            if (capacity < 1) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Invalid Capacity',
                    text: 'Capacity must be at least 1'
                });
                return;
            }

            // Create URL parameters
            const params = new URLSearchParams();
            if (id) params.append('id', id);
            params.append('name', name);
            params.append('address', address);
            params.append('city', city);
            params.append('contactPerson', contactPerson);
            params.append('contactNumber', contactNumber);
            params.append('capacity', capacity);

            console.log('Saving orphanage with params:', params.toString());

            // Show loading
            Swal.fire({
                title: 'Saving...',
                text: 'Please wait while we save the orphanage details',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });

            fetch('DashboardOrphanageServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: params.toString()
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok: ' + response.status);
                }
                return response.json();
            })
            .then(result => {
                console.log('Save result:', result);
                Swal.close();
                
                if (result.success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success!',
                        text: 'Orphanage saved successfully!',
                        timer: 2000,
                        showConfirmButton: false
                    });
                    
                    const modal = bootstrap.Modal.getInstance(document.getElementById('orphanageModal'));
                    if (modal) modal.hide();
                    loadOrphanages();
                    loadDashboard(); // Refresh stats
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: result.message || 'Failed to save orphanage'
                    });
                }
            })
            .catch(error => {
                console.error('Error saving orphanage:', error);
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Failed to save orphanage: ' + error.message
                });
            });
        }

        function deleteOrphanage(id) {
            if (!id || id === 'N/A') {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid orphanage ID',
                    text: 'Please select a valid orphanage to delete.'
                });
                return;
            }
            
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#ED145B',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    console.log('Deleting orphanage ID:', id);
                    
                    const params = new URLSearchParams();
                    params.append('action', 'delete');
                    params.append('id', id);
                    
                    // Show loading
                    Swal.fire({
                        title: 'Deleting...',
                        text: 'Please wait while we delete the orphanage',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });
                    
                    fetch('DashboardOrphanageServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: params.toString()
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok: ' + response.status);
                        }
                        return response.json();
                    })
                    .then(result => {
                        console.log('Delete result:', result);
                        Swal.close();
                        
                        if (result.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Deleted!',
                                text: 'Orphanage deleted successfully!',
                                timer: 2000,
                                showConfirmButton: false
                            });
                            loadOrphanages();
                            loadDashboard();
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: result.message || 'Failed to delete orphanage'
                            });
                        }
                    })
                    .catch(error => {
                        console.error('Error deleting orphanage:', error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Failed to delete orphanage: ' + error.message
                        });
                    });
                }
            });
        }

        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page loaded, initializing dashboard...');
            loadDashboard();
            loadOrphanages();
        });
    </script>
</body>
</html>
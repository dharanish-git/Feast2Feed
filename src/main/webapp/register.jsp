<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Community Food Donation - Register</title>
    <link rel="icon" type="image/x-icon" href="images/icon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
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
            background: linear-gradient(135deg, var(--light-color) 0%, #fff 100%);
            min-height: 100vh;
        }
        
        /* Navbar - Matching home.jsp */
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
        
        /* Register Form Styling */
        .register-container {
            min-height: calc(100vh - 76px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }
        
        .register-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: var(--shadow);
            padding: 50px 40px;
            max-width: 520px;
            width: 100%;
            border-top: 4px solid var(--primary-color);
            position: relative;
            overflow: hidden;
        }
        
        .register-card:before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: rgba(237,20,91,0.05);
        }
        
        .register-card:after {
            content: '';
            position: absolute;
            bottom: -30%;
            left: -30%;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: rgba(255,142,60,0.05);
        }
        
        .register-header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
            z-index: 2;
        }
        
        .register-title {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .register-subtitle {
            color: var(--text-color);
            font-size: 1.1rem;
        }
        
        .role-select {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 30px;
            position: relative;
            z-index: 2;
        }
        
        .role-option {
            display: flex;
            align-items: center;
            cursor: pointer;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .role-option input {
            margin-right: 8px;
            accent-color: var(--primary-color);
        }
        
        .role-option:hover {
            color: var(--primary-color);
        }
        
        .form-group {
            margin-bottom: 25px;
            position: relative;
            z-index: 2;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 12px 15px;
            font-size: 1rem;
            transition: var(--transition);
            background: #fafafa;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(237,20,91,0.1);
            background: #fff;
        }
        
        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #888;
            transition: var(--transition);
        }
        
        .toggle-password:hover {
            color: var(--primary-color);
        }
        
        .btn-submit {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: #fff;
            border: none;
            border-radius: 30px;
            padding: 14px 30px;
            font-weight: 600;
            font-size: 1.1rem;
            width: 100%;
            transition: var(--transition);
            margin-top: 10px;
            position: relative;
            z-index: 2;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(237,20,91,0.3);
        }
        
        .register-footer {
            text-align: center;
            margin-top: 30px;
            position: relative;
            z-index: 2;
            font-weight: 500;
        }
        
        .register-footer a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }
        
        .register-footer a:hover {
            color: var(--secondary-color);
        }
        
        .error-message {
            color: #dc3545;
            font-size: 0.9rem;
            margin-top: 5px;
            display: block;
        }
        
        @media (max-width: 576px) {
            .register-card {
                padding: 30px 25px;
            }
            
            .register-title {
                font-size: 2rem;
            }
            
            .role-select {
                flex-direction: column;
                gap: 15px;
                align-items: center;
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
                <li class="nav-item"><a class="nav-link active" href="register.jsp">Register</a></li>
                <li class="nav-item"><a class="nav-link" href="donation.jsp">Donate</a></li>
                <li class="nav-item"><a class="nav-link" href="request.jsp">Request</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
            </ul>
            <a class="btn btn-login ms-3" href="login.jsp">Login</a>
        </div>
    </div>
</nav>

<!-- Register Section -->
<section class="register-container">
    <div class="register-card">
        <div class="register-header">
            <h1 class="register-title">Join Our Community</h1>
            <p class="register-subtitle">Create your account to start making a difference</p>
        </div>
        
        <form id="registerForm" method="POST" action="RegisterServlet" novalidate>
            <div class="role-select">
                <label class="role-option">
                    <input type="radio" name="userRole" value="donor" <% 
                        String userRole = request.getParameter("userRole");
                        if (userRole == null || userRole.equals("donor")) { %> checked <% } %> /> Donor
                </label>
                <label class="role-option">
                    <input type="radio" name="userRole" value="ngo" <% 
                        if ("ngo".equals(userRole)) { %> checked <% } %> /> NGO
                </label>
            </div>
            
            <div class="form-group">
                <input type="text" name="name" class="form-control" placeholder="Full Name" required value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>"/>
                <div id="nameError" class="error-message"></div>
            </div>
            <div class="form-group">
                <input type="tel" name="mobile" class="form-control" placeholder="Mobile Number" pattern="[0-9]{10}" required value="<%= request.getParameter("mobile") != null ? request.getParameter("mobile") : "" %>"/>
                <div id="mobileError" class="error-message"></div>
            </div>
            <div class="form-group">
                <input type="email" name="email" class="form-control" placeholder="Email Address" required value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>"/>
                <div id="emailError" class="error-message"></div>
            </div>
            <div class="form-group">
                <input type="password" name="password" class="form-control" id="passwordInput" placeholder="Password" required minlength="6"/>
                <span class="toggle-password" onclick="togglePassword('passwordInput')">
                    <i class="fas fa-eye-slash" id="eyeIconPassword"></i>
                </span>
                <div id="passwordError" class="error-message"></div>
            </div>
            <div class="form-group">
                <input type="password" name="confirmPassword" class="form-control" id="confirmPasswordInput" placeholder="Confirm Password" required minlength="6"/>
                <span class="toggle-password" onclick="togglePassword('confirmPasswordInput')">
                    <i class="fas fa-eye-slash" id="eyeIconConfirm"></i>
                </span>
                <div id="confirmPasswordError" class="error-message"></div>
            </div>
            <button type="submit" class="btn-submit" id="registerBtn">Create Account</button>
        </form>
        
        <div class="register-footer">
            Already have an account? <a href="login.jsp">Sign in here</a>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            document.querySelector('.navbar').classList.add('scrolled');
        } else {
            document.querySelector('.navbar').classList.remove('scrolled');
        }
    });

    // Toggle password visibility
    function togglePassword(inputId) {
        var input = document.getElementById(inputId);
        var iconId = inputId === "passwordInput" ? "eyeIconPassword" : "eyeIconConfirm";
        var icon = document.getElementById(iconId);
        if (input.type === "password") {
            input.type = "text";
            icon.className = "fas fa-eye";
        } else {
            input.type = "password";
            icon.className = "fas fa-eye-slash";
        }
    }

    // Handle form submission with AJAX for better user experience
    document.getElementById('registerForm').addEventListener('submit', async function(e) {
        e.preventDefault();
        
        // Clear previous errors
        document.querySelectorAll('.error-message').forEach(el => el.textContent = '');
        
        const formData = new FormData(this);
        const registerBtn = document.getElementById('registerBtn');
        
        // Basic client-side validation
        let valid = true;
        const name = formData.get('name').trim();
        const mobile = formData.get('mobile');
        const email = formData.get('email').trim();
        const password = formData.get('password');
        const confirmPassword = formData.get('confirmPassword');
        
        if (!name) {
            document.getElementById('nameError').textContent = 'Name is required';
            valid = false;
        }
        if (!mobile.match(/^[0-9]{10}$/)) {
            document.getElementById('mobileError').textContent = 'Enter a valid 10-digit mobile number';
            valid = false;
        }
        if (!email.match(/\S+@\S+\.\S+/)) {
            document.getElementById('emailError').textContent = 'Please enter a valid email address';
            valid = false;
        }
        if (password.length < 6) {
            document.getElementById('passwordError').textContent = 'Password must be at least 6 characters';
            valid = false;
        }
        if (password !== confirmPassword) {
            document.getElementById('confirmPasswordError').textContent = 'Passwords do not match';
            valid = false;
        }
        
        if (!valid) return;
        
        registerBtn.disabled = true;
        registerBtn.textContent = 'Creating Account...';
        
        try {
            const response = await fetch('RegisterServlet', {
                method: 'POST',
                body: new URLSearchParams(new URLSearchParams(formData))
            });
            
            const result = await response.text();
            
            if (response.ok) {
                Swal.fire({
                    icon: 'success',
                    title: 'Registration Successful!',
                    text: 'Your account has been created successfully. Redirecting to login...',
                    confirmButtonColor: '#ED145B',
                    timer: 2000,
                    timerProgressBar: true,
                    showConfirmButton: false
                }).then(() => {
                    // Auto-redirect to login page
                    window.location.href = 'login.jsp';
                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Registration Failed',
                    text: result || 'There was an error creating your account. Please try again.',
                    confirmButtonColor: '#ED145B',
                    timer: 3000,
                    timerProgressBar: true
                });
            }
        } catch (error) {
            Swal.fire({
                icon: 'error',
                title: 'Network Error',
                text: 'Please check your connection and try again.',
                confirmButtonColor: '#ED145B',
                timer: 3000,
                timerProgressBar: true
            });
        } finally {
            registerBtn.disabled = false;
            registerBtn.textContent = 'Create Account';
        }
    });

    // Show server-side messages with auto-hide and redirect
    document.addEventListener('DOMContentLoaded', function() {
        <% if (request.getAttribute("successMessage") != null) { %>
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: '<%= request.getAttribute("successMessage") %>',
                confirmButtonColor: '#ED145B',
                timer: 2000,
                timerProgressBar: true,
                showConfirmButton: false
            }).then(() => {
                window.location.href = 'login.jsp';
            });
        <% } %>
        
        <% if (request.getAttribute("errorMessage") != null) { %>
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: '<%= request.getAttribute("errorMessage") %>',
                confirmButtonColor: '#ED145B',
                timer: 4000,
                timerProgressBar: true
            });
        <% } %>
    });
</script>
</body>
</html>
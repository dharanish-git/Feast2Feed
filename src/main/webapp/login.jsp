<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Community Food Donation - Login</title>
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
        
        /* Login Form Styling */
        .login-container {
            min-height: calc(100vh - 76px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }
        
        .login-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: var(--shadow);
            padding: 50px 40px;
            max-width: 480px;
            width: 100%;
            border-top: 4px solid var(--primary-color);
            position: relative;
            overflow: hidden;
        }
        
        .login-card:before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: rgba(237,20,91,0.05);
        }
        
        .login-card:after {
            content: '';
            position: absolute;
            bottom: -30%;
            left: -30%;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: rgba(255,142,60,0.05);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
            z-index: 2;
        }
        
        .login-title {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .login-subtitle {
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
        
        .login-footer {
            text-align: center;
            margin-top: 30px;
            position: relative;
            z-index: 2;
            font-weight: 500;
        }
        
        .login-footer a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }
        
        .login-footer a:hover {
            color: var(--secondary-color);
        }
        
        .error-message {
            color: #dc3545;
            font-size: 0.9rem;
            margin-top: 5px;
            display: block;
        }
        
        @media (max-width: 576px) {
            .login-card {
                padding: 30px 25px;
            }
            
            .login-title {
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
                <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                <li class="nav-item"><a class="nav-link" href="donation.jsp">Donate</a></li>
                <li class="nav-item"><a class="nav-link" href="request.jsp">Request</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
            </ul>
            <a class="btn btn-login ms-3" href="login.jsp">Login</a>
        </div>
    </div>
</nav>

<!-- Login Section -->
<section class="login-container">
    <div class="login-card">
        <div class="login-header">
            <h1 class="login-title">Welcome Back</h1>
            <p class="login-subtitle">Sign in to your account to continue</p>
        </div>
        
        <div class="role-select">
            <label class="role-option">
                <input type="radio" name="userRole" value="donor" checked /> Donor
            </label>
            <label class="role-option">
                <input type="radio" name="userRole" value="ngo" /> NGO
            </label>
            <label class="role-option">
                <input type="radio" name="userRole" value="admin" /> Admin
            </label>
        </div>
        
        <form id="loginForm" novalidate>
            <div class="form-group">
                <input type="text" id="email" class="form-control" placeholder="Email or Username" required />
                <div id="emailError" class="error-message"></div>
            </div>
            <div class="form-group">
                <input type="password" id="password" class="form-control" placeholder="Password" required minlength="6" />
                <span class="toggle-password" onclick="togglePassword('password')">
                    <i class="fas fa-eye-slash" id="eyeIconPassword"></i>
                </span>
                <div id="passwordError" class="error-message"></div>
            </div>
            <button type="submit" class="btn-submit" id="loginBtn">Login</button>
        </form>
        
        <div class="login-footer">
            Don't have an account? <a href="register.jsp">Register now</a>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const contextPath = '<%= request.getContextPath() %>';

    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            document.querySelector('.navbar').classList.add('scrolled');
        } else {
            document.querySelector('.navbar').classList.remove('scrolled');
        }
    });

    function togglePassword(inputId) {
        var input = document.getElementById(inputId);
        var icon = document.getElementById('eyeIconPassword');
        if (input.type === "password") {
            input.type = "text";
            icon.className = "fas fa-eye";
        } else {
            input.type = "password";
            icon.className = "fas fa-eye-slash";
        }
    }

    const loginForm = document.getElementById('loginForm');
    loginForm.addEventListener('submit', async function(e) {
        e.preventDefault();

        // Clear previous errors
        document.getElementById('emailError').textContent = '';
        document.getElementById('passwordError').textContent = '';

        const role = document.querySelector('input[name="userRole"]:checked').value;
        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value;

        let valid = true;
        if (!email) {
            document.getElementById('emailError').textContent = 'Email or username is required';
            valid = false;
        }
        if (!password) {
            document.getElementById('passwordError').textContent = 'Password is required';
            valid = false;
        } else if (password.length < 6) {
            document.getElementById('passwordError').textContent = 'Password must be at least 6 characters';
            valid = false;
        }
        if (!valid) return;

        const loginBtn = document.getElementById('loginBtn');
        loginBtn.disabled = true;
        loginBtn.textContent = 'Logging in...';

        try {
            const loginUrl = contextPath + '/LoginServlet';
            const response = await fetch(loginUrl, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({ role, email, password }),
                credentials: 'include'
            });
            const result = await response.json();

            if (result.success) {
                Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: 'Login successful! Redirecting...',
                    confirmButtonColor: '#ED145B',
                    timer: 1500,
                    timerProgressBar: true,
                    showConfirmButton: false
                }).then(() => {
                    // Auto-redirect after success
                    if (role === 'donor') {
                        window.location.href = contextPath + '/donation.jsp';
                    } else if (role === 'ngo') {
                        window.location.href = contextPath + '/request.jsp';
                    } else {
                        window.location.href = contextPath + '/dashboard.jsp';
                    }
                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Login Failed',
                    text: result.message || 'Invalid credentials. Please try again.',
                    confirmButtonColor: '#ED145B',
                    timer: 3000,
                    timerProgressBar: true
                });
            }
        } catch (error) {
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: 'Network error. Please check your connection and try again.',
                confirmButtonColor: '#ED145B',
                timer: 3000,
                timerProgressBar: true
            });
        } finally {
            loginBtn.disabled = false;
            loginBtn.textContent = 'Login';
        }
    });

    // Auto-hide any existing messages after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.display = 'none';
            });
        }, 5000);
    });
</script>
</body>
</html>
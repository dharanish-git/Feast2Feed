<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>About Us - Feast2Feed</title>
    <link rel="icon" type="image/x-icon" href="images/icon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
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
        }
        
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
            background: var(--primary-color);
            color: white;
            border-radius: 30px;
            padding: 8px 20px;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .btn-login:hover {
            background: #c8104a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(237,20,91,0.3);
        }
        
        .about-hero {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            height: 350px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
            text-align: center;
            border-radius: 0 0 20px 20px;
            margin-top: 76px;
            position: relative;
            overflow: hidden;
        }
        
        .about-hero:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23ffffff" fill-opacity="0.1" d="M0,96L48,112C96,128,192,160,288,186.7C384,213,480,235,576,213.3C672,192,768,128,864,128C960,128,1056,192,1152,192C1248,192,1344,128,1392,96L1440,64L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
            background-size: cover;
            background-position: center;
        }
        
        .about-hero-content {
            position: relative;
            z-index: 1;
        }
        
        .about-hero h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .about-hero p {
            font-size: 1.2rem;
            font-weight: 400;
            max-width: 600px;
            margin: 0 auto;
        }
        
        .section-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 30px;
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
        
        .team-card {
            text-align: center;
            background: white;
            border-radius: 15px;
            padding: 30px 20px;
            box-shadow: var(--shadow);
            margin-bottom: 25px;
            transition: var(--transition);
            height: 100%;
            border-top: 4px solid var(--primary-color);
            position: relative;
            overflow: hidden;
        }
        
        .team-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(237,20,91,0.1), transparent);
            transition: var(--transition);
        }
        
        .team-card:hover:before {
            left: 100%;
        }
        
        .team-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .team-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 20px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2.5rem;
            box-shadow: 0 5px 15px rgba(237,20,91,0.3);
        }
        
        .team-name {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 6px;
            font-size: 1.3rem;
        }
        
        .team-role {
            color: var(--secondary-color);
            font-weight: 500;
            margin-bottom: 15px;
            font-size: 1rem;
        }
        
        .mission-section {
            background: var(--light-color);
            padding: 70px 0;
            border-radius: 15px;
            margin: 50px 0;
            position: relative;
            overflow: hidden;
        }
        
        .mission-section:before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: rgba(237,20,91,0.05);
        }
        
        .mission-section:after {
            content: '';
            position: absolute;
            bottom: -30%;
            left: -10%;
            width: 250px;
            height: 250px;
            border-radius: 50%;
            background: rgba(255,142,60,0.05);
        }
        
        .mission-content {
            position: relative;
            z-index: 1;
        }
        
        .stats-section {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 70px 0;
            border-radius: 15px;
            margin: 50px 0;
        }
        
        .stat-item {
            text-align: center;
            padding: 20px;
        }
        
        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 10px;
            display: block;
        }
        
        .stat-label {
            font-size: 1.2rem;
            font-weight: 500;
        }
        
        .values-section {
            padding: 70px 0;
        }
        
        .value-card {
            text-align: center;
            padding: 30px 20px;
            border-radius: 15px;
            background: white;
            box-shadow: var(--shadow);
            transition: var(--transition);
            height: 100%;
            margin-bottom: 25px;
        }
        
        .value-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .value-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 2rem;
        }
        
        .value-title {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 15px;
            font-size: 1.3rem;
        }
        
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
            .about-hero {
                height: 300px;
                margin-top: 66px;
            }
            
            .about-hero h1 {
                font-size: 2.2rem;
            }
            
            .section-title {
                font-size: 1.8rem;
            }
            
            .stat-number {
                font-size: 2.5rem;
            }
        }
        
        @media (max-width: 576px) {
            .about-hero {
                height: 250px;
            }
            
            .about-hero h1 {
                font-size: 1.8rem;
            }
            
            .section-title {
                font-size: 1.5rem;
            }
            
            .navbar-brand {
                font-size: 1.5rem;
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
            data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                <li class="nav-item"><a class="nav-link" href="donation.jsp">Donate</a></li>
                <li class="nav-item"><a class="nav-link" href="request.jsp">Request</a></li>
                <li class="nav-item"><a class="nav-link active" href="aboutus.jsp">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
            </ul>
            <a class="btn btn-login ms-3" href="login.jsp">Login</a>
        </div>
    </div>
</nav>

<!-- Hero -->
<section class="about-hero">
    <div class="about-hero-content">
        <h1>About Feast2Feed</h1>
        <p>Codethon Project by Team Sharks - SLA Institute</p>
    </div>
</section>

<!-- Mission Section -->
<section class="mission-section">
    <div class="container">
        <div class="mission-content">
            <h2 class="section-title">Our Mission</h2>
            <p class="text-center" style="font-size: 1.15rem; max-width: 800px; margin: 0 auto;">
                Feast2Feed was created with a simple vision: <b>No food should go to waste when someone is hungry.</b>  
                Our platform connects generous food donors with orphanages and NGOs, ensuring timely delivery of meals.  
                Through technology and teamwork, we aim to reduce food waste and spread kindness in our community.
            </p>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="stats-section">
    <div class="container">
        <div class="row text-center">
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <span class="stat-number">500+</span>
                    <span class="stat-label">Meals Donated</span>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <span class="stat-number">50+</span>
                    <span class="stat-label">Partners</span>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <span class="stat-number">10+</span>
                    <span class="stat-label">Communities</span>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <span class="stat-number">100%</span>
                    <span class="stat-label">Volunteer Powered</span>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Values Section -->
<section class="values-section">
    <div class="container">
        <h2 class="section-title">Our Values</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="value-card">
                    <div class="value-icon">
                        <i class="fas fa-heart"></i>
                    </div>
                    <h3 class="value-title">Compassion</h3>
                    <p>We believe in showing empathy and kindness to those in need, ensuring no one goes hungry.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="value-card">
                    <div class="value-icon">
                        <i class="fas fa-recycle"></i>
                    </div>
                    <h3 class="value-title">Sustainability</h3>
                    <p>Reducing food waste helps protect our environment while feeding those in need.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="value-card">
                    <div class="value-icon">
                        <i class="fas fa-handshake"></i>
                    </div>
                    <h3 class="value-title">Collaboration</h3>
                    <p>We work together with donors, volunteers, and communities to create lasting impact.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Team Section -->
<section class="container py-5">
    <h2 class="section-title">Meet Team Sharks</h2>
    <div class="row g-4">
        <div class="col-md-3 col-6">
            <div class="team-card">
                <div class="team-img">
                    <i class="fas fa-user"></i>
                </div>
                <div class="team-name">Dharanishwaran</div>
                <div class="team-role">Full Stack Developer</div>
                <p>Passionate about creating seamless user experiences and robust backend systems.</p>
            </div>
        </div>
        <div class="col-md-3 col-6">
            <div class="team-card">
                <div class="team-img">
                    <i class="fas fa-user"></i>
                </div>
                <div class="team-name">Bharani Dharan</div>
                <div class="team-role">Database Administrator</div>
                <p>Ensuring data integrity and optimizing database performance for smooth operations.</p>
            </div>
        </div>
        <div class="col-md-3 col-6">
            <div class="team-card">
                <div class="team-img">
                    <i class="fas fa-user"></i>
                </div>
                <div class="team-name">Harish</div>
                <div class="team-role">Backend Developer</div>
                <p>Building the core functionality that powers our platform and connects all components.</p>
            </div>
        </div>
        <div class="col-md-3 col-6">
            <div class="team-card">
                <div class="team-img">
                    <i class="fas fa-user"></i>
                </div>
                <div class="team-name">Ramesh</div>
                <div class="team-role">Frontend Developer</div>
                <p>Crafting intuitive interfaces that make our platform accessible and user-friendly.</p>
            </div>
        </div>
    </div>
</section>

<!-- Closing Section -->
<section class="container text-center py-5">
    <h2 class="section-title">Why "Sharks"?</h2>
    <p style="max-width: 700px; margin: 0 auto; font-size: 1.1rem;">
        Our team name "Sharks" represents <b>strength, teamwork, and persistence</b>.  
        Just like sharks never stop moving, we believe in continuously striving to create solutions that make a real-world impact.  
        This Codethon project is our step towards solving food wastage and hunger challenges in our communities.
    </p>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-6 mb-4">
                <a href="home.jsp" class="footer-logo"><i class="fas fa-utensils"></i> Feast2Feed</a>
                <p>Connecting surplus food with those in need. Together, we can reduce waste and fight hunger.</p>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-6 mb-4 footer-links">
                <h5>Quick Links</h5>
                <ul>
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="aboutus.jsp">About Us</a></li>
                    <li><a href="donation.jsp">Donate Food</a></li>
                    <li><a href="request.jsp">Request Food</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6 mb-4 footer-links">
                <h5>Resources</h5>
                <ul>
                    <li><a href="#">How It Works</a></li>
                    <li><a href="#">Success Stories</a></li>
                    <li><a href="#">Volunteer</a></li>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6 mb-4 footer-links">
                <h5>Contact Info</h5>
                <ul>
                    <li><i class="fas fa-map-marker-alt me-2"></i> SLA Institute, Chennai</li>
                    <li><i class="fas fa-phone me-2"></i> +91 98765 43210</li>
                    <li><i class="fas fa-envelope me-2"></i> info@feast2feed.org</li>
                </ul>
            </div>
        </div>
        <div class="copyright">
            &copy; 2025 Feast2Feed. All rights reserved. | Codethon Project by Team Sharks
        </div>
    </div>
</footer>

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
    
    // Simple counter animation for stats
    document.addEventListener('DOMContentLoaded', function() {
        const statNumbers = document.querySelectorAll('.stat-number');
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const target = entry.target;
                    const finalValue = parseInt(target.textContent);
                    let currentValue = 0;
                    const increment = finalValue / 50;
                    
                    const timer = setInterval(() => {
                        currentValue += increment;
                        if (currentValue >= finalValue) {
                            target.textContent = finalValue + (target.textContent.includes('%') ? '%' : '+');
                            clearInterval(timer);
                        } else {
                            target.textContent = Math.floor(currentValue) + (target.textContent.includes('%') ? '%' : '+');
                        }
                    }, 30);
                    
                    observer.unobserve(target);
                }
            });
        }, { threshold: 0.5 });
        
        statNumbers.forEach(stat => {
            observer.observe(stat);
        });
    });
</script>
</body>
</html>
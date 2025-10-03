<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
       <link rel="icon" type="image/x-icon" href="images/icon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Community Food Donation - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Google Fonts: Montserrat for clean bold headings -->
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
        
        /* Hero Section */
        .hero {
          background-image: url("images/figma1.jpg");
          background-size: cover;
          background-position: center;
          height: 500px;
          position: relative;
          color: #fff;
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
          margin-top: 76px;
          border-radius: 0 0 20px 20px;
          overflow: hidden;
        }
        
        .hero-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0,0,0,0.47); /* only black overlay */
  z-index: 1;
  border-radius: 0 0 22px 22px; /* keep if needed for roundness at bottom */
}

        
        .hero-content {
          position: relative;
          z-index: 2;
          max-width: 800px;
          text-align: center;
          padding: 0 20px;
        }
        
        .hero-content h1 {
          font-size: 3rem;
          font-weight: 700;
          margin-bottom: 20px;
          text-shadow: 2px 2px 8px rgba(0,0,0,0.5);
          letter-spacing: -1px;
        }
        
        .hero-content p {
          font-size: 1.3rem;
          margin-bottom: 30px;
          text-shadow: 1px 1px 4px rgba(0,0,0,0.5);
          font-weight: 400;
        }
        
        .btn-primary, .btn-outline-light {
          border-radius: 30px;
          font-weight: 600;
          font-size: 1.1rem;
          padding: 12px 30px;
          transition: var(--transition);
        }
        
        .btn-primary {
          background-color: var(--primary-color);
          border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
          background-color: #c8104a;
          border-color: #c8104a;
          transform: translateY(-2px);
          box-shadow: 0 5px 15px rgba(237,20,91,0.4);
        }
        
        .btn-outline-light:hover {
          background-color: rgba(255,255,255,0.1);
          transform: translateY(-2px);
        }
        
        /* Image Gallery Section */
        .image-gallery {
          margin-top: 70px;
          margin-bottom: 50px;
        }
        
        .image-gallery img {
          border-radius: 15px;
          box-shadow: var(--shadow);
          width: 100%;
          height: 280px;
          object-fit: cover;
          margin-bottom: 15px;
          border: 3px solid #fafafa;
          transition: var(--transition);
        }
        
        .image-gallery img:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        
        /* Stats & Quotes Section */
        .stats {
          background: var(--light-color);
          border-radius: 15px;
          margin-top: 40px;
          padding: 40px 0;
          box-shadow: var(--shadow);
          position: relative;
          overflow: hidden;
        }
        
        .stats:before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 250px;
            height: 250px;
            border-radius: 50%;
            background: rgba(237,20,91,0.05);
        }
        
        .stats:after {
            content: '';
            position: absolute;
            bottom: -30%;
            left: -10%;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: rgba(255,142,60,0.05);
        }
        
        .stat-value {
          font-size: 2.5rem;
          color: var(--primary-color);
          font-weight: 700;
          margin-bottom: 10px;
          display: block;
        }
        
        .stat-label {
          font-size: 1.1rem;
          color: var(--text-color);
          font-weight: 500;
        }
        
        .quote-section {
          margin-top: 50px;
          margin-bottom: 50px;
          font-size: 1.25rem;
          color: var(--text-color);
          text-align: center;
          padding: 30px;
          background: linear-gradient(135deg, var(--light-color) 0%, #fff 100%);
          border-radius: 15px;
          box-shadow: var(--shadow);
        }
        
        .quote {
          font-style: italic;
          font-weight: 600;
          color: var(--primary-color);
          margin-bottom: 20px;
          font-size: 1.4rem;
        }
        
        .session-info {
          position: fixed;
          top: 80px;
          right: 20px;
          background: #f8f9fa;
          padding: 10px 15px;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
          font-size: 0.9rem;
          z-index: 1000;
        }
        
        /* New Styles for Additional Content */
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
        
        .how-it-works {
          padding: 70px 0;
          background-color: #fff;
          position: relative;
          overflow: hidden;
        }
        
        .how-it-works:before {
            content: '';
            position: absolute;
            top: -20%;
            left: -10%;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: rgba(237,20,91,0.03);
        }
        
        .step-card {
          text-align: center;
          padding: 30px 20px;
          border-radius: 15px;
          box-shadow: var(--shadow);
          height: 100%;
          transition: var(--transition);
          background: white;
          border-top: 4px solid var(--primary-color);
          position: relative;
          overflow: hidden;
        }
        
        .step-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(237,20,91,0.05), transparent);
            transition: var(--transition);
        }
        
        .step-card:hover:before {
            left: 100%;
        }
        
        .step-card:hover {
          transform: translateY(-10px);
          box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .step-number {
          width: 60px;
          height: 60px;
          background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
          color: white;
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          margin: 0 auto 20px;
          font-weight: 700;
          font-size: 1.5rem;
          box-shadow: 0 5px 15px rgba(237,20,91,0.3);
        }
        
        .step-card h3 {
            color: var(--primary-color);
            margin-bottom: 15px;
            font-weight: 600;
        }
        
        .impact-section {
          padding: 70px 0;
          background-color: var(--light-color);
          position: relative;
          overflow: hidden;
        }
        
        .impact-section:before {
            content: '';
            position: absolute;
            bottom: -10%;
            right: -5%;
            width: 250px;
            height: 250px;
            border-radius: 50%;
            background: rgba(255,142,60,0.05);
        }
        
        .impact-card {
          background: white;
          border-radius: 15px;
          padding: 30px 25px;
          box-shadow: var(--shadow);
          height: 100%;
          text-align: center;
          transition: var(--transition);
          border-top: 4px solid var(--secondary-color);
        }
        
        .impact-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .impact-icon {
          font-size: 3rem;
          margin-bottom: 20px;
          display: block;
        }
        
        .impact-card h3 {
            color: var(--primary-color);
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .impact-card p {
            color: var(--text-color);
            font-weight: 500;
        }
        
        .food-types {
          padding: 70px 0;
          background-color: #fff;
        }
        
        .food-card {
          border-radius: 15px;
          overflow: hidden;
          box-shadow: var(--shadow);
          margin-bottom: 30px;
          background: white;
          transition: var(--transition);
          height: 100%;
        }
        
        .food-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .food-card img {
          width: 100%;
          height: 220px;
          object-fit: cover;
          transition: var(--transition);
        }
        
        .food-card:hover img {
            transform: scale(1.05);
        }
        
        .food-card-content {
          padding: 25px;
        }
        
        .food-card-content h3 {
            color: var(--primary-color);
            margin-bottom: 15px;
            font-weight: 600;
        }
        
        .testimonial-section {
          padding: 70px 0;
          background: linear-gradient(135deg, var(--light-color) 0%, #fff 100%);
          position: relative;
          overflow: hidden;
        }
        
        .testimonial-section:before {
            content: '';
            position: absolute;
            top: -10%;
            left: -5%;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: rgba(237,20,91,0.05);
        }
        
        .testimonial-card {
          background: white;
          border-radius: 15px;
          padding: 30px;
          box-shadow: var(--shadow);
          margin-bottom: 30px;
          position: relative;
          transition: var(--transition);
          height: 100%;
        }
        
        .testimonial-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .testimonial-card:before {
          content: '"';
          font-size: 5rem;
          color: var(--primary-color);
          opacity: 0.2;
          position: absolute;
          top: 10px;
          left: 15px;
          line-height: 1;
        }
        
        .testimonial-text {
          font-style: italic;
          margin-bottom: 20px;
          font-size: 1.1rem;
          position: relative;
          z-index: 1;
        }
        
        .testimonial-author {
          font-weight: 600;
          color: var(--primary-color);
        }
        
       .cta-section {
  padding: 80px 0;
  background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('images/img3.png');
  background-size: cover;
  background-position: center;
  color: white;
  text-align: center;
  border-radius: 15px;
  margin: 50px 0;
  position: relative;
  overflow: hidden;
}

        
       .cta-section:before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: none; /* removes colored overlays completely */
}

        
        .cta-content {
            position: relative;
            z-index: 1;
        }
        
        .cta-section h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        .cta-section p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
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
            .hero {
                height: 450px;
                margin-top: 66px;
            }
            
            .hero-content h1 {
                font-size: 2.2rem;
            }
            
            .section-title {
                font-size: 1.8rem;
            }
            
            .stat-value {
                font-size: 2rem;
            }
        }
        
        @media (max-width: 576px) {
            .hero {
                height: 400px;
            }
            
            .hero-content h1 {
                font-size: 1.8rem;
            }
            
            .section-title {
                font-size: 1.5rem;
            }
            
            .navbar-brand {
                font-size: 1.5rem;
            }
            
            .btn-primary, .btn-outline-light {
                padding: 10px 20px;
                font-size: 1rem;
                display: block;
                width: 100%;
                margin-bottom: 10px;
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
                <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                <li class="nav-item"><a class="nav-link" href="donation.jsp">Donate</a></li>
                <li class="nav-item"><a class="nav-link" href="request.jsp">Request</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="statistics.jsp">Statistics</a></li>
            </ul>
            <a class="btn btn-login ms-3" href="login.jsp">Login</a>
        </div>
    </div>
</nav>

<!-- Session Info (will be populated by JavaScript) -->
<div id="sessionInfo" class="session-info" style="display: none;"></div>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <h1>"No one has ever become poor by giving."</h1>
        <p>Join us in making a difference through food donation to orphanages in need.</p>
        <a href="donation.jsp" class="btn btn-primary btn-lg me-3">Donate Food</a>
        <a href="register.jsp" class="btn btn-outline-light btn-lg">Register Now</a>
    </div>
</section>

<!-- Image Gallery Section -->
<section class="container image-gallery">
    <div class="row g-4">
        <div class="col-md-4">
            <img src="images/food1.jpg" alt="Children eating food" />
        </div>
        <div class="col-md-4">
            <img src="images/giving_food.jpg" alt="Volunteers distributing food" />
        </div>
        <div class="col-md-4">
            <img src="images/food2.jpg" alt="Food donation packing" />
        </div>
    </div>
</section>

<!-- How It Works Section -->
<section class="how-it-works">
    <div class="container">
        <h2 class="section-title">How It Works</h2>
        <div class="row g-4">
            <div class="col-md-3">
                <div class="step-card">
                    <div class="step-number">1</div>
                    <h3>Register</h3>
                    <p>Create an account as a donor or recipient organization</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="step-card">
                    <div class="step-number">2</div>
                    <h3>Post</h3>
                    <p>Donors post available food donations with details</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="step-card">
                    <div class="step-number">3</div>
                    <h3>Match</h3>
                    <p>Our system matches donations with nearby needs</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="step-card">
                    <div class="step-number">4</div>
                    <h3>Deliver</h3>
                    <p>Coordinate pickup and delivery to those in need</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="container stats text-center">
    <div class="row">
        <div class="col-md-4">
            <div class="stat-value">0%</div>
            <div class="stat-label">Platform Fee</div>
        </div>
        <div class="col-md-4">
            <div class="stat-value">100+</div>
            <div class="stat-label">Verified NGO Partners</div>
        </div>
        <div class="col-md-4">
            <div class="stat-value">1 Hour</div>
            <div class="stat-label">Average Pickup Time</div>
        </div>
    </div>
</section>

<!-- Impact Section -->
<section class="impact-section">
    <div class="container">
        <h2 class="section-title">Our Impact</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="impact-card">
                    <div class="impact-icon">🍽️</div>
                    <h3>1000+</h3>
                    <p>Meals Provided to Date</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="impact-card">
                    <div class="impact-icon">🌍</div>
                    <h3>10+</h3>
                    <p>Cities Served Across the State</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="impact-card">
                    <div class="impact-icon">📦</div>
                    <h3>5+ Tons</h3>
                    <p>Food Waste Prevented</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Food Types Section -->
<section class="food-types">
    <div class="container">
        <h2 class="section-title">What Food Can You Donate?</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="food-card">
                    <img src="images/veg.jpg" alt="Perishable foods">
                    <div class="food-card-content">
                        <h3>Perishable Foods</h3>
                        <p>Fresh fruits, vegetables, dairy products, and prepared meals that are properly stored and within safe consumption timeframes.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="food-card">
                    <img src="images/rice.jpeg" alt="Non-perishable foods">
                    <div class="food-card-content">
                        <h3>Non-Perishable Foods</h3>
                        <p>Canned goods, rice, pasta, cereal, and other shelf-stable items with intact packaging and valid expiration dates.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="food-card">
                    <img src="images/bakery.jpeg" alt="Bakery items">
                    <div class="food-card-content">
                        <h3>Bakery Items</h3>
                        <p>Bread, pastries, and other baked goods from restaurants, bakeries, or events that would otherwise go to waste.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Quotes Section -->
<section class="container quote-section">
    <div class="row">
        <div class="col-md-12 quote">
            "If you can't feed a hundred people, then just feed one." - Mother Teresa
        </div>
        <div class="col-md-12">
            "Food donation fosters a sense of community and togetherness, creating bonds that transcend differences."
        </div>
    </div>
</section>

<!-- Testimonials Section -->
<section class="testimonial-section">
    <div class="container">
        <h2 class="section-title">What People Say</h2>
        <div class="row">
            <div class="col-md-6">
                <div class="testimonial-card">
                    <p class="testimonial-text">“As a restaurant owner in Chennai, we used to throw away perfectly good food at the end of each day. Now we donate through Feast2Feed, and it’s incredibly rewarding to know we’re helping feed families in need.”</p>
                    <p class="testimonial-author">– S. Kumar, Restaurant Owner, Chennai</p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="testimonial-card">
                    <p class="testimonial-text">“Our orphanage in Madurai struggles with food budgets. Feast2Feed has been a blessing, providing nutritious meals for our children and teaching them about the kindness of strangers.”</p>
                    <p class="testimonial-author">- Father Thomas, Hope Children's Home</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Call to Action Section -->
<section class="container">
    <div class="cta-section">
        <div class="cta-content">
            <h2>Ready to Make a Difference?</h2>
            <p class="mb-4">Join thousands of donors and organizations fighting hunger and reducing food waste</p>
            <a href="register.jsp" class="btn btn-primary btn-lg me-3">Join Now</a>
            <a href="about.jsp" class="btn btn-outline-light btn-lg">Learn More</a>
        </div>
    </div>
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
                    <li><a href="about.jsp">About Us</a></li>
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
                    <li><i class="fas fa-map-marker-alt me-2"></i> Navalur, Chennai</li>
                    <li><i class="fas fa-phone me-2"></i> +91 8428532512</li>
                    <li><i class="fas fa-envelope me-2"></i> tmsharks.sla@gmail.com</li>
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
        const statNumbers = document.querySelectorAll('.stat-value');
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const target = entry.target;
                    const finalValue = target.textContent;
                    
                    // For percentage values
                    if (finalValue.includes('%')) {
                        let currentValue = 0;
                        const increment = 1;
                        
                        const timer = setInterval(() => {
                            currentValue += increment;
                            if (currentValue >= parseInt(finalValue)) {
                                target.textContent = finalValue;
                                clearInterval(timer);
                            } else {
                                target.textContent = currentValue + '%';
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
                                target.textContent = finalValue;
                                clearInterval(timer);
                            } else {
                                target.textContent = Math.floor(currentValue) + '+';
                            }
                        }, 30);
                    }
                    // For time values
                    else if (finalValue.includes('Hours')) {
                        target.textContent = finalValue;
                    }
                    
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
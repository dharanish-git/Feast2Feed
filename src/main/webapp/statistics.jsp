<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
       <link rel="icon" type="image/x-icon" href="images/icon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Statistics & Insights - Feast2Feed</title>
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
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 100px 0 60px;
            margin-top: 76px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .page-header:before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
        }
        
        .page-header:after {
            content: '';
            position: absolute;
            bottom: -30%;
            left: -10%;
            width: 250px;
            height: 250px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
        }
        
        .page-header h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }
        
        .page-header p {
            font-size: 1.2rem;
            max-width: 700px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }
        
        /* Statistics Overview */
        .stats-overview {
            padding: 80px 0;
            background-color: var(--light-color);
            position: relative;
            overflow: hidden;
        }
        
        .stats-overview:before {
            content: '';
            position: absolute;
            top: -10%;
            right: -5%;
            width: 250px;
            height: 250px;
            border-radius: 50%;
            background: rgba(237,20,91,0.05);
        }
        
        .stats-overview:after {
            content: '';
            position: absolute;
            bottom: -10%;
            left: -5%;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: rgba(255,142,60,0.05);
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 30px 25px;
            box-shadow: var(--shadow);
            height: 100%;
            text-align: center;
            transition: var(--transition);
            border-top: 4px solid var(--primary-color);
            position: relative;
            overflow: hidden;
        }
        
        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .stat-card.global {
            border-top-color: var(--primary-color);
        }
        
        .stat-card.india {
            border-top-color: var(--secondary-color);
        }
        
        .stat-card.tamilnadu {
            border-top-color: var(--accent-color);
        }
        
        .stat-icon {
            font-size: 3rem;
            margin-bottom: 20px;
            display: block;
        }
        
        .stat-card h3 {
            color: var(--primary-color);
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .stat-card p {
            color: var(--text-color);
            font-weight: 500;
        }
        
        /* Image Gallery Section */
        .stats-gallery {
            padding: 80px 0;
            background-color: #fff;
        }
        
        .gallery-item {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            background: white;
            transition: var(--transition);
            height: 100%;
            position: relative;
        }
        
        .gallery-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .gallery-item img {
            width: 100%;
            height: 280px;
            object-fit: cover;
            transition: var(--transition);
        }
        
        .gallery-item:hover img {
            transform: scale(1.05);
        }
        
        .gallery-caption {
            padding: 25px;
            background: white;
        }
        
        .gallery-caption h3 {
            color: var(--primary-color);
            margin-bottom: 15px;
            font-weight: 600;
            font-size: 1.4rem;
        }
        
        .gallery-caption p {
            color: var(--text-color);
            margin-bottom: 0;
        }
        
        /* Section Titles */
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
        
        /* Detailed Statistics */
        .detailed-stats {
            padding: 80px 0;
            background-color: var(--light-color);
        }
        
        .region-stats {
            margin-bottom: 60px;
        }
        
        .region-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid rgba(0,0,0,0.1);
        }
        
        .region-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            font-size: 1.8rem;
            color: white;
        }
        
        .global .region-icon {
            background: var(--primary-color);
        }
        
        .india .region-icon {
            background: var(--secondary-color);
        }
        
        .tamilnadu .region-icon {
            background: var(--accent-color);
        }
        
        .region-header h2 {
            color: var(--text-color);
            font-weight: 600;
            margin: 0;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }
        
        .stat-item {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            border-left: 4px solid var(--primary-color);
        }
        
        .stat-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .stat-item.global {
            border-left-color: var(--primary-color);
        }
        
        .stat-item.india {
            border-left-color: var(--secondary-color);
        }
        
        .stat-item.tamilnadu {
            border-left-color: var(--accent-color);
        }
        
        .stat-value {
            font-size: 2.2rem;
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 10px;
            display: block;
        }
        
        .stat-item.india .stat-value {
            color: var(--secondary-color);
        }
        
        .stat-item.tamilnadu .stat-value {
            color: var(--accent-color);
        }
        
        .stat-desc {
            font-size: 1.05rem;
            color: var(--text-color);
        }
        
        /* Comparison Section */
        .comparison-section {
            padding: 80px 0;
            background-color: #fff;
            position: relative;
            overflow: hidden;
        }
        
        .comparison-section:before {
            content: '';
            position: absolute;
            top: -10%;
            right: -5%;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: rgba(237,20,91,0.05);
        }
        
        .comparison-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: var(--shadow);
            height: 100%;
            transition: var(--transition);
        }
        
        .comparison-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .comparison-title {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 20px;
            font-size: 1.5rem;
        }
        
        .comparison-list {
            list-style: none;
            padding: 0;
        }
        
        .comparison-list li {
            margin-bottom: 15px;
            padding-left: 25px;
            position: relative;
        }
        
        .comparison-list li:before {
            content: '•';
            color: var(--primary-color);
            font-size: 1.5rem;
            position: absolute;
            left: 0;
            top: -5px;
        }
        
        /* Call to Action */
        .stats-cta {
            padding: 80px 0;
            background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)), url('images/stats-bg.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .stats-cta-content {
            position: relative;
            z-index: 1;
        }
        
        .stats-cta h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        .stats-cta p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .btn-primary {
          background-color: var(--primary-color);
          border-color: var(--primary-color);
          border-radius: 30px;
          font-weight: 600;
          font-size: 1.1rem;
          padding: 12px 30px;
          transition: var(--transition);
        }
        
        .btn-primary:hover {
          background-color: #c8104a;
          border-color: #c8104a;
          transform: translateY(-2px);
          box-shadow: 0 5px 15px rgba(237,20,91,0.4);
        }
        
        .btn-outline-light {
          border-radius: 30px;
          font-weight: 600;
          font-size: 1.1rem;
          padding: 12px 30px;
          transition: var(--transition);
        }
        
        footer {
            background: var(--dark-color);
            color: white;
            padding: 50px 0 20px;
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
            .page-header {
                padding: 80px 0 40px;
            }
            
            .page-header h1 {
                font-size: 2.2rem;
            }
            
            .section-title {
                font-size: 1.8rem;
            }
            
            .stat-card h3 {
                font-size: 2rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .region-header {
                flex-direction: column;
                text-align: center;
            }
            
            .region-icon {
                margin-right: 0;
                margin-bottom: 15px;
            }
        }
        
        @media (max-width: 576px) {
            .page-header h1 {
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
                <li class="nav-item"><a class="nav-link active" href="statistics.jsp">Statistics</a></li>
            </ul>
            <a class="btn btn-login ms-3" href="login.jsp">Login</a>
        </div>
    </div>
</nav>

<!-- Page Header -->
<section class="page-header">
    <div class="container">
        <h1>Statistics & Insights</h1>
        <p>Understanding the scale of food waste globally, across India, and in Tamil Nadu to drive meaningful change</p>
    </div>
</section>

<!-- Statistics Overview -->
<section class="stats-overview">
    <div class="container">
        <h2 class="section-title">The Food Waste Crisis at a Glance</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="stat-card global">
                    <div class="stat-icon">🌍</div>
                    <h3>931M</h3>
                    <p>Tons of food wasted globally each year</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card india">
                    <div class="stat-icon">🇮🇳</div>
                    <h3>78M</h3>
                    <p>Tons of household food waste in India annually</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card tamilnadu">
                    <div class="stat-icon">🏙️</div>
                    <h3>800T</h3>
                    <p>Tonnes of food waste daily in Chennai alone</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Image Gallery Section -->
<section class="stats-gallery">
    <div class="container">
        <h2 class="section-title">Visualizing the Food Waste Crisis</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="gallery-item">
                    <img src="images/foodwaste5.jpeg" alt="Global Food Waste Visualization">
                    <div class="gallery-caption">
                        <h3>Global Food Waste</h3>
                        <p>931 million tons of food wasted annually worldwide - enough to feed all hungry people four times over</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="gallery-item">
                    <img src="images/foodwaste2.jpg" alt="India Food Waste Problem">
                    <div class="gallery-caption">
                        <h3>India's Challenge</h3>
                        <p>78 million tonnes of household food waste annually while millions face food insecurity</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="gallery-item">
                    <img src="images/foodwaste3.jpg" alt="Chennai Food Waste Issues">
                    <div class="gallery-caption">
                        <h3>Chennai's Situation</h3>
                        <p>600-800 tonnes of food waste collected daily from households, restaurants and events</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="gallery-item">
                    <img src="images/foodwaste4.jpg" alt="Environmental Impact of Food Waste">
                    <div class="gallery-caption">
                        <h3>Environmental Impact</h3>
                        <p>Food waste generates 8-10% of global greenhouse gas emissions, contributing to climate change</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="gallery-item">
                    <img src="images/zerowaste.jpg" alt="Food Redistribution Solutions">
                    <div class="gallery-caption">
                        <h3>The Solution</h3>
                        <p>Redirecting just 25% of wasted food could feed all 690 million undernourished people worldwide</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="gallery-item">
                    <img src="images/happy.jpeg" alt="Community Food Sharing">
                    <div class="gallery-caption">
                        <h3>Community Impact</h3>
                        <p>Food donation creates social bonds and reduces landfill burden while fighting hunger</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Detailed Statistics -->
<section class="detailed-stats">
    <div class="container">
        <!-- Global Statistics -->
        <div class="region-stats global">
            <div class="region-header">
                <div class="region-icon">
                    <i class="fas fa-globe-americas"></i>
                </div>
                <h2>Global Food Waste Statistics</h2>
            </div>
            <div class="stats-grid">
                <div class="stat-item global">
                    <span class="stat-value">931 Million Tons</span>
                    <p class="stat-desc">Total food wasted globally each year according to UNEP Food Waste Index 2021</p>
                </div>
                <div class="stat-item global">
                    <span class="stat-value">17%</span>
                    <p class="stat-desc">Of all food available to consumers is wasted at retail and consumption levels</p>
                </div>
                <div class="stat-item global">
                    <span class="stat-value">61%</span>
                    <p class="stat-desc">Of food waste comes from households, 26% from food service, and 13% from retail</p>
                </div>
                <div class="stat-item global">
                    <span class="stat-value">8-10%</span>
                    <p class="stat-desc">Of global greenhouse gas emissions are linked to unconsumed food</p>
                </div>
                <div class="stat-item global">
                    <span class="stat-value">1.3B Tons</span>
                    <p class="stat-desc">Edible food wasted while 690M people suffer from hunger worldwide</p>
                </div>
                <div class="stat-item global">
                    <span class="stat-value">$1 Trillion</span>
                    <p class="stat-desc">Economic cost of food waste globally each year</p>
                </div>
            </div>
        </div>
        
        <!-- India Statistics -->
        <div class="region-stats india">
            <div class="region-header">
                <div class="region-icon">
                    <i class="fas fa-flag"></i>
                </div>
                <h2>India Food Waste Statistics</h2>
            </div>
            <div class="stats-grid">
                <div class="stat-item india">
                    <span class="stat-value">78 Million Tons</span>
                    <p class="stat-desc">Household food waste generated annually in India (Food Waste Index Report 2024)</p>
                </div>
                <div class="stat-item india">
                    <span class="stat-value">55 kg</span>
                    <p class="stat-desc">Food waste per person per year in India, higher than neighboring countries</p>
                </div>
                <div class="stat-item india">
                    <span class="stat-value">40%</span>
                    <p class="stat-desc">Of food produced in India is lost or wasted along the supply chain and consumer level</p>
                </div>
                <div class="stat-item india">
                    <span class="stat-value">₹92,000 Cr</span>
                    <p class="stat-desc">Value of food wasted annually in India, enough to feed 100M people</p>
                </div>
                <div class="stat-item india">
                    <span class="stat-value">22M Tons</span>
                    <p class="stat-desc">Wheat wasted annually in India, equivalent to Australia's total production</p>
                </div>
                <div class="stat-item india">
                    <span class="stat-value">1.5M</span>
                    <p class="stat-desc">Children in India die annually due to malnutrition-related causes</p>
                </div>
            </div>
        </div>
        
        <!-- Tamil Nadu Statistics -->
        <div class="region-stats tamilnadu">
            <div class="region-header">
                <div class="region-icon">
                    <i class="fas fa-city"></i>
                </div>
                <h2>Tamil Nadu & Chennai Food Waste</h2>
            </div>
            <div class="stats-grid">
                <div class="stat-item tamilnadu">
                    <span class="stat-value">600-800 Tonnes</span>
                    <p class="stat-desc">Food waste collected daily in Chennai from households, restaurants and events</p>
                </div>
                <div class="stat-item tamilnadu">
                    <span class="stat-value">65-70%</span>
                    <p class="stat-desc">Of Chennai's biodegradable waste consists of food and vegetable waste</p>
                </div>
                <div class="stat-item tamilnadu">
                    <span class="stat-value">40%</span>
                    <p class="stat-desc">Increase in food waste during festival seasons and wedding months</p>
                </div>
                <div class="stat-item tamilnadu">
                    <span class="stat-value">3,500+</span>
                    <p class="stat-desc">Large marriage halls in Chennai generating significant food surplus</p>
                </div>
                <div class="stat-item tamilnadu">
                    <span class="stat-value">₹200 Cr+</span>
                    <p class="stat-desc">Estimated value of edible food wasted annually in Chennai's hospitality sector</p>
                </div>
                <div class="stat-item tamilnadu">
                    <span class="stat-value">15%</span>
                    <p class="stat-desc">Reduction target in food waste set by Tamil Nadu government by 2025</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Comparison Section -->
<section class="comparison-section">
    <div class="container">
        <h2 class="section-title">Impact & Opportunities</h2>
        <div class="row g-4">
            <div class="col-md-6">
                <div class="comparison-card">
                    <h3 class="comparison-title">Environmental Impact</h3>
                    <ul class="comparison-list">
                        <li>Food waste in landfills generates methane, 25x more potent than CO₂</li>
                        <li>Wasted food represents wasted water, land, and energy resources</li>
                        <li>Reducing food waste is a top solution to climate change</li>
                        <li>Food waste accounts for 8% of global greenhouse gas emissions</li>
                        <li>Each kg of food waste prevented saves 4.5 kg of CO₂ equivalent</li>
                    </ul>
                </div>
            </div>
            <div class="col-md-6">
                <div class="comparison-card">
                    <h3 class="comparison-title">Social & Economic Opportunities</h3>
                    <ul class="comparison-list">
                        <li>Redirecting just 25% of wasted food could feed all undernourished people</li>
                        <li>Food donation creates community bonds and social responsibility</li>
                        <li>Reducing waste lowers food costs and increases affordability</li>
                        <li>Food recovery creates green jobs in logistics and distribution</li>
                        <li>Businesses save on waste disposal costs while building brand reputation</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Call to Action -->
<section class="stats-cta">
    <div class="container">
        <div class="stats-cta-content">
            <h2>Be Part of the Solution</h2>
            <p class="mb-4">These statistics show both the scale of the problem and the tremendous opportunity for impact. Join us in turning food waste into nourishment for those in need.</p>
            <a href="register.jsp" class="btn btn-primary btn-lg me-3">Join Our Mission</a>
            <a href="donation.jsp" class="btn btn-outline-light btn-lg">Donate Food Today</a>
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
                    <li><a href="statistics.jsp">Statistics</a></li>
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
    
    // Animate statistics when they come into view
    document.addEventListener('DOMContentLoaded', function() {
        const statValues = document.querySelectorAll('.stat-value');
        const galleryItems = document.querySelectorAll('.gallery-item');
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const target = entry.target;
                    target.style.opacity = '0';
                    target.style.transform = 'translateY(20px)';
                    
                    setTimeout(() => {
                        target.style.transition = 'all 0.8s ease';
                        target.style.opacity = '1';
                        target.style.transform = 'translateY(0)';
                    }, 200);
                    
                    observer.unobserve(target);
                }
            });
        }, { threshold: 0.3 });
        
        statValues.forEach(stat => {
            observer.observe(stat);
        });
        
        galleryItems.forEach((item, index) => {
            setTimeout(() => {
                observer.observe(item);
            }, index * 100);
        });
    });
</script>
</body>
</html>
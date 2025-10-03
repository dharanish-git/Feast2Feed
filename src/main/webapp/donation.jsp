<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Check if NGO is logged in
    HttpSession sessionCheck = request.getSession(false);
    if (sessionCheck == null || !"donor".equalsIgnoreCase((String) sessionCheck.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Community Food Donation - Donate Food</title>
  <link rel="icon" type="image/x-icon" href="images/icon.ico">
  <meta name="viewport" content="width=device-width, initial-scale=1" />
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
    
    /* Form Container */
    .form-container { 
        max-width: 700px; 
        margin: 40px auto 60px; 
        background: #fff;
        border-radius: 15px; 
        box-shadow: var(--shadow); 
        padding: 40px 35px;
        border-top: 4px solid var(--primary-color);
        position: relative;
        overflow: hidden;
    }
    
    .form-container:before {
        content: '';
        position: absolute;
        top: -20%;
        right: -10%;
        width: 200px;
        height: 200px;
        border-radius: 50%;
        background: rgba(237,20,91,0.03);
    }
    
    h2 { 
        font-weight: 700; 
        color: var(--primary-color); 
        margin-bottom: 30px; 
        text-align: center;
        position: relative;
        padding-bottom: 15px;
        font-size: 2.2rem;
    }
    
    h2:after {
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
    
    .form-group { 
        margin-bottom: 25px; 
    }
    
    label { 
        font-weight: 600; 
        color: var(--text-color);
        margin-bottom: 8px;
        display: block;
    }
    
    select.form-select, input.form-control, textarea.form-control {
        border-radius: 10px; 
        border: 1.75px solid #e0e0e0; 
        font-size: 1rem;
        padding: 12px 18px; 
        font-family: 'Montserrat', Arial, sans-serif;
        transition: var(--transition);
        background: #fafafa;
    }
    
    select.form-select:focus, input.form-control:focus, textarea.form-control:focus {
        border-color: var(--primary-color); 
        box-shadow: 0 0 10px rgba(237,20,91,0.2);
        background: #fff;
        transform: translateY(-2px);
    }
    
    .btn-submit { 
        background-color: var(--primary-color); 
        color: #fff; 
        border-radius: 30px; 
        font-weight: 600;
        padding: 14px 0; 
        width: 100%; 
        font-size: 1.1rem; 
        border: none; 
        cursor: pointer; 
        transition: var(--transition);
        margin-top: 10px;
    }
    
    .btn-submit:hover { 
        background-color: #c8104a; 
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(237,20,91,0.3);
    }
    
    .btn-submit:disabled { 
        background-color: #d16f87; 
        cursor: not-allowed;
        transform: none;
        box-shadow: none;
    }
    
    .btn-outline-danger{
        border-radius: 30px;
        font-weight: 600;
        transition: var(--transition);
    }
    
    .btn-outline-danger:hover {
        transform: translateY(-2px);
    }
    
    .audience-list { 
        margin-top: 10px; 
        font-style: italic; 
        font-weight: 600; 
        color: var(--primary-color); 
        padding: 10px;
        background: rgba(237,20,91,0.05);
        border-radius: 8px;
        border-left: 4px solid var(--primary-color);
        display: none; /* Hidden by default */
    }
    
    .error-message { 
        color: #dc3545; 
        font-size: 0.9rem; 
        margin-top: 8px; 
        font-weight: 500;
    }
    
    .food-checkbox-group { 
        margin-top: 15px; 
    }
    
    .food-checkbox-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
        gap: 12px;
        margin-top: 10px;
    }
    
    .food-checkbox { 
        display: flex;
        align-items: center;
        padding: 8px 12px;
        background: #f8f9fa;
        border-radius: 8px;
        transition: var(--transition);
    }
    
    .food-checkbox:hover {
        background: rgba(237,20,91,0.05);
        transform: translateY(-2px);
    }
    
    .food-checkbox input { 
        margin-right: 8px; 
        transform: scale(1.2);
    }
    
    .food-checkbox label {
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
        margin-bottom: 0;
    }
    
    .food-checkbox:hover label {
        color: var(--primary-color);
    }
    
    .selected-foods { 
        margin-top: 15px; 
        padding: 15px; 
        background: var(--light-color); 
        border-radius: 10px; 
        border-left: 4px solid var(--accent-color);
        transition: var(--transition);
    }
    
    .selected-foods:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    }
    
    /* SweetAlert2 custom styling */
    .swal2-popup {
        border-radius: 15px;
        font-family: 'Montserrat', Arial, sans-serif;
        box-shadow: var(--shadow);
    }
    
    .swal2-title {
        color: var(--primary-color);
        font-weight: 700;
    }
    
    .swal2-confirm {
        background-color: var(--primary-color) !important;
        border-radius: 30px !important;
        padding: 10px 24px !important;
        font-weight: 600 !important;
        transition: var(--transition) !important;
    }
    
    .swal2-confirm:hover {
        background-color: #c8104a !important;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(237,20,91,0.3) !important;
    }
    
    .swal2-icon {
        border-color: var(--primary-color) !important;
        color: var(--primary-color) !important;
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .form-container {
            margin: 30px 15px;
            padding: 30px 25px;
        }
        
        h2 {
            font-size: 1.8rem;
        }
        
        .navbar-brand {
            font-size: 1.5rem;
        }
        
        .food-checkbox-container {
            grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
        }
    }
    
    @media (max-width: 576px) {
        .form-container {
            padding: 25px 20px;
        }
        
        h2 {
            font-size: 1.5rem;
        }
        
        .food-checkbox-container {
            grid-template-columns: 1fr;
        }
    }
  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
  <div class="container">
    <a class="navbar-brand" href="home.jsp"><i class="fas fa-utensils"></i> Feast2Feed</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" >
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="MyDonationServlet">My Donations</a></li>
        <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
        <li class="nav-item"><a class="nav-link active" href="donation.jsp">Donate</a></li>
        <li class="nav-item"><a class="nav-link" href="request.jsp">Request</a></li>
        <li class="nav-item"><a class="nav-link" href="#" id="logoutBtn">Logout</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="form-container">
  <h2>Donate Food</h2>
  <form id="donationForm" novalidate>
    <div class="form-group">
      <label for="donorName">Name</label>
      <input type="text" id="donorName" name="donorName" class="form-control" placeholder="Your Name" required />
      <div id="donorNameError" class="error-message"></div>
    </div>

    <div class="form-group">
      <label for="mobileNumber">Mobile Number</label>
      <input type="tel" id="mobileNumber" name="mobile" class="form-control" placeholder="10-digit Mobile Number" required pattern="\\d{10}" />
      <div id="mobileNumberError" class="error-message"></div>
    </div>

    <div class="form-group">
      <label for="pickupAddress">Pickup Address</label>
      <textarea id="pickupAddress" name="pickupAddress" class="form-control" placeholder="Enter pickup address or use 'Fetch Location'" rows="3" required></textarea>
      <div id="pickupAddressError" class="error-message"></div>
      <button type="button" id="fetchLocationBtn" class="btn btn-outline-danger btn-sm mt-2">Fetch Location</button>
    </div>

    <div class="form-group">
      <label>Select Food Types (Multiple Selection)</label>
      <div class="food-checkbox-group">
        <div class="food-checkbox-container">
          <div class="food-checkbox">
            <input type="checkbox" name="foodTypes" value="idly" id="idly">
            <label for="idly">Idly</label>
          </div>
          <div class="food-checkbox">
            <input type="checkbox" name="foodTypes" value="dosa" id="dosa">
            <label for="dosa">Dosa</label>
          </div>
          <div class="food-checkbox">
            <input type="checkbox" name="foodTypes" value="meals" id="meals">
            <label for="meals">Meals</label>
          </div>
          <div class="food-checkbox">
            <input type="checkbox" name="foodTypes" value="chapati" id="chapati">
            <label for="chapati">Chapati</label>
          </div>
          <div class="food-checkbox">
            <input type="checkbox" name="foodTypes" value="pongal" id="pongal">
            <label for="pongal">Pongal</label>
          </div>
          <div class="food-checkbox">
            <input type="checkbox" name="foodTypes" value="pizza" id="pizza">
            <label for="pizza">Pizza</label>
          </div>
          <div class="food-checkbox">
            <input type="checkbox" name="foodTypes" value="burger" id="burger">
            <label for="burger">Burger</label>
          </div>
          <div class="food-checkbox">
            <input type="checkbox" name="foodTypes" value="fries" id="fries">
            <label for="fries">French Fries</label>
          </div>
          <div class="food-checkbox">
            <input type="checkbox" name="foodTypes" value="pasta" id="pasta">
            <label for="pasta">Pasta</label>
          </div>
          <div class="food-checkbox">
            <input type="checkbox" name="foodTypes" value="fruits" id="fruits">
            <label for="fruits">Fruits</label>
          </div>
          <div class="food-checkbox">
            <input type="checkbox" name="foodTypes" value="vegetables" id="vegetables">
            <label for="vegetables">Vegetables</label>
          </div>
        </div>
      </div>
      <div id="selectedFoods" class="selected-foods" style="display: none;">
        <strong>Selected Foods:</strong> <span id="selectedFoodsList"></span>
      </div>
      <div id="foodTypeError" class="error-message"></div>
      <div id="audienceSuitability" class="audience-list"></div>
    </div>

    <div class="form-group">
      <label for="notes">Notes (Optional)</label>
      <textarea id="notes" name="notes" class="form-control" placeholder="Any special notes" rows="3"></textarea>
    </div>

    <button type="submit" class="btn-submit" id="donateBtn">Submit Donation</button>
  </form>
</div>

<script>
  const contextPath = '<%=request.getContextPath()%>';

  const foodAudienceRules = {
    idly: ['Kids','Adults','Old People'],
    dosa: ['Kids','Adults','Old People'],
    meals: ['Kids','Adults','Old People'],
    chapati: ['Kids','Adults','Old People'],
    pongal: ['Kids','Adults','Old People'],
    pizza: ['Adults'],
    burger: ['Adults'],
    fries: ['Adults'],
    pasta: ['Adults'],
    fruits: ['Kids','Adults','Old People'],
    vegetables: ['Kids','Adults','Old People']
  };

  const fetchLocationBtn = document.getElementById("fetchLocationBtn");
  const pickupAddressInput = document.getElementById("pickupAddress");
  const donateBtn = document.getElementById("donateBtn");
  const selectedFoodsDiv = document.getElementById("selectedFoods");
  const selectedFoodsList = document.getElementById("selectedFoodsList");
  const audienceSuitabilityDiv = document.getElementById("audienceSuitability");

  // Navbar scroll effect
  window.addEventListener('scroll', function() {
      if (window.scrollY > 50) {
          document.querySelector('.navbar').classList.add('scrolled');
      } else {
          document.querySelector('.navbar').classList.remove('scrolled');
      }
  });

  // Update selected foods display
  function updateSelectedFoods() {
    const selected = Array.from(document.querySelectorAll('input[name="foodTypes"]:checked'))
      .map(cb => cb.value);
    
    if (selected.length > 0) {
      selectedFoodsList.textContent = selected.join(', ');
      selectedFoodsDiv.style.display = 'block';
      
      // Update audience suitability
      const allAudiences = new Set();
      selected.forEach(food => {
        const audiences = foodAudienceRules[food] || [];
        audiences.forEach(aud => allAudiences.add(aud));
      });
      
      audienceSuitabilityDiv.innerText = "Suitable for: " + Array.from(allAudiences).join(', ');
      audienceSuitabilityDiv.style.display = 'block';
    } else {
      selectedFoodsDiv.style.display = 'none';
      audienceSuitabilityDiv.style.display = 'none';
    }
    document.getElementById("foodTypeError").innerText = "";
  }

  // Add event listeners to all checkboxes
  document.querySelectorAll('input[name="foodTypes"]').forEach(checkbox => {
    checkbox.addEventListener('change', updateSelectedFoods);
  });

  // Fetch location with reverse geocoding
  fetchLocationBtn.addEventListener('click', () => {
    if (!navigator.geolocation) {
      Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'Geolocation is not supported by your browser.'
      });
      return;
    }
    fetchLocationBtn.disabled = true;
    fetchLocationBtn.textContent = "Fetching...";
    navigator.geolocation.getCurrentPosition(async (position) => {
      const lat = position.coords.latitude;
      const lon = position.coords.longitude;
      try {
        const backendUrl = contextPath + '/reverse-geocode?lat=' + encodeURIComponent(lat) + '&lon=' + encodeURIComponent(lon);
        const res = await fetch(backendUrl);
        if (!res.ok) throw new Error('Error fetching address');
        const data = await res.json();
        pickupAddressInput.value = data.display_name || `${lat.toFixed(6)}, ${lon.toFixed(6)}`;
      } catch (error) {
        pickupAddressInput.value = `${lat.toFixed(6)}, ${lon.toFixed(6)}`;
        Swal.fire({
          icon: 'warning',
          title: 'Partial success',
          text: 'Could not fetch full address. Coordinates used.'
        });
      } finally {
        fetchLocationBtn.disabled = false;
        fetchLocationBtn.textContent = "Fetch Location";
      }
    }, (error) => {
      Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'Failed to get location: ' + error.message
      });
      fetchLocationBtn.disabled = false;
      fetchLocationBtn.textContent = "Fetch Location";
    }, { enableHighAccuracy: true, timeout: 10000, maximumAge: 0 });
  });

  // Form validation and submission
  document.getElementById("donationForm").addEventListener('submit', async function(e) {
    e.preventDefault();

    // Clear previous errors
    ['donorNameError', 'mobileNumberError', 'pickupAddressError', 'foodTypeError'].forEach(id => {
      document.getElementById(id).innerText = '';
    });

    const donorName = document.getElementById('donorName').value.trim();
    const mobile = document.getElementById('mobileNumber').value.trim();
    const pickupAddress = pickupAddressInput.value.trim();
    const foodTypes = Array.from(document.querySelectorAll('input[name="foodTypes"]:checked'))
      .map(cb => cb.value);
    const notes = document.getElementById('notes').value.trim();

    let valid = true;
    if (!donorName) {
      document.getElementById('donorNameError').innerText = 'Name is required.';
      valid = false;
    }
    if (!mobile || !/^\d{10}$/.test(mobile)) {
      document.getElementById('mobileNumberError').innerText = 'Enter valid 10-digit mobile number.';
      valid = false;
    }
    if (!pickupAddress) {
      document.getElementById('pickupAddressError').innerText = 'Pickup address is required.';
      valid = false;
    }
    if (foodTypes.length === 0) {
      document.getElementById('foodTypeError').innerText = 'Please select at least one food type.';
      valid = false;
    }
    if (!valid) return;

    donateBtn.disabled = true;
    donateBtn.textContent = 'Submitting...';

    try {
      const formData = new URLSearchParams();
      formData.append('donorName', donorName);
      formData.append('mobile', mobile);
      formData.append('pickupAddress', pickupAddress);
      formData.append('foodTypes', foodTypes.join(','));
      formData.append('notes', notes);

      const res = await fetch(contextPath + '/DonationServlet', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: formData.toString(),
        credentials: 'include'
      });
      const data = await res.json();
      if (res.ok && data.success) {
        Swal.fire({
          icon: 'success',
          title: 'Success!',
          text: data.message || 'Donation submitted successfully!',
          confirmButtonColor: '#ED145B'
        });
        this.reset();
        selectedFoodsDiv.style.display = 'none';
        audienceSuitabilityDiv.style.display = 'none';
      } else {
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: data.message || 'Failed to submit donation.',
          confirmButtonColor: '#ED145B'
        });
      }
    } catch (error) {
      Swal.fire({
        icon: 'error',
        title: 'Server Error',
        text: 'An error occurred during submission. Please try again later.',
        confirmButtonColor: '#ED145B'
      });
    } finally {
      donateBtn.disabled = false;
      donateBtn.textContent = 'Submit Donation';
    }
  });

  document.getElementById('logoutBtn').addEventListener('click', () => {
    window.location.href = contextPath + '/logout.jsp';
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
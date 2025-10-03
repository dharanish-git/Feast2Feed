<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>My Donations</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <style>
    body { font-family: 'Montserrat', Arial, sans-serif; padding-top:56px; }
    .status-pill { border-radius: 18px; padding: 6px 12px; font-weight:600; }
    .s-wait { background:#fff3f6; color:#ED145B; border:1px solid #ED145B; }
    .s-claimed { background:#fff7e6; color:#d07a00; border:1px solid #d07a00; }
    .s-onway { background:#e8f8ff; color:#0a7ea4; border:1px solid #0a7ea4; }
    .s-delivered { background:#e9fbe9; color:#0b9a3b; border:1px solid #0b9a3b; }
  </style>
</head>
<body>
<nav class="navbar navbar-light fixed-top bg-white">
  <div class="container">
    <a class="navbar-brand" href="home.jsp">Feast2Feed</a>
    <a class="btn btn-primary" href="logout.jsp">Logout</a>
  </div>
</nav>

<div class="container mt-5">
  <h2 class="text-danger">My Donation History</h2>
  <div id="history" class="row gy-3"></div>
</div>

<script>
  const contextPath = '<%=request.getContextPath()%>';
  async function loadHistory() {
    try {
      const res = await fetch(contextPath + '/MyDonationServlet', { credentials:'include' });
      const data = await res.json();
      const container = document.getElementById('history');
      container.innerHTML = '';
      if (!Array.isArray(data) || data.length===0) {
        container.innerHTML = '<div class="col-12"><p>No donations yet.</p></div>';
        return;
      }
      data.forEach(d => {
        const col = document.createElement('div'); col.className='col-md-6';
        let statusClass = 's-wait';
        if (d.status && d.status.includes('Waiting for NGO')) statusClass='s-wait';
        else if (d.status && d.status.includes('claimed')) statusClass='s-claimed';
        else if (d.status && d.status.includes('on the way')) statusClass='s-onway';
        else if (d.status && d.status.includes('delivered')) statusClass='s-delivered';
        col.innerHTML = `
          <div class="card p-3">
            <div><strong>${d.donor_name}</strong> <small class="text-muted">(${d.mobile})</small></div>
            <div class="small text-muted">${d.pickup_address}</div>
            <div>Foods: ${d.food_types}</div>
            <div class="mt-2">
              <span class="status-pill ${statusClass}">${d.status}</span>
            </div>
            <div class="mt-2 text-muted small">Posted: ${d.created_at}</div>
          </div>`;
        container.appendChild(col);
      });
    } catch(err) { console.error(err); }
  }
  window.addEventListener('DOMContentLoaded', loadHistory);
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

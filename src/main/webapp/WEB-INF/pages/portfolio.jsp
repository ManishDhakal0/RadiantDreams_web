<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Portfolio | Radiant Dreams</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portfolio.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Helvetica+Neue:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
 <jsp:include page="header.jsp"/>

  <main class="portfolio-section">
    <div class="portfolio-header">
      <h1>Your Profile</h1>
      <p>View and manage your account information and settings</p>
    </div>

    <div class="portfolio-content">
      <div class="profile-card">
        <div class="profile-header">
          <h2>Account Information</h2>
          <a href="${pageContext.request.contextPath}/updatePortfolio" class="edit-button">
            <img src="${pageContext.request.contextPath}/resources/images/editIcon.png" alt="Edit" class="edit-icon">
            <span>Edit Profile</span>
          </a>
        </div>

        <div class="profile-body">
          <div class="profile-image-container">
            <c:choose>
              <c:when test="${not empty customer.image}">
                <img class="profile-image" src="${pageContext.request.contextPath}${customer.image}" alt="Profile Image">
              </c:when>
              <c:otherwise>
                <img class="profile-image" src="${pageContext.request.contextPath}/resources/images/default.png" alt="Default Profile Image">
              </c:otherwise>
            </c:choose>
          </div>

          <div class="profile-details">
            <div class="detail-group">
              <h3>Personal Information</h3>
              <div class="detail-item">
                <span class="detail-label">Name:</span>
                <span class="detail-value">${customer.firstName} ${customer.lastName}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">Username:</span>
                <span class="detail-value">${customer.username}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">Date of Birth:</span>
                <span class="detail-value">${customer.dob}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">Gender:</span>
                <span class="detail-value">${customer.gender}</span>
              </div>
            </div>

            <div class="detail-group">
              <h3>Contact Information</h3>
              <div class="detail-item">
                <span class="detail-label">Email:</span>
                <span class="detail-value">${customer.email}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">Phone:</span>
                <span class="detail-value">${customer.phone}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">Address:</span>
                <span class="detail-value">${customer.address}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="action-cards">
        <div class="action-card">
          <h3>Order History</h3>
          <p>View your past orders and check their status</p>
          <a href="${pageContext.request.contextPath}/orders" class="action-button">View Orders</a>
        </div>
        
        <div class="action-card">
          <h3>Wishlist</h3>
          <p>Manage your saved products for future purchase</p>
          <a href="${pageContext.request.contextPath}/wishlist" class="action-button">View Wishlist</a>
        </div>
        
        <div class="action-card">
          <h3>Sleep Preferences</h3>
          <p>Update your sleep profile to get personalized recommendations</p>
          <a href="${pageContext.request.contextPath}/preferences" class="action-button">Edit Preferences</a>
        </div>
      </div>
    </div>
  </main>

  <jsp:include page="footer.jsp"/>

</body>
</html>
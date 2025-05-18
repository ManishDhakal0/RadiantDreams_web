<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Profile | Radiant Dreams</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/updatePortfolio.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Helvetica+Neue:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
 <jsp:include page="header.jsp"/>


  <main class="update-section">
    <div class="update-header">
      <h1>Update Your Profile</h1>
      <p>Update your personal information and preferences</p>
    </div>

    <div class="update-content">
      <form action="${pageContext.request.contextPath}/updatePortfolio" method="post" enctype="multipart/form-data" class="update-form">
        <div class="form-columns">
          <div class="form-column">
            <h2>Personal Information</h2>
            
            <div class="form-group">
              <label for="first_name">First Name</label>
              <input type="text" id="first_name" name="first_name" value="${customer.firstName}" required>
              <c:if test="${not empty firstNameError}">
                <div class="field-error">${firstNameError}</div>
              </c:if>
            </div>
            
            <div class="form-group">
              <label for="last_name">Last Name</label>
              <input type="text" id="last_name" name="last_name" value="${customer.lastName}" required>
              <c:if test="${not empty lastNameError}">
                <div class="field-error">${lastNameError}</div>
              </c:if>
            </div>
            
            <div class="form-group">
              <label for="gender">Gender</label>
              <select id="gender" name="gender" required>
                <option value="male" ${customer.gender == 'male' ? 'selected' : ''}>Male</option>
                <option value="female" ${customer.gender == 'female' ? 'selected' : ''}>Female</option>
                <option value="other" ${customer.gender == 'other' ? 'selected' : ''}>Other</option>
              </select>
            </div>
            
            <div class="form-group">
              <label for="dob">Date of Birth</label>
              <input type="date" id="dob" name="dob" value="${customer.dob}" required>
              <c:if test="${not empty dobError}">
                <div class="field-error">${dobError}</div>
              </c:if>
            </div>
          </div>
          
          <div class="form-column">
            <h2>Contact Information</h2>
            
            <div class="form-group">
              <label for="email">Email Address</label>
              <input type="email" id="email" name="email" value="${customer.email}" required>
              <c:if test="${not empty emailError}">
                <div class="field-error">${emailError}</div>
              </c:if>
            </div>
            
            <div class="form-group">
              <label for="phone">Phone Number</label>
              <input type="tel" id="phone" name="phone" value="${customer.phone}" required>
              <c:if test="${not empty phoneError}">
                <div class="field-error">${phoneError}</div>
              </c:if>
            </div>
            
            <div class="form-group">
              <label for="address">Address</label>
              <input type="text" id="address" name="address" value="${customer.address}" required>
            </div>
            
            <div class="form-group">
              <label for="password">New Password <span class="optional">(Optional)</span></label>
              <input type="password" id="password" name="password" placeholder="Leave blank to keep current password">
              <c:if test="${not empty passwordError}">
                <div class="field-error">${passwordError}</div>
              </c:if>
            </div>
          </div>
        </div>
        
        <div class="image-section">
          <h2>Profile Image</h2>
          <div class="image-container">
            <div class="current-image">
              <c:if test="${not empty customer.image}">
                <img src="${pageContext.request.contextPath}${customer.image}" alt="Current Profile Image">
                <p>Current Image</p>
              </c:if>
              <c:if test="${empty customer.image}">
                <img src="${pageContext.request.contextPath}/resources/images/default.png" alt="Default Profile Image">
                <p>Default Image</p>
              </c:if>
            </div>
            
            <div class="upload-controls">
              <label for="image-upload" class="file-upload-label">Choose New Image</label>
              <input type="file" id="image-upload" name="image" class="file-upload-input">
              <p class="upload-help">Supported formats: JPG, PNG, GIF (Max size: 5MB)</p>
            </div>
          </div>
        </div>
        
        <div class="form-actions">
          <a href="${pageContext.request.contextPath}/portfolio" class="cancel-button">Cancel</a>
          <button type="submit" class="submit-button">Save Changes</button>
        </div>
      </form>
    </div>
  </main>

 <jsp:include page="footer.jsp"/>

</body>
</html>
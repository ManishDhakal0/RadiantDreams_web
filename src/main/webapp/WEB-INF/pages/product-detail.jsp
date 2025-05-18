<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.RadiantDreams.model.ProductModel" %>
<%
  ProductModel product = (ProductModel) request.getAttribute("product");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${product.name} - Radiant Dreams</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product-detail.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Helvetica+Neue:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
  
  
  <div class="container">
    <div class="product-detail">
      <div class="product-gallery">
        <div class="product-image">
         <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.name}">

        </div>
      </div>
      
      <div class="product-info">
        <h1><%= product.getName() %></h1>
        
        <div class="product-description">
          <%= product.getDescription() %>
        </div>
        
        <div class="product-meta">
          <p class="price">₹<%= product.getPrice() %></p>
          <p class="category">Category: <%= product.getCategory() %></p>
          <p class="stock">Available: <%= product.getQuantity() %> in stock</p>
        </div>
        
        <div class="product-actions">
          <button class="buy-button">ADD TO CART</button>
        </div>
        
        <a href="<%= request.getContextPath() %>/products" class="back-link">Back to Products</a>
      </div>
    </div>
    
    <div class="product-details-section">
      <h2>Product Specifications</h2>
      <div class="specifications">
        <div class="spec-item">
          <p class="spec-title">Dimensions</p>
          <p class="spec-value">As per selected size</p>
        </div>
        <div class="spec-item">
          <p class="spec-title">Material</p>
          <p class="spec-value">Premium quality materials</p>
        </div>
        <div class="spec-item">
          <p class="spec-title">Warranty</p>
          <p class="spec-value">10 years</p>
        </div>
        <div class="spec-item">
          <p class="spec-title">Trial Period</p>
          <p class="spec-value">100 nights</p>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
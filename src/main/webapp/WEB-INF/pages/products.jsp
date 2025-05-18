<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.RadiantDreams.model.ProductModel" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Products - Radiant Dreams</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">
<h1>Our Products</h1>

<form method="get" action="${pageContext.request.contextPath}/products" class="filter-bar">
<label for="categoryFilter">Filter by Category:</label>
<select id="categoryFilter" name="category" onchange="this.form.submit()">
<option value="all" ${empty selectedCategory || selectedCategory == 'all' ? 'selected' : ''}>All Products</option>
<c:forEach var="category" items="${categoryList}">
<option value="${category.name}" ${category.name == selectedCategory ? 'selected' : ''}>${category.name}</option>
</c:forEach>
</select>
</form>

<c:if test="${not empty sessionScope.message}">
  <div class="alert">${sessionScope.message}</div>
  <c:remove var="message" scope="session" />
</c:if>

<div class="product-grid" id="productGrid">
<c:forEach var="product" items="${productList}">
<div class="product-card" data-category="${product.category}">
<div class="product-image">
<img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.name}">
</div>
<div class="product-info">
<h3>${product.name}</h3>
<p>${product.description}</p>
<p class="price">₹${product.price}</p>
<p class="stock">${product.quantity} in stock</p>
<div class="actions">
<a class="view" href="${pageContext.request.contextPath}/product/view?id=${product.id}">View Details</a>
<form method="post" action="${pageContext.request.contextPath}/products" onsubmit="return confirmBuy()">
<input type="hidden" name="action" value="buy">
<input type="hidden" name="productId" value="${product.id}">
<input type="hidden" name="category" value="${selectedCategory}">
<div class="buy-container">
  <div class="quantity-selector">
    <button type="button" class="quantity-btn minus" onclick="decrementQuantity(this)">-</button>
    <input type="number" name="quantity" value="1" min="1" max="${product.quantity}" class="quantity-input" readonly>
    <button type="button" class="quantity-btn plus" onclick="incrementQuantity(this, ${product.quantity})">+</button>
  </div>
  <button type="submit" class="buy">Buy Now</button>
</div>
</form>
</div>
</div>
</div>
</c:forEach>

<c:if test="${empty productList}">
<div class="no-products">
<p>No products available in this category.</p>
</div>
</c:if>
</div>
</div>
<script>
function confirmBuy() {
  return confirm("Are you sure you want to buy this product?");
}

function decrementQuantity(btn) {
  const input = btn.nextElementSibling;
  const currentValue = parseInt(input.value);
  if (currentValue > 1) {
    input.value = currentValue - 1;
  }
}

function incrementQuantity(btn, maxStock) {
  const input = btn.previousElementSibling;
  const currentValue = parseInt(input.value);
  if (currentValue < maxStock) {
    input.value = currentValue + 1;
  }
}
</script>

<jsp:include page="footer.jsp"/>

</body>
</html>
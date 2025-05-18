<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.RadiantDreams.model.ProductModel" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Products - Radiant Dreams</title>

  <!-- Link to external CSS files for header and product page styling -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css">

  <!-- Google Fonts preconnect and stylesheet -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>

  <!-- Include common header JSP (navigation, logo, etc.) -->
  <jsp:include page="header.jsp"/>

  <div class="container">
    <h1>Our Products</h1>

    <!-- Filter bar form for filtering products by category -->
    <form method="get" action="${pageContext.request.contextPath}/products" class="filter-bar">
      <label for="categoryFilter">Filter by Category:</label>
      <select id="categoryFilter" name="category" onchange="this.form.submit()">
        <!-- Default option: show all products -->
        <option value="all" ${empty selectedCategory || selectedCategory == 'all' ? 'selected' : ''}>All Products</option>
        
        <!-- Loop through categoryList to dynamically create options -->
        <c:forEach var="category" items="${categoryList}">
          <option value="${category.name}" ${category.name == selectedCategory ? 'selected' : ''}>${category.name}</option>
        </c:forEach>
      </select>
    </form>

    <!-- Show a message from session scope if available, then remove it -->
    <c:if test="${not empty sessionScope.message}">
      <div class="alert">${sessionScope.message}</div>
      <c:remove var="message" scope="session" />
    </c:if>

    <!-- Grid container for products -->
    <div class="product-grid" id="productGrid">
      <!-- Loop through productList and display each product card -->
      <c:forEach var="product" items="${productList}">
        <div class="product-card" data-category="${product.category}">
          <!-- Product image -->
          <div class="product-image">
            <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.name}">
          </div>

          <!-- Product details -->
          <div class="product-info">
            <h3>${product.name}</h3>
            <p>${product.description}</p>
            <p class="price">₹${product.price}</p>
            <p class="stock">${product.quantity} in stock</p>

            <!-- Actions: View details link and buy form -->
            <div class="actions">
              <!-- Link to product detail page -->
              <a class="view" href="${pageContext.request.contextPath}/product/view?id=${product.id}">View Details</a>
              
              <!-- Form for buying product -->
              <form method="post" action="${pageContext.request.contextPath}/products" onsubmit="return confirmBuy()">
                <!-- Hidden fields to identify action and product -->
                <input type="hidden" name="action" value="buy">
                <input type="hidden" name="productId" value="${product.id}">
                <input type="hidden" name="category" value="${selectedCategory}">

                <!-- Quantity selector and buy button -->
                <div class="buy-container">
                  <div class="quantity-selector">
                    <!-- Decrement quantity button -->
                    <button type="button" class="quantity-btn minus" onclick="decrementQuantity(this)">-</button>

                    <!-- Quantity input field (readonly, changed by buttons) -->
                    <input type="number" name="quantity" value="1" min="1" max="${product.quantity}" class="quantity-input" readonly>

                    <!-- Increment quantity button -->
                    <button type="button" class="quantity-btn plus" onclick="incrementQuantity(this, ${product.quantity})">+</button>
                  </div>

                  <!-- Submit buy button -->
                  <button type="submit" class="buy">Buy Now</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </c:forEach>

      <!-- Message to show when no products available -->
      <c:if test="${empty productList}">
        <div class="no-products">
          <p>No products available in this category.</p>
        </div>
      </c:if>
    </div>
  </div>

  <!-- JavaScript functions to confirm purchase and handle quantity input -->
  <script>
    // Confirm purchase prompt on form submit
    function confirmBuy() {
      return confirm("Are you sure you want to buy this product?");
    }

    // Decrement quantity but don't go below 1
    function decrementQuantity(btn) {
      const input = btn.nextElementSibling;
      const currentValue = parseInt(input.value);
      if (currentValue > 1) {
        input.value = currentValue - 1;
      }
    }

    // Increment quantity but don't exceed max stock
    function incrementQuantity(btn, maxStock) {
      const input = btn.previousElementSibling;
      const currentValue = parseInt(input.value);
      if (currentValue < maxStock) {
        input.value = currentValue + 1;
      }
    }
  </script>

  <!-- Include common footer JSP -->
  <jsp:include page="footer.jsp"/>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Home | Radiant Dreams</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Helvetica+Neue:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
 <jsp:include page="header.jsp"/>


  <main class="hero-section">
    <div class="hero-content">
      <h1>Sleep Better, Live Brighter</h1>
      <p>Discover premium sleep solutions designed for your comfort and well-being.</p>
      <a href="${pageContext.request.contextPath}/products" class="cta-button">SHOP NOW</a>
    </div>
    <div class="hero-image">
      <img src="${pageContext.request.contextPath}/resources/images/room3.jpg" alt="Premium Bedroom Setup">
    </div>
  </main>

  <section class="features">
    <div class="feature">
      <h2>Premium Quality</h2>
      <p>Experience unmatched comfort with our carefully selected materials, designed to provide the perfect balance of support and softness.</p>
    </div>
    <div class="feature">
      <h2>Eco-Friendly</h2>
      <p>Our products are crafted with sustainability in mind, using responsibly sourced materials and eco-conscious manufacturing processes.</p>
    </div>
    <div class="feature">
      <h2>100-Night Trial</h2>
      <p>Enjoy risk-free sleep with our generous trial period. If you're not completely satisfied, we'll handle the return at no cost to you.</p>
    </div>
  </section>

  <section class="products-showcase">
    <h2>Our Products</h2>
    <div class="products">
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/resources/images/mattress1.webp" alt="Duo Latex Mattress">
        <h3>Duo Latex Mattress</h3>
        <p>Ultimate bounce and support with natural latex for cooler, more responsive sleep.</p>
      </div>
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/resources/images/mattress2.jpg" alt="Duo Eco Mattress">
        <h3>Duo Eco Mattress</h3>
        <p>Eco-conscious comfort with breathable materials for a healthier sleep environment.</p>
      </div>
      <div class="product-card">
        <img src="${pageContext.request.contextPath}/resources/images/product3.jpg" alt="Duo Memory Mattress">
        <h3>Duo Memory Mattress</h3>
        <p>Memory foam luxury for deep, restorative sleep with pressure relief and minimal motion transfer.</p>
      </div>
    </div>
  </section>

  <section class="reviews-section">
    <h2>Customer Reviews</h2>
    <div class="reviews">
      <div class="review">
        <h4>Sarah K.</h4>
        <p>"Radiant Dreams gave me the best sleep I've had in years. The mattress perfectly conforms to my body while providing the support I need."</p>
      </div>
      <div class="review">
        <h4>James L.</h4>
        <p>"Top quality mattresses that exceed expectations. Worth every penny for the improvement in my sleep quality and morning energy levels."</p>
      </div>
      <div class="review">
        <h4>Anita D.</h4>
        <p>"Fast delivery, amazing product, and excellent support! Their customer service team went above and beyond to ensure I was satisfied."</p>
      </div>
    </div>
  </section>

  <section class="about-section">
    <h2>About Us</h2>
    <p>Radiant Dreams is committed to providing premium sleep experiences through innovative design and quality craftsmanship. 
    Our mattresses are thoughtfully designed with both comfort and sustainability in mind, 
    ensuring you wake up refreshed and energized every morning. We believe that better sleep leads to better living, 
    and our mission is to help you achieve your best rest possible.</p>
  </section>

 <jsp:include page="footer.jsp"/>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>About Us | Radiant Dreams</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Helvetica+Neue:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp"/>

  <main class="about-hero-section">
    <div class="about-hero-content">
      <h1>Our Story</h1>
      <p>We're passionate about creating sleep products that enhance your life, one night at a time.</p>
    </div>
    <div class="about-hero-image">
      <img src="${pageContext.request.contextPath}/resources/images/mattressfact.avif" alt="Radiant Dreams Workshop">
    </div>
  </main>

  <section class="about-mission">
    <h2>Our Mission</h2>
    <p>At Radiant Dreams, we believe that quality sleep is essential for a healthy and productive life. Our mission is to provide innovative sleep solutions that help you wake up refreshed and energized every morning, ready to tackle whatever the day brings.</p>
  </section>

  <section class="about-values">
    <h2>Our Values</h2>
    <div class="values">
      <div class="value">
        <h3>Quality</h3>
        <p>We use only premium materials and advanced sleep technology to create products that deliver exceptional comfort and support.</p>
      </div>
      <div class="value">
        <h3>Sustainability</h3>
        <p>We're committed to environmentally responsible practices, from sourcing eco-friendly materials to reducing waste in our manufacturing process.</p>
      </div>
      <div class="value">
        <h3>Innovation</h3>
        <p>We continuously research and develop new sleep solutions to address the evolving needs of our customers.</p>
      </div>
    </div>
  </section>

  <section class="about-team">
    <h2>Our Team</h2>
    <div class="team-members">
      <div class="team-member">
        <img src="${pageContext.request.contextPath}/resources/images/emma.avif" alt="Emma Khatiwada">
        <h3>Emma Khatiwada</h3>
        <p>Founder & CEO</p>
      </div>
      <div class="team-member">
        <img src="${pageContext.request.contextPath}/resources/images/david.webp" alt="David Dhakal">
        <h3>David Dhakal</h3>
        <p>Head of Product Design</p>
      </div>
      <div class="team-member">
        <img src="${pageContext.request.contextPath}/resources/images/sarah.jpg" alt="Sarah Pandey">
        <h3>Sarah Pandey</h3>
        <p>Sleep Science Expert</p>
      </div>
    </div>
  </section>

  <section class="about-commitment">
    <h2>Our Commitment to You</h2>
    <div class="commitments">
      <div class="commitment">
        <h3>100-Night Trial</h3>
        <p>Sleep on our mattresses for up to 100 nights. If you're not completely satisfied, we'll handle the return at no cost.</p>
      </div>
      <div class="commitment">
        <h3>10-Year Warranty</h3>
        <p>We stand behind our products with a comprehensive warranty covering manufacturing defects.</p>
      </div>
      <div class="commitment">
        <h3>Free Shipping</h3>
        <p>Enjoy complimentary shipping to your doorstep and hassle-free setup of your new sleep products.</p>
      </div>
    </div>
  </section>

  <section class="about-contact">
    <h2>Get In Touch</h2>
    <div class="contact-info">
      <p>Email: contact@radiantdreams.com</p>
      <p>Phone: (555) 123-4567</p>
      <p>Hours: Monday-Friday, 9AM-6PM EST</p>
    </div>
  </section>

 <jsp:include page="footer.jsp"/>

</body>
</html>
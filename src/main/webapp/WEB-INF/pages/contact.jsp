<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us | Radiant Dreams</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Helvetica+Neue:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
 <jsp:include page="header.jsp"/>

  <main class="contact-section">
    <div class="contact-header">
      <h1>Contact Us</h1>
      <p>We're here to help with any questions about our products or services. Our team is ready to assist you in finding the perfect sleep solution.</p>
    </div>

    <div class="contact-content">
      <div class="contact-info">
        <div class="info-box">
          <h3>Customer Support</h3>
          <p>Our dedicated team is available Monday through Friday, 9am to 6pm EST.</p>
          <p>Email: support@radiantdreams.com</p>
          <p>Phone: (555) 123-4567</p>
        </div>
        
        <div class="info-box">
          <h3>Visit Our Showroom</h3>
          <p>Experience our mattresses in person at our flagship store.</p>
          <p>123 Sleep Avenue, Dream City, DC 10001</p>
          <p>Open daily: 10am - 8pm</p>
        </div>
        
        <div class="info-box">
          <h3>Sleep Consultations</h3>
          <p>Book a free consultation with our sleep experts to find your perfect mattress match.</p>
          <p>Schedule through our form or call us directly.</p>
        </div>
      </div>

      <div class="contact-form-container">
        <h2>Send Us a Message</h2>
        
        <!-- Display success or error messages -->
        <c:if test="${not empty success}">
          <div class="success-message">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
          <div class="error-message">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/contact" method="POST" class="contact-form">
          <div class="form-group">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" required>
          </div>
          
          <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required>
          </div>
          
          <div class="form-group">
            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone" required>
          </div>
          
          <div class="form-group">
            <label for="subject">Subject</label>
            <select id="subject" name="subject">
              <option value="general">General Inquiry</option>
              <option value="support">Product Support</option>
              <option value="returns">Returns & Exchanges</option>
              <option value="feedback">Feedback</option>
            </select>
          </div>
          
          <div class="form-group">
            <label for="message">Message</label>
            <textarea id="message" name="message" rows="5" required></textarea>
          </div>
          
          <div class="form-group">
            <button  class="submit-button">SEND MESSAGE</button>
          </div>
        </form>
      </div>
    </div>
  </main>

  <section class="faq-section">
    <h2>Frequently Asked Questions</h2>
    <div class="faq-container">
      <div class="faq-item">
        <h4>What is your return policy?</h4>
        <p>We offer a 100-night trial period. If you're not completely satisfied with your mattress, we'll arrange a free pickup and process a full refund.</p>
      </div>
      
      <div class="faq-item">
        <h4>How long does shipping take?</h4>
        <p>Standard shipping takes 3-5 business days. We also offer expedited shipping options at checkout.</p>
      </div>
      
      <div class="faq-item">
        <h4>Do you offer international shipping?</h4>
        <p>Currently, we ship to the continental United States, Canada, and select European countries.</p>
      </div>
    </div>
  </section>

 <jsp:include page="footer.jsp"/>

</body>
</html>
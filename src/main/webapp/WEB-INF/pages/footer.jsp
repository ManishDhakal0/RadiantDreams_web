<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
</head>
<body>
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-section about">
                <div class="logo-text">RADIANT DREAMS</div>
                <p>
                    Bringing your creative visions to life with passion and precision.
                    Explore our portfolio and discover the art of possibilities.
                </p>
                <div class="contact">
                    <span><i class="fas fa-phone"></i> &nbsp; +1 234 567 8900</span>
                    <span><i class="fas fa-envelope"></i> &nbsp; info@radiantdreams.com</span>
                </div>
                <div class="socials">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin"></i></a>
                </div>
            </div>
            
            <div class="footer-section links">
                <h2>Quick Links</h2>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                    <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/portfolio">Portfolio</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                </ul>
            </div>
            
            <div class="footer-section newsletter">
                <h2>Stay Updated</h2>
                <p>Subscribe to our newsletter for the latest updates and offers.</p>
                <form action="${pageContext.request.contextPath}/subscribe" method="post">
                    <input type="email" name="email" class="newsletter-input" placeholder="Enter your email">
                    <button type="submit" class="newsletter-btn">
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </form>
            </div>
        </div>
        
        <div class="footer-bottom">
            <p>&copy; 2025 Radiant Dreams. All Rights Reserved.</p>
        </div>
    </footer>
</body>
</html>
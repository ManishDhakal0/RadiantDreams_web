<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>

<%
// Initialize necessary objects and variables
HttpSession userSession = request.getSession(false);
String currentUser = (String) (userSession != null ? userSession.getAttribute("username") : null);
// Set contextPath variable
String contextPath = request.getContextPath();
// Set currentUser in page context for later use
pageContext.setAttribute("currentUser", currentUser);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Radiant Dreams</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
</head>
<body>
    <div id="header">
        <header class="header">
            <div class="logo">RADIANT DREAMS</div>
            <ul class="main-nav">
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                <li class="user-dropdown">
                    <button class="dropdown-btn"><i class="fas fa-user-circle"></i> Account</button>
                    <div class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/portfolio"><i class="fas fa-id-card"></i> Portfolio</a>
                        <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </div>
                </li>
            </ul>
        </header>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Any additional JavaScript can go here if needed
        });
    </script>
</body>
</html>
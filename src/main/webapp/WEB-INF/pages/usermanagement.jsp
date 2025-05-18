<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.RadiantDreams.model.CustomerModel" %>
<%@ page import="com.RadiantDreams.util.SessionUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String username = (String) SessionUtil.getAttribute(request, "username");
    String role = (String) SessionUtil.getAttribute(request, "role");
    
    if (username == null || !"admin".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    List<CustomerModel> userList = (List<CustomerModel>) request.getAttribute("userList");
    int totalUsers = (Integer) request.getAttribute("totalUsers");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Radiant Dreams</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/usermanagement.css">
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h1>Admin Panel</h1>
            <ul>
                <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/users" class="active">Users</a></li>
                <li><a href="${pageContext.request.contextPath}/productsmanagement">Products</a></li>
                <li><a href="${pageContext.request.contextPath}/ordermanagement">Orders</a></li>

            </ul>

            <form action="${pageContext.request.contextPath}/logout" method="post" class="logout-form">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>

        <div class="main-content">
            <div class="header">
                <h2>User Management</h2>
                <div class="user-info">Admin User: <%= username %></div>
            </div>

            <div class="stats-container">
                <div class="stat-card">
                    <h3>Total Users</h3>
                    <div class="stat-value"><%= totalUsers %></div>
                </div>
            </div>

            <h3>All Users</h3>

            <table>
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Full Name</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userList}">
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}${user.image}" alt="User Image" class="user-thumbnail" />
                            </td>
                            <td>${user.firstName} ${user.lastName}</td>
                            <td>${user.username}</td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>${user.address}</td>
                            <td class="action-links">
                                
                                <a href="users?delete=${user.id}" class="delete-link" onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
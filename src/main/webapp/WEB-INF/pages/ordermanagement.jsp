<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.RadiantDreams.model.OrderModel" %>
<%@ page import="com.RadiantDreams.util.SessionUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String username = (String) SessionUtil.getAttribute(request, "username");
    String role = (String) SessionUtil.getAttribute(request, "role");

    if (username == null || !"admin".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management - Radiant Dreams</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ordermanagement.css">
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h1>Admin Panel</h1>
            <ul>
                <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/users">Users</a></li>
                <li><a href="${pageContext.request.contextPath}/productsmanagement">Products</a></li>
                <li><a href="${pageContext.request.contextPath}/ordermanagement" class="active">Orders</a></li>
            </ul>

            <form action="${pageContext.request.contextPath}/logout" method="post" class="logout-form">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>

        <div class="main-content">
            <div class="header">
                <h2>Order Management</h2>
                <div class="user-info">Admin User: <%= username %></div>
            </div>
            
            <div class="content-grid">
                <div class="list-panel">
                    <div class="panel-header">
                        <h3>All Orders</h3>
                    </div>
                    
                    <div class="panel-body">
                        <c:if test="${empty orderList}">
                            <div class="no-results">
                                <p>No orders found.</p>
                            </div>
                        </c:if>
                        
                        <div class="orders-list">
                            <c:forEach var="order" items="${orderList}">
                                <div class="order-card">
                                    <div class="order-header">
                                        <div class="order-id">
                                            <h3>Order #${order.id}</h3>
                                            <span class="order-date">${order.orderDate}</span>
                                        </div>
                                        <div class="customer-info">
                                            <span class="customer-label">Customer:</span>
                                            <span class="customer-name">${order.customerUsername}</span>
                                        </div>
                                        <div class="order-toggle">
                                            <button class="toggle-details-btn" onclick="toggleOrderDetails(this, 'order-${order.id}')">View Details</button>
                                        </div>
                                    </div>
                                    
                                    <div id="order-${order.id}" class="order-details">
                                        <table class="order-items-table">
                                            <thead>
                                                <tr>
                                                    <th>Product</th>
                                                    <th>Image</th>
                                                    <th>Price (Rs)</th>
                                                    <th>Quantity</th>
                                                    <th>Subtotal (Rs)</th>
                                                    <th>Status</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:set var="total" value="0" />
                                                <c:forEach var="detail" items="${order.orderDetails}">
                                                    <tr>
                                                        <td class="product-name">${detail.product.name}</td>
                                                        <td class="product-image">
                                                            <img src="${pageContext.request.contextPath}${detail.product.imageUrl}" alt="${detail.product.name}">                                                       
                                                        </td>
                                                        <td class="price-column">Rs${detail.product.price}</td>
                                                        <td class="quantity-column">${detail.quantity}</td>
                                                        <td class="subtotal-column">
                                                            <c:set var="subtotal" value="${detail.product.price * detail.quantity}" />
                                                            Rs.${subtotal}
                                                            <c:set var="total" value="${total + subtotal}" />
                                                        </td>
                                                        <td class="status-column">
                                                            <span class="status-badge ${detail.status.toLowerCase().replace(' ', '-')}">
                                                                ${detail.status}
                                                            </span>
                                                        </td>
                                                        <td class="actions-column">
                                                            <form method="post" action="${pageContext.request.contextPath}/ordermanagement" class="status-update-form">
                                                                <input type="hidden" name="action" value="updateStatus" />
                                                                <input type="hidden" name="orderDetailId" value="${detail.id}" />
                                                                <div class="action-buttons">
                                                                    <c:if test="${detail.status != 'Delivered' && detail.status != 'Cancelled'}">
                                                                        <button type="submit" name="status" value="Processing" class="status-btn processing">Processing</button>
                                                                        <button type="submit" name="status" value="Out for Delivery" class="status-btn delivery">Out for Delivery</button>
                                                                        <button type="submit" name="status" value="Delivered" class="status-btn delivered">Delivered</button>
                                                                        <button type="submit" name="status" value="Cancelled" class="status-btn cancelled">Cancel</button>
                                                                    </c:if>
                                                                    <c:if test="${detail.status == 'Delivered' || detail.status == 'Cancelled'}">
                                                                        <span class="status-final">Status Finalized</span>
                                                                    </c:if>
                                                                </div>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                <tr class="total-row">
                                                    <td colspan="4" class="total-label">Order Total:</td>
                                                    <td colspan="3" class="total-amount">Rs.${total}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        
                                        <div class="delivery-info">
                                            <h4>Order Information</h4>
                                            <div class="contact-info">
                                                <p><strong>Order Date:</strong> ${order.orderDate}</p>
                                                <p><strong>Customer:</strong> ${order.customerUsername}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function toggleOrderDetails(button, orderId) {
            const detailsElement = document.getElementById(orderId);
            
            if (detailsElement.classList.contains('visible')) {
                detailsElement.classList.remove('visible');
                button.textContent = 'View Details';
            } else {
                detailsElement.classList.add('visible');
                button.textContent = 'Hide Details';
            }
        }
        
        // Initialize all order details as hidden
        document.addEventListener('DOMContentLoaded', function() {
            const orderDetails = document.querySelectorAll('.order-details');
            orderDetails.forEach(detail => {
                detail.classList.remove('visible');
            });
        });
    </script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.RadiantDreams.model.*" %>
<%@ page import="com.RadiantDreams.service.*" %>
<%@ page import="java.util.Map" %>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equalsIgnoreCase("admin")) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    String username = (String) session.getAttribute("username");
    ProductService productService = new ProductService();
    CategoryService categoryService = new CategoryService();
    OrderService orderService = new OrderService();

    List<ProductModel> products = productService.getAllProducts();
    List<CategoryModel> categories = categoryService.getAllCategories();
    List<OrderModel> orders = orderService.getAllOrdersWithDetails();
    List<CustomerModel> latestCustomers = (List<CustomerModel>) request.getAttribute("latestCustomers");
    int totalCustomers = (Integer) request.getAttribute("totalCustomers");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <title>Admin Dashboard - RadiantDreams</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h1>Admin Panel</h1>
            <ul>
                <li><a href="${pageContext.request.contextPath}/dashboard" class="active">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/users">Users</a></li>
                <li><a href="${pageContext.request.contextPath}/productsmanagement">Products</a></li>
                <li><a href="${pageContext.request.contextPath}/ordermanagement">Orders</a></li>
                
            </ul>
            
            <form action="${pageContext.request.contextPath}/logout" method="post" class="logout-form">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>
        
        <div class="main-content">
            <div class="header">
                <h2>Admin Dashboard</h2>
                <div class="user-info">Admin User: <%= username %></div>
            </div>
            
            <div class="dashboard-cards">
                <div class="card">
                    <h2><%= products.size() %></h2>
                    <p>Products</p>
                </div>
                <div class="card">
                    <h2><%= categories.size() %></h2>
                    <p>Categories</p>
                </div>
                <div class="card">
                    <h2><%= orders.size() %></h2>
                    <p>Orders</p>
                </div>
                <div class="card">
                    <h2><%= totalCustomers %></h2>
                    <p>Users</p>
                </div>
                <div class="card">
                    <h2>Rs.<%= String.format("%.2f", (Double) request.getAttribute("totalRevenue")) %></h2>
                    <p>Total Revenue</p>
                </div>
            </div>
            
            <div class="section">
                <div class="section-header">
                    <h2>Top 5 Bestselling Products</h2>
                </div>
                <div class="section-body">
                    <div class="chart-container">
                        <canvas id="productChart"></canvas>
                    </div>
                </div>
            </div>
            
            <div class="section">
                <div class="section-header">
                    <h2>Order Status Overview</h2>
                </div>
                <div class="section-body">
                    <div class="chart-container">
                        <canvas id="statusChart"></canvas>
                    </div>
                </div>
            </div>
            
            <div class="section">
                <div class="section-header">
                    <h2>Recent Orders</h2>
                </div>
                <div class="section-body">
                    <table>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Date</th>
                                <th>Products</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int recentLimit = Math.min(orders.size(), 5);
                                for (int i = 0; i < recentLimit; i++) {
                                    OrderModel order = orders.get(i);
                                    String status = order.getOrderDetails().get(0).getStatus();
                                    String statusClass = "pending";
                                    
                                    if (status.equalsIgnoreCase("shipped")) {
                                        statusClass = "shipped";
                                    } else if (status.equalsIgnoreCase("delivered")) {
                                        statusClass = "delivered";
                                    } else if (status.equalsIgnoreCase("cancelled")) {
                                        statusClass = "cancelled";
                                    }
                            %>
                            <tr>
                                <td><%= order.getId() %></td>
                                <td><%= order.getCustomerUsername() %></td>
                                <td><%= order.getOrderDate() %></td>
                                <td>
                                    <% 
                                        for (int j = 0; j < Math.min(order.getOrderDetails().size(), 2); j++) {
                                            OrderDetailModel detail = order.getOrderDetails().get(j);
                                    %>
                                        <%= detail.getProduct().getName() %> (x<%= detail.getQuantity() %>)<br>
                                    <% 
                                        }
                                        if (order.getOrderDetails().size() > 2) {
                                    %>
                                        <span class="more-items">+ <%= order.getOrderDetails().size() - 2 %> more</span>
                                    <% } %>
                                </td>
                                <td><span class="status-badge <%= statusClass %>"><%= status %></span></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="section">
                <div class="section-header">
                    <h2>Latest Registered Customers</h2>
                </div>
                <div class="section-body">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="customer" items="${latestCustomers}">
                                <tr>
                                    <td>${customer.id}</td>
                                    <td>${customer.username}</td>
                                    <td>${customer.firstName} ${customer.lastName}</td>
                                    <td>${customer.email}</td>
                                    <td>${customer.phone}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            

    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        // Top Products Chart
        const topProductLabels = [
            <c:forEach var="p" items="${topProducts}" varStatus="i">
                "<c:out value='${p.name}'/>"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
        ];
        const topProductData = [
            <c:forEach var="p" items="${topProducts}" varStatus="i">
                <c:out value='${p.quantity}'/><c:if test="${!i.last}">,</c:if>
            </c:forEach>
        ];

        if (topProductLabels.length && topProductData.length && topProductData.reduce((a, b) => a + b, 0) > 0) {
            new Chart(document.getElementById('productChart'), {
                type: 'bar',
                data: {
                    labels: topProductLabels,
                    datasets: [{
                        label: 'Quantity Sold',
                        data: topProductData,
                        backgroundColor: 'rgba(52, 152, 219, 0.6)',
                        borderColor: 'rgba(52, 152, 219, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                precision: 0
                            }
                        }
                    }
                }
            });
        } else {
            document.getElementById('productChart').parentNode.innerHTML = 
                '<div class="no-data-message">No sales data available</div>';
        }

        // Order Status Chart
        const statusLabels = [
            <c:forEach var="entry" items="${orderStatuses}" varStatus="i">
                "<c:out value='${entry.key}'/>"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
        ];
        const statusData = [
            <c:forEach var="entry" items="${orderStatuses}" varStatus="i">
                <c:out value='${entry.value}'/><c:if test="${!i.last}">,</c:if>
            </c:forEach>
        ];

        if (statusLabels.length && statusData.length && statusData.reduce((a, b) => a + b, 0) > 0) {
            new Chart(document.getElementById('statusChart'), {
                type: 'doughnut',
                data: {
                    labels: statusLabels,
                    datasets: [{
                        label: 'Order Status',
                        data: statusData,
                        backgroundColor: [
                            'rgba(52, 152, 219, 0.7)',  // Blue
                            'rgba(46, 204, 113, 0.7)',  // Green
                            'rgba(241, 196, 15, 0.7)',  // Yellow
                            'rgba(231, 76, 60, 0.7)'    // Red
                        ],
                        borderColor: [
                            'rgba(52, 152, 219, 1)',
                            'rgba(46, 204, 113, 1)',
                            'rgba(241, 196, 15, 1)',
                            'rgba(231, 76, 60, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'right'
                        }
                    }
                }
            });
        } else {
            document.getElementById('statusChart').parentNode.innerHTML = 
                '<div class="no-data-message">No order status data available</div>';
        }
    });
</script>

</body>
</html>
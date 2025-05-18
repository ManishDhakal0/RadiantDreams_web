<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.RadiantDreams.model.ProductModel" %>
<%@ page import="com.RadiantDreams.util.SessionUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Get username and role from session using utility method
    String username = (String) SessionUtil.getAttribute(request, "username");
    String role = (String) SessionUtil.getAttribute(request, "role");

    // Redirect to login if user not logged in or not admin
    if (username == null || !"admin".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/login");
        return; // Stop further processing of the page
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management - Radiant Dreams</title>

    <!-- Link to the CSS file for styling product management page -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productsmanagement.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar navigation for admin panel -->
        <div class="sidebar">
            <h1>Admin Panel</h1>
            <ul>
                <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/users">Users</a></li>
                <li><a href="${pageContext.request.contextPath}/productsmanagement" class="active">Products</a></li>
                <li><a href="${pageContext.request.contextPath}/ordermanagement">Orders</a></li>
            </ul>

            <!-- Logout form with POST method -->
            <form action="${pageContext.request.contextPath}/logout" method="post" class="logout-form">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>

        <!-- Main content area -->
        <div class="main-content">
            <div class="header">
                <h2>Product Management</h2>
                <!-- Display logged in admin username -->
                <div class="user-info">Admin User: <%= username %></div>
            </div>
            
            <div class="content-grid">
                <!-- Left panel: Add/Edit product form -->
                <div class="form-panel">
                    <div class="panel-header">
                        <!-- Conditional heading for add or edit -->
                        <h3>${empty editProduct ? "Add New Product" : "Edit Product"}</h3>
                    </div>
                    
                    <div class="panel-body">
                        <form action="productsmanagement" method="post" enctype="multipart/form-data">
                            <!-- Hidden input for product ID in edit mode -->
                            <c:if test="${not empty editProduct}">
                                <input type="hidden" name="id" value="${editProduct.id}" />
                            </c:if>
                            
                            <div class="form-section">
                                <!-- Product name and price inputs -->
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="name">Product Name</label>
                                        <input type="text" id="name" name="name" value="${editProduct.name}" required placeholder="Enter product name" />
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="price">Price (₹)</label>
                                        <input type="number" id="price" name="price" value="${editProduct.price}" step="0.01" required placeholder="0.00" />
                                    </div>
                                </div>
                                
                                <!-- Product description textarea -->
                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <textarea id="description" name="description" rows="3" required placeholder="Enter product description">${editProduct.description}</textarea>
                                </div>
                                
                                <!-- Quantity and category inputs -->
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="quantity">Quantity</label>
                                        <input type="number" id="quantity" name="quantity" value="${editProduct.quantity}" required placeholder="0" />
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="category">Category</label>
                                        <select id="category" name="category" required>
                                            <option value="">Select a category</option>
                                            <option value="Mattress" ${editProduct.category == 'Mattress' ? 'selected' : ''}>Mattress</option>
                                            <option value="Pillow" ${editProduct.category == 'Pillow' ? 'selected' : ''}>Pillow</option>
                                            <option value="Bed" ${editProduct.category == 'Bed' ? 'selected' : ''}>Bed</option>
                                            <option value="Bedding" ${editProduct.category == 'Beddings' ? 'selected' : ''}>Beddings</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Product image upload section -->
                                <div class="form-group image-upload-container">
                                    <label for="image">Product Image</label>
                                    <div class="image-upload-area">
                                        <c:choose>
                                            <!-- Show existing image preview if editing -->
                                            <c:when test="${not empty editProduct.imageUrl}">
                                                <div class="image-preview-container">
                                                    <img src="${pageContext.request.contextPath}${editProduct.imageUrl}" alt="Product Image" class="product-image-preview"/>
                                                </div>
                                            </c:when>
                                            <!-- Placeholder if no image selected -->
                                            <c:otherwise>
                                                <div class="image-placeholder">
                                                    <i class="placeholder-icon">📷</i>
                                                    <span>No image selected</span>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- File input for image upload -->
                                        <input type="file" id="image" name="image" class="file-input" />
                                        <label for="image" class="file-label">Choose File</label>
                                    </div>
                                </div>
                                
                                <!-- Availability toggle checkbox -->
                                <div class="form-group toggle-container">
                                    <label class="toggle-label">
                                        <input type="checkbox" id="availability" name="availability" ${editProduct.availability ? 'checked' : ''} />
                                        <span class="toggle-switch"></span>
                                        <span class="toggle-text">Available for Sale</span>
                                    </label>
                                </div>
                            </div>
                            
                            <!-- Form action buttons: Add/Update and Cancel -->
                            <div class="form-actions">
                                <button type="submit" class="submit-button">
                                    <i class="action-icon">${empty editProduct ? "+" : "✓"}</i> 
                                    ${empty editProduct ? "Add Product" : "Update Product"}
                                </button>
                                <!-- Cancel button visible only in edit mode -->
                                <c:if test="${not empty editProduct}">
                                    <a href="productsmanagement" class="cancel-button">Cancel</a>
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>
            
                <!-- Right panel: List of all products -->
                <div class="list-panel">
                    <div class="panel-header">
                        <h3>All Products</h3>
                        <div class="header-actions">
                            <!-- Search form to filter products -->
                            <form method="get" action="productsmanagement" class="search-form">
                                <div class="search-container">
                                    <input type="text" id="productSearch" name="search" placeholder="Search products..." class="search-input" value="${param.search}" />
                                    <button type="submit" class="search-button">Search</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <div class="panel-body">
                        <!-- Show search result info if search performed -->
                        <c:if test="${not empty param.search}">
                            <div class="search-results-info">
                                Showing results for: <span class="search-term">"${param.search}"</span>
                                <a href="productsmanagement" class="clear-search">Clear Search</a>
                            </div>
                        </c:if>
                        
                        <!-- Products table -->
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Category</th>
                                    <th>Status</th>
                                    <th>Qty</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Loop through products list -->
                                <c:forEach var="product" items="${products}">
                                    <tr>
                                        <td>${product.id}</td>
                                        <td>
                                            <!-- Product image with fallback placeholder -->
                                            <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.name}" class="product-thumbnail" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.png';" />
                                        </td>
                                        <td>${product.name}</td>
                                        <!-- Truncate description if longer than 80 characters -->
                                        <td>${product.description.length() > 80 ? product.description.substring(0, 80).concat('...') : product.description}</td>
                                        <td class="price-column">₹${product.price}</td>
                                        <!-- Category with styled badge -->
                                        <td><span class="category-badge ${product.category.toLowerCase()}">${product.category}</span></td>
                                        <!-- Availability status badge -->
                                        <td>
                                            <span class="status-badge ${product.availability ? 'available' : 'out-of-stock'}">
                                                ${product.availability ? 'Available' : 'Out of Stock'}
                                            </span>
                                        </td>
                                        <td class="quantity-column">${product.quantity}</td>
                                        <td class="action-links">
                                            <!-- Edit and delete action buttons -->
                                            <a href="productsmanagement?edit=${product.id}" class="action-button edit-button" title="Edit">✏️</a>
                                            <a href="productsmanagement?delete=${product.id}" class="action-button delete-button" title="Delete" onclick="return confirm('Are you sure you want to delete this product?');">🗑️</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                        <!-- Show message if no products found -->
                        <c:if test="${empty products}">
                            <div class="no-results">
                                <p>No products found${not empty param.search ? ' matching "'.concat(param.search).concat('"') : ''}.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Script to update file input label on file selection -->
    <script>
        const fileInput = document.getElementById('image');
        if (fileInput) {
            fileInput.addEventListener('change', function() {
                const fileLabel = document.querySelector('.file-label');
                if (this.files.length > 0) {
                    fileLabel.textContent = this.files[0].name;
                } else {
                    fileLabel.textContent = 'Choose File';
                }
            });
        }
    </script>
</body>
</html>

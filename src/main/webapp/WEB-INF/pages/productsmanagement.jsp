<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.RadiantDreams.model.ProductModel" %>
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
    <title>Product Management - Radiant Dreams</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productsmanagement.css">
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h1>Admin Panel</h1>
            <ul>
                <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/users">Users</a></li>
                <li><a href="${pageContext.request.contextPath}/productsmanagement" class="active">Products</a></li>
				<li><a href="${pageContext.request.contextPath}/ordermanagement">Orders</a></li>
                
            </ul>

            <form action="${pageContext.request.contextPath}/logout" method="post" class="logout-form">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>

        <div class="main-content">
            <div class="header">
                <h2>Product Management</h2>
                <div class="user-info">Admin User: <%= username %></div>
            </div>
            
            <div class="content-grid">
                <div class="form-panel">
                    <div class="panel-header">
                        <h3>${empty editProduct ? "Add New Product" : "Edit Product"}</h3>
                    </div>
                    
                    <div class="panel-body">
                        <form action="productsmanagement" method="post" enctype="multipart/form-data">
                            <c:if test="${not empty editProduct}">
                                <input type="hidden" name="id" value="${editProduct.id}" />
                            </c:if>
                            
                            <div class="form-section">
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
                                
                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <textarea id="description" name="description" rows="3" required placeholder="Enter product description">${editProduct.description}</textarea>
                                </div>
                                
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
                                
                                <div class="form-group image-upload-container">
                                    <label for="image">Product Image</label>
                                    <div class="image-upload-area">
                                        <c:choose>
                                            <c:when test="${not empty editProduct.imageUrl}">
                                                <div class="image-preview-container">
                                                    <img src="${pageContext.request.contextPath}${editProduct.imageUrl}" alt="Product Image" class="product-image-preview"/>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="image-placeholder">
                                                    <i class="placeholder-icon">📷</i>
                                                    <span>No image selected</span>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <input type="file" id="image" name="image" class="file-input" />
                                        <label for="image" class="file-label">Choose File</label>
                                    </div>
                                </div>
                                
                                <div class="form-group toggle-container">
                                    <label class="toggle-label">
                                        <input type="checkbox" id="availability" name="availability" ${editProduct.availability ? 'checked' : ''} />
                                        <span class="toggle-switch"></span>
                                        <span class="toggle-text">Available for Sale</span>
                                    </label>
                                </div>
                            </div>
                            
                            <div class="form-actions">
                                <button type="submit" class="submit-button">
                                    <i class="action-icon">${empty editProduct ? "+" : "✓"}</i> 
                                    ${empty editProduct ? "Add Product" : "Update Product"}
                                </button>
                                <c:if test="${not empty editProduct}">
                                    <a href="productsmanagement" class="cancel-button">Cancel</a>
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>
            
                <div class="list-panel">
                    <div class="panel-header">
                        <h3>All Products</h3>
                        <div class="header-actions">
                            <form method="get" action="productsmanagement" class="search-form">
                                <div class="search-container">
                                    <input type="text" id="productSearch" name="search" placeholder="Search products..." class="search-input" value="${param.search}" />
                                    <button type="submit" class="search-button">Search</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <div class="panel-body">
                        <c:if test="${not empty param.search}">
                            <div class="search-results-info">
                                Showing results for: <span class="search-term">"${param.search}"</span>
                                <a href="productsmanagement" class="clear-search">Clear Search</a>
                            </div>
                        </c:if>
                        
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
                                <c:forEach var="product" items="${products}">
                                    <tr>
                                        <td>${product.id}</td>
                                        <td>
                                            <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.name}" class="product-thumbnail" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.png';" />
                                        </td>
                                        <td>${product.name}</td>
                                        <td>${product.description.length() > 80 ? product.description.substring(0, 80).concat('...') : product.description}</td>
                                        <td class="price-column">₹${product.price}</td>
                                        <td><span class="category-badge ${product.category.toLowerCase()}">${product.category}</span></td>
                                        <td>
                                            <span class="status-badge ${product.availability ? 'available' : 'out-of-stock'}">
                                                ${product.availability ? 'Available' : 'Out of Stock'}
                                            </span>
                                        </td>
                                        <td class="quantity-column">${product.quantity}</td>
                                        <td class="action-links">
                                            <a href="productsmanagement?edit=${product.id}" class="action-button edit-button" title="Edit">✏️</a>
                                            <a href="productsmanagement?delete=${product.id}" class="action-button delete-button" title="Delete" onclick="return confirm('Are you sure you want to delete this product?');">🗑️</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
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
    
    <script>
        // Show file name when selected
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
package com.RadiantDreams.controller;

import com.RadiantDreams.model.ProductModel;
import com.RadiantDreams.service.ProductManagementService;
import com.RadiantDreams.util.ImageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/productsmanagement")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024)
public class ProductManagementController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductManagementService productmanagementService = new ProductManagementService();
    private ImageUtil imageUtil = new ImageUtil(); // Utility for handling image uploads

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Access control: only admins allowed
        String username = (String) request.getSession().getAttribute("username");
        String role = (String) request.getSession().getAttribute("role");

        if (username == null || !"admin".equalsIgnoreCase(role)) {
            response.sendRedirect("login");
            return;
        }

        // Handle product deletion
        if (request.getParameter("delete") != null) {
            int id = Integer.parseInt(request.getParameter("delete"));
            productmanagementService.deleteProduct(id);
            response.sendRedirect("productsmanagement");
            return;
        }

        // Handle product edit - fetch existing data
        if (request.getParameter("edit") != null) {
            int id = Integer.parseInt(request.getParameter("edit"));
            ProductModel product = productmanagementService.getProductById(id);
            request.setAttribute("editProduct", product);
        }

        // Handle product search/filter
        String searchTerm = request.getParameter("search");
        List<ProductModel> products;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            products = productmanagementService.searchProducts(searchTerm.trim());
        } else {
            products = productmanagementService.getAllProducts();
        }

        // Set attributes for JSP
        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/pages/productsmanagement.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;
        Part imagePart = request.getPart("image");
        String imageUrl = null;

        // Upload image if provided
        if (imagePart != null && imagePart.getSize() > 0) {
            String imageName = imageUtil.uploadImage(imagePart, "profiles", request);
            imageUrl = imageUtil.getImageWebPath("profiles", imageName);
        }

        // Collect form data into ProductModel
        ProductModel product = new ProductModel();
        product.setId(id);
        product.setName(request.getParameter("name"));
        product.setDescription(request.getParameter("description"));
        product.setPrice(Double.parseDouble(request.getParameter("price")));
        product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        product.setCategory(request.getParameter("category"));
        product.setAvailability("on".equals(request.getParameter("availability")));
        if (imageUrl != null) product.setImageUrl(imageUrl);

        // Determine if it's an update or a new addition
        if (id > 0) {
            productmanagementService.updateProduct(product);
        } else {
            productmanagementService.addProduct(product);
        }

        response.sendRedirect("productsmanagement"); // Redirect back to admin panel
    }
}


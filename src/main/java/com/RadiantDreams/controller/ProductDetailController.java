package com.RadiantDreams.controller;

import com.RadiantDreams.model.ProductModel;
import com.RadiantDreams.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/product/view")
public class ProductDetailController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService;

    public ProductDetailController() {
        productService = new ProductService(); // Service to handle product-related DB logic
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id"); // Get product ID from query parameter

        if (idParam != null) {
            try {
                int productId = Integer.parseInt(idParam); // Parse ID to integer
                ProductModel product = productService.getProductById(productId); // Fetch product from DB

                if (product != null) {
                    request.setAttribute("product", product); // Set product for view rendering
                    request.getRequestDispatcher("/WEB-INF/pages/product-detail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace(); // Log invalid ID format
            }
        }

        response.sendRedirect(request.getContextPath() + "/products"); // Redirect to product listing if error
    }
}

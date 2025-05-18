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
        productService = new ProductService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null) {
            try {
                int productId = Integer.parseInt(idParam);
                ProductModel product = productService.getProductById(productId); 



                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/WEB-INF/pages/product-detail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/products");
    }
}

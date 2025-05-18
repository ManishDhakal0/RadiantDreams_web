package com.RadiantDreams.controller;

import com.RadiantDreams.model.CustomerModel;
import com.RadiantDreams.service.PortfolioService;
import com.RadiantDreams.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Displays customer portfolio details for logged-in users.
 */
@WebServlet("/portfolio")
public class PortfolioController extends HttpServlet {
    private static final long serialVersionUID = 1L; 
    private PortfolioService portfolioService;

    @Override
    public void init() {
        portfolioService = new PortfolioService();
    }

    /**
     * Retrieves and displays the customer's profile if logged in.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) SessionUtil.getAttribute(request, "username");

        if (username != null) {
            CustomerModel customer = portfolioService.getCustomerProfile(username);

            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/WEB-INF/pages/portfolio.jsp").forward(request, response);
            } else {
                // If customer profile not found, redirect to login
                response.sendRedirect(request.getContextPath() + "/login");
            }
        } else {
            // If session is not valid, redirect to login
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}

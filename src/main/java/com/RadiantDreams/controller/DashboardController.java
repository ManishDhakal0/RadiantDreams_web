package com.RadiantDreams.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.RadiantDreams.model.OrderModel;
import com.RadiantDreams.model.ProductModel;
import com.RadiantDreams.model.CustomerModel;
import com.RadiantDreams.service.DashboardService;

/**
 * Handles admin dashboard functionalities.
 * Retrieves metrics and summary data to display on the admin dashboard.
 */
@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DashboardController() {
        super();
    }

    /**
     * Handles GET requests to /dashboard.
     * Verifies admin session and retrieves dashboard data using DashboardService.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");

            // Only allow access if user is admin
            if (username != null && "admin".equalsIgnoreCase(role)) {
                DashboardService dashboardService = new DashboardService();

                // Fetch summary statistics and lists for dashboard
                int totalCustomers = dashboardService.getTotalCustomers();
                int totalOrders = dashboardService.getTotalOrders();
                double totalRevenue = dashboardService.getTotalRevenue();
                List<OrderModel> recentOrders = dashboardService.getRecentOrders();
                List<CustomerModel> latestCustomers = dashboardService.getLatestCustomers();
                List<ProductModel> topProducts = dashboardService.getTopSellingProducts();
                Map<String, Integer> orderStatuses = dashboardService.getOrderStatusCounts();

                // Pass data to the JSP page
                request.setAttribute("totalCustomers", totalCustomers);
                request.setAttribute("totalOrders", totalOrders);
                request.setAttribute("totalRevenue", totalRevenue);
                request.setAttribute("recentOrders", recentOrders);
                request.setAttribute("latestCustomers", latestCustomers);
                request.setAttribute("topProducts", topProducts);
                request.setAttribute("orderStatuses", orderStatuses);

                request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(request, response);
                return;
            }
        }

        // Redirect to login if not authorized
        response.sendRedirect(request.getContextPath() + "/login");
    }

    /**
     * Redirects POST requests back to dashboard.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}


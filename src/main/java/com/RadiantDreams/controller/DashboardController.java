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

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DashboardController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");

            if (username != null && "admin".equalsIgnoreCase(role)) {
                DashboardService dashboardService = new DashboardService();

                int totalCustomers = dashboardService.getTotalCustomers();
                int totalOrders = dashboardService.getTotalOrders();
                double totalRevenue = dashboardService.getTotalRevenue();
                List<OrderModel> recentOrders = dashboardService.getRecentOrders();
                List<CustomerModel> latestCustomers = dashboardService.getLatestCustomers();
                List<ProductModel> topProducts = dashboardService.getTopSellingProducts();
               

                Map<String, Integer> orderStatuses = dashboardService.getOrderStatusCounts();

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

        response.sendRedirect(request.getContextPath() + "/login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // No POST operations currently
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}

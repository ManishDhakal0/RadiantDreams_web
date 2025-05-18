package com.RadiantDreams.controller;

import com.RadiantDreams.service.OrderService;
import com.RadiantDreams.model.OrderModel;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.util.List;

/**
 * Handles order management for admin users.
 * Allows viewing and updating order statuses.
 */
@WebServlet(asyncSupported = true, urlPatterns = {"/ordermanagement"})
public class OrderController extends HttpServlet {
    private OrderService orderService = new OrderService();

    /**
     * Handles status update for specific order details via POST.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("updateStatus".equals(action)) {
            int orderDetailId = Integer.parseInt(req.getParameter("orderDetailId"));
            String newStatus = req.getParameter("status");

            if (orderDetailId > 0 && newStatus != null && !newStatus.isEmpty()) {
                orderService.updateOrderDetailStatus(orderDetailId, newStatus);
            }
        }

        // Redirect back to order management view
        resp.sendRedirect(req.getContextPath() + "/ordermanagement");
    }

    /**
     * Displays all orders to admin user.
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String role = (String) req.getSession().getAttribute("role");

        // Restrict access to admin only
        if (!"admin".equalsIgnoreCase(role)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<OrderModel> orders = orderService.getAllOrdersWithDetails();
        req.setAttribute("orderList", orders);
        req.getRequestDispatcher("/WEB-INF/pages/ordermanagement.jsp").forward(req, resp);
    }
}

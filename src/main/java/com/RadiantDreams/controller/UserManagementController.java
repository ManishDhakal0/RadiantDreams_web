package com.RadiantDreams.controller;

import com.RadiantDreams.model.CustomerModel;
import com.RadiantDreams.service.UserManagementService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/users")
public class UserManagementController extends HttpServlet {

    private UserManagementService userService = new UserManagementService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !role.equalsIgnoreCase("admin")) {
            response.sendRedirect("login");
            return;
        }

        String deleteId = request.getParameter("delete");
        if (deleteId != null) {
            userService.deleteUser(Integer.parseInt(deleteId));
            response.sendRedirect("users");
            return;
        }

        List<CustomerModel> users = userService.getAllUsers();
        request.setAttribute("userList", users);
        request.setAttribute("totalUsers", users.size());
        request.getRequestDispatcher("/WEB-INF/pages/usermanagement.jsp").forward(request, response);
    }
}

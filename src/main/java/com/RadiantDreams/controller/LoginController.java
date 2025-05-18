package com.RadiantDreams.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.RadiantDreams.service.LoginService;
import com.RadiantDreams.util.CookieUtil;
import com.RadiantDreams.util.SessionUtil;

/**
 * Handles login functionality for both admin and user roles.
 */
@WebServlet(asyncSupported = true, urlPatterns = {"/login", "/"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LoginService loginService;

    public LoginController() {
        this.loginService = new LoginService();
    }

    /**
     * Displays login form when user accesses the login page.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doGet called for /login");
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    /**
     * Processes login credentials.
     * Sets session attributes and redirects based on user role.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        Boolean loginStatus = loginService.loginUser(username, password, role);

        if (loginStatus != null && loginStatus) {
            // Set session attributes and role-based cookies
            SessionUtil.setAttribute(request, "username", username);
            SessionUtil.setAttribute(request, "role", role);
            CookieUtil.addCookie(response, "role", role, 5 * 60); // 5 minutes expiry

            // Redirect based on role
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            handleLoginFailure(request, response, loginStatus);
        }
    }

    /**
     * Displays error messages for login failure.
     */
    private void handleLoginFailure(HttpServletRequest req, HttpServletResponse resp, Boolean loginStatus)
            throws ServletException, IOException {
        String errorMessage;
        if (loginStatus == null) {
            errorMessage = "Our server is under maintenance. Please try again later!";
        } else {
            errorMessage = "User credential mismatch. Please try again!";
        }
        req.setAttribute("errorMsg", errorMessage); 
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }
}

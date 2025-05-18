package com.RadiantDreams.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.RadiantDreams.service.LoginService;
import com.RadiantDreams.util.CookieUtil;
import com.RadiantDreams.util.SessionUtil;

@WebServlet(asyncSupported = true, urlPatterns = {"/login","/"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LoginService loginService;

    public LoginController() {
        this.loginService = new LoginService();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doGet called for /login");
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); //role from dropdown

        Boolean loginStatus = loginService.loginUser(username, password, role);

        if (loginStatus != null && loginStatus) {
            SessionUtil.setAttribute(request, "username", username);
            SessionUtil.setAttribute(request, "role", role);

            CookieUtil.addCookie(response, "role", role, 5 * 60);

            
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            handleLoginFailure(request, response, loginStatus);
        }
    }
 
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
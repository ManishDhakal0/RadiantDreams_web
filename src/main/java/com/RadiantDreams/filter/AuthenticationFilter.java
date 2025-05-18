package com.RadiantDreams.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.RadiantDreams.util.SessionUtil;
import com.RadiantDreams.util.CookieUtil;

@WebFilter(asyncSupported = true, urlPatterns = "/*")
public class AuthenticationFilter implements Filter {

    private static final String LOGIN = "/login";
    private static final String LOGOUT = "/logout";
    private static final String REGISTER = "/register";
    private static final String HOME = "/home";
    private static final String ROOT = "/";
    private static final String DASHBOARD = "/dashboard";
    private static final String USERS = "/users";
    private static final String PRODUCTS_MANAGEMENT = "/productsmanagement";
    private static final String ORDER_MANAGEMENT = "/ordermanagement";
    private static final String PORTFOLIO = "/portfolio";
    private static final String UPDATE_PORTFOLIO = "/updatePortfolio";
    private static final String PRODUCTS = "/products";
    private static final String PRODUCT_VIEW = "/product/view";
    private static final String ABOUT = "/about";
    private static final String CONTACT = "/contact";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        // Allow static resources without filtering
        if (uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".png") ||
            uri.endsWith(".jpg") || uri.contains("/resources/")) {
            chain.doFilter(request, response);
            return;
        }

        boolean isLoggedIn = SessionUtil.getAttribute(req, "username") != null;
        String userRole = CookieUtil.getCookie(req, "role") != null
                ? CookieUtil.getCookie(req, "role").getValue()
                : null;

        // Public routes
        if (
            uri.endsWith(LOGIN) ||
            uri.endsWith(REGISTER) ||
            uri.endsWith(LOGOUT) ||
            uri.endsWith(HOME) ||
            uri.endsWith(ROOT) ||
            uri.startsWith(contextPath + PRODUCT_VIEW) ||
            uri.endsWith(ABOUT) ||
            uri.endsWith(CONTACT)
        ) {
            chain.doFilter(request, response);
            return;
        }

        // Admin routes
        if ("admin".equalsIgnoreCase(userRole)) {
            if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
                res.sendRedirect(contextPath + DASHBOARD);
            } else if (
                uri.endsWith(DASHBOARD) ||
                uri.endsWith(USERS) ||
                uri.endsWith(PRODUCTS_MANAGEMENT) ||
                uri.endsWith(ORDER_MANAGEMENT)
            ) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(contextPath + DASHBOARD);
            }
        }

        // Customer routes
        else if ("customer".equalsIgnoreCase(userRole)) {
            if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
                res.sendRedirect(contextPath + HOME);
            } else if (
                uri.endsWith(PORTFOLIO) ||
                uri.endsWith(UPDATE_PORTFOLIO) ||
                uri.endsWith(PRODUCTS)
            ) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(contextPath + HOME);
            }
        }

        // Not logged in
        else {
            res.sendRedirect(contextPath + LOGIN);
        }
    }

    @Override
    public void destroy() {
        // No cleanup needed
    }
}

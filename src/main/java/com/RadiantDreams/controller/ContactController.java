package com.RadiantDreams.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/contact")
public class ContactController extends HttpServlet {

  


    // This handles the form page loading
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
    }

    // This handles form submission
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //  a dummy success message
        req.setAttribute("success", "Your message has been processed.Thank you for reaching out.");
        
        // Forward back to the contact.jsp page
        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
    }

}

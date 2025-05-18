package com.RadiantDreams.controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class HomeController
 */
@WebServlet(asyncSupported =true,urlPatterns ={"/home"})
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String username = (String) request.getSession().getAttribute("username");

	    if (username == null) {
	        response.sendRedirect("login");
	    } else {
	        request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
	    }
	}




}

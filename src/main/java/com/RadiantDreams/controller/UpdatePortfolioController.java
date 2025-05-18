package com.RadiantDreams.controller;

import com.RadiantDreams.model.CustomerModel;
import com.RadiantDreams.service.PortfolioService;
import com.RadiantDreams.util.SessionUtil;
import com.RadiantDreams.util.ValidationUtil;
import com.RadiantDreams.util.ImageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/updatePortfolio")
@MultipartConfig
public class UpdatePortfolioController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PortfolioService portfolioService;
    private ImageUtil imageUtil;

    @Override
    public void init() {
        portfolioService = new PortfolioService();
        imageUtil = new ImageUtil();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = (String) SessionUtil.getAttribute(request, "username");
        if (username != null) {
            CustomerModel customer = portfolioService.getCustomerProfile(username);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/pages/updatePortfolio.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) SessionUtil.getAttribute(request, "username");

        CustomerModel updatedCustomer = new CustomerModel();
        updatedCustomer.setUsername(username);
        updatedCustomer.setFirstName(request.getParameter("first_name"));
        updatedCustomer.setLastName(request.getParameter("last_name"));
        updatedCustomer.setEmail(request.getParameter("email"));
        updatedCustomer.setPhone(request.getParameter("phone"));
        updatedCustomer.setAddress(request.getParameter("address"));
        updatedCustomer.setGender(request.getParameter("gender"));

        String password = request.getParameter("password");
        String dobString = request.getParameter("dob");
        Part imagePart = request.getPart("image");

        boolean hasError = false;

        // VALIDATIONS start here
        if (!ValidationUtil.isAlphabetic(updatedCustomer.getFirstName())) {
            request.setAttribute("firstNameError", "First name must contain only letters.");
            hasError = true;
        }
        if (!ValidationUtil.isAlphabetic(updatedCustomer.getLastName())) {
            request.setAttribute("lastNameError", "Last name must contain only letters.");
            hasError = true;
        }
        if (!ValidationUtil.isValidPhone(updatedCustomer.getPhone())) {
            request.setAttribute("phoneError", "Phone must start with 98 and be 10 digits.");
            hasError = true;
        }
        if (!ValidationUtil.isValidEmail(updatedCustomer.getEmail())) {
            request.setAttribute("emailError", "Invalid email format.");
            hasError = true;
        }
        if (password != null && !password.isBlank()) {
            if (!ValidationUtil.isValidPassword(password)) {
                request.setAttribute("passwordError", "Password must be 8+ chars, 1 uppercase, 1 number, 1 special char.");
                hasError = true;
            } else {
                updatedCustomer.setPassword(password);
            }
        }
        if (dobString != null && !dobString.isBlank()) {
            try {
                LocalDate dob = LocalDate.parse(dobString);
                if (!ValidationUtil.isAgeAtLeast18(dob)) {
                    request.setAttribute("dobError", "You must be at least 18 years old.");
                    hasError = true;
                } else {
                    updatedCustomer.setDob(dob);
                }
            } catch (Exception e) {
                request.setAttribute("dobError", "Invalid Date of Birth format.");
                hasError = true;
            }
        }
        String imagePath = null;

     // Handle image upload
     if (imagePart != null && imagePart.getSize() > 0) {
    	 	String imageName = imageUtil.uploadImage(imagePart, "profiles", request);

         if (imageName != null) {
             imagePath = imageUtil.getImageWebPath("profiles", imageName);
             updatedCustomer.setImage(imagePath); 
         }
     }

        // If validation errors exist
        if (hasError) {
            request.setAttribute("customer", updatedCustomer); // So form retains entered values
            request.getRequestDispatcher("/WEB-INF/pages/updatePortfolio.jsp").forward(request, response);
            return;
        }

        // Now save to database
        boolean success = portfolioService.updateCustomerProfile(updatedCustomer);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/portfolio");
        } else {
            request.setAttribute("error", "Update failed.");
            request.setAttribute("customer", updatedCustomer);
            request.getRequestDispatcher("/WEB-INF/pages/updatePortfolio.jsp").forward(request, response);
        }
    }
}
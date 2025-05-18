package com.RadiantDreams.controller;
import com.RadiantDreams.model.CustomerModel;
import com.RadiantDreams.service.RegisterService;
import com.RadiantDreams.util.ValidationUtil;
import com.RadiantDreams.util.ImageUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/register")
@MultipartConfig
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RegisterService service;
    private ImageUtil imageUtil;

    @Override
    public void init() {
        service = new RegisterService();
        imageUtil = new ImageUtil();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get Form Data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String dobString = request.getParameter("birthday");
        Part imagePart = request.getPart("image");

        boolean hasError = false;

        if (!ValidationUtil.isAlphabetic(firstName)) {
            request.setAttribute("firstNameError", "First name must contain only letters.");
            hasError = true;
        }
        if (!ValidationUtil.isAlphabetic(lastName)) {
            request.setAttribute("lastNameError", "Last name must contain only letters.");
            hasError = true;
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            request.setAttribute("phoneError", "Phone must start with 98 and be 10 digits.");
            hasError = true;
        }
        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("emailError", "Invalid email format.");
            hasError = true;
        }
        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("passwordError", "Password must be 8+ chars, 1 uppercase, 1 number, 1 special char.");
            hasError = true;
        }
        if (!password.equals(confirmPassword)) {
            request.setAttribute("confirmPasswordError", "Passwords do not match.");
            hasError = true;
        }
        if (dobString == null || dobString.isEmpty() || !ValidationUtil.isAgeAtLeast18(LocalDate.parse(dobString))) {
            request.setAttribute("dobError", "You must be at least 18 years old.");
            hasError = true;
        }
        // If there are validation errors
        if (hasError) {
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }
        LocalDate dob = LocalDate.parse(dobString);
        String imagePath = null;
        
        // Handle image upload
        if (imagePart != null && imagePart.getSize() > 0) {
        	String imageName = imageUtil.uploadImage(imagePart, "profiles", request);

            if (imageName != null) {
                imagePath = imageUtil.getImageWebPath("profiles", imageName);
            } else {
                imagePath = "/resources/images/default.png";  // fallback!
            }
        } else {
            imagePath = "/resources/images/default.png";  // fallback!
        }
        CustomerModel customer = new CustomerModel();
        customer.setFirstName(firstName);
        customer.setLastName(lastName);
        customer.setUsername(username);
        customer.setPassword(password);
        customer.setGender(gender);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setAddress(address);
        customer.setDob(dob);
        customer.setImage(imagePath); 
        Boolean status = service.addCustomer(customer);

        if (status != null && status) {
            response.sendRedirect("login");
        } else {
            request.setAttribute("error", "Registration failed. Try again!");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }
}
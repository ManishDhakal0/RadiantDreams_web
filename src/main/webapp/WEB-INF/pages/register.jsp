<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Radiant Dreams</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Radiant Dreams</h2>
            <p>SLEEP BETTER</p>
        </div>

        <div class="login-box">
            <div class="image-section" style="background-image: url('${pageContext.request.contextPath}/resources/images/customer/room2.jpg');">
                <!-- Overlay with text -->
                <div class="image-overlay">
                    <h3>Join Our Community</h3>
                    <p>Experience the comfort of Radiant Dreams</p>
                </div>
            </div>

            <div class="form-section">
                <div class="navigation">
                    <a href="login">Login</a>
                    <a href="register" class="active">Register</a>
                </div>

                <div class="welcome">
                    <h3>Welcome</h3>
                    <p>Register to access the Radiant Dreams application</p>
                </div>

                <c:if test="${not empty errorMsg}">
                    <div class="field-error">${errorMsg}</div>
                </c:if>

                <form action="register" method="post" enctype="multipart/form-data">
                    <label for="role">Register as:</label>
                    <select name="role" id="role" required>
                        <option value="customer">Customer</option>
                    </select>

                    <div class="row">
                        <div class="col">
                            <label for="firstName">First Name:</label>
                            <input type="text" name="firstName" placeholder="Enter first name" value="${param.firstName}" required>
                            <c:if test="${not empty firstNameError}">
                                <div class="field-error">${firstNameError}</div>
                            </c:if>
                        </div>
                        <div class="col">
                            <label for="lastName">Last Name:</label>
                            <input type="text" name="lastName" placeholder="Enter last name" value="${param.lastName}" required>
                            <c:if test="${not empty lastNameError}">
                                <div class="field-error">${lastNameError}</div>
                            </c:if>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <label for="gender">Gender:</label>
                            <select name="gender" id="gender" required>
                                <option value="male" ${param.gender == 'male' ? 'selected' : ''}>Male</option>
                                <option value="female" ${param.gender == 'female' ? 'selected' : ''}>Female</option>
                                <option value="other" ${param.gender == 'other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                        <div class="col">
                            <label for="birthday">Birthday:</label>
                            <input type="date" name="birthday" value="${param.birthday}" required>
                            <c:if test="${not empty dobError}">
                                <div class="field-error">${dobError}</div>
                            </c:if>
                        </div>
                    </div>

                    <label for="address">Address:</label>
                    <input type="text" name="address" placeholder="Enter address" value="${param.address}" required>

                    <label for="phone">Phone Number:</label>
                    <input type="tel" name="phone" placeholder="Enter phone number" value="${param.phone}" required>
                    <c:if test="${not empty phoneError}">
                        <div class="field-error">${phoneError}</div>
                    </c:if>

                    <label for="email">Email:</label>
                    <input type="email" name="email" placeholder="Enter email" value="${param.email}" required>
                    <c:if test="${not empty emailError}">
                        <div class="field-error">${emailError}</div>
                    </c:if>

                    <label for="username">Username:</label>
                    <input type="text" name="username" placeholder="Choose a username" value="${param.username}" required>

                    <div class="row">
                        <div class="col">
                            <label for="password">Password:</label>
                            <input type="password" name="password" placeholder="Choose a password" required>
                            <c:if test="${not empty passwordError}">
                                <div class="field-error">${passwordError}</div>
                            </c:if>
                        </div>
                        <div class="col">
                            <label for="confirmPassword">Retype Password:</label>
                            <input type="password" name="confirmPassword" placeholder="Retype your password" required>
                            <c:if test="${not empty confirmPasswordError}">
                                <div class="field-error">${confirmPasswordError}</div>
                            </c:if>
                        </div>
                    </div>

                    <div class="file-upload">
                        <label for="image">Profile Picture:</label>
                        <input type="file" id="image" name="image">
                    </div>

                    <button type="submit">Register</button>
                </form>

                <div class="footer">
                    <p>Already have an account? <a href="login">Login here</a></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
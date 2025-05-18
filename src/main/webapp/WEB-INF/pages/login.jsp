<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Radiant Dreams</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Radiant Dreams</h2>
            <p>SLEEP BETTER</p>
        </div>

        <div class="login-box">
            <div class="image-section" style="background-image: url('${pageContext.request.contextPath}/resources/images/customer/room2.jpg');">
                
            </div>

            <div class="form-section">

                <div class="navigation">
                    <a href="login" class="active">Login</a>
                    <a href="register">Register</a>
                </div>

                <div class="welcome">
                    <h3>Welcome</h3>
                    <p>Login to access the Radiant Dreams application</p>
                </div>

                <c:if test="${not empty errorMsg}">
    <div class="field-error" >
        ${errorMsg}
    </div>
</c:if>


                <form action="login" method="post">
                    <label for="role">Login as:</label>
                    <select name="role" id="role" required>
                        <option value="customer">Customer</option>
                        <option value="admin">Admin</option>
                    </select>

                    <label for="username">Username:</label>
                    <input type="text" name="username" placeholder="Enter your username" required>

                    <label for="password">Password:</label>
                    <input type="password" name="password" placeholder="Enter your password" required>

                    <button type="submit">Login</button>
                </form>

                <div class="footer">
                    <a href="forgotPassword">Forgot Password?</a>
                </div>

            </div>
        </div>
    </div>
</body>
</html>
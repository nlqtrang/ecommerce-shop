<%-- 
    Document   : login
    Created on : Oct 12, 2023, 5:14:31 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dal.UsersDAO"%>
<%@page import="util.SignUpValidation"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta name="description" content="Ogani Template">
        <meta name="keywords" content="Ogani, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
            <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,900;1,400&display=swap" rel="stylesheet">

        <title>Ogani</title>
        <link rel="stylesheet" href="css/style.css"/>
        <link rel="stylesheet" href="css/login.css"/>
        
    </head>
    <body style="height: 100vh; display: flex; justify-content: center; align-items: center;">
        
        <div class="cont <c:if test="${requestScope.signup == true}">s--signup</c:if>">
            <div class="humberger__menu__logo">
                <a href="home.jsp"><img src="img/logo.png" alt=""></a>
            </div>
            <form class="form sign-in" action="login" method="post">
                <h2>Welcome back,</h2>
                <label>
                    <span>user-name</span>
                    <input type="text" name="user"/>
                </label>
                <label>
                    <span>Password</span>
                    <input type="password" name="pass"/>
                </label>
                <p class="forgot-pass">Forgot password?</p>
                <button type="submit" class="submit">Sign In</button>
                <center style="color: red;">${requestScope.message}</center>
            <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:9999/EcommerceShop/login-google&response_type=code
    &client_id=570524258444-ridflrjec1qvuq3oidpn67cc1gm3t8i6.apps.googleusercontent.com&approval_prompt=force"><button type="button" class="fb-btn">Connect with <span>google</span></button></a>
                
            </form>
            <form class="sub-cont" action="signup" method="post">
                <div class="img">
                    <div class="img__text m--up">
                        <h2>New here?</h2>
                        <p>Sign up and discover great amount of new opportunities!</p>
                    </div>
                    <div class="img__text m--in">
                        <h2>One of us?</h2>
                        <p>If you already has an account, just sign in. We've missed you!</p>
                    </div>
                    <div class="img__btn">
                        <span class="m--up">Sign Up</span>
                        <span class="m--in">Sign In</span>
                    </div>
                </div>
                <div class="form sign-up">
                    <c:set var="errors" value="${requestScope.INSERTERR}"/>
                    <h2>Time to feel like home,</h2>
                    <label>
                        <span>Name</span>
                        <input type="text" name="name" value="${param.name}"/>
                        <c:if test="${not empty errors.fullNameLengthErr}">
                            <center style='color: red;'>${errors.fullNameLengthErr}</center>
                        </c:if>
                        
                    </label>
                    <label>
                        <span>User-name</span>
                        <input id="username" type="text" name="username" value="${param.username}" onchange="handleUserName()"/>
                        <c:if test="${not empty errors.usernameLengthErr}">
                            <center style='color: red;'>${errors.usernameLengthErr}</center>
                        </c:if>
                    </label>
                    
                    <label>
                        <span>Password</span>
                        <input type="password" name="password" value='${param.password}'/>
                        <c:if test="${not empty errors.passwordLengthErr}">
                            <center style='color: red;'>${errors.passwordLengthErr}</center>
                        </c:if>
                    </label>
                    <label>
                        <span>Confirm Password</span>
                        <input type="password" name="confirmPassword" value='${param.confirmPassword}'/>
                        <c:if test="${not empty errors.confirmNotMatch}">
                            <center style='color: red;'>${errors.confirmNotMatch}</center>
                        </c:if>
                    </label>
                    <button type="submit" class="submit">Sign Up</button>
                    <c:if test="${not empty errors.usernameIsExited}">
                        <center style='color: red;'> 
                        ${errors.usernameIsExited}
                        </center>
                    </c:if>
                    <button type="button" class="fb-btn">Join with <span>google</span></button>
                </div>
            </form>
        </div>



        <script>
            document.querySelector('.img__btn').addEventListener('click', function () {
                document.querySelector('.cont').classList.toggle('s--signup');
            });

        </script>
    </body>
</html>

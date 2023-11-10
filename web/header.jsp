<%-- 
    Document   : header
    Created on : Oct 12, 2023, 5:04:53 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>OGANI</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">
`   <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,900;1,400&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <style>
        .user-account {
            position: relative;
            display: inline-block;
            font-size: 16px;
        }

        .user-info {
            cursor: pointer;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            top: 90%;
            right: 0;
            background-color: #fff;
            border: 1px solid #ccc;
            border-top: none;
            border-radius: 0 0 5px 5px;
        }

        .user-account:hover .dropdown-menu {
            display: block;
        }

        .user-account:hover .user-info {
            background-color: #f0f0f0;
        }

        .user-account:hover .dropdown-menu a {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: #333;
            transition: background-color 0.2s;
        }

        .user-account:hover .dropdown-menu a:hover {
            background-color: #7fad39; /* Change to your preferred hover background color */
            color: #fff;
            cursor: pointer;
        }
    </style>
</head>
<body>
    
        <%
        String currentURL = request.getRequestURL().toString();
        session.setAttribute("targetURL", currentURL);
        %>
    <!-- Page Preloder -->
<!--     <div id="preloder">
        <div class="loader"></div>
    </div> -->

    <!-- Humberger Begin -->
    <div class="humberger__menu__overlay"></div>
    <div class="humberger__menu__wrapper">
        <div class="humberger__menu__logo">
            <a href="home"><img src="img/logo.png" alt=""></a>
        </div>
        <div class="humberger__menu__cart">
            <ul>
                <li><a href="#"><i class="fa fa-heart"></i> <span>1</span></a></li>
                <li><a href="#"><i class="fa fa-shopping-bag"></i> <span>3</span></a></li>
            </ul>
            <div class="header__cart__price">item: <span>$150.00</span></div>
        </div>
        <div class="humberger__menu__widget">
            <div class="header__top__right__language">
                <img src="img/language.png" alt="">
                <div>English</div>
                <span class="arrow_carrot-down"></span>
                <ul>
                    <li><a href="#">Spanish</a></li>
                    <li><a href="#">English</a></li>
                </ul>
            </div>
            <c:if test="${sessionScope.user==null}">
                <div class="header__top__right__auth">
                    <a href="login.jsp"><i class="fa fa-user"></i> Login</a>
                </div>
            </c:if>
            <c:if test="${sessionScope.user!=null}">
                <div class="header__top__right__auth">
                    <a href="login.jsp"><i class="fa fa-user"></i>${sessionScope.user.name}</a>
                </div>
            </c:if>
        </div>
        <nav class="humberger__menu__nav mobile-menu">
            <ul>
                <li class="active"><a href="./index.html">Home</a></li>
                <!-- <li><a href="./shop-grid.html">Shop</a></li>
                <li><a href="#">Pages</a>
                    <ul class="header__menu__dropdown">
                        <li><a href="./shop-details.html">Shop Details</a></li>
                        <li><a href="./shoping-cart.html">Shoping Cart</a></li>
                        <li><a href="./checkout.html">Check Out</a></li>
                        <li><a href="./blog-details.html">Blog Details</a></li>
                    </ul>
                </li>
                <li><a href="./blog.html">Blog</a></li>
                <li><a href="./contact.html">Contact</a></li> -->
            </ul>
        </nav>
        <div id="mobile-menu-wrap"></div>
        <div class="header__top__right__social">
            <a href="#"><i class="fa fa-facebook"></i></a>
            <a href="#"><i class="fa fa-instagram"></i></a>
        </div>
        <div class="humberger__menu__contact">
            <ul>
                <li><i class="fa fa-envelope"></i> hello@colorlib.com</li>
                <li>Free Shipping for all Order of $99</li>
            </ul>
        </div>
    </div>
    <!-- Humberger End -->

    <!-- Header Section Begin -->
    <header class="header" style="background-color: #ccc;">
        <div class="header__top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="header__top__left">
                            <ul>
                                <li><i class="fa fa-envelope"></i> hello@colorlib.com</li>
                                <li>Free Shipping for all Order of $99</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="header__top__right">
                            <div class="header__top__right__social">
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-instagram"></i></a>
                            </div>
                            <div class="header__top__right__language">
                                <img src="img/language.png" alt="">
                                <div>English</div>
                                <span class="arrow_carrot-down"></span>
                                <ul>
                                    <li><a href="#">Spanish</a></li>
                                    <li><a href="#">English</a></li>
                                </ul>
                            </div>
                            <div class="user-account">
                                <c:if test="${sessionScope.user==null}">
                                    <div class="header__top__right__auth">
                                        <a href="login"><i class="fa fa-user"></i> Login</a>
                                    </div>
                                </c:if>
                                <c:if test="${sessionScope.user!=null}">
                                    <div class="user-info header__top__right__auth">
                                        <a href="#"><i class="fa fa-user"></i>${sessionScope.user.name}</a>
                                    </div>
                                    <ul class="dropdown-menu">
                                        <li><a href="profile">
                                                Trang Cá Nhân
                                            </a>
                                        </li>
                                        <c:if test="${sessionScope.user.role!=2}">
                                            <li><a href="dashboard">Admin</a></li>
                                        </c:if>
                                        <li><a href="purchase">Đơn mua</a></li>
                                        <li><a href="javascript:void(0);" onclick="logout()">
                                                Đăng xuất
                                            </a>
                                        </li>
                                    </ul>
                                </c:if>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-2">
                    <div class="header__logo">
                        <a href="home"><img src="img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-8 col-9 my-auto">
                    <div class="hero__search">
                        <div class="hero__search__form">
                            <form action="search">
                                <input type="text" placeholder="What do you need?" name='search'>
                                <button type="submit" class="site-btn">Tìm kiếm</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-3">
                    <div class="header__cart">
                        <a href="shopping-cart">
                            <i class="fa fa-shopping-bag"></i> 
                            <c:if test="${not empty sessionScope.user}">
                                <span class='shopping-cart-quantity' style='color: #fff'>${sessionScope.numberOfProductsInCart}</span>
                            </c:if>
                        </a>
                        
                    </div>
                </div>
            </div>
            <div class="humberger__open">
                <i class="fa fa-bars"></i>
            </div>
        </div>
    </header>
    <!-- Header Section End -->

        <!-- Js Plugins -->
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.nice-select.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <script src="js/jquery.slicknav.js"></script>
        <script src="js/mixitup.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/main.js"></script>
        <script>
             function logout() {


                // Chuyển hướng đến trang logout rồi chuyển về trang vừa tới
                window.location.href = "logout";
            }
            
            var currentURL = window.location.href;
console.log(currentURL);
        </script>
</body>

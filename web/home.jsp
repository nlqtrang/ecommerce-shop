<%-- 
    Document   : home
    Created on : Oct 12, 2023, 5:13:00 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Ogani Template">
        <meta name="keywords" content="Ogani, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>OGANI</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@200;300;400;600;900&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,900;1,400&display=swap" rel="stylesheet">

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
            .product {
                position: relative;
                background-color: #fff;
                border: 1px solid #e1e1e1;
                padding: 8px;
                margin-bottom: 20px;
            }

            .product__top-right {
                position: absolute;
                top: 0;
                right: 0;
                background-color: #ff0000;
                color: #fff;
                padding: 5px 10px;
                font-weight: bold;
            }

            .product__image img {
                max-width: 100%;
                height: auto;
            }

            .product__title {
                font-size: 16px;
                margin-top: 10px;
            }

            .product__price {
                margin-top: 10px;
            }

            .product__sale-price {
                font-weight: bold;
                color: #ff0000;
                margin-left: 10px;
            }

            .product__meta {
                margin-top: 10px;
                font-size: 14px;
            }

            .product__meta .product__sales {
                margin-right: 20px;
            }

            .product__rating i {
                color: #f1c40f;
            }

            .truncate-text {
                /* max-height: 3em; Chiều cao tối đa là 3 dòng */
                line-height: 1.5;
                max-height: 3em;
                overflow: hidden;
                text-overflow: ellipsis; /* Hiển thị dấu "..." khi văn bản bị cắt */
                white-space: nowrap; /*Ngăn các dòng mới*/

            }

            .prod_cont:hover {
                transform: scale(1.1); /* Phóng to phần tử 110% khi hover. */
                border: 2px solid #ccc; /* Thêm đường viền có độ rộng 2px màu xanh. */
                /* Hoặc sử dụng outline nếu bạn muốn viền không ảnh hưởng đến kích thước tổng của phần tử. */
                /* outline: 2px solid blue; */
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>


        <div class="body" style="background-color: #f5f5f5;">
            <!--Slide and Aside-->
            <div  class='container' style="background-color: #fff;">
                <div class='row'>
                    <div class="col-lg-3">
                        <aside class="hero__categories">
                            <div class="hero__categories__all">
                                <i class="fa fa-bars"></i>
                                <span>Danh mục</span>
                            </div>
                            <ul>
                                <c:forEach items="${listProductsTypes}" var="type">
                                    <li><a href="search?type=${type.id}">${type.name}</a></li>
                                </c:forEach>
                            </ul>
                        </aside>
                    </div>
                    <div class="col-lg-9">
                        <div id="carouselExampleIndicators" class="carousel slide" style="max-height: 400px;" data-ride="carousel">
                            <ol class="carousel-indicators">
                                <c:forEach items="${listSlides}" var="slide" varStatus="loop">
                                    <c:if test="${loop.index==0}">
                                        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                                        </c:if>
                                        <c:if test="${loop.index!=0}">
                                        <li data-target="#carouselExampleIndicators" data-slide-to="${loop.index}"></li>
                                        </c:if>
                                    </c:forEach>
                                <!--                            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                                                            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                                                            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>-->
                            </ol>
                            <div class="carousel-inner" style="max-height: 400px;">
                                <c:forEach items="${listSlides}" var="slide" varStatus="loop">
                                    <c:if test="${loop.index==0}">
                                        <div class="carousel-item active position-relative">
                                            <img class="d-block w-100 img-fluid position-static" src="${slide.image}" alt="${loop.count} slide">
                                            <div class="carousel-caption d-block d-md-block position-absolute">
                                                <h5>${slide.title}</h5>
                                                <p>${slide.description}</p>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${loop.index!=0}">
                                        <div class="carousel-item position-relative">
                                            <img class="d-block w-100 img-fluid position-static" src="${slide.image}" alt="${loop.count} slide">
                                            <div class="carousel-caption d-block d-md-block position-absolute">
                                                <h5>${slide.title}</h5>
                                                <p>${slide.description}</p>
                                            </div>
                                        </div>

                                    </c:if>
                                </c:forEach>
                                <!--                            <div class="carousel-item active">
                                                                <img class="d-block w-100 img-fluid" src="img/blog/sidebar/sr-1.jpg" alt="First slide">
                                                                <div class="carousel-caption d-block d-md-block">
                                                                    <h5>...</h5>
                                                                    <p>...</p>
                                                                </div>
                                                            </div>
                                                            <div class="carousel-item">
                                                                <img class="d-block w-100 img-fluid" src="img/blog/sidebar/sr-2.jpg" alt="Second slide">
                                                            </div>
                                                            <div class="carousel-item">
                                                                <img class="d-block w-100 img-fluid" src="img/blog/sidebar/sr-3.jpg" alt="Third slide">
                                                            </div>-->
                            </div>
                            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>
                </div>

            </div>

            <!--Best Sellers-->
            <section class="categories">
                <div class="container">
                    <div class="section-title p-3">
                        <h2>FLASH SALES</h2>
                    </div>
                    <div class="row">
                        <div class="categories__slider owl-carousel">
                            <c:forEach items="${listProductsCategoriesDTOFlashSale}" var="productsCategory">
                                <c:if test="${productsCategory.isStored == false}">
                                    <a class="prod_cont" href="product-detail?productId=${productsCategory.id}" >
                                        <div class="col-lg-3" style="background-color: #f5f5f5;">
                                            <!--                                        <a href="#">
                                                                                        <div class="categories__item set-bg" data-setbg="${productsCategory.image}">
                                            
                                                                                        </div>
                                                                                        <h5 style="color: black; font-size: 14px; padding-top: 8px; background-color: #fff;">${productsCategory.name}</h5>
                                                                                    </a>-->
                                            <div class="product p-2 pt-1">
                                                <div class="categories__item set-bg product__image" data-setbg="${productsCategory.image}">
                                                </div>
                                                <div class="product__content">
                                                    <div class="product__top-right">
                                                        <span class="product__discount">-${productsCategory.salePrice}%</span>
                                                    </div>
                                                    <h5 class="product__title truncate-text">${productsCategory.name}</h5>
                                                    <div class="product__price">
                                                        <span class="product__sale-price">${productsCategory.minPrice}đ</span>
                                                        <c:if test="${productsCategory.maxPrice!=productsCategory.minPrice}">
                                                            <span class="product__sale-price">- ${productsCategory.maxPrice}đ</span>
                                                        </c:if>

                                                    </div>
                                                    <div class="product__meta d-flex justify-content-between">
                                                        <span class="product__rating"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></span>
                                                        <span class="product__sales" style="color: black;">Đã bán: ${productsCategory.soldQuantity}</span>
                                                        <span class="product__sales" style="color: black;">Còn hàng: ${productsCategory.quantity}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </c:if>

                            </c:forEach>
                            <!--                        <div class="col-lg-3">
                                                            <div class="categories__item set-bg" data-setbg="img/categories/cat-1.jpg">
                                                                <h5><a href="#">Fresh Fruit</a></h5>
                                                            </div>
                                                        </div>
                            -->
                        </div>
                    </div>
                </div>
            </section>
            <!-- Best Sellers End -->

            <!-- Featured Section Begin -->
            <section class="featured spad">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="section-title">
                                <h2>SẢN PHẨM</h2>
                            </div>
                            <div class="featured__controls">
                                <ul>
                                    <li class="active" data-filter="*">Tất cả</li>
                                    <li data-filter=".oranges">Bán chạy</li>
                                    <li data-filter=".fresh-meat">Mới nhất</li>
                                    <li data-filter=".vegetables">Flash Sales</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row featured__filter">
                        <c:forEach items="${listProductsCategoriesDTO}" var="productsCategory">
                            <c:if test="${productsCategory.isStored == false}">
                                <div style="background-color: white;" class="
                                     col-lg-3 col-md-4 col-sm-6 mix
                                     <c:if test="${listProductsCategoriesBestSellers.contains(productsCategory.id)}">oranges</c:if>
                                     <c:if test="${listProductsCategoriesNewest.contains(productsCategory.id)}">fresh-meat</c:if>
                                     <c:if test="${listProductsCategoriesSales.contains(productsCategory.id)}">vegetables</c:if>
                                ">
                                         <div class="featured__item">
                                             <div class="featured__item__pic set-bg" data-setbg="${productsCategory.image}">
                                             <ul class="featured__item__pic__hover">
                                                 <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                                 <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                                 <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                                             </ul>
                                         </div>
                                         <a href="product-detail?productId=${productsCategory.id}" class="product__content">
                                             <div class="product__top-right">
                                                 <span class="product__discount">-${productsCategory.salePrice}%</span>
                                             </div>
                                             <h5 class="product__title truncate-text">${productsCategory.name}</h5>
                                             <div class="product__price">
                                                 <span class="product__sale-price">${productsCategory.minPrice}đ</span>
                                                 <c:if test="${productsCategory.maxPrice!=productsCategory.minPrice}">
                                                     <span class="product__sale-price">- ${productsCategory.maxPrice}đ</span>
                                                 </c:if>
                                             </div>
                                             <div class="product__meta d-flex justify-content-between">
                                                 <span class="product__rating"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></span>
                                                 <span class="product__sales" style="color: black;">Đã bán: ${productsCategory.soldQuantity}</span>
                                                 <span class="product__sales" style="color: black;">Còn hàng: ${productsCategory.quantity}</span>
                                             </div>
                                         </a>
                                     </div>
                                </div>
                            </c:if>
                        </c:forEach>

<!--                        <div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
                            <div class="featured__item">
                                <div class="featured__item__pic set-bg" data-setbg="img/featured/feature-1.jpg">
                                    <ul class="featured__item__pic__hover">
                                        <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                        <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                        <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                                    </ul>
                                </div>
                                <div class="featured__item__text">
                                    <h6><a href="#">Crab Pool Security</a></h6>
                                    <h5>$30.00</h5>
                                </div>
                            </div>
                        </div>-->
                        
                    </div>
                </div>
            </section>
            <!-- Featured Section End -->
            <%@include file="footer.jsp" %>
        </div>

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
//            var itemsToShow = ${listProductsCategoriesDTOFlashSale.size()}; // Đặt số lượng mặc định là 4
//            if (itemsToShow < 4) {
//                var loopEnabled = false;
//            } else {
//                var loopEnabled = true;
//            }
//
//            // Khởi tạo Owl Carousel với điều kiện loop
//            $(".product__details__pic__slider").owlCarousel({
//                loop: loopEnabled, // Sử dụng biến loopEnabled để đặt loop
//                margin: 20,
//                items: itemsToShow,
//                dots: true,
//                smartSpeed: 1200,
//                autoHeight: false,
//                autoplay: true
//            });
        </script>
    </body>
</html>

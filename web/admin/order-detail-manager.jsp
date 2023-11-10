<%-- 
    Document   : order-detail-manager
    Created on : Nov 9, 2023, 2:31:27 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="admin/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css">
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <style>
            span {
                font-weight: 500 !important;
                font-size: 16px !important;
            }

            h5 {
                font-weight: 700 !important;
                font-size: 20px !important;
            }

        </style>
    
</head>
    <body class="sb-nav-fixed">
        <%@include file="header.jsp" %>
        <div id="layoutSidenav">
            <%@include file="navbar.jsp" %>
            <div id="layoutSidenav_content">
                <!-- Checkout Section Begin -->
                    <section class="checkout spad">
                        <div class="container">
                            <!--                <div class="row">
                                                <div class="col-lg-12">
                                                    <h6><span class="icon_tag_alt"></span> Have a coupon? <a href="#">Click here</a> to enter your code
                                                    </h6>
                                                </div>
                                            </div>-->
                            <div class="checkout__form">
                                <div class="row">
                                    <div class="col-lg-8 col-md-6">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <h4 class='text-danger'>${order.status}</h4>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="checkout__input">
                                                    <h5>Họ và tên: <span>${order.name}</span></h5>

                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="checkout__input">
                                                    <h5>Số điện thoại: <span>${order.phone}</span></h5>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="checkout__input">
                                            <h5>Địa chỉ: <span>${order.address}</span></h5>
                                        </div>
                                        <div class="checkout__input">
                                            <h5>Ghi chú: <span>${order.message}</span></h5>
                                        </div>
                                        <div class="checkout__input">
                                            <h5>Ngày đặt: <span>${order.createdAt}</span></h5>
                                        </div>
                                        <c:if test="${not empty order.shippingDate}">
                                        <div class="checkout__input">
                                            <h5>Ngày ship: <span>${order.shippingDate}</span></h5>
                                        </div>
                                        </c:if>
                                        <c:if test="${not empty order.shippedDate}">
                                        <div class="checkout__input">
                                            <h5>Ngày nhận hàng: <span>${order.shippedDate}</span></h5>
                                        </div>
                                        </c:if>
                                    </div>


                                    <div class="col-lg-4 col-md-6">
                                        <div class="checkout__order">
                                            <h4>Hóa đơn</h4>
                                            <div class="checkout__order__products">Số lượng sản phẩm <span></span></div>

                                            <div class="checkout__order__subtotal mb-0" id='checkout__sum'>Tổng <span></span></div>
                                            <div class="checkout__order__subtotal" id='checkout__ship'>Phí ship <span>20000</span></div>
                                            <div class="checkout__order__total">Tổng <span></span></div>
                                            <input type='hidden' value="${listProductIds}" name='listProductIds'>
                                        </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <section class="shoping-cart spad">
                                        <div class="container">
                                            <div class="row position-relative">
                                                <div class="col-lg-12">
                                                    <div class="shoping__cart__table">
                                                        <table>
                                                            <thead>
                                                                <tr>
                                                                    <th class="shoping__product">Sản phẩm</th>
                                                                    <th>Đơn giá</th>
                                                                    <th>Số lượng</th>
                                                                    <th>Thành tiền</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach items="${order.listOrdersDetails}" var="product">

                                                                    <tr id="row${product.id}">
                                                                        <td class="shoping__cart__item row">
                                                                            <img class="col-lg-2 p-0 m-0 img-fluid" src="${product.image}" alt="">
                                                                            <a href="edit-product?productId=${product.productCategoryId}" class="col-lg-6"><h5>${product.name}</h5></a>
                                                                            <div class="col-lg-4">
                                                                                <span>Phân loại sản phẩm</span>
                                                                                <p>${product.variantName}</p>
                                                                            </div>   
                                                                        </td>
                                                                        <td class="shoping__cart__price">
                                                                            <del style="color: #ccc">${product.priceOriginal}</del>
                                                                            <p id="price${product.id}">${product.price}</p>
                                                                        </td>
                                                                        <td class="shoping__cart__quantity">
                                                                            <!--                                                                    <div class="quantity">
                                                                                                                                                    <div class="pro-qty">
                                                                                                                                                        <input type="number" value="${product.quantity}" min="1" max="${product.productQuantity}" onchange="updateQuantity(this, ${product.id})">
                                                                                                                                                        <input type="hidden" value="${product.productQuantity}" id="max${product.id}">
            
                                                                                                                                                    </div>
                                                                                                                                                </div>-->
                                                                            <p class="product-quantity">${product.quantity}</p>
                                                                            <p style="color: red;" id="message${product.id}"></p>
                                                                        </td>
                                                                        <td class="shoping__cart__total" id="total${product.id}">
                                                                            ${product.total}
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
                                </div>
                                <div class="row d-flex justify-content-between">
                                    <button type="button" class="site-btn m-0 p-1"><a href="dashboard" class="primary-btn mx-auto">Trang chủ</a></button><!--  -->
                                    <button type="button" class="site-btn m-0 p-1"><a href="orders-manager" class="primary-btn mx-auto">Quay lại quản lý đơn hàng</a></button>
                                </div>

                            </div>
                        </div>
                    </section>
                    <!-- Checkout Section End -->
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="admin/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="admin/assets/demo/chart-area-demo.js"></script>
        <script src="admin/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="admin/js/datatables-simple-demo.js"></script>
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.nice-select.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <script src="js/jquery.slicknav.js"></script>
        <script src="js/mixitup.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/main.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="sweetalert2.min.css">
        <script>
            var noProduct = document.querySelector('.checkout__order__products span');
            var sum = document.querySelector('#checkout__sum span');
//            var ship = document.querySelector('#checkout__ship');
            var total = document.querySelector('.checkout__order__total span');

            var productsQuantity = document.querySelectorAll('.product-quantity');
            var totalQuantity = 0;
            productsQuantity.forEach(function (product) {
                // Giả sử số lượng là một số nguyên. Sử dụng parseInt để chuyển đổi nếu cần.
                // Bạn cũng có thể dùng Number() nếu số lượng có thể là số thực.
                totalQuantity += parseInt(product.textContent) || 0; // Sử dụng || 0 để xử lý trường hợp NaN.
            });
            noProduct.innerHTML = totalQuantity;

            var totalElements = document.querySelectorAll('.shoping__cart__total');
            var grandTotal = 0;
            totalElements.forEach(function (element) {
                // Lấy giá trị nội dung của mỗi phần tử và chuyển đổi nó thành số
                var value = parseFloat(element.textContent.trim()) || 0; // sử dụng parseFloat cho giá trị thập phân, || 0 để xử lý trường hợp NaN.
                grandTotal += value;
            });
            sum.innerHTML = grandTotal;
            total.innerHTML = (grandTotal + 20000);
        </script>
    </body>
</html>

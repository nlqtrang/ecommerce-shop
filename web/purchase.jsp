<%-- 
    Document   : purchase
    Created on : Nov 2, 2023, 5:29:58 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="description" content="Ogani Template" />
    <meta name="keywords" content="Ogani, unica, creative, html" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Ogani</title>

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
<!--    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
    <style>
        .btn-orange {
            background-color: #ff5700;
            color: #fff;
        }

        .list-group-item {
            border: none;
            background-color: transparent;
            color: #333;
        }

        .list-group-item:hover {
            background-color: #f5f5f5;
            cursor: pointer;
        }

        a:hover {
            text-decoration: none;
            color: #000 !important;
        }

        a {
            color: #000 !important;
        }
    </style>
</head>

<body>
<%@include file="header.jsp" %>
<div class="mt-5">
    <div class="row m-0 p-0">
        <!-- Sidebar -->
        <div class="col-md-3">
            <div class="mb-3">
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-orange text-white mr-2" style="width: 40px; height: 40px; display: flex; justify-content: center; align-items: center;">T</div>
                    <div>
                        <strong>${sessionScope.user.name}</strong>
                        <br>
                        <a href="#" style="color: #000;">Sửa Hồ Sơ</a>
                    </div>
                </div>
            </div>
            <ul class="list-group">
                <li class="list-group-item">Tài Khoản Của Tôi</li>
                <li class="list-group-item" style='background-color: #7fad39; color: #fff;'>Đơn Mua</li>
                <li class="list-group-item">Đăng xuất</li>
            </ul>
        </div>
        <!-- Main Content -->
        <div class="col-md-9">
            
            <section class="featured spad pt-0">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="featured__controls">
                                <ul>
                                    <li class="active" data-filter="*">Tất cả</li>
                                    <li data-filter=".status1">Chờ xác nhận</li>
                                    <li data-filter=".status2">Đang chuẩn bị hàng</li>
                                    <li data-filter=".status3">Đang giao hàng</li>
                                    <li data-filter=".status4">Hàng đã tới</li>
                                    <li data-filter=".status5">Đã nhận hàng</li>
                                    <li data-filter=".status6">Đã hủy</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row featured__filter">
                        <c:forEach var="order" items="${listOrders}">
                            <div class="card mb-3 mix status${order.statusId} col-lg-11 p-0">
                                <div class="card-header">
                                    <div class="d-flex justify-content-between">
                                        <div class="text-danger">${order.status}</div>
                                    </div>
                                </div>
                                <div class="card-body p-1">
                                    <c:forEach items="${order.listOrdersDetails}" var="product">
                                        <div class="d-flex justify-content-between align-items-center m-1">
                                            <a href="product-detail?productId=${product.productCategoryId}" class="d-flex">
                                                <img src="${product.image}" alt="product-image" class="mr-3 img-fluid" width='75' height='100'>
                                                <div>
                                                    <div>${product.name}</div>
                                                    <c:if test="${not empty product.variantName}">
                                                        <p>Phân loại hàng: ${product.variantName}</p>
                                                    </c:if>
                                                    
                                                    <div>x${product.quantity}</div>
                                                </div>
                                            </a>
                                            <div>₫${product.total}</div>
                                        </div>
                                    </c:forEach>
                                    <!-- Product 1 -->
                                    
                                    <!-- Product 2 -->
<!--                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <a href="" class="d-flex">
                                            <img src="https://via.placeholder.com/70" alt="product-image" class="mr-3">
                                            <div>
                                                <div>Túi deo chéo nữ dáng yên ngựa nắp khóa cái thời trang hàng hiệu cao cấp TX63</div>
                                                <p>Phân loại hàng: trắng</p>
                                                <div>x1</div>
                                            </div>
                                        </a>
                                        <div>₫1.000</div>
                                    </div>-->
                                </div>
                                <div class="card-footer d-flex justify-content-between">
                                    <div><strong>Thành tiền:</strong> ₫${order.price+20000}</div>
                                    <div>
                                        <c:if test="${order.statusId<=2}">
                                            <button class="btn btn-danger" onclick='cancelOrder(${order.id})'>Hủy hàng</button>
                                        </c:if>
                                        <!--<button class="btn btn-warning">Mua Lại</button>-->
                                        <button class="btn btn-success" onclick='redirect(${order.id})'>Chi tiết đơn hàng</button>
                                        <!--<button class="btn btn-light">Liên Hệ Người Bán</button>-->
                                        <c:if test="${order.statusId==5}">
                                            <button class="btn btn-warning">Đánh giá</button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        

                    </div>
                </div>
            </section>
            
        </div>
    </div>

</div>
    <!-- Footer Section Begin -->
    <%@include file="footer.jsp" %>
    <!-- Footer Section End -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
<script>
    function redirect(orderId) {
        window.location.href = "order-detail?orderId="+orderId;
    }
    
//    function cancelOrder(orderId) {
//        Swal.fire({
//                    title: 'Thành công!',
//                    text: 'Đã cập nhật thành công.',
//                    icon: 'success',
//                    confirmButtonText: 'OK'
//                }).then(response) {
//                    if (response.isConfirmed) {
//                        window.location.href = "cancel-order?orderId="+orderId;
//                    }
//                }
//        
//    }
    function cancelOrder(orderId) {
    // Show a confirmation dialog
    Swal.fire({
        title: 'Bạn có chắc chắn?',
        text: 'Bạn có muốn hủy đơn hàng này không?',
        icon: 'warning',
        showCancelButton: true, // Show the Cancel button
        confirmButtonText: 'Có, hủy nó!',
        cancelButtonText: 'Không, giữ lại!',
        reverseButtons: true
    }).then((result) => {
        // If confirmed, redirect or perform the cancel action
        if (result.isConfirmed) {
            
            
            Swal.fire(
                        'Đã Hủy!',
                        'Đơn hàng của bạn đã được hủy.',
                        'success'
                    ).then((result) => {
        // If confirmed, redirect or perform the cancel action
        if (result.isConfirmed) {
            window.location.href = "cancel-order?orderId="+orderId;
                    }})
                    
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            // If canceled, do something else or nothing
            Swal.fire(
                'Đã Giữ Lại',
                'Đơn hàng của bạn an toàn :)',
                'error'
            );
        }
    });
}

</script>
</body>

</html>


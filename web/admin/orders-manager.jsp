<%-- 
    Document   : orders-manager
    Created on : Nov 9, 2023, 2:44:15 AM
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
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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

        #layoutSidenav_content a:hover {
            text-decoration: none;
            color: #000 !important;
        }

        #layoutSidenav_content a {
            color: #000 !important;
        }
    </style>
</head>
    <body class="sb-nav-fixed">
        <%@include file="header.jsp" %>
        <div id="layoutSidenav">
            <%@include file="navbar.jsp" %>
            <div id="layoutSidenav_content">
                <section class="featured spad pt-5">
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
                        <c:catch>
                            <c:forEach var="order" items="${listOrders}">
                            <div class="card mb-3 mix status${order.statusId} col-lg-11 p-0">
                                <div class="card-header">
                                    <div class="d-flex justify-content-between">
                                        <div class="text-danger" id="statusOrder${order.id}">${order.status}</div>
                                    </div>
                                </div>
                                <div class="card-body p-1">
                                    <h5>Người mua: ${order.userId}</h5>
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
                                        <select onchange="changeOrder(${order.id}, this)">
                                            <option value="1" ${order.statusId==1 ? "selected" : ""}>Đang chờ xác nhận</option>
                                            <option value="2" ${order.statusId==2 ? "selected" : ""}>Đang chuẩn bị hàng</option>
                                            <option value="3" ${order.statusId==3 ? "selected" : ""}>Đang giao hàng</option>
                                            <option value="4" ${order.statusId==4 ? "selected" : ""}>Hàng đã tới</option>
                                            <option value="5" ${order.statusId==5 ? "selected" : ""}>Đã nhận hàng</option>
                                            <option value="6" ${order.statusId==6 ? "selected" : ""}>Đã hủy</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        </c:catch>
                        
                        

                    </div>
                </div>
            </section>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="admin/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="admin/assets/demo/chart-area-demo.js"></script>
        <script src="admin/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="admin/js/datatables-simple-demo.js"></script>
        
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
    function changeOrder(orderId, select) {
    // Show a confirmation dialog
        Swal.fire({
            title: 'Bạn có chắc chắn?',
            text: 'Bạn có muốn cập nhật đơn hàng này không?',
            icon: 'warning',
            showCancelButton: true, // Show the Cancel button
            confirmButtonText: 'Có, cập nhật!',
            cancelButtonText: 'Không, giữ lại!',
            reverseButtons: true
        }).then((result) => {
            // If confirmed, redirect or perform the cancel action
            if (result.isConfirmed) {


                Swal.fire(
                            'Đã Cập nhật!',
                            'Đơn hàng này đã được cập nhật.',
                            'success'
                        ).then((result) => {
            // If confirmed, redirect or perform the cancel action
            if (result.isConfirmed) {
                window.location.href = "change-order?orderId="+orderId+"&status="+select.value;
                        }})
//                    $.ajax({
//                            url: '/EcommerceShop/change-order', // Đường dẫn tới servlet hoặc controller xử lý cập nhật
//                            type: 'GET',
//                            data: {
//                                'orderId': orderId,
//                                'status': select.value
//                            },
//                            success: function(response) {
//                                // Xử lý khi cập nhật thành công
//                                console.log('Cập nhật thành công', response);
//                                document.querySelector("#statusOrder"+orderId).innerHTML = response;
//                            },
//                            error: function(error) {
//                                // Xử lý lỗi
//                                console.log('Có lỗi xảy ra', error);
//                            }
//                        });
//                }})
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                // If canceled, do something else or nothing
                Swal.fire(
                    'Đã Giữ Lại',
                    'Đơn hàng không thay đổi :)',
                    'error'
                );
            }
        });
    }

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
    
    function redirect(orderId) {
        window.location.href = "order-detail-manager?orderId="+orderId;
    }

</script>
    </body>
</html>


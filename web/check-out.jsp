<%-- 
    Document   : check-out
    Created on : Oct 30, 2023, 7:27:51 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="zxx">

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
    </head>
    <body>

        <%@include file="header.jsp" %>

        <!-- Breadcrumb Section Begin -->
        <section class="breadcrumb-section set-bg" data-setbg="https://media.istockphoto.com/id/1183329518/vi/anh/tinh-v%C3%A2n-v%C5%A9-tr%E1%BB%A5-v%C3%A0-c%C3%A1c-ng%C3%B4i-sao-s%C3%A1ng.jpg?b=1&s=612x612&w=0&k=20&c=D05OvYS8OP789JddeHOwT7fhV5PPyAdp_gUfvhT-PPQ=">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="breadcrumb__text">
                            <h2>Thanh toán</h2>
                            <div class="breadcrumb__option">
                                <a href="./index.html">Home</a>
                                <span>Thanh toán</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End -->

        <!-- Checkout Section Begin -->
        <section class="checkout spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <h6><span class="icon_tag_alt"></span> Have a coupon? <a href="#">Click here</a> to enter your code
                        </h6>
                    </div>
                </div>
                <div class="checkout__form">
                    <h4>Chi tiết đơn hàng</h4>
                    <form action="create-bill" method='post' id="checkout-form">
                        <div class="row">
                            <div class="col-lg-8 col-md-6">
                                <c:set value="${sessionScope.user}" var="user"></c:set>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="checkout__input">
                                                <p>Họ và tên <span>*</span></p>
                                                <input type="text" value='${user.name}' style='color: #000;' name='name' required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Số điện thoại <span>*</span></p>
                                            <input type="text" value='${user.phone}' style='color: #000;' name='phone' required>
                                        </div>
                                    </div>
                                </div>
                                <div class="checkout__input">
                                    <p>Địa chỉ <span>*</span></p>
                                    <input type="text" placeholder="Địa chỉ cụ thể" class="checkout__input__add" name='address' required>
                                </div>
                                <div class="checkout__input">
                                    <p>Ghi chú </p>
                                    <input type="text" placeholder="Ghi chú về đơn hàng hoặc cách vận chuyển" name='message'>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-6">
                                <div class="checkout__order">
                                    <h4>Hóa đơn</h4>
                                    <div class="checkout__order__products">Số lượng sản phẩm <span></span></div>

                                    <div class="checkout__order__subtotal mb-0" id='checkout__sum'>Tổng <span></span></div>
                                    <div class="checkout__order__subtotal" id='checkout__ship'>Phí ship <span>20000</span></div>
                                    <div class="checkout__order__total">Tổng <span></span></div>
                                    <input type='hidden' value="${listProductIds}" name='listProductIds'>
                                    <button type="submit" class="site-btn" id='order-button'>Đặt hàng</button>
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
                                                        <c:forEach items="${listProducts}" var="product">

                                                            <tr id="row${product.id}">
                                                                <td class="shoping__cart__item row">
                                                                    <img class="col-lg-2 p-0 m-0" src="${product.image}" alt="">
                                                                    <a href="product-detail?productId=${product.productCategoryId}" class="col-lg-6"><h5>${product.name}</h5></a>
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
                            <button type="submit" class="site-btn m-0 p-1"><a href="home" class="primary-btn mx-auto">Trang chủ</a></button><!--  -->
                            <button type="submit" class="site-btn m-0 p-1"><a href="shopping-cart" class="primary-btn mx-auto">Quay lại giỏ hàng</a></button>
                        </div>

                    </form>
                </div>
            </div>
        </section>
        <!-- Checkout Section End -->

        <!-- Footer Section Begin -->
        <%@include file="footer.jsp" %>
        <!-- Footer Section End -->

        <!-- Js Plugins -->
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


            $("#order-button").click(function (event) {
                const swalWithBootstrapButtons = Swal.mixin({
                    customClass: {
                        confirmButton: 'btn btn-success',
                        cancelButton: 'btn btn-danger'
                    },
                    buttonsStyling: false
                })
                event.preventDefault(); // Ngăn chặn việc tải lại trang
                var form = $(this).closest("form");
                var formData = $('#checkout-form').serialize();
                if (!form[0].checkValidity()) {
                    swalWithBootstrapButtons.fire({
                        title: 'Lỗi!',
                        text: 'Vui lòng điền đầy đủ thông tin bắt buộc.',
                        icon: 'error',
                        confirmButtonText: 'Đồng ý'
                    });
                    return;
                }
                

                swalWithBootstrapButtons.fire({
                    title: 'Bạn có chắc chắn muốn đặt hàng?',
                    text: "Bạn có thể hủy hàng trước khi đơn hàng được duyệt!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Yes, delete it!',
                    cancelButtonText: 'No, cancel!',
                    reverseButtons: true
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: '/EcommerceShop/create-bill',
                            type: 'POST',
                            data: formData,
                            // Các thông số khác...
                            success: function (response) {
                                // Xử lý phản hồi
                                console.log(response);
                                //                                alert("Đặt hàng thành công!");
                                // Chuyển hướng người dùng, hiển thị thông báo, v.v...
                                if (response == "true") {
                                    swalWithBootstrapButtons.fire(
                                            'Đã mua!',
                                            'Vào đơn mua để xem tình trạng đơn hàng.',
                                            'success'
                                            ).then((result) => {
                                        if (result.isConfirmed) {
                                            window.location.href = 'home'; // Điều hướng người dùng sau khi nhấn "OK"
                                        }
                                    });
                                } else {
                                    swalWithBootstrapButtons.fire(
                                            'Lỗi',
                                            'Đơn hàng xảy ra lỗi, vui lòng đặt lại',
                                            'error'
                                            )
                                }

                            },
                            error: function (error) {
                                // Xử lý lỗi
                                console.error(error);
                                //                                alert("Đặt hàng không thành công. Vui lòng thử lại.");
                                swalWithBootstrapButtons.fire(
                                        'Lỗi',
                                        'Có trục trặc xảy ra rồi',
                                        'error'
                                        )
                            }
                        });
                    } else if (
                            /* Read more about handling dismissals below */
                            result.dismiss === Swal.DismissReason.cancel
                            ) {
                        swalWithBootstrapButtons.fire(
                                'Canceled',
                                '',
                                'error'
                                )
                    }
                })
            });

        </script>


    </body>

</html>

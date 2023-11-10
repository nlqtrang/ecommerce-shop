<%-- 
    Document   : shopping-cart
    Created on : Oct 29, 2023, 5:41:24 PM
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
    <style>
/* h5.title-clamp {
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 3;
    overflow: hidden;
    text-overflow: ellipsis;
    max-height: 4.5em;
    line-height: 1.5em;
    white-space: normal;
} */
.clamp-title {
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
    line-height: 1.5em; 
    max-height: 4.5em; 
}

.out-of-stock-row {
    opacity: 0.5;
    pointer-events: none;
}

.out-of-stock-row .shoping__cart__item__close {
    pointer-events: all;
}

.out-of-stock-row .icon_close:hover {
    cursor: pointer;
    color: red;  /* Có thể thay đổi màu nếu bạn muốn */
}


    </style>
</head>

<body>

    <%@include file="header.jsp" %>
    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="https://vienkyluc.vn/Userfiles/Upload/images/Download/2020/8/5/df0efb5b03d041aab873879c180fbed3.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Giỏ hàng</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.html">Home</a>
                            <span>Giỏ hàng</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Shoping Cart Section Begin -->
    <form action="check-out" method="post">
    <section class="shoping-cart spad">
        <div class="container">
            <div class="row position-relative">
                <div class="col-lg-12">
                    <div class="shoping__cart__table">
                        <table>
                            <thead>
                                <tr>
                                    <th width="200"><input id="checkall" type="checkbox"><label for="checkall" class="pl-2 pr-2"> Chọn tất cả</label></th>
                                    <th class="shoping__product">Sản phẩm</th>
                                    <th>Đơn giá</th>
                                    <th>Số lượng</th>
                                    <th>Thành tiền</th>
                                    <th>Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listProductsInCart}" var="product">
                                    <c:if test="${product.isStored==true || product.productQuantity==0}">
                                        <tr id="row${product.id}" class="out-of-stock-row">
                                            <td class="pr-2">Sản phẩm này hiện không có sẵn</td>
                                            <td class="shoping__cart__item row">
                                                <img class="col-lg-3 p-0 m-0" src="${product.image}" alt="">
                                                <span class="col-lg-5"><h5>${product.name}</h5></span>
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
                                                <div class="quantity">
                                                    <div class="pro-qty">
                                                        <input type="number" value="${product.quantity}" disabled>
                                                    </div>
                                                </div>
                                                <p style="color: red;" id="message${product.id}"></p>
                                            </td>
                                            <td class="shoping__cart__total" id="total${product.id}">
                                                ${product.total}
                                            </td>
                                            <td class="shoping__cart__item__close" style="opacity: 1;">
                                                <button style="height: 50px; opacity: 1; border: black;" type="button" onclick="deleteProduct(this, ${product.id})"><span style="opacity: 1" class="icon_close"></span></button>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${product.isStored==false && product.productQuantity!=0}">
                                        <tr id="row${product.id}">
                                            <td><input name="checkbox" value="${product.id}" type="checkbox"></td>
                                            <td class="shoping__cart__item row">
                                                <img class="col-lg-3 p-0 m-0" src="${product.image}" alt="">
                                                <a href="product-detail?productId=${product.productCategoryId}" class="col-lg-5"><h5>${product.name}</h5></a>
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
                                                <div class="quantity">
                                                    <div class="pro-qty">
                                                        <input type="number" value="${product.quantity}" min="1" max="${product.productQuantity}" onchange="updateQuantity(this, ${product.id})">
                                                        <input type="hidden" value="${product.productQuantity}" id="max${product.id}">
                                                    </div>
                                                </div>
                                                <p style="color: red;" id="message${product.id}"></p>
                                            </td>
                                            <td class="shoping__cart__total" id="total${product.id}">
                                                ${product.total}
                                            </td>
                                            <td class="shoping__cart__item__close">
                                                <button style="height: 50px;" type="button" onclick="deleteProduct(this, ${product.id})"><span class="icon_close"></span></button>

                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
<!--        <div class="row" style="position: fixed; bottom: 0; background-color: #ccc; z-index: 5; right: 0; left: 0;">
            
            <div class="col-lg-4  my-auto">
                <div class="d-flex justify-content-center">
                    <a href="#" class="primary-btn cart-btn mx-auto">CONTINUE SHOPPING</a>
                    
                </div>
                 <div class="shoping__continue">
                    <div class="shoping__discount">
                        <h5>Discount Codes</h5>
                        <form action="#">
                            <input type="text" placeholder="Enter your coupon code">
                            <button type="submit" class="site-btn">APPLY COUPON</button>
                        </form>
                    </div>
                </div> 
            </div>
            <div class="col-lg-4 d-flex justify-content-center" style="background-color: #ccc;">
                <div class="shoping__checkout p-0 m-2" style="background-color: #ccc;">
                    <h5 class="p-0 m-0">Tổng thanh toán </h5>
                    <p>2 sản phẩm</p>
                    <span style="color: red; font-size: 24px;">240000</span>
                    
                </div>
            </div>
            <div class="col-lg-4 my-auto">
                <a href="#" class="primary-btn">Mua hàng</a>
                <input style="border: none;" type="submit" class="primary-btn" value="Mua hàng">
            </div>
        </div>-->
        <div class="row" style="position: fixed; bottom: 0; background-color: #ccc; z-index: 5; right: 0; left: 0;">
            <div class="col-lg-4 my-auto">
                <div class="d-flex justify-content-center">
                    <a href="home" class="primary-btn cart-btn mx-auto">CONTINUE SHOPPING</a>
                </div>
            </div>
            <div class="col-lg-4 d-flex justify-content-center" style="background-color: #ccc;">
                <div class="shoping__checkout p-0 m-2" style="background-color: #ccc;">
                    <h5 class="p-0 m-0">Tổng thanh toán </h5>
                    <p id="selected-products-count">0 sản phẩm</p>
                    <span id="selected-products-price" style="color: red; font-size: 24px;">0</span>
                </div>
            </div>
            <div class="col-lg-4 my-auto">
                <input id="checkout-button" style="border: none; color: #6f6f6f; background-color: #f5f5f5;" type="submit" class="primary-btn" value="Mua hàng" disabled>
            </div>
        </div>

        </div>
        
    </section>    
    </form>
    
    <!-- Shoping Cart Section End -->

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
    <!--<script src="https://unpkg.com/@popperjs/core@2"></script>-->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        $(document).ready(function(){
            $('#checkall').click(function(){
                if(this.checked){
                    $('input[name=checkbox]').each(function(){
                        this.checked = true;
                    });
                }else{
                    $('input[name=checkbox]').each(function(){
                        this.checked = false;
                    });
                }
            });
        });
        
        function updateQuantity(element, productId) {
            var newQuantity = element.value;
            var max= parseInt(document.querySelector("#max"+productId).value);
            if (newQuantity>max) {
                document.querySelector("#message"+productId).innerHTML="Không được vượt quá "+max;
            } else {
                document.querySelector("#message"+productId).innerHTML="";
                // Gửi dữ liệu sử dụng AJAX
                $.ajax({
                    url: '/EcommerceShop/update-cart', // Đường dẫn tới servlet hoặc controller xử lý cập nhật
                    type: 'POST',
                    data: {
                        'productId': productId,
                        'quantity': newQuantity,
                        'action': 'update'
                    },
                    success: function(response) {
                        // Xử lý khi cập nhật thành công
                        console.log('Cập nhật thành công', response);
                    },
                    error: function(error) {
                        // Xử lý lỗi
                        console.log('Có lỗi xảy ra', error);
                    }
                });
                var price = document.querySelector("#price"+productId);
                document.querySelector("#total"+productId).innerHTML = parseInt(price.textContent) * newQuantity;
            }  
        }
        
        function deleteProduct(element, productId) {
            const swalWithBootstrapButtons = Swal.mixin({
                customClass: {
                  confirmButton: 'btn btn-success',
                  cancelButton: 'btn btn-danger'
                },
                buttonsStyling: false
              })

              swalWithBootstrapButtons.fire({
                title: 'Bạn có muốn xóa sản phẩm này?',
                text: "Sau khi xóa sản phẩm sẽ không còn trong giỏ hàng!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Vâng!',
                cancelButtonText: 'Không!',
                reverseButtons: true
              }).then((result) => {
                if (result.isConfirmed) {
                  swalWithBootstrapButtons.fire(
                    'Đã xóa!',
                    'Sản phẩm đã được xóa khỏi giỏ hàng.',
                    'success'
                  )
                  $.ajax({
                            url: '/EcommerceShop/update-cart', // Đường dẫn tới servlet hoặc controller xử lý cập nhật
                            type: 'POST',
                            data: {
                                'productId': productId,
                                'quantity': 0,
                                'action': 'delete'
                            },
                            success: function(response) {
                                // Xử lý khi cập nhật thành công
                                console.log('Cập nhật thành công', response);
                                document.querySelector('.shopping-cart-quantity').textContent = response;
                            },
                            error: function(error) {
                                // Xử lý lỗi
                                console.log('Có lỗi xảy ra', error);
                            }
                        });
                        document.querySelector("#row"+productId).innerHTML = "";
                } else if (
                  /* Read more about handling dismissals below */
                  result.dismiss === Swal.DismissReason.cancel
                ) {
                  swalWithBootstrapButtons.fire(
                    'Thoát',
                    'Sản phẩm đã không xóa :)',
                    'error'
                  )
                }
              })
            
            
        }
        
        
        document.addEventListener("DOMContentLoaded", function() {
            let checkboxes = document.querySelectorAll("input[name='checkbox']");

            checkboxes.forEach(function(checkbox) {
                checkbox.addEventListener("change", function() {
                    updateSelectedProductsInfo();
                });
            });
        });

        function updateSelectedProductsInfo() {
            let selectedProducts = document.querySelectorAll("input[name='checkbox']:checked");
            let selectedProductsCount = selectedProducts.length;
            let totalPrice = 0.0;

            selectedProducts.forEach(function(productCheckbox) {
                let row = productCheckbox.closest("tr");
                let productPriceElem = row.querySelector(".shoping__cart__total");
                if (productPriceElem) {
                    // Convert the textContent to a double
                    let productPrice = parseFloat(productPriceElem.textContent.replace(/,/g, ""));
                    totalPrice += productPrice;
                }
            });

            document.getElementById("selected-products-count").textContent = selectedProductsCount + " sản phẩm";
            // Format the double to display with 2 decimal places
            document.getElementById("selected-products-price").textContent = totalPrice.toFixed(2);

            // Enable or disable the checkout button based on product selection
            let checkoutButton = document.getElementById("checkout-button");
            checkoutButton.disabled = selectedProductsCount === 0;
            if (selectedProductsCount === 0) {
                checkoutButton.style.backgroundColor='#f5f5f5';
                checkoutButton.style.color='#6f6f6f';
            } else {
                checkoutButton.style.backgroundColor='';
                checkoutButton.style.color='';
            }
        }


    </script>

</body>

</html>

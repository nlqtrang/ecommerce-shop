<%-- 
    Document   : product-detail
    Created on : Oct 23, 2023, 9:49:23 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="model.ProductsCategory" %>
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
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css" />
        <link rel="stylesheet" href="css/nice-select.css" type="text/css" />
        <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css" />
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css" />
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css" />
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <style>
            .variant-button {
                padding: 8px 16px;
                margin: 5px;
                border: 2px solid #ccc;
                border-radius: 16px;
                cursor: pointer;
                background-color: #fff;
            }

            .variant-button.selected {
                background-color: #7fad39;
                color: #fff;
            }

            .carousel-inner img {
                width: 100%;
                height: 100%;
            }

            #custCarousel .carousel-indicators {
                position: static;
                margin-top:20px;
            }

            #custCarousel .carousel-indicators > li {
                width:100px;
            }

            #custCarousel .carousel-indicators li img {
                display: block;
                opacity: 0.5;
            }

            #custCarousel .carousel-indicators li.active img {
                opacity: 1;
            }

            #custCarousel .carousel-indicators li:hover img {
                opacity: 0.75;
            }

            .carousel-item img{

                width:80%;
            }

            .popup {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.7);
            }

            .popup-content {
                background-color: #fff;
                width: 300px;
                margin: 100px auto;
                padding: 20px;
                border: 1px solid #333;
            }

            .close {
                float: right;
                cursor: pointer;
            }

        </style>
    </head>

    <body>
        <!-- Page Preloder -->
        <!-- <div id="preloder">
            <div class="loader"></div>
        </div> -->


        <%@include file="header.jsp" %>

        <div class="body">
            <!-- Product Details Section Begin -->
            <section class="product-details spad">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 col-md-6">
                            <div class="product__details__pic">
                                
                                <div id="custCarousel" class="carousel slide" data-ride="carousel" align="center">
                                    <!-- slides -->
                                    <div>
                                        <div class="carousel-inner">
                                            <div class="carousel-item active">
                                                <img src="${product.image}" alt="Hills">
                                            </div>
                                            <c:forEach items="${product.listImages}" var="image">
                                                <div class="carousel-item">
                                                    <img src="${image.image}" alt="Hills">
                                                </div>
                                            </c:forEach>
                                            <c:set var="count" value="${product.listImages.size()+1}"></c:set>
                                            <c:forEach items="${product.listProducts}" var="prod">
                                                <c:if test="${not empty prod.image}"> 
                                                    <div class="carousel-item">
                                                        <img src="${prod.image}" alt="Hills">
                                                    </div>
                                                    <c:set var="count" value="${count+1}"></c:set>
                                                </c:if>
                                            </c:forEach>
                                        </div>

                                        <!-- Left right -->
                                        <a class="carousel-control-prev my-auto" href="#custCarousel" data-slide="prev" style="background-color: black; height: 100px;">
                                            <span class="carousel-control-prev-icon"></span>
                                        </a>
                                        <a class="carousel-control-next my-auto" href="#custCarousel" data-slide="next" style="background-color: black; height: 100px;">
                                            <span class="carousel-control-next-icon"></span>
                                        </a>
                                    </div>

                                    <ol class="carousel-indicators list-inline">
                                        <li class="list-inline-item active">
                                            <a id="carousel-selector-0" class="selected" data-slide-to="0" data-target="#custCarousel">
                                                <img src="${product.image}" class="img-fluid">
                                            </a>
                                        </li>
                                        <c:forEach items="${product.listImages}" var="image" varStatus="loop">
                                            <li class="list-inline-item">      
                                                <a id="carousel-selector-${loop.count}" data-slide-to="${loop.count}" data-target="#custCarousel">
                                                    <img src="${image.image}" class="img-fluid">
                                                </a>
                                            </li>
                                        </c:forEach>
                                        <c:set var="count" value="${product.listImages.size()+1}"></c:set>
                                        <c:forEach items="${product.listProducts}" var="prod" varStatus="loop">
                                            <c:if test="${not empty prod.image}"> <!--check null vì image của products không phải lúc nào cx có giá trị-->
                                                <li class="list-inline-item">      
                                                    <a id="carousel-selector-${count}" data-slide-to="${count}" data-target="#custCarousel">
                                                        <img src="${prod.image}" class="img-fluid">
                                                    </a>
                                                </li>
                                                <c:set var="count" value="${count+1}"></c:set>
                                            </c:if>

                                        </c:forEach>
                                        

                                </div>

                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6">
                            <div class="product__details__text">

                                <h3 style="font-weight: 600; font-size: 24px;">${product.name}</h3>
                                <div class="product__details__rating">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star-half-o"></i>
                                    <span>(18 đánh giá)</span>
                                    <span class="ml-3" style="color: #000;">${product.quantitySold} đã bán</span>
                                </div>
                                <c:if test="${product.isStored==true}">
                                    <div style="color: red; font-size: 24px;">Sản phẩm này hiện đang ngừng bán!</div>
                                </c:if>
                                <c:if test="${product.quantity==0}">
                                    <div style="color: red; font-size: 24px;">Sản phẩm này hiện đang hết hàng!</div>
                                </c:if>
                                <c:if test="${product.isStored==false && product.quantity!=0}">
                                    <div style="display: flex; align-items: center;">
                                        <c:if test="${product.minPriceOriginal==product.maxPriceOriginal}">
                                            <del id="priceOriginal">${product.minPriceOriginal}</del>
                                        </c:if>
                                        <c:if test="${product.minPriceOriginal!=product.maxPriceOriginal}">
                                            <del id="priceOriginal">${product.minPriceOriginal} - ${product.maxPriceOriginal}</del>
                                        </c:if>
                                        <c:if test="${product.minPrice==product.maxPrice}">
                                            <div class="product__details__price my-auto ml-3" id="price">${product.minPrice}</div>
                                        </c:if>
                                        <c:if test="${product.minPrice!=product.maxPrice}">
                                            <div class="product__details__price my-auto ml-3" id="price">${product.minPrice} - ${product.maxPrice}</div>
                                        </c:if>
                                        <button id="salePrice" class="ml-3" type="button" style="cursor: default; border: none; background: red; color: #fff; border-radius: 18px; font-weight: 700;"> SALE: ${product.salePrice}%</button>
                                    </div>


                                </c:if>
                                <form action="add-product-to-cart" method="post" id='add-form'>
                                    <c:if test="${product.isStored==false && product.quantity!=0}">
                                        <c:forEach items="${product.listProductsVariants}" var="variant">
                                            <h4>${variant.name}</h4>
                                            <div>
                                                <c:forEach items="${variant.listProductsVariantsValues}" var="value">
                                                    <label class="variant-button" onclick="selectVariant(this)">
                                                        ${value.name}
                                                        <input type="radio" style="display: none;" name="${variant.sku}" value="${value.sku}">
                                                    </label>

                                                </c:forEach>
                                            </div>
                                            <input type="hidden" name="variant" value="${variant.sku}">
                                        </c:forEach>
                                        <c:set var="numberOfVariants" value="${fn:length(product.listProductsVariants)}" />
                                        <div class="product__details__quantity mt-4">
                                            <c:if test="${numberOfVariants==0}">
                                                <div class="quantity">
                                                    <div class="pro-qty">
                                                        <input id="quantityButton" name="quantity" type="number" value="1" min="1" max="${product.quantity}"/>
                                                    </div>
                                                </div>
                                                <span>${product.quantity} sản phẩm có sẵn</span>
                                            </c:if>
                                            <c:if test="${numberOfVariants!=0}">
                                                <div class="quantity">
                                                    <div class="pro-qty">
                                                        <input id="quantityButton" name="quantity" type="number" value="1" min="1"/>
                                                    </div>
                                                </div>
                                                <span id="quantity"></span>
                                            </c:if>

                                        </div>
                                        <div id="message" style="color: red; font-size: 20px;"></div>

                                        <input type="hidden" name="productsCategoryId" value="${product.id}">

                                        <c:if test="${numberOfVariants==0}">
                                            <input id="addToCart" style="border: none;" name="submit" type="submit" class="primary-btn mt-5" value="Thêm vào giỏ hàng">
                                        </c:if>
                                        <c:if test="${numberOfVariants!=0}">
                                            <input id="addToCart" style="border: none; background-color: #ccc;" disabled name="submit" type="submit" class="primary-btn mt-5" value="Thêm vào giỏ hàng">
                                        </c:if>
                                        <input type="hidden" name="numberOfVariants" value="${numberOfVariants}" />
                                    </c:if>
                                </form>

                                <ul>
                                    <li><b>Availability</b> <span>In Stock</span></li>
                                    <li>
                                        <b>Shipping</b>
                                        <span>01 day shipping. <samp>Free pickup today</samp></span>
                                    </li>
                                    <li><b>Weight</b> <span>0.5 kg</span></li>
                                    <li>
                                        <b>Share on</b>
                                        <div class="share">
                                            <a href="#"><i class="fa fa-facebook"></i></a>
                                            <a href="#"><i class="fa fa-twitter"></i></a>
                                            <a href="#"><i class="fa fa-instagram"></i></a>
                                            <a href="#"><i class="fa fa-pinterest"></i></a>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="product__details__tab">
                                <ul class="nav nav-tabs" role="tablist">
                                    <li class="nav-item">
                                        <a
                                            class="nav-link active"
                                            data-toggle="tab"
                                            href="#tabs-1"
                                            role="tab"
                                            aria-selected="true"
                                            >Description</a
                                        >
                                    </li>
                                    <li class="nav-item">
                                        <a
                                            class="nav-link"
                                            data-toggle="tab"
                                            href="#tabs-2"
                                            role="tab"
                                            aria-selected="false"
                                            >Information</a
                                        >
                                    </li>
                                    <li class="nav-item">
                                        <a
                                            class="nav-link"
                                            data-toggle="tab"
                                            href="#tabs-3"
                                            role="tab"
                                            aria-selected="false"
                                            >Reviews <span>(1)</span></a
                                        >
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                        <div class="product__details__tab__desc">
                                            <h6>Products Infomation</h6>
                                            <p>${product.description}</p>
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="tabs-2" role="tabpanel">
                                        <div class="product__details__tab__desc">
                                            <h6>Products Infomation</h6>
                                            <p>
                                                Vestibulum ac diam sit amet quam vehicula elementum sed
                                                sit amet dui. Pellentesque in ipsum id orci porta dapibus.
                                                Proin eget tortor risus. Vivamus suscipit tortor eget
                                                felis porttitor volutpat. Vestibulum ac diam sit amet quam
                                                vehicula elementum sed sit amet dui. Donec rutrum congue
                                                leo eget malesuada. Vivamus suscipit tortor eget felis
                                                porttitor volutpat. Curabitur arcu erat, accumsan id
                                                imperdiet et, porttitor at sem. Praesent sapien massa,
                                                convallis a pellentesque nec, egestas non nisi. Vestibulum
                                                ac diam sit amet quam vehicula elementum sed sit amet dui.
                                                Vestibulum ante ipsum primis in faucibus orci luctus et
                                                ultrices posuere cubilia Curae; Donec velit neque, auctor
                                                sit amet aliquam vel, ullamcorper sit amet ligula. Proin
                                                eget tortor risus.
                                            </p>
                                            <p>
                                                Praesent sapien massa, convallis a pellentesque nec,
                                                egestas non nisi. Lorem ipsum dolor sit amet, consectetur
                                                adipiscing elit. Mauris blandit aliquet elit, eget
                                                tincidunt nibh pulvinar a. Cras ultricies ligula sed magna
                                                dictum porta. Cras ultricies ligula sed magna dictum
                                                porta. Sed porttitor lectus nibh. Mauris blandit aliquet
                                                elit, eget tincidunt nibh pulvinar a.
                                            </p>
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="tabs-3" role="tabpanel">
                                        <div class="product__details__tab__desc">
                                            <h6>Products Infomation</h6>
                                            <p>
                                                Vestibulum ac diam sit amet quam vehicula elementum sed
                                                sit amet dui. Pellentesque in ipsum id orci porta dapibus.
                                                Proin eget tortor risus. Vivamus suscipit tortor eget
                                                felis porttitor volutpat. Vestibulum ac diam sit amet quam
                                                vehicula elementum sed sit amet dui. Donec rutrum congue
                                                leo eget malesuada. Vivamus suscipit tortor eget felis
                                                porttitor volutpat. Curabitur arcu erat, accumsan id
                                                imperdiet et, porttitor at sem. Praesent sapien massa,
                                                convallis a pellentesque nec, egestas non nisi. Vestibulum
                                                ac diam sit amet quam vehicula elementum sed sit amet dui.
                                                Vestibulum ante ipsum primis in faucibus orci luctus et
                                                ultrices posuere cubilia Curae; Donec velit neque, auctor
                                                sit amet aliquam vel, ullamcorper sit amet ligula. Proin
                                                eget tortor risus.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Product Details Section End -->
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="sweetalert2.min.css">
        <script>
            function selectVariant(but) {
                var buttons = document.querySelectorAll('.variant-button');
                for (var i = 0; i < buttons.length; i++) {
                    if (buttons[i].querySelector("input").checked && !buttons[i].classList.contains("selected")) {
                        buttons[i].classList.add("selected");
                    } else if (!buttons[i].querySelector("input").checked && buttons[i].classList.contains("selected")) {
                        buttons[i].classList.remove("selected");
                    }

                }
                document.querySelector('#message').innerHTML = "";
                document.querySelector('#quantity').innerHTML = "";

                var sku = '';
                var count = 0;
                for (var i = 0; i < buttons.length; i++) {
                    if (buttons[i].querySelector('input').checked) {
                        var sku_value = buttons[i].querySelector('input').value;
                        var sku_variant = buttons[i].querySelector('input').name;
                        sku += (sku_variant + "_" + sku_value + "$");
                        count++;
                        console.log(count);
                    }
                }

                sku = sku.slice(0, sku.length - 1);
                console.log(sku);
                var productCategoryId = document.querySelector('input[name="productsCategoryId"]').value;
                console.log(document.querySelector('input[name="numberOfVariants"]').value);
                console.log(productCategoryId);
                var skuJSON = JSON.stringify(sku);
                // Gửi yêu cầu Ajax đến servlet với sku
                if (count === parseInt(document.querySelector('input[name="numberOfVariants"]').value)) {
                    document.querySelector('#addToCart').disabled = false;
                    document.querySelector('#addToCart').style.backgroundColor = '';
                    $.ajax({
                        url: '/EcommerceShop/check-is-stored',
                        type: 'POST',
                        async: false,
                        data: {sku: skuJSON, productCategoryId: productCategoryId},
                        success: function (response) {
                            // Xử lý kết quả từ servlet ở đây
                            console.log(response);
                            if (response.quantity === 0) {
                                document.querySelector('#message').innerHTML = "Loại sản phẩm này hiện đang hết hàng!";
                                document.querySelector('#addToCart').disabled = true;
                                document.querySelector('#addToCart').style.backgroundColor = '#ccc';
                                document.querySelector('#price').innerHTML = (response.price * (100 - response.salePrice) / 100);
                                document.querySelector('#priceOriginal').innerHTML = (response.price);
                                document.querySelector('#salePrice').innerHTML = "SALE: " + response.salePrice + "%";
                            } else if (response.isStored === true) {
                                document.querySelector('#message').innerHTML = "Loại sản phẩm này hiện đang ngừng bán!";
                                document.querySelector('#addToCart').disabled = true;
                                document.querySelector('#addToCart').style.backgroundColor = '#ccc';
                                document.querySelector('#price').innerHTML = (response.price * (100 - response.salePrice) / 100);
                                document.querySelector('#priceOriginal').innerHTML = (response.price);
                                document.querySelector('#salePrice').innerHTML = "SALE: " + response.salePrice + "%";
                            } else {
                                document.querySelector('#price').innerHTML = (response.price * (100 - response.salePrice) / 100);
                                document.querySelector('#priceOriginal').innerHTML = (response.price);
                                document.querySelector('#salePrice').innerHTML = "SALE: " + response.salePrice + "%";
                                document.querySelector('#quantity').innerHTML = response.quantity + " sản phẩm có sẵn";
                                document.querySelector('#quantityButton').max = response.quantity;
                            }
                        }
                    });
                }
            }
            
            
            $("#addToCart").click(function (event) {
                event.preventDefault(); // Ngăn chặn việc tải lại trang
                const swalWithBootstrapButtons = Swal.mixin({
                    customClass: {
                        confirmButton: 'btn btn-success',
                        cancelButton: 'btn btn-danger'
                    },
                    buttonsStyling: false
                })
                var formData = $('#add-form').serialize();
                
                
//                swalWithBootstrapButtons.fire({
//                    title: 'Bạn có chắc chắn muốn thêm sản phẩm vào giỏ hàng?',
//                    text: "Bạn có thể xóa sản phẩm trong giỏ hàng!",
//                    icon: 'warning',
//                    showCancelButton: true,
//                    confirmButtonText: 'Có!',
//                    cancelButtonText: 'Không!',
//                    reverseButtons: true
//                }).then((result) => {
//                    if (result.isConfirmed) {
//                        $.ajax({
//                            url: '/EcommerceShop/add-product-to-cart',
//                            type: 'POST',
//                            data: formData,
//                            // Các thông số khác...
//                            success: function (response) {
//                                // Xử lý phản hồi
//                                console.log(response);
//                                //                                alert("Đặt hàng thành công!");
//                                // Chuyển hướng người dùng, hiển thị thông báo, v.v...
//                                if (response.redirect) {
//                                    // Chuyển hướng người dùng
//                                    window.location.href = response.redirect;
//                                } else
//                                if (response == "true") {
//                                    swalWithBootstrapButtons.fire(
//                                        'Đã thêm!',
//                                        'Vào giỏ hàng để mua sản phẩm.',
//                                        'success'
//                                    )
//                                } else {
//                                    swalWithBootstrapButtons.fire(
//                                        'Lỗi',
//                                        'Vui lòng thêm lại vào giỏ hàng',
//                                        'error'
//                                    )
//                                }
//
//                            },
//                            error: function (error) {
//                                // Xử lý lỗi
//                                console.error(error);
//                                //                                alert("Đặt hàng không thành công. Vui lòng thử lại.");
//                                swalWithBootstrapButtons.fire(
//                                        'Lỗi',
//                                        'Có trục trặc xảy ra rồi',
//                                        'error'
//                                        )
//                            }
//                        });
//                    } else if (
//                            /* Read more about handling dismissals below */
//                            result.dismiss === Swal.DismissReason.cancel
//                            ) {
//                        swalWithBootstrapButtons.fire(
//                                'Cancelled',
//                                '',
//                                'error'
//                                )
//                    }
//                })
                $.ajax({
    url: '/EcommerceShop/add-product-to-cart',
    type: 'POST',
    data: formData,
    dataType: 'json', // Đảm bảo kiểu dữ liệu nhận về là JSON
    success: function (response) {
        if (response.status && response.status === "login_required") {
            // Hiển thị thông báo hoặc/ và chuyển hướng
            swalWithBootstrapButtons.fire(
                'Yêu cầu đăng nhập',
                'Bạn cần đăng nhập để thực hiện chức năng này.',
                'info'
            ).then(function() {
                window.location.href = "login"; // Thay đổi đường dẫn nếu cần
            });
        } else if (response.status === true) {
            // Xử lý thành công
            // Cập nhật số lượng sản phẩm trong giỏ hàng
            if (response.newCartTotal !== undefined) {
                // Tìm và cập nhật nội dung số lượng sản phẩm trong giỏ hàng
                document.querySelector('.shopping-cart-quantity').textContent = response.newCartTotal;
            }
            swalWithBootstrapButtons.fire(
                'Đã thêm!',
                'Vào giỏ hàng để mua sản phẩm.',
                'success'
            );
        } else {
            // Xử lý thất bại
            swalWithBootstrapButtons.fire(
                'Lỗi',
                'Vui lòng thêm lại vào giỏ hàng',
                'error'
            );
        }
    },
    error: function (error) {
        // Xử lý lỗi
        console.error(error);
        swalWithBootstrapButtons.fire(
            'Lỗi',
            'Có trục trặc xảy ra rồi',
            'error'
        );
    }
});

            });
        </script>
    </body>
</html>


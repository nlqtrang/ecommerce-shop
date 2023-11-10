<%-- 
    Document   : search
    Created on : Nov 4, 2023, 10:15:46 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
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
            /* Style for labels to look like buttons */
            /* Style for labels to look like buttons */
            .btn-sort {
                display: inline-block;
                padding: 5px 15px;
                margin-right: 5px; /* adjust spacing as needed */
                background-color: #f7f7f7;
                color: #333;
                border: 1px solid #ddd;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
            }

            /* Adjust background and text color for active state */
            .btn-sort:hover,
            .btn-sort.active,
            input[type="radio"]:checked + label {
                background-color: #7fad39;
                color: white;
            }

            /* Styles for the sort options container */
            .sort-options {
                display: inline-block; /* This will align the options horizontally */
            }

            /* Styles for the pagination control */
            #pagination-container {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
            }

            .page-item {
                margin: 0 5px;
                cursor: pointer;
            }

            .page-item.active {
                font-weight: bold;
                color: red;
            }

            #current-page {
                width: 50px;
                text-align: center;
            }


            /* Optional: Clear float */
            .row::after {
                content: "";
                clear: both;
                display: table;
            }

            .pagination-container button {
                background-color: #f2f2f2; /* Light grey background */
                color: #333; /* Dark grey text */
                border: 1px solid #ddd; /* Light grey border */
                text-align: center;
                padding: 8px 16px;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
                border-radius: 5px; /* Rounded corners */
                transition: background-color 0.3s; /* Smooth transition for hover effect */
            }

            .pagination-container button:hover {
                background-color: #ddd; /* Darker grey background on hover */
            }

            .pagination-container input[type="number"] {
                width: 60px; /* Fixed width for the input */
                padding: 8px;
                margin: 4px 2px;
                border: 1px solid #ddd;
                border-radius: 5px;
                text-align: center;
                font-size: 16px;
            }
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

        <!-- Product Section Begin -->
        <section class="product spad">
            <div class="container">
                <form id='form'>
                    <div class="row">

                        <div class="col-lg-3 col-md-5">
                            <div class="sidebar">
                                <div class="sidebar__item">
                                    <h4>Tìm kiếm</h4>
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Search for..." name='search2' onchange='searchEvent()'>
                                        <span class="input-group-btn">
                                            <button class="btn btn-dark" type="button" onclick="searchEvent()">Go!</button>
                                        </span>
                                    </div>

                                </div>
                                <div class="sidebar__item">
                                    <h4>Phân loại</h4>
                                    <ul>
                                        <li class='m-0 w-100'>
                                                <input type='radio' value='' id='type0' name='type' style='display: none;' onclick='searchEvent(this)'>
                                                <label for='type0' class="btn-sort m-0 w-100">Tất cả</label>
                                        </li>
                                        <c:forEach items="${listProductsTypes}" var="type">
                                            <li class='m-0 w-100'>
                                                <input type='radio' value='${type.id}' id='type${type.id}' name='type' style='display: none;' onclick='searchEvent(this)' <c:if test="${currentType==type.id}">checked</c:if>>
                                                <label for='type${type.id}' class="btn-sort m-0 w-100">${type.name}</label>
                                            </li>
                                        </c:forEach>


                                    </ul>
                                </div>
                                <div class="sidebar__item">
                                    <h4>Giá</h4>
                                    <input type="number" class="form-control mb-2" placeholder="Thấp nhất" name='minPrice' onchange='searchEvent()'>
                                    <input type="number" class="form-control" placeholder="Cao nhất" name='maxPrice' onchange='searchEvent()'>

                                </div>


                                <div class="sidebar__item">
                                    <div class="latest-product__text">
                                        <h4>Latest Products</h4>
                                        <div class="latest-product__slider owl-carousel">
                                            <div class="latest-prdouct__slider__item">
                                                <a href="#" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="img/latest-product/lp-1.jpg" alt="">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>Crab Pool Security</h6>
                                                        <span>$30.00</span>
                                                    </div>
                                                </a>
                                                <a href="#" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="img/latest-product/lp-2.jpg" alt="">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>Crab Pool Security</h6>
                                                        <span>$30.00</span>
                                                    </div>
                                                </a>
                                                <a href="#" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="img/latest-product/lp-3.jpg" alt="">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>Crab Pool Security</h6>
                                                        <span>$30.00</span>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="latest-prdouct__slider__item">
                                                <a href="#" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="img/latest-product/lp-1.jpg" alt="">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>Crab Pool Security</h6>
                                                        <span>$30.00</span>
                                                    </div>
                                                </a>
                                                <a href="#" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="img/latest-product/lp-2.jpg" alt="">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>Crab Pool Security</h6>
                                                        <span>$30.00</span>
                                                    </div>
                                                </a>
                                                <a href="#" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="img/latest-product/lp-3.jpg" alt="">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>Crab Pool Security</h6>
                                                        <span>$30.00</span>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-9 col-md-7">
                            <div class="filter__item">
                                <div class="row">
                                    <div class="col-lg-8 col-md-9">
                                        <div class="filter__sort">
                                            <span>Sắp xếp theo: </span>
                                            <div class="sort-options">
                                                <input type="radio" id="newest" name="sort" value="newest" style="display:none;" onclick='searchEvent()'>
                                                <label for="newest" class="btn-sort">Mới Nhất</label>

                                                <input type="radio" id="best-seller" name="sort" value="best-seller" style="display:none;" onclick='searchEvent()'>
                                                <label for="best-seller" class="btn-sort">Bán Chạy</label>

                                                <input type="radio" id="price-high" name="sort" value="price-high" style="display:none;" onclick='searchEvent()'>
                                                <label for="price-high" class="btn-sort">Giá Cao</label>

                                                <input type="radio" id="price-low" name="sort" value="price-low" style="display:none;" onclick='searchEvent()'>
                                                <label for="price-low" class="btn-sort">Giá Thấp</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-3">
                                        <div id="pagination-container-top" class="pagination-container">
                                            <button onclick="changePage('prev')"><<</button>
                                            <input type="number" id="current-page-top" value="1" min="1" name='noPage' onchange="searchEvent();"/>
                                            <span id="total-pages-top">/${page}</span>
                                            <button type='button' onchange="changePage('next');">>></button>
                                        </div>

                                    </div>
                                </div>
                            </div>


                            <input type='hidden' value='${page}' id='numberOfPage' name='page'>
                            
                                <div id="productContent" class="row">
                                    <c:forEach items="${listProducts}" var="productsCategory">
                                        <div class="col-lg-4 col-md-6 col-sm-6">
                                            <div class="product__item">
                                                <a class="prod_cont" href="product-detail?productId=${productsCategory.id}" >
                                                    <div style="background-color: #f5f5f5;">

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
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>




                                <div class="product__pagination">
                                    <div id="pagination-container-bottom" class="pagination-container">
                                        <button onclick="changePage('prev')"><<</button>
                                        <input type="number" id="current-page-bottom" value="1" min="1" onchange="searchEvent();"/>
                                        <span id="total-pages-bottom">/${page}</span>
                                        <button type='button' onchange="changePage('next');">>></button>
                                    </div>
                                </div>
                            
                        </div>
                    </div>
                </form>

        </section>
        <!-- Product Section End -->
        <%@include file="footer.jsp" %>

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
//        $(document).ready(function () {
//            $('input[type="radio"][name="sort"]').click(function () {
//                if ($(this).hasClass('checked')) { // if the radio button is already checked
//                    $(this).prop('checked', false).removeClass('checked'); // uncheck it and remove the 'checked' class
//                } else {
//                    $('input[type="radio"]').removeClass('checked'); // remove 'checked' class from all radio buttons
//                    $(this).addClass('checked'); // add 'checked' class to the clicked radio button
//                }
//            });
//        });
//       
        // Khởi tạo một biến để theo dõi radio button hiện tại được check
let checkedRadioButton = null;

// Thêm sự kiện 'click' cho tất cả các radio buttons
document.querySelectorAll('input[type="radio"][name="sort"]').forEach(radio => {
    radio.addEventListener('click', function(e) {
        // Nếu radio button này đã được check...
        if (checkedRadioButton == this) {
            // ...thì uncheck nó và cập nhật biến theo dõi
            this.checked = false;
            checkedRadioButton = null;
            
            // Gọi hàm searchEvent nếu bạn muốn thực hiện tìm kiếm ngay khi uncheck
            searchEvent();
        } else {
            // Nếu không, cập nhật biến theo dõi với radio button hiện tại
            checkedRadioButton = this;
        }
    });
});



//document.querySelectorAll('.btn-sort').forEach(label => {
//    label.addEventListener('click', function(e) {
//        // Get the associated radio button
//        var radio = document.getElementById(this.getAttribute('for'));
//
//        // If the radio is already checked, uncheck it
//        if (radio.checked) {
//            radio.checked = false;
//            // Since you're manually unchecking, you might want to trigger your search event if needed
//            searchEvent(); // Or pass any parameters if necessary
//        } else {
//            // Radio wasn't checked, let's proceed with default behavior
//            radio.checked = true;
//        }
//    });
//});
//
//// Prevent default behavior of labels which changes radio state
//document.querySelectorAll('.btn-sort').forEach(label => {
//    label.addEventListener('mousedown', function(e) {
//        e.preventDefault();
//    });
//});

        function changePage(action) {
            // Assume totalPages is the total number of pages
            const totalPages = parseInt(document.querySelector("#numberOfPage"));

            let currentPageTop = parseInt(document.getElementById('current-page-top').value);
            let currentPageBottom = parseInt(document.getElementById('current-page-bottom').value);

            // Synchronize top and bottom pagination current page
            let currentPage = currentPageTop === currentPageBottom ? currentPageTop : Math.min(currentPageTop, currentPageBottom);

            if (action === 'next' && currentPage < totalPages) {
                currentPage++;
            } else if (action === 'prev' && currentPage > 1) {
                currentPage--;
            }

            // Update both the top and bottom pagination components
            document.getElementById('current-page-top').value = currentPage;
            document.getElementById('current-page-bottom').value = currentPage;
            // Optionally, you can add your logic here to fetch data based on the new page number
        }

        // Synchronize both paginations on manual page change
        document.getElementById('current-page-top').addEventListener('change', (e) => {
            document.getElementById('current-page-bottom').value = e.target.value;
            // Add your logic here for page change
        });

        document.getElementById('current-page-bottom').addEventListener('change', (e) => {
            document.getElementById('current-page-top').value = e.target.value;
            // Add your logic here for page change
        });

        function searchEvent() {
            var form = $("#form").serialize();
            $.ajax({
                url: '/EcommerceShop/search',
                type: 'POST',
                data: form,
                async: false,
                // Các thông số khác...
                success: function (response) {
                    // Xử lý phản hồi
                    console.log(response);
                    var productContent = document.querySelector('#productContent');
                    productContent.innerHTML = response.data;
                    $('.set-bg').each(function () {
                        var bg = $(this).data('setbg');
                        $(this).css('background-image', 'url(' + bg + ')');
                    });
                    document.querySelector("#numberOfPage").value=parseInt(response.page);
                    document.getElementById('current-page-top').value=parseInt(response.noPage);
                    document.getElementById('current-page-bottom').value=parseInt(response.noPage);
                    document.getElementById('total-pages-top').innerHTML='/'+parseInt(response.page);
                    document.getElementById('total-pages-bottom').innerHTML='/'+parseInt(response.page);
                },
                error: function (xhr, status, error) {
                    // Handle error
                    console.error(xhr.responseText);
                }
            });
        }


        </script>
    </body>
</html>

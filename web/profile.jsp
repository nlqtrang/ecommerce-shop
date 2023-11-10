<%-- 
    Document   : profile
    Created on : Nov 3, 2023, 1:47:32 AM
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
        <link rel="stylesheet" href="./css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="./css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="./css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="./css/nice-select.css" type="text/css">
        <link rel="stylesheet" href="./css/jquery-ui.min.css" type="text/css">
        <link rel="stylesheet" href="./css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="./css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="./css/style.css" type="text/css">
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
            .form-group {
                padding-top: 16px;
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
                        <li class="list-group-item" style='background-color: #7fad39; color: #fff;'>Tài Khoản Của Tôi</li>
                        <li class="list-group-item">Đơn Mua</li>
                        <li class="list-group-item">Đăng xuất</li>
                    </ul>
                </div>
                <!-- Main Content -->
                <div class="col-md-9 mb-5">

                    <div class="container profile-container">
                        <div class="row">
                            <!-- Personal Info -->
                                <c:set var="user" value="${sessionScope.user}"></c:set>
                                <form class="col-md-6" method="post" action='update-profile'>
                                    <h3>Thông Tin Cá Nhân</h3>
                                    <div class="form-group">
                                        <label for="name">Tên:</label>
                                        <input type="text" class="form-control" id="name" name="name" value="${user.name}">
                                    </div>
                                    <div class="form-group">
                                        <label for="username">Tên đăng nhập:</label>
                                        <input type="text" class="form-control" id="username" name="username" value="${user.username}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email:</label>
                                        <input type="text" class="form-control" id="email" name="email" value="${user.email}">
                                    </div>
                                    <div class="form-group">
                                        <label for="address">Địa chỉ:</label>
                                        <input type="text" class="form-control" id="address" name="address" value="${user.address}">
                                    </div>
                                    <div class="form-group">
                                        <label for="gender">Giới tính:</label>
                                        <select class="form-control d-block" name="gender">
                                            <option value='true' ${user.gender == true ? 'selected' : ''}>Nam</option>
                                            <option value='false' ${user.gender == false ? 'selected' : ''}>Nữ</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="phone">Số điện thoại:</label>
                                        <input type="tel" class="form-control" id="phone" name="phone" value="${user.phone}">
                                    </div>
                                    <button class="btn site-btn">Cập nhật</button>
                                    <input type='hidden' value='updateProfile' name='button'>
                                </form>
                                <!-- Update Password -->
                                <form class="col-md-6"  method="post" action='update-profile'>
                                    <h3>Cập Nhật Mật Khẩu</h3>
                                    <div class="form-group">
                                        <label for="currentPassword">Mật khẩu hiện tại:</label>
                                        <input type="password" class="form-control" name="currentPassword">
                                        <p style="color: red;">${message1}</p>
                                    </div>
                                    <div class="form-group">
                                        <label for="newPassword">Mật khẩu mới:</label>
                                        <input type="password" class="form-control" name="newPassword">
                                    </div>
                                    <div class="form-group">
                                        <label for="confirmNewPassword">Xác nhận mật khẩu mới:</label>
                                        <input type="password" class="form-control" name="confirmNewPassword">
                                    </div>
                                    <p style="color: red;">${message2}</p>
                                    <button class="btn site-btn">Cập nhật mật khẩu</button>
                                    <input type='hidden' value='updatePass' name='button'>
                                </form>

                        </div>
                    </div>

                </div>
            </div>

        </div>
        <!-- Footer Section Begin -->
        <%@include file="footer.jsp" %>
        <!-- Footer Section End -->
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>-->
        <script src="./js/jquery-3.3.1.min.js"></script>
        <script src="./js/bootstrap.min.js"></script>
        <!--<script src="./js/jquery.nice-select.min.js"></script>-->
        <script src="./js/jquery-ui.min.js"></script>
        <script src="./js/jquery.slicknav.js"></script>
        <script src="./js/mixitup.min.js"></script>
        <script src="./js/owl.carousel.min.js"></script>
         <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!--<script src="./js/main.js"></script>-->
        <script>
            $('select#gender').niceSelect('destroy');
            function showUpdateSuccess() {
                Swal.fire({
                    title: 'Thành công!',
                    text: 'Đã cập nhật thành công.',
                    icon: 'success',
                    confirmButtonText: 'OK'
                });
            }
        </script>
        <c:if test="${isUpdated==true}">
            <script>
                showUpdateSuccess();
            </script>
        </c:if>
    </body>

</html>


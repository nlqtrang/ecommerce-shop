<%-- 
    Document   : users-manager
    Created on : Nov 9, 2023, 2:50:35 PM
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
        <style>
            /* Style for the select element */
select.w100 {
  width: 100%; /* Make select box width 100% of its parent */
  padding: 8px 12px; /* Add some padding inside the select box */
  margin: 5px 0; /* Add some margin around the select box */
  border: 1px solid #cccccc; /* Add a border to the select box */
  border-radius: 4px; /* Slightly round the corners */
  background-color: white; /* Set a background color */
  font-size: 16px; /* Increase font size */
  -webkit-appearance: none; /* Remove default style in webkit browsers */
  -moz-appearance: none; /* Remove default style in Mozilla browsers */
  appearance: none; /* Remove default style for the select dropdown */
  cursor: pointer; /* Change cursor to pointer to indicate it's a dropdown */
}

/* Add a pseudo-element for custom arrow */
select.w100::-ms-expand {
  display: none; /* For IE11, remove the default arrow */
}

/* Style for select box on hover */
select.w100:hover {
  border-color: #888888; /* Darken the border a bit when hovering */
}

/* Style for select box when it gains focus */
select.w100:focus {
  outline: none; /* Remove default focus outline */
  border-color: #555555; /* Darken the border when focused */
  box-shadow: 0 0 3px #aad6ff; /* Add a subtle glow/shadow to indicate focus */
}

/* You may need a container for custom arrow

        </style>
    </head>
    <body class="sb-nav-fixed">
        <%@include file="header.jsp" %>
        <div id="layoutSidenav">
            <%@include file="navbar.jsp" %>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">User</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="dashboard">User</a></li>
                            <li class="breadcrumb-item active">Tables</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Danh sách users của web
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>Tên</th>
                                            <th>username</th>
                                            <th>password</th>
                                            <th>role</th>
                                            <th>số điện thoại</th>
                                            <th>Bị cấm?</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>Tên</th>
                                            <th>username</th>
                                            <th>password</th>
                                            <th>role</th>
                                            <th>số điện thoại</th>
                                            <th>Bị cấm?</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <c:forEach items="${listUsers}" var="user">
                                            <tr>
                                                <td>${user.name}</td>
                                                <td>${user.username}</td>
                                                <td>${user.password}</td>
                                                <td><select class="w100" onchange="changeRole(${user.id}, this)">
                                                        <option ${user.role==0 ? "selected" : ""} value="0">Admin</option>
                                                        <option ${user.role==1 ? "selected" : ""} value="1">Staff</option>
                                                        <option ${user.role==2 ? "selected" : ""} value="2">User</option>
                                                    </select></td>
                                                <td>${user.phone}</td>
                                                <td><select class="w100" onchange="changeIsBanned(${user.id}, this)">
                                                        <option ${user.isBanned==true ? "selected" : ""}>true</option>
                                                        <option ${user.isBanned==false ? "selected" : ""}>false</option>
                                                    </select></td>
                                            </tr>
                                        </c:forEach>
                                        
                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="admin/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="admin/js/datatables-simple-demo.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function changeRole(userId, select) {
    // Show a confirmation dialog
        Swal.fire({
            title: 'Bạn có chắc chắn?',
            text: 'Bạn có muốn cập nhật role của user này không?',
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
                            'User role đã được cập nhật.',
                            'success'
                        ).then((result) => {
            // If confirmed, redirect or perform the cancel action
            if (result.isConfirmed) {
//                window.location.href = "change-order?orderId="+orderId+"&status="+select.value;
//                        }})
                    $.ajax({
                            url: '/EcommerceShop/update-user', // Đường dẫn tới servlet hoặc controller xử lý cập nhật
                            type: 'GET',
                            data: {
                                'userId': userId,
                                'role': select.value,
                                'option': 'role'
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
                }})
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                // If canceled, do something else or nothing
                Swal.fire(
                    'Đã Giữ Lại',
                    'Role không thay đổi :)',
                    'error'
                );
            }
        });
    }
    
    function changeIsBanned(userId, select) {
    // Show a confirmation dialog
        Swal.fire({
            title: 'Bạn có chắc chắn?',
            text: 'Bạn có muốn thay đổi lệnh cấm user này không?',
            icon: 'warning',
            showCancelButton: true, // Show the Cancel button
            confirmButtonText: 'Có, thay đổi!',
            cancelButtonText: 'Không, giữ lại!',
            reverseButtons: true
        }).then((result) => {
            // If confirmed, redirect or perform the cancel action
            if (result.isConfirmed) {


                Swal.fire(
                            'Đã Cập nhật!',
                            'User role đã được cập nhật.',
                            'success'
                        ).then((result) => {
            // If confirmed, redirect or perform the cancel action
            if (result.isConfirmed) {
//                window.location.href = "change-order?orderId="+orderId+"&status="+select.value;
//                        }})
                    $.ajax({
                            url: '/EcommerceShop/update-user', // Đường dẫn tới servlet hoặc controller xử lý cập nhật
                            type: 'GET',
                            data: {
                                'userId': userId,
                                'isBanned': select.value,
                                'option': 'isBanned'
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
                }})
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                // If canceled, do something else or nothing
                Swal.fire(
                    'Đã Giữ Lại',
                    'Lệnh cấm không cập nhật :)',
                    'error'
                );
            }
        });
    }
        </script>
    </body>
</html>
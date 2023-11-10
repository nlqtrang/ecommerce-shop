<%-- 
    Document   : products-manager
    Created on : Nov 6, 2023, 5:00:56 PM
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
            .tm-product-edit-input {
    margin-top: 10px;
    display: block;
}

.tm-product-edit-ok {
    margin-top: 10px;
    display: inline-block;
    cursor: pointer;
}

        </style>
    </head>
    <body class="sb-nav-fixed">
        <%@include file="header.jsp" %>
        <div id="layoutSidenav">
            <%@include file="navbar.jsp" %>
            <div id="layoutSidenav_content">
                <div class="container mt-5">
                    <div class="row tm-content-row">
                        <div class="col-sm-12 col-md-12 col-lg-9 col-xl-9 tm-block-col">
                            <div class="tm-bg-primary-dark tm-block tm-block-products">
                                <div class="tm-product-table-container" style="height: 500px; overflow-y: scroll;">
                                    <table class="table table-hover tm-table-small tm-product-table" >
                                        <thead>
                                            <tr>
                                                <th scope="col">Ảnh</th>
                                                <th scope="col">Tên</th>
                                                <th scope="col">Đã bán</th>
                                                <th scope="col">Số lượng</th>
                                                <th scope="col">Giá</th>
                                                <th scope="col">lưu trữ?</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listProducts}" var="product">
                                                <tr class="tm-product-name" data-id="${product.id}">
                                                    <td class="col-lg-1"><img class="img-fluid" src="${product.image}" alt=""></td>
                                                    <td class="tm-product-name">${product.name}</td>
                                                    <td>${product.soldQuantity}</td>
                                                    <td>${product.quantity}</td>
                                                    <td>${product.minPrice}</td>
                                                    <td>
                                                        ${product.isStored}
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            
                                            
                                        </tbody>
                                    </table>
                                </div>
                                <!-- table container -->
                                <a
                                    href="add-new-product"
                                    class="btn btn-primary btn-block text-uppercase mb-3 mt-3">Thêm mới sản phẩm</a>

                            </div>
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-3 col-xl-3 tm-block-col">
                            <div class="tm-bg-primary-dark tm-block tm-block-product-categories">
                                <h2 class="tm-block-title">Danh mục sản phẩm</h2>
                                <div class="tm-product-table-container" style="max-height: 500px; overflow-y: scroll;">
                                    <table class="table tm-table-small tm-product-table">
                                        <tbody>
                                            <c:forEach items="${listTypes}" var="type">
                                                <tr>
                                                    <td class="tm-product-name">${type.name}</td>
                                                    <td class="text-center">
                                                        <a href="add-new-category?deleteid=${type.id}" class="tm-product-delete-link">
                                                            <i class="far fa-trash-alt tm-product-delete-icon"></i>
                                                        </a>
                                                    </td>
                                                    <td class="text-center">
                                                        <a href="javascript:void(0);" onclick="editType(${type.id}, this)" class="tm-product-edit-link tm-product-delete-link">
                                                            <i class="fas fa-edit tm-product-delete-icon"></i>
                                                        </a>
                                                    </td>

                                                </tr>
                                            </c:forEach>
                                            
                                            
                                        </tbody>
                                    </table>
                                </div>
                                <!-- table container -->
                                <form action="add-new-category" method="post">
                                    <input type="text" placeholder="Add new category" class="form-control mb-2" name="newCategory">
                                    <button class="btn btn-primary btn-block text-uppercase mb-3">
                                        Thêm mới danh mục
                                    </button>
                                </form>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="admin/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="admin/assets/demo/chart-area-demo.js"></script>
        <script src="admin/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="admin/js/datatables-simple-demo.js"></script>
        <script>
            document.querySelectorAll(".tm-product-name").forEach(function(element) {
                element.addEventListener("click", function() {
                  // Giả sử rằng ID sản phẩm được lưu trữ trong một thuộc tính data-id của phần tử.
                  var id = this.getAttribute('data-id');
                  window.location.href = "edit-product?productId=" + id;
                });
            });
            
            function editType(typeId, element) {
                // Check if edit input already exists
                if (document.getElementById('edit-input-' + typeId)) {
                    return;
                }

                // Create the input element
                var input = document.createElement('input');
                input.type = 'text';
                input.id = 'edit-input-' + typeId;
                input.className = 'tm-product-edit-input';
                input.value = ''; // You can set it to an existing value if needed

                // Create the OK button
                var okButton = document.createElement('button');
                okButton.textContent = 'OK';
                okButton.className = 'tm-product-edit-ok';
                okButton.onclick = function() {
                    // Perform the redirect with the input's value
                    var editValue = input.value;
                    window.location.href = 'add-new-category?id=' + typeId + '&newValue=' + encodeURIComponent(editValue);
                };

                // Add the input and button to the document, you might want to add it somewhere specific
                element.closest('td').appendChild(input);
                element.closest('td').appendChild(okButton);
            }

        </script>
    </body>
</html>

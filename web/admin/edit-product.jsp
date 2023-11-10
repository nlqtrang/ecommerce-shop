<%-- 
    Document   : edit-product
    Created on : Nov 6, 2023, 10:07:07 PM
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
        <!-- include libraries(jQuery, bootstrap) -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>

        <style>
            /* Base styles to reset and set a clean slate */
            /* Base styles to reset and set a clean slate */
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline;
}

/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure, 
footer, header, hgroup, menu, nav, section {
    display: block;
}

body {
    line-height: 1;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f4f4f4; /* Light grey background */
    color: #333; /* Dark grey text */
}

/* Container and alignment styles */
#layoutSidenav_content {
    margin: 0 auto;
    padding: 2rem;
}

/* Form styling */
#layoutSidenav_content form {
    background: #fff;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

#layoutSidenav_content input[type=text], select {
    width: 100%;
    padding: 0.75rem;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

#layoutSidenav_content input[type=submit] {
    width: 100%;
    background-color: #4CAF50; /* Green background */
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

#layoutSidenav_content input[type=submit]:hover {
    background-color: #45a049;
}

/* Table styles */
table {
    width: 100%;
    border-collapse: collapse;
}

table, th, td {
    border: 1px solid #ddd;
}

th {
    height: 50px;
    text-align: left;
    background-color: #f2f2f2; /* Light grey background for headers */
    color: black;
}

td, th {
    padding: 15px;
    text-align: left;
}

/* Buttons */
.add-btn {
    background-color: #007bff;
    color: white;
    padding: 0.375rem 0.75rem;
    margin: 0.375rem;
    border: none;
    border-radius: 0.25rem;
    cursor: pointer;
    transition: background-color 0.15s ease-in-out;
}

.add-btn:hover {
    background-color: #0056b3; /* Darken the button color on hover */
    color: #fff;
}

#layoutSidenav_content .btn-warning {
    background-color: #ffc107; /* Bootstrap warning color */
}

#layoutSidenav_content .btn-danger {
    background-color: #dc3545; /* Bootstrap danger color */
}

#layoutSidenav_content .btn-info {
    background-color: #17a2b8; /* Bootstrap info color */
}

/* Responsive layout */
@media (max-width: 768px) {
    #layoutSidenav_content {
        padding: 1rem;
    }

    .col-lg-6, .col-lg-12 {
        padding: 1rem;
    }

    input[type=submit] {
        width: auto;
    }
}

/* Typography */
#layoutSidenav_content h1, h2, h3, h4, h5, h6 {
    color: #333;
    margin-top: 0.5rem;
    margin-bottom: 0.5rem;
    font-weight: normal;
    line-height: 1.2;
}

#layoutSidenav_content h1 {
    font-size: 2.5rem;
}

.center {
    text-align: center;
}

.img-fluid {
    max-width: 100%;
    height: auto;
}

/* Misc classes for spacing */
.mt-5 {
    margin-top: 3rem;
}

.p-3 {
    padding: 1rem;
}

.p-5 {
    padding: 3rem;
}

#layoutSidenav_content .input-auto {
    display: block;
    width: auto;
    margin-bottom: 1rem;
}

/* Styling for unchecked state */
#category label {
    display: inline-block;
    background-color: #f2f2f2; /* Normal state background */
    padding: 10px;
    margin-bottom: 5px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease; /* Smooth transition for background color */
}

/* Styling for checked state using the :checked pseudo-class and adjacent sibling combinator */
#category input[type="checkbox"]:checked + label {
    background-color: #4CAF50; /* Checked state background */
    color: #fff;
}

/* Hide the checkbox visually but remain accessible */
#category input[type="checkbox"] {
    display: none;
}

#summernote button {
    background-color: #fff !important;
    color: #000 !important;
    }

        </style>
    </head>
    <body class="sb-nav-fixed">
        <%@include file="header.jsp" %>
        <div id="layoutSidenav">
            <%@include file="navbar.jsp" %>
            <div id="layoutSidenav_content">
                <center class='mt-5'><h1>Sửa sản phẩm</h1></center>
                <form method="post" action="edit-product" class='row p-0 m-0'>
                    <div class="col-lg-6 p-3">
                        Tên: <input class='input-auto' type="text" value="${product.name}" name='productName'><br>
                        Ảnh <input class='input-auto' type="text" value="${product.image}" name='productImage'> <br>
                        Mô tả 
                        <!--<input class='input-auto' type="text" value="${product.description}" name='productDescription'>--> 
                        <textarea id="summernote" name='productDescription' style="background-color: #fff; color: #000;">${product.description}</textarea>
                        <br>
                        Lưu trữ? <select name='productIsStored'>
                            <option value="true">True</option>
                            <option value="false" ${product.isStored eq false ? "selected" : ""}>False</option>
                        </select> <br>
                        <input type="hidden" value="${product.id}" name="id">
                        
                        <div id="category">
                            Danh mục 
                            <c:forEach items="${listTypes}" var="type">
                                <input type="checkbox" id="type${type.id}" name="type" value="${type.id}" class="hidden-checkbox" ${listTypesByProductsCategoryId.contains(type.id)?"checked":""}>
                                <label for="type${type.id}">${type.name}</label>
                            </c:forEach>

                        </div>
                        <img class="img-fluid mt-5" src="${product.image}" alt="alt"/>
                    </div>
                    <div class='col-lg-6 p-3'>
                        <h2>Variants</h2>
                        <input type="text" id="new-variant-name" placeholder="Enter new variant name">
                        <input type="text" id="sku-variant" placeholder="Enter sku">
                        <button type="button" class="add-btn" id="add-variant-btn">Thêm biến thể</button>

                        <!-- Parent container for all variant options -->
                        <div id="variants-container">
                            <!-- Individual variant options will be added here -->
                            <c:catch>
                                <c:forEach items="${product.listProductsVariants}" var="variant">
                                <div class="variant form-control m-3">
                                    <h3>${variant.name} (${variant.sku})</h3>
                                    <input type="hidden" name="variant_name" value="${variant.name} (${variant.sku})">
                                    <button type="button" class='btn btn-danger btn-sm btn-delete' onclick='deleteVariant(this)'>Xóa</button>
                                    <button type='button' class='btn btn-info btn-sm btn-update' onclick='updateVariant(this)'>Sửa</button>
                                    <div class='edit-variant'></div>
                                    <ul>
                                        <!-- Individual option values will be added here -->
                                        <c:forEach items="${variant.listProductsVariantsValues}" var="option">
                                            <li>${option.name} (${option.sku})</li>
                                            <button type="button" class="btn btn-danger btn-sm btn-delete" onclick="deleteOption(this)">Xóa</button>
                                            <button type='button' class='btn btn-info btn-sm btn-update' onclick='updateOption(this)'>Sửa</button>
                                            <div class='edit-option'></div>
                                            <input type="hidden" name="${variant.sku}" value="${option.name} (${option.sku})">
                                        </c:forEach>

                                    </ul>
                                    <input type="text" placeholder="Option value">
                                    <input type="text" placeholder="Option SKU">
                                    <button type="button" class="add-btn" onclick="addOption(this)">Thêm option</button>
                                </div>
                            </c:forEach>
                            </c:catch>
                        </div>
                    </div>
                    

                    <div class='col-lg-12 p-5'>
                        <button type="button" class='btn btn-warning' id="generate-products-btn">Tạo sản phẩm</button>

                        <table id="products-table">
                            <thead>
                                <tr>
                                    <th>Sku</th>
                                    <th>Name</th>
                                    <th>Price</th>
                                    <th>Image</th>
                                    <th>Quantity</th>
                                    <th>Quantity Sold</th>
                                    <th>Sale Price</th>
                                    <th>is stored</th>

                                </tr>
                            </thead>
                            <tbody>
                                <!-- Generated products will go here -->
                            </tbody>
                        </table>
                        <input class='btn btn-warning' type="submit" value="update">
                    </div>

                    
                </form>
            </div>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="admin/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="admin/assets/demo/chart-area-demo.js"></script>
        <script src="admin/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="admin/js/datatables-simple-demo.js"></script>
        <script type="text/javascript">
            function addOption(button) {
                var newOptionValue = button.previousElementSibling.previousElementSibling.value.trim();
                var newOptionSku = button.previousElementSibling.value.trim();
                if (newOptionValue && newOptionSku) {
                    var optionItem = document.createElement('li');
                    optionItem.textContent = newOptionValue + " (" + newOptionSku + ")";
                    var optionsList = button.parentNode.querySelector("ul");
                    
                    optionsList.appendChild(optionItem);
                    optionsList.innerHTML += "<button type='button' class='btn btn-danger btn-sm btn-delete' onclick='deleteOption(this)'>Xóa</button>"
                    optionsList.innerHTML += "<button type='button' class='btn btn-info btn-sm btn-update' onclick='updateOption(this)'>Sửa</button>"
                    optionsList.innerHTML += "<div class='edit-option'></div>"
                    optionsList.innerHTML += "<input type='hidden' name='option_name' value='" + newOptionSku + "'>";
                    button.previousElementSibling.previousElementSibling.value = '';
                    button.previousElementSibling.value = '';
                } else {
                    alert('Please enter both an option value and an option SKU.');
                }
            }
            
            document.addEventListener('DOMContentLoaded', function () {
                var addVariantBtn = document.getElementById('add-variant-btn');
                var newVariantNameInput = document.getElementById('new-variant-name');
                var newVariantSkuInput = document.getElementById('sku-variant'); // Đây nên là ID đúng của input
                var variantsContainer = document.getElementById('variants-container');

                addVariantBtn.addEventListener('click', function () {
                    // Get the new variant name and SKU from the input
                    var newVariantName = newVariantNameInput.value.trim();
                    var newVariantSku = newVariantSkuInput.value.trim();

                    // Check if the new variant name and SKU are not empty
                    if (newVariantName && newVariantSku) {
                        // Create the new variant container
                        var variantDiv = document.createElement('div');
                        variantDiv.classList.add('variant');
                        variantDiv.classList.add('form-control');
                        variantDiv.classList.add('m-3');

                        // Add the variant name title
                        var variantTitle = document.createElement('h3');
                        variantTitle.textContent = newVariantName + " (" + newVariantSku + ")";
                        variantDiv.appendChild(variantTitle);
                        variantDiv.innerHTML += "<input type='hidden' name='variant_name' value='" + newVariantName + " (" + newVariantSku + ")" + "'>";
                        // Container for the options and SKUs
                        variantDiv.innerHTML += "<button type='button' class='btn btn-danger btn-sm btn-delete' onclick='deleteVariant(this)'>Xóa</button>";
                        variantDiv.innerHTML += "<button type='button' class='btn btn-info btn-sm btn-update' onclick='updateVariant(this)'>Sửa</button>";
                        variantDiv.innerHTML += "<div class='edit-variant'></div>";
                        var optionsList = document.createElement('ul');
                        variantDiv.appendChild(optionsList);

                        // Input for adding a new option value to this variant
                        var optionInput = document.createElement('input');
                        optionInput.type = 'text';
                        optionInput.placeholder = 'Option value';
                        variantDiv.appendChild(optionInput);

                        // Input for adding a new option SKU to this variant
                        var optionSkuInput = document.createElement('input');
                        optionSkuInput.type = 'text';
                        optionSkuInput.placeholder = 'Option SKU';
                        variantDiv.appendChild(optionSkuInput);

                        // Button to add a new option value and SKU to this variant
                        var addOptionBtn = document.createElement('button');
                        addOptionBtn.textContent = 'Add option';
                        addOptionBtn.type='button';
                        addOptionBtn.classList.add("add-btn");
                        variantDiv.appendChild(addOptionBtn);

                        // Append the complete variant div to the variants container
                        variantsContainer.appendChild(variantDiv);

                        // Clear the inputs for the new variant
                        newVariantNameInput.value = '';
                        newVariantSkuInput.value = '';

                        // Add click event listener to 'Add option' button for this variant
                        addOptionBtn.addEventListener('click', function () {
                            console.log("hello");
                            var newOptionValue = optionInput.value.trim();
                            var newOptionSku = optionSkuInput.value.trim();
                            if (newOptionValue && newOptionSku) {
                                var optionItem = document.createElement('li');
                                optionItem.textContent = newOptionValue + " (" + newOptionSku + ")";

                                optionsList.appendChild(optionItem);

                                optionsList.innerHTML += "<button type='button' class='btn btn-danger btn-sm btn-delete' onclick='deleteOption(this)'>Xóa</button>"
                                optionsList.innerHTML += "<button type='button' class='btn btn-info btn-sm btn-update' onclick='updateOption(this)'>Sửa</button>"
                                optionsList.innerHTML += "<div class='edit-option'></div>"
                                optionsList.innerHTML += "<input type='hidden' name='"+newVariantSku+"' value='" + newOptionValue + " (" + newOptionSku + ")" + "'>";
                                optionInput.value = '';
                                optionSkuInput.value = '';
                            } else {
                                alert('Please enter both an option value and an option SKU.');
                            }

                        });
                    } else {
                        alert('Please enter both a variant name and a variant SKU.');
                    }
                });
            });

            function deleteOption(button) {

                // Tìm phần tử li đứng trước nút button
                var liToDelete = button.previousElementSibling;

                liToDelete.remove();
                var button2 = button.nextElementSibling;
                button2.nextElementSibling.nextElementSibling.remove();
                button2.nextElementSibling.remove();
                button.nextElementSibling.remove();
                button.remove();
            }
            
            function deleteVariant(button) {
                button.parentNode.remove();
            }
            
            function updateVariant(button) {
                
                button.nextElementSibling.innerHTML += "<input type='text'><input type='button' onclick='submitUpdate(this)' value='OK'>";
                
            }
            
            function submitUpdate(button1) {
                var newValue = button1.previousElementSibling.value;
                var currentText = button1.parentNode.parentNode.querySelector("h3").textContent;
                var newText = newValue +" "+ currentText.substring(currentText.indexOf("("));
                button1.parentNode.parentNode.querySelector("h3").textContent=newText;
                button1.parentNode.parentNode.querySelector("h3").nextElementSibling.value=newText;
                button1.parentNode.innerHTML="";
            }
            
            function updateOption(button) {
                button.nextElementSibling.innerHTML += "<input type='text'><input type='button' onclick='submitUpdate2(this)' value='OK'>";
                
            }
            function submitUpdate2(button1) {
                var newValue = button1.previousElementSibling.value;
                var currentText = button1.parentNode.previousElementSibling.previousElementSibling.previousElementSibling.textContent;
                var newText = newValue +" "+ currentText.substring(currentText.indexOf("("));
                button1.parentNode.previousElementSibling.previousElementSibling.previousElementSibling.textContent=newText;
                button1.parentNode.nextElementSibling.value=newText;
                button1.parentNode.innerHTML="";
                
            }

            document.getElementById('generate-products-btn').addEventListener('click', function () {
                // Find all variant containers
                var variants = document.querySelectorAll('.variant');
                var variantOptions = [];

                // Loop through each variant to collect the option values and SKUs
                variants.forEach(function (variant) {
                    var variantSku = variant.querySelector('h3').textContent.match(/\((.*?)\)$/)[1]; // Assuming variant title is in the format "Variant Name (VariantSKU)"
                    var options = variant.querySelectorAll('li');
                    var optionValues = [];
                    options.forEach(function (option) {
                        var optionMatch = option.textContent.match(/^(.*?) \((.*?)\)$/);
                        if (optionMatch) {
                            var value = optionMatch[1];
                            var optionSku = optionMatch[2];
                            optionValues.push({value, sku: variantSku + "_" + optionSku});
                        }
                    });
                    if (optionValues.length > 0) {
                        variantOptions.push(optionValues);
                    }
                });

                // Calculate the cartesian product to get all combinations
                var combinations = cartesianProduct(variantOptions);
                var listProducts;
                try {
                  listProducts = ${listProductsJson};
                } catch (error) {
                  console.error("Parsing error:", error);
                }
                console.log(listProducts);
                // Use the combinations to build the table rows
                var productsTableBody = document.getElementById('products-table').querySelector('tbody');
                productsTableBody.innerHTML = ''; // Clear existing table rows

                combinations.forEach(function (combination) {
                    var tr = document.createElement('tr');

                    // Generate the SKU by concatenating variant SKUs and option SKUs
                    var sku = combination.map(function (option) {
                        return option.sku;
                    }).join('$');

                    // Generate the name by concatenating the option values
                    var name = combination.map(function (option) {
                        return option.value;
                    }).join(' ');
                    if (!sku) sku=null;
                    // Placeholder for actual logic to get price, quantity, sales, and image
                    var price = '';
                    var quantity = '';
                    var sales = '';
                    var imagePlaceholder = 'path/to/image.png'; // Replace with actual image path
                    var product= listProducts[sku];
                    console.log(product);
                    tr.innerHTML = `<td>\${sku||""}<input type="hidden" name="sku" value="\${sku||""}"></td>
                            <td>\${name}</td>
                            <td><input type="text" name="price" value="\${product?.price||""}"></td>
                            <td><input type="text" name="image" value="\${product?.image||""}"></td>
                            <td><input type="text" name="quantity" value="\${product?.quantity||"0"}"></td>
                            <td>\${product?.quantitySold||""}</td>
                            <td><input type="text" name="salePrice" value="\${product?.salePrice||""}"></td>
                            <td><input type="checkbox" name="isStored" \${product?.isStored===true ? "checked" : ""} value="\${product?.isStored===true ? sku : 0}" onclick="this.value = this.checked ? '\${sku}' : '0';" ></td>`;

//tr.innerHTML = `<td>${sku}<input type="hidden" name="sku" value="${sku}"></td>
//                        <td>${name}</td>
//                        <td><input type="text" class="price" value="${price}"></td>
//                        <td><input type="text" class="price"></td>
//                        <td><input type="text" class="quantity" value="${quantity}"></td>
//                        <td><input type="text" class="quantity" value="${quantity}"></td>
//                        <td><input type="text" class="sales" value="${sales}"></td>
//                        <td><input type="checkbox" class="stored" value="${sales}"></td>
//                        `;
                    productsTableBody.appendChild(tr);
                });
            });

            function cartesianProduct(arr) {
                return arr.reduce(function (a, b) {
                    return a.map(function (x) {
                        return b.map(function (y) {
                            return x.concat([y]);
                        });
                    }).flat();
                }, [[]]);
            }
            
            document.addEventListener('DOMContentLoaded', function() {
                // Get all checkboxes
                var checkboxes = document.querySelectorAll('input[type="checkbox"]');

                checkboxes.forEach(function(checkbox) {
                    checkbox.addEventListener('change', function() {
                        // When a checkbox is changed, toggle the 'checked' class on the next sibling label
                        if (checkbox.checked) {
                            checkbox.nextElementSibling.style.backgroundColor = "#4CAF50"; // Checked color
                        } else {
                            checkbox.nextElementSibling.style.backgroundColor = "#f2f2f2"; // Unchecked color
                        }
                    });
                });
            });
$('#summernote').summernote();
        </script>
    </body>
</html>


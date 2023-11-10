<%-- 
    Document   : navbar
    Created on : Nov 9, 2023, 10:29:50 PM
    Author     : DELL
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <a class="nav-link" href="dashboard">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Tổng quan
                </a>
                <div class="sb-sidenav-menu-heading">Quản lý</div>
                <c:if test="${sessionScope.user.role==0}">
                    <a class="nav-link" href="users-manager">
                        <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                        Quản lý các tài khoản
                    </a>
                </c:if>
                <a class="nav-link" href="orders-manager">
                    <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                    Quản lý đơn hàng
                </a>
                <a class="nav-link" href="products-manager">
                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                    Quản lý sản phẩm
                </a>
                <div class="sb-sidenav-menu-heading">Trang cá nhân</div>
                <a class="nav-link" href="profile">
                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                    Trang cá nhân
                </a>
                <a class="nav-link" href="logout">
                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                    Đăng xuất
                </a>
            </div>
        </div>
    </nav>
</div>

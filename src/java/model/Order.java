/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.OrdersDAO;
import java.util.List;

/**
 *
 * @author DELL
 */
public class Order {
    private int id, userId;
    private String createdAt, shippingDate, shippedDate;
    
    private String status;
    
    
    private String name, address, phone, message;
    private List<ProductsInCartDTO> listOrdersDetails;
    public Order() {
    }

    public Order(int id, int userId, String createdAt, String shippingDate, String shippedDate, String status, String name, String address, String phone, String message) {
        this.id = id;
        this.userId = userId;
        this.createdAt = createdAt;
        this.shippingDate = shippingDate;
        this.shippedDate = shippedDate;
        this.status = status;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.message = message;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getShippingDate() {
        return shippingDate;
    }

    public void setShippingDate(String shippingDate) {
        this.shippingDate = shippingDate;
    }

    public String getShippedDate() {
        return shippedDate;
    }

    public void setShippedDate(String shippedDate) {
        this.shippedDate = shippedDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<ProductsInCartDTO> getListOrdersDetails() {
        return listOrdersDetails;
    }

    public void setListOrdersDetails() {
        this.listOrdersDetails = new OrdersDAO().listOrdersDetails(userId, id);
    }
    
    
    
}

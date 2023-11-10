/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

public class OrderDTO {
    private int id, userId, statusId;
    private String status;
    private double price;
    private List<ProductsInCartDTO> listOrdersDetails;

    public OrderDTO() {
    }

    public OrderDTO(int id, int userId, int statusId, String status,double price, List<ProductsInCartDTO> listOrdersDetails) {
        this.id = id;
        this.userId = userId;
        this.statusId=statusId;
        this.status = status;
        this.price=price;
        this.listOrdersDetails = listOrdersDetails;
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

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }
    

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    

    public List<ProductsInCartDTO> getListOrdersDetails() {
        return listOrdersDetails;
    }

    public void setListOrdersDetails(List<ProductsInCartDTO> listOrdersDetails) {
        this.listOrdersDetails = listOrdersDetails;
    }
    
}

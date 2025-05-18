package com.RadiantDreams.model;

import java.sql.Timestamp;
import java.util.List;

public class OrderModel {
    private int id;
    private String customerUsername;
    private Timestamp orderDate;
    private List<OrderDetailModel> orderDetails;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCustomerUsername() {
        return customerUsername;
    }

    public void setCustomerUsername(String customerUsername) {
        this.customerUsername = customerUsername;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public List<OrderDetailModel> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetailModel> orderDetails) {
        this.orderDetails = orderDetails;
    }
}

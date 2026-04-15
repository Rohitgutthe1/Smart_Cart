package model;

import java.util.Date;
import java.util.List;

public class Order {

    private int id;
    private int userId;
    private double totalPrice;
    private String status;
    private Date date;

    // Extra: List of items in this order
    private List<OrderItem> items;

    // Default Constructor
    public Order() {
    }

    // Full Constructor
    public Order(int id, int userId, double totalPrice, String status, Date date) {
        this.id = id;
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.status = status;
        this.date = date;
    }

    // Constructor without ID (for insert)
    public Order(int userId, double totalPrice, String status) {
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.status = status;
    }

    // Getters and Setters

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

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
}
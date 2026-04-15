package model;

public class Product {

    private int id;
    private String name;
    private String description;
    private double price;
    private int categoryId;
    private String image;

    // Default Constructor
    public Product() {
    }

    // Parameterized Constructor
    public Product(int id, String name, String description, double price, int categoryId, String image) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.categoryId = categoryId;
        this.image = image;
    }

    // Constructor without ID (for insert)
    public Product(String name, String description, double price, int categoryId, String image) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.categoryId = categoryId;
        this.image = image;
    }

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
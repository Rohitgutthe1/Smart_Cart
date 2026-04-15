package model;

public class Category {

    private int id;
    private String name;

    // Default Constructor
    public Category() {
    }

    // Parameterized Constructor (with ID)
    public Category(int id, String name) {
        this.id = id;
        this.name = name;
    }

    // Constructor without ID (for insert)
    public Category(String name) {
        this.name = name;
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
}
package com.RadiantDreams.model;

import java.time.LocalDate;

public class CustomerModel {

    private int id;
    private String firstName;
    private String lastName;
    private String username;
    private LocalDate dob;
    private String gender;
    private String email;
    private String phone;     // updated from phoneNumber
    private String password;
    private String address;   // updated from subject
    private String image;

    public CustomerModel() {}

    public CustomerModel(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public CustomerModel(int id, String firstName, String lastName, String username, LocalDate dob, String gender,
                         String email, String phone, String password, String address, String image) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.username = username;
        this.dob = dob;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.address = address;
        this.image = image;
    }

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}

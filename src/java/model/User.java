/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DELL
 */
public class User {
    private int id;
    private String name;
    private String email;
    private String username;
    private String password;
    private int role;
    private String phone;
    private boolean isBanned;
    private String address;
    private boolean gender;

    public User() {
    }

    public User(int id, String name, String email, String username, String password, int role, String phone, boolean isBanned, String address, boolean gender) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.username = username;
        this.password = password;
        this.role = role;
        this.phone = phone;
        this.isBanned = isBanned;
        this.address=address;
        this.gender=gender;
    }

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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public boolean isIsBanned() {
        return isBanned;
    }

    public void setIsBanned(boolean isBanned) {
        this.isBanned = isBanned;
    }

    public String getAddress() {
        return address;
    }

    public boolean isGender() {
        return gender;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }
    
    
    
    
}

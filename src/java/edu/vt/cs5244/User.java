/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.vt.cs5244;

/**
 *
 * @author christopherbritz
 */
public class User {
    
    private String username;
    private String password;
    private String mobile;
    
    public User(){
        
    }

    User(String un, String pw, String mobile) {
        this.username = un;
        this.password = pw;
        this.mobile = mobile;
    }
    
    public String getUserName(){
        return this.username;
    }
    
    public void setUserName(String username){
        this.username = username;
    }
    
    public String getPassword(){
        return this.password;
    }
    
    public void setPassword(String password){
        this.password = password;
    }
          
    public String getMobile(){
        return this.mobile;
    }
    public void setMobile(String mobile){
        this.mobile = mobile;
    }
}

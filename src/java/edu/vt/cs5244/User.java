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
    private String phone1;
    private String phone2;
    private String phone3;
    
    
    public User(){
        
    }

    User(String un, String pw, String phone1, String phone2, String phone3) {
        this.username = un;
        this.password = pw;
        this.phone1 = phone1;
        this.phone2 = phone2;
        this.phone3 = phone3;
                
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
          
    public String getPhone1(){
        return this.phone1;
    }
    public void setPhone1(String phone1){
        this.phone1 = phone1;
    }
        
    public String getPhone2(){
        return this.phone2;
    }
    public void setPhone2(String phone2){
        this.phone2 = phone2;
    }    
    
    public String getPhone3(){
        return this.phone3;
    }
    public void setMobile(String phone3){
        this.phone3= phone3;
    }
}

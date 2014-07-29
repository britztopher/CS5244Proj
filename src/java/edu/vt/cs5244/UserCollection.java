/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.vt.cs5244;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author christopherbritz
 */
public class UserCollection {
    
    private final Map<String, User> userMap;
    
    public UserCollection(){
        
        this.userMap = new HashMap<>();
    }
    
    synchronized 
    public Map<String, User> getUserMap(){
        return this.userMap;
    }
            
}

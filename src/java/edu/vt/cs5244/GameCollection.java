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
public class GameCollection {
    
    private final Map<Integer, Game> gameMap;
    
    public GameCollection(){
        this.gameMap = new HashMap<>();
    }
    
    synchronized 
    public Map<Integer, Game> getGameMap(){
        return this.gameMap;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.vt.cs5244;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author christopherbritz
 */
public class GameCollection {
    
    private final Map<Integer, Game> gameMap;
    
    public GameCollection(Game game){
        this.gameMap = new HashMap<>();
        this.gameMap.put(game.getGameId(), game);
    }
    
     
    public synchronized Map<Integer, Game> getGameMap(){
        return this.gameMap;
    }
    
    public synchronized Integer getMaxId(){
        
        Integer maxKey = Integer.MIN_VALUE;
        
        for(Integer id : gameMap.keySet()){
            if(id > maxKey){
                maxKey = id;
            }
        }
        
        System.out.println("MAXKEY: "+ maxKey);
        
        return (Integer)maxKey;
    }
    
}

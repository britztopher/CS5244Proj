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
        
        return maxKey;
    }
    
    public synchronized HashMap<Integer, Game> getAcceptedGamesByUser(String user){
        HashMap<Integer, Game> acceptedMap = new HashMap<>();
        
        for(Game game : this.gameMap.values()){
            
            if(game.getAcceptor()!= null && game.getAcceptor().equals(user)){
                acceptedMap.put(game.getGameId(), game);
            }
        }
        
        return acceptedMap;
    }
    
    public synchronized HashMap<Integer, Game> getOfferedGames(String user){
        HashMap<Integer, Game> offeredMap = new HashMap<>();
        
        for(Game game : this.gameMap.values()){
            
            if(game.getAcceptor()==null){
                offeredMap.put(game.getGameId(), game);
            }
        }
        
        return offeredMap;
    }
    
}

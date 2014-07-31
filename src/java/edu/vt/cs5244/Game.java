/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.vt.cs5244;

import edu.vt.cs5244.util.HW3HtmlDAB;
import edu.vt.cs5244.util.ProjHtmlDAB;

/**
 *
 * @author christopherbritz
 */
public class Game {
    
    private String userNameOne;
    private String userNameTwo;
    private int gameId;
    private String offerorUN;
    private final DABEngine theDAB;
    private final int boardSize;
    
    public Game(int size){
        
        theDAB = new ProjHtmlDAB(new HW3HtmlDAB(new SafeHW1_DAB(new HW1_DAB())));
        theDAB.init(size);
        this.boardSize = size;
    }
    
    public ProjHtmlDAB getTheDAB(){
        
        return (ProjHtmlDAB)theDAB;
    }
    
    public int getGameId(){
        return this.gameId;
    }
    
    public void setGameId(int gameId){
        this.gameId = gameId;
    }
    
    public String getUserNameOne(){
        return this.userNameOne;
    }
        
    public void setUserNameOne(String userNameOne){
        this.userNameOne = userNameOne;
    }
        
    public String getUserNameTwo(){
        return this.userNameTwo;
    }
    
    public void getUserNameTwo(String userNameTwo){
        this.userNameTwo = userNameTwo;
    }
        
    public String getOfferorUN(){
        return this.offerorUN;
    }
    
    public void setOfferorUN(String offerorUN){
        this.offerorUN = offerorUN;
    }
        
    public int getBoardSize(){
        return this.boardSize;
    }   
}

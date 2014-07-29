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
    private DABEngine theDAB;
    
    public Game(int size){
        
        theDAB = new ProjHtmlDAB(new HW3HtmlDAB(new SafeHW1_DAB(new HW1_DAB())));
        theDAB.init(size);
    }
    
    public ProjHtmlDAB getTheDAB(){
        
        return (ProjHtmlDAB)theDAB;
    }
    
}

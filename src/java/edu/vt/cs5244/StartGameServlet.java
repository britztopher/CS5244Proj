/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.vt.cs5244;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author christopherbritz
 */
public class StartGameServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
         
         //get the Session object
        HttpSession session = request.getSession();

        //get the context
        ServletContext application = getServletConfig().getServletContext();
        
        //request parameters
        String size = request.getParameter("size");
        String dabCmd = request.getParameter("command");
        String dabCol = request.getParameter("draw_col");
        String dabRow = request.getParameter("draw_row");
        String dabEdge = request.getParameter("draw_edge");
        String dabSize = request.getParameter("init_size");
       
        try{
            
            Game thisGame = (Game)session.getAttribute("game");
            GameCollection gameMap = (GameCollection)application.getAttribute("gameMap");
            
            if(thisGame == null){
                thisGame = new Game(Integer.parseInt(size));
                session.setAttribute("game", thisGame);
                response.sendRedirect("../startGame.jsp?status=initMv"); return;
            }
             
            if (dabCmd.equalsIgnoreCase("draw")) {
               
                try {
                    thisGame.getTheDAB().drawEdge(Integer.parseInt(dabRow), Integer.parseInt(dabCol), Util.parseEdge(dabEdge));
                    response.sendRedirect("../startGame.jsp?status=drawsuccess");
                    return;

                } catch (NumberFormatException nfe) {
                    response.sendRedirect("../startGame.jsp?status=drawnfe");
                    return;
                }
                
            } else if("offerGame".equalsIgnoreCase(dabCmd)){
                
                if(gameMap == null){
                    //since no game exists yet set gameId = 1 for the first game
                    thisGame.setGameId(1);
                    
                    //TODO: maybe need a check for null on loggedInUser incase of session timeout?
                    thisGame.setOfferorUN((String)session.getAttribute("loggedInUser"));
                    //instantiate the game collection for the first time passing
                    //in the first game
                    gameMap = new GameCollection(thisGame);
                    //set the application object, so we can find this collection
                    //later on
                    application.setAttribute("gameMap", gameMap);
                    session.removeAttribute("game");
                   
                    response.sendRedirect("../offeredGames.jsp");
                    return;
                }else{
                    //get MaxId in the keyset of the map and add 1
                    thisGame.setGameId(gameMap.getMaxId()+1);
                    thisGame.setOfferorUN((String)session.getAttribute("loggedInUser"));
                    
                    gameMap.getGameMap().put(thisGame.getGameId(), thisGame);
                    session.removeAttribute("game");
                    response.sendRedirect("../offeredGames.jsp"); return;
                }

            }else if("resetGame".equalsIgnoreCase(dabCmd)){
                session.removeAttribute("game");
                response.sendRedirect("../startGame.jsp"); return;
                
            }else {
                response.sendRedirect("../startGame.jsp?status=invalidCmd");
                return;

            }
            
        }catch (DABException dabe) {
            session.setAttribute("message", "INIT: Board Size of " + dabSize + " not Supported.");
        } catch (NumberFormatException nfe) {
            session.setAttribute("message", "INIT: Size value must be numeric");
        } catch (NullPointerException npe) {
            session.setAttribute("message", "Please select a Valid Command.");
        }
        
        response.sendRedirect("../startGame.jsp");
        return;
    
    }
        
                

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

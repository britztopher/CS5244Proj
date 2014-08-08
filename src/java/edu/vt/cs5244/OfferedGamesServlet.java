/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.vt.cs5244;

import java.io.IOException;
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
public class OfferedGamesServlet extends HttpServlet {

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
        String gameId = request.getParameter("gameId");
        String cmd = request.getParameter("cmd");
       
        try{
            GameCollection gameMap = (GameCollection)application.getAttribute("gameMap");
            Game game;
            game = gameMap.getGameMap().get(Integer.parseInt(gameId));
            
            if("retract".equals(cmd) && session.getAttribute("loggedInUser").equals(game.getOfferorUN())){
                
                if(game.getAcceptor()!=null){
                    response.sendRedirect("../offeredGames.jsp?status=accepted"); return;
                }
                
                gameMap.getGameMap().remove(game.getGameId());
                response.sendRedirect("../offeredGames.jsp?status=success"); return;
            }else{
                response.sendRedirect("../offeredGames.jsp?status=notyours"); return;
            }
            
        }catch(NumberFormatException nfe){
            response.sendRedirect("../offeredGames.jsp?status=idnotnum"); return;
        }catch(NullPointerException npe){
            response.sendRedirect("../offeredGames.jsp?status=gamenull"); return;
        }
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

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
public class AcceptGameServlet extends HttpServlet {

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
        String cmd = request.getParameter("command");
        
       
        try{
            GameCollection gameMap = (GameCollection)application.getAttribute("gameMap");
            Game game = gameMap.getGameMap().get(Integer.parseInt(gameId));
            
            game.getGameId();
            if("normal".equals(cmd)){
                game.setUserNameTwo((String)session.getAttribute("loggedInUser"));
                game.setUserNameOne(game.getOfferorUN());
                game.setAcceptor((String)session.getAttribute("loggedInUser"));
            }else if("reversed".equals(cmd)){
                game.setUserNameTwo(game.getOfferorUN());
                game.setUserNameOne((String)session.getAttribute("loggedInUser"));
                game.setAcceptor((String)session.getAttribute("loggedInUser"));
            }else{
                //invalid command
            }
            
            response.sendRedirect("../playGame.jsp?gameId="+gameId); return;
            
        }catch(NumberFormatException nfe){
            response.sendRedirect("../acceptGame.jsp?status=gamenfe"); return;
        }catch(NullPointerException npe){
            response.sendRedirect("../offeredGames.jsp?status=gameremoved");
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

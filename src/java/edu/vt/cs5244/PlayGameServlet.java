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
public class PlayGameServlet extends HttpServlet {

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
        String dabCol = request.getParameter("draw_col");
        String dabRow = request.getParameter("draw_row");
        String dabEdge = request.getParameter("draw_edge");
        boolean isDrawn = false;
        
       
        try{
            GameCollection gameMap = (GameCollection)application.getAttribute("gameMap");
            Game game = gameMap.getGameMap().get(Integer.parseInt(gameId));
            
            if ("draw".equals(cmd)) {

                Player turn = null;
                
                try {

                    turn = game.getTheDAB().getTurn();
                    isDrawn = game.getTheDAB().drawEdge(Integer.parseInt(dabRow), Integer.parseInt(dabCol), Util.parseEdge(dabEdge));

                    if (!isDrawn) {
                        //, "DRAW(" + dabRow + ", " + dabCol + ", " + dabEdge + ") Line Already Drawn."
                         response.sendRedirect("../playGame.jsp?status=edgeexists&gameId="+gameId); return;
                    } else {
                        //"DRAW(" + dabRow + ", " + dabCol + ", " + dabEdge + ") Success!"
                        response.sendRedirect("../playGame.jsp?status=edgeDrawn&gameId="+gameId); return;
                    }
                } catch (DABException dabe) {
                    if (turn == null) {
                        //Game is over
                        response.sendRedirect("../playGame.jsp?status=gameovr&gameId="+gameId); return;
                    } else if ( dabEdge == null){
                        //"DRAW: Edge value must be selected from clickable grid."
                        response.sendRedirect("../playGame.jsp?status=edgeErr&gameId="+gameId);return;
                    }else if( dabEdge.equalsIgnoreCase("none")){
                        //DRAW: Edge value must be selected from the drop-down box.
                        response.sendRedirect("../playGame.jsp?status=edgenone&gameId="+gameId); return;                        
                    }else{
                        //DRAW: Location is Out of Bounds.
                        response.sendRedirect("../playGame.jsp?status=edgeoob&gameId="+gameId); return;                   
                    }
                } catch (NumberFormatException nfe) {
                    //"DRAW: Row and Col values must both be numeric.
                    response.sendRedirect("../playGame.jsp?status=edgenfe&gameId="+gameId); return;
                }

            } else {
                //Please select a Valid Command
                response.sendRedirect("../playGame.jsp?status=invldcmd&gameId="+gameId); return;

            }
            
        }catch(NumberFormatException nfe){
            //Could not parse gameid
            response.sendRedirect("../playGame.jsp?status=gamenfe&gameId="+gameId); return;
        }catch(NullPointerException npe){
            response.sendRedirect("../offeredGames.jsp?status=gamedne&gameId="+gameId); return;
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.vt.cs5244;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
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
public class RegistServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private static final String redirectAddy = "registration.jsp?status=";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
         //get the Session object
        HttpSession session = request.getSession();

        //get the context
        ServletContext application = getServletConfig().getServletContext();
        UserCollection userMap;
        
        //request parameters
        String un = request.getParameter("un");
        String pw = request.getParameter("pw");
        String mobile = request.getParameter("mobile");
        
        //set the session object atrributes for login form redirect on failed 
        //registration attempt
        session.setAttribute("un", un);
        session.setAttribute("pw", pw);
        session.setAttribute("mobile", mobile);
        
        
         //User Collection
        if(application.getAttribute("userMap") == null){
            userMap = new UserCollection();
            application.setAttribute("userMap", userMap);
        }else{
            userMap = (UserCollection)application.getAttribute("userMap");
        }
        
       
//        if(un.isEmpty() || pw.isEmpty()){
//            response.sendRedirect(redirectAddy+"emptyField"); return;
//        }else if(un.length() < 3 || un.length() >16){
//            response.sendRedirect(redirectAddy+"unLength");
//        }
        
        User user = userMap.getUserMap().get(un);
        
        //if username doesnt exist in collection yet
        //TODO: Need to inclue check for valid fields so this should be after 
        //validation
        if(user==null){
            User thisUser = new User(un, pw, mobile);
            ((UserCollection)application.getAttribute("userMap")).getUserMap().put(un, thisUser);
            response.sendRedirect("../registration/registration.jsp?success=yes"); return;
        }else{//if user exists then we need to send back dup msg
            
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

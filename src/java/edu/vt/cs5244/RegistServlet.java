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
        String phone1 = request.getParameter("phone1");
        String phone2 = request.getParameter("phone2");
        String phone3 = request.getParameter("phone3");
        
        //set the session object atrributes for login form redirect on failed 
        //registration attempt
        session.setAttribute("un", un);
        session.setAttribute("pw", pw);
        session.setAttribute("phone1", phone1);
        session.setAttribute("phone2", phone2);
        session.setAttribute("phone3", phone3);
       
         //User Collection
        if(application.getAttribute("userMap") == null){
            userMap = new UserCollection();
            application.setAttribute("userMap", userMap);
        }else{
            userMap = (UserCollection)application.getAttribute("userMap");
        }
        
        try{
            //check to make sure all are numbers
            Integer.parseInt(phone1);
            Integer.parseInt(phone2);
            Integer.parseInt(phone3);
          
            //catch npe and message the user to enter all fields
            Integer phoneNumTotal = phone1.length()+phone2.length()+phone3.length();

            if(un.isEmpty() || pw.isEmpty()){
                response.sendRedirect("../registration/registration.jsp?status=emptyField"); return;
            }else if(un.length() < 3 || un.length() >16){
                session.removeAttribute("un");
                session.removeAttribute("pw");
                response.sendRedirect("../registration/registration.jsp?status=unLength");return;
            }else if(!un.matches("^[A-Za-z0-9_]+$")){
                session.removeAttribute("un");
                response.sendRedirect("../registration/registration.jsp?status=invldun");return;
            }else if(pw.length() < 5  || pw.length() > 5 ){
                session.removeAttribute("pw");
                response.sendRedirect("../registration/registration.jsp?status=lengthpw");return;
            }else if(phoneNumTotal != 10){
                session.removeAttribute("phone1");
                session.removeAttribute("phone2");
                session.removeAttribute("phone3");
                response.sendRedirect("../registration/registration.jsp?status=phonelength");return;
//            }else if(pw.matches("(\\d\\w+,{0,2})")){
//                TODO: I just cant seem to find a regex to check on a string for if it contains 2 letters and 2 numbers.
//                right now just letting any password as long as its exactly 5
//                session.removeAttribute(pw);
//                response.sendRedirect("../registration/registration.jsp?status=phoneletsnums");return;
              }

            User user = userMap.getUserMap().get(un);

            //if username doesnt exist in collection yet
            //TODO: Need to inclue check for valid fields so this should be after 
            //validation
            if(user==null){
                User thisUser = new User(un, pw, phone1, phone2, phone3);
                ((UserCollection)application.getAttribute("userMap")).getUserMap().put(un, thisUser);

                //remove session attributes so fields are blank
                session.removeAttribute("un");
                session.removeAttribute("pw");
                session.removeAttribute("phone1");
                session.removeAttribute("phone2");
                session.removeAttribute("phone3");

                response.sendRedirect("../registration/registration.jsp?success=yes"); return;
            }else{//if user exists then we need to send back dup msg
                response.sendRedirect("../registration/registration.jsp?status=unexists"); return;
            }
        }catch(NullPointerException npe){
                session.removeAttribute("phone1");
                session.removeAttribute("phone2");
                session.removeAttribute("phone3");
                response.sendRedirect("../registration/registration.jsp?status=phonefields"); return;
        }catch(NumberFormatException nfe){
                session.removeAttribute("phone1");
                session.removeAttribute("phone2");
                session.removeAttribute("phone3");
                response.sendRedirect("../registration/registration.jsp?status=phonenums"); return;
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

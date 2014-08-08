<%-- 
    Document   : gameError
    Created on : Aug 3, 2014, 11:17:28 AM
    Author     : christopherbritz
--%>

<%@page import="edu.vt.cs5244.Util"%>
<%@page import="edu.vt.cs5244.Game"%>
<%@page import="edu.vt.cs5244.GameCollection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.addHeader("Cache-control", "no-cache");%>
<%  String user = (String)session.getAttribute("loggedInUser");
    if(user==null){ //no authentication, thus no authorization
        response.sendRedirect("../login/login.jsp"); return;
    }
%>
    
        <%  
            String gameId = request.getParameter("gameId");
            String isYourTurn = "NO";
            
            GameCollection gameMap = (GameCollection)application.getAttribute("gameMap"); 
            try{
                
                Integer id = Integer.parseInt(gameId);
                Game game = gameMap.getGameMap().get(id);
                
//                out.write("YES");
                
                if(game.whosTurn().equals(user)){
                    isYourTurn ="YES";
                }else if(game.whosTurn() ==null){
                    isYourTurn = "GAME OVER";
                }
            
            }catch(NullPointerException npe){
                
            }catch(NumberFormatException nfe){
                response.sendRedirect("offeredGames.jsp"); return;
                 
            }
         %>

<%=isYourTurn%>
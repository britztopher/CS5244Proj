<%-- 
    Document   : playgame
    Created on : Jul 31, 2014, 5:37:09 PM
    Author     : christopherbritz
--%>

<%@page import="edu.vt.cs5244.GameCollection"%>
<%@page import="edu.vt.cs5244.Game"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  String user = (String)session.getAttribute("loggedInUser");
    if(user==null){ //no authentication, thus no authorization
        response.sendRedirect("../login/login.jsp"); return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Play Game Page</title>
    </head>
    <body>
        <h1>Hello <%=user%>!</h1>
        
        <%  
            String gridDisplay = null;
            String gameId = request.getParameter("gameId");
            String playerOne = null;
            String playerTwo = null;
            String whosTurn = null;
            
            try{
                Integer id = Integer.parseInt(gameId);
            
                GameCollection gameMap = (GameCollection)application.getAttribute("gameMap"); 
                Game game = gameMap.getGameMap().get(id);
                playerOne = game.getUserNameOne();
                playerTwo = game.getUserNameTwo();
                
                if(game == null){
                    gridDisplay = "Game is Null in Game Collection.  Contact Admin for Help.";
                }else if(game.whosTurn().equals(user)){
                    gridDisplay = game.getTheDAB().toString("PlayGameServlet", "gameId", gameId);
                }else{
                    gridDisplay = game.getTheDAB().toString();
                }
            }catch(NumberFormatException nfe){
                //couldnt parse the gameid for some reason
            } 
            
            
         %>
         
         <%=gridDisplay%>
         ONE <%=
         
        <h2><a href="mainplayer.jsp">Current Games</a></h2>
        <h2><a href="completedGames.jsp">Completed Games</a></h2>
        <h2><a href="offeredGames.jsp">Offered Games</a></h2>
        <a href="mainPlayer.jsp">Refresh</a><br>
        <a href="edu.vt.cs5244.Login">Logout</a>
    </body>
</html>

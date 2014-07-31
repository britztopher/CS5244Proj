<%-- 
    Document   : offerred
    Created on : Jul 27, 2014, 9:58:09 PM
    Author     : christopherbritz
--%>

<%@page import="edu.vt.cs5244.Game"%>
<%@page import="edu.vt.cs5244.GameCollection"%>
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
        <title>Offered Games Page</title>
       
    </head>
    <body>
        <h1>Welcome <%=user%>!</h1>
        <h2>Offered Games</h2>
         <%  
            GameCollection gameMap = (GameCollection)application.getAttribute("gameMap"); 
            %><ul><%
            if(gameMap == null){
                //offer a new Game link
            }else{
                //display collection of games
                for(Game game : gameMap.getOfferedGames(user).values()){
                    String href = "acceptGame.jsp?gameId="+game.getGameId();
                    //if the logged in user is the one that offered the game
                    //dont show href link to accept page
                    if(session.getAttribute("loggedInUser").equals(game.getOfferorUN())){
                        %><li><b><%=game.getOfferorUN()%></b>:&nbsp;Game #<%=game.getGameId()%>&nbsp;(size&nbsp;<%=game.getBoardSize()%>)</li><%
                    }else{
                        %><li><%=game.getOfferorUN()%>:&nbsp;<a href="<%=href%>">Game #<%=game.getGameId()%>&nbsp;(size&nbsp;<%=game.getBoardSize()%>)</a></li><%
                    }
                }   
            }
            %><li><a href="startGame.jsp">Offer New Game</a></li>    
            <ul/><%
           
        %>
       
    </body>
</html>

<%-- 
    Document   : mainplayer
    Created on : Jul 27, 2014, 10:41:48 AM
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
        <title>Main Page</title>
    </head>
    <body>
        <%  
            GameCollection gameMap = (GameCollection)application.getAttribute("gameMap"); 
            %><ul><%
            if(gameMap == null){
                //offer a new Game link
            }else{
                //display collection of games
                for(Game game : gameMap.getAcceptedGamesByUser(user).values()){
                    String href = "playgame.jsp?gameId="+game.getGameId();
                    
                    if(session.getAttribute("loggedInUser").equals(game.getOfferorUN())){
                        %><li><b><%=game.getOfferorUN()%></b>:&nbsp;Game #<%=game.getGameId()%>&nbsp;(size&nbsp;<%=game.getBoardSize()%>)</li><%
                    }else{
                        //show link
                        %><li><%=game.getOfferorUN()%>:&nbsp;<a href="<%=href%>">Game #<%=game.getGameId()%>&nbsp;(size&nbsp;<%=game.getBoardSize()%>)</a></li><%
                    }
                }   
            }
            %><li><a href="startGame.jsp">Offer New Game</a></li>    
            <ul/><%
           
        %>
        <h1>Welcome <%=user%>!</h1>
        <h2>Current Games</h2>
        <h3>My Turn:</h3>
        <ul>
        
        </ul>
        
        <h3>Opponent's Turn:</h3>
        <ul>
        
        </ul>
        <h2><a href="completedGames.jsp">Completed Games</a></h2>
        <h2><a href="offeredGames.jsp">Offered Games</a></h2>
        <a href="mainPlayer.jsp">Refresh</a><br>
        <a href="edu.vt.cs5244.Login">Logout</a>
    </body>
</html>
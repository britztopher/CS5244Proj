<%-- 
    Document   : acceptGame
    Created on : Jul 30, 2014, 8:16:15 PM
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
        <title>Accept Page</title>
    </head>
    <body>
        <h1>Welcome <%=user%>!</h1>
        <h2>Accept a Game</h2>
         <%  
            String gridDisplay = null;
            String gameOfferor = null;
            String gameId = request.getParameter("gameId");
            Integer id = Integer.parseInt(gameId);
            
            GameCollection gameMap = (GameCollection)application.getAttribute("gameMap"); 
            Game game = gameMap.getGameMap().get(id);
            
            if(game == null){
                gridDisplay = "Game is Null in Game Collection.  Contact Admin for Help.";
            }else{
                gridDisplay = game.getTheDAB().toString();
                gameOfferor = game.getOfferorUN();
            }
         %>
         
         <%=gridDisplay%>
         Game #<%=gameId%> (offered by <%=gameOfferor%>)
         
         <h3>Accept this game as:</h3>
         <br/>
         <ul>
             <li><a href="servlet/edu.vt.cs5244.AcceptGameServlet?command=normal&gameId=<%=gameId%>">Normal</a>: You will be player TWO, and you will move next</li>
             <li><a href="servlet/edu.vt.cs5244.AcceptGameServlet?command=reversed&gameId=<%=gameId%>">Reversed</a>: You will be player ONE, and the move above will become your first move</li>
         </ul>
    </body>
</html>

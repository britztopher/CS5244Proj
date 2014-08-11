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
        <link rel='stylesheet' href='../css/bootstrap.min.css' type='text/css'/>
        <link rel='stylesheet' href='../css/style.css' type='text/css'/>
        <title>Offered Games Page</title>
       
    </head>
    <body>
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4">
                <h1>Welcome <%=user%>!</h1>
                <h2>Offered Games</h2>
            </div>
            <div class="row">
                <div class="col-lg-4 col-lg-offset-4">
        
        
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
                               %><li><b><%=game.getOfferorUN()%></b>:&nbsp;Game #<%=game.getGameId()%>&nbsp;(size&nbsp;<%=game.getBoardSize()%>)&nbsp;<a href="servlet/OfferedGamesServlet?cmd=retract&gameId=<%=game.getGameId()%>">retract</a></li><%
                           }else{
                               %><li><%=game.getOfferorUN()%>:&nbsp;<a href="acceptGame.jsp?gameId=<%=game.getGameId()%>">Game #<%=game.getGameId()%></a>&nbsp;(size&nbsp;<%=game.getBoardSize()%>)</li><%
                           }
                       }   
                   }
                   %><li><a href="startGame.jsp">Offer New Game</a></li>    
                   </ul><%

               %>
               <%
                   String message = request.getParameter("status");
                   if ("success".equals(message)) {
                       %>  <h2>Successfully Retracted Game.</h2> <%
                   } else if ("notyours".equals(message)){
                     %>  <h2>Cannot Retract a Game that You Haven't Offered.</h2> <%
                   }else if ("gameovr".equals(message)){
                     %>  <h2>Game is over</h2> <%
                   }else if ("idnotnum".equals(message)){
                     %>  <h2>Game Id is Not a Number.</h2> <%
                   }else if ("gamenull".equals(message)){
                     %>  <h2>Game Does not Exist in Database. Please try selecting another game.</h2> <%
                   }else if ("gameremoved".equals(message)){
                     %>  <h2>Sorry but game has been retracted from offerer</h2> <%
                   }else if ("gamedne".equals(message)){
                     %>  <h2>Sorry but game <%=request.getParameter("gameId")%> Does Not Exist.  Please select Another game or offer your own.</h2> <%
                   }else if ("accepted".equals(message)){
                     %>  <h2>Cannot Retract a Game that You Haven't Offered.</h2> <%
                   }
               %>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4">
                <h2><a href="completedGames.jsp">Completed Games</a></h2>
                <h2><a href="mainplayer.jsp">Current Games</a></h2>
                 <div class="row">
                    <div class="col-lg-12 ">
                         <p>
                             <a href="offeredGames.jsp"><button class="btn btn-primary" type="button" value="Refresh">Refresh</button></a>
                             <a href="../servlet/LoginServlet"><button class="btn btn-warning" type="button" value="Logout">Logout</button></a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

<%-- 
    Document   : mainplayer
    Created on : Jul 27, 2014, 10:41:48 AM
    Author     : christopherbritz
--%>

<%@page import="edu.vt.cs5244.Player"%>
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
        <link rel='stylesheet' href='../css/bootstrap.min.css' type='text/css'/>
        <link rel='stylesheet' href='../css/style.css' type='text/css'/>
    </head>
    <body>
        
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4">
                <h1>Welcome <%=user%>!</h1>
                <h2>Current Games</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4">
                <h3>My Turn:</h3>
        
        <%  
            GameCollection gameMap = (GameCollection)application.getAttribute("gameMap"); 
            
            if(gameMap !=null){
                //display collection of games
                for(Game game : gameMap.getAcceptedGamesByUser(user).values()){
                    String href = "playGame.jsp?gameId="+game.getGameId();                    
                    String whosTurn = game.whosTurn();
                    %><ul><%

                    if(whosTurn != null && game.whosTurn().equals(user)){
                         if(user.equals(whosTurn)){
                            %><li><a href="<%=href%>"><%=game.getUserNameOne()%>&nbsp;vs.&nbsp<%=game.getUserNameTwo()%>&nbsp(size&nbsp;<%=game.getBoardSize()%>)</a></li><%     
                        }else{
                             %><li><a href="<%=href%>"><%=game.getUserNameTwo()%>&nbsp;vs.&nbsp<%=game.getUserNameOne()%>&nbsp(size&nbsp;<%=game.getBoardSize()%>)</a></li><%     
                        }
                    }
                    %></ul><%
                }

                //TODO: NEED TO REFACTOR THIS AREA BECAUSE THERE IS SOME CODE REDUNDANCY
                //MAYBE MOVE IT INTO ITS OWN METHOD WITHIN GAME OBJECT    
                %>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4">
                <h3>Opponents Turn:</h3><%

                    for(Game game : gameMap.getAcceptedGamesByUser(user).values()){
                     //might need to synchronize this because i can see where the href could get overwritten
                        String href = "playGame.jsp?gameId="+game.getGameId();    
                        String whosTurn = game.whosTurn();
                         %><ul><%
                        if(whosTurn != null && !game.whosTurn().equals(user)){

                            if(!user.equals(game.getUserNameOne())){
                                %><li><a href="<%=href%>"><%=game.getUserNameOne()%>&nbsp;vs.&nbsp<%=game.getUserNameTwo()%>&nbsp(size&nbsp;<%=game.getBoardSize()%>)</a></li><%     
                            }else{
                                 %><li><a href="<%=href%>"><%=game.getUserNameTwo()%>&nbsp;vs.&nbsp<%=game.getUserNameOne()%>&nbsp(size&nbsp;<%=game.getBoardSize()%>)</a></li><%     
                            }
                        }
                        %></ul><%
                    }
            }
        %>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4">
                <h2><a href="completedGames.jsp">Completed Games</a></h2>
                <h2><a href="offeredGames.jsp">Offered Games</a></h2>
                 <div class="row">
                    <div class="col-lg-12 ">
                         <p>
                             <a href="mainplayer.jsp"><button class="btn btn-primary" type="button" value="Refresh">Refresh</button></a>
                             <a href="../servlet/LoginServlet"><button class="btn btn-warning" type="button" value="Logout">Logout</button></a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
       
    </body>
</html>
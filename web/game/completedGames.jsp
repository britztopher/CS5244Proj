<%-- 
    Document   : completedGames
    Created on : Aug 1, 2014, 7:41:34 PM
    Author     : christopherbritz
--%>

<%@page import="edu.vt.cs5244.Player"%>
<%@page import="java.util.Map"%>
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
        <title>Completed Games Page</title>
    </head>
    <body>
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4">
                <h1>Welcome <%=user%>!</h1>
                <h2>Completed Games</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4">
        
        <%  
            GameCollection gameMap = (GameCollection)application.getAttribute("gameMap"); 
          
            Integer scoreOne = 0;
            Integer scoreTwo = 0;
            String scoreOneStr = "0";
            String scoreTwoStr = "0";
            Map<Player, Integer> scoreMap;
            int wins = 0, losses=0, draws = 0;
            
            try{
                //display collection of games
                for(Game game : gameMap.getAcceptedGamesByUser(user).values()){
                    String href = "playGame.jsp?gameId="+game.getGameId();                    
                    String whosTurn = game.whosTurn();
                    scoreMap = game.getTheDAB().getScores();

                    scoreOne = scoreMap.get(Player.ONE);
                    scoreTwo = scoreMap.get(Player.TWO);
                    scoreOneStr = String.valueOf(scoreOne);
                    scoreTwoStr = String.valueOf(scoreTwo);

                    %><ul><%

                    if(whosTurn == null){
                        if(user.equals(game.getUserNameOne()) && (scoreOne<scoreTwo)){
                            losses += 1;
                            %><li><a href="<%=href%>">Game #<%=game.getGameId()%></a>&nbsp; - &nbsp<%=game.getUserNameOne()%>&nbsp;<b><%=scoreOneStr%></b>&nbsp;vs.&nbsp;<%=game.getUserNameTwo()%>&nbsp;<b><%=scoreTwoStr%></b>&nbsp; - &nbsp;Loss</li><%     
                        }else if (user.equals(game.getUserNameOne()) && (scoreOne>scoreTwo)){
                            wins +=1;
                            %><li><a href="<%=href%>">Game #<%=game.getGameId()%></a>&nbsp; - &nbsp<%=game.getUserNameOne()%>&nbsp;<b><%=scoreOneStr%></b>&nbsp;vs.&nbsp;<%=game.getUserNameTwo()%>&nbsp;<b><%=scoreTwoStr%></b>&nbsp; - &nbsp;Win</li><%      
                        }else if (user.equals(game.getUserNameTwo()) && (scoreOne>scoreTwo)){
                            losses +=1;
                            %><li><a href="<%=href%>">Game #<%=game.getGameId()%></a>&nbsp; - &nbsp<%=game.getUserNameOne()%>&nbsp;<b><%=scoreOneStr%></b>&nbsp;vs.&nbsp;<%=game.getUserNameTwo()%>&nbsp;<b><%=scoreTwoStr%></b>&nbsp; - &nbsp;Loss</li><%       
                        }else if(user.equals(game.getUserNameTwo()) && (scoreOne<scoreTwo)){
                            wins +=1;
                            %><li><a href="<%=href%>">Game #<%=game.getGameId()%></a>&nbsp; - &nbsp<%=game.getUserNameOne()%>&nbsp;<b><%=scoreOneStr%></b>&nbsp;vs.&nbsp;<%=game.getUserNameTwo()%>&nbsp;<b><%=scoreTwoStr%></b>&nbsp; - &nbsp;Win</li><%        
                        }else{
                            draws +=1;
                            %><li><a href="<%=href%>">Game #<%=game.getGameId()%></a>&nbsp; - &nbsp<%=game.getUserNameOne()%>&nbsp;<b><%=scoreOneStr%></b>&nbsp;vs.&nbsp;<%=game.getUserNameTwo()%>&nbsp;<b><%=scoreTwoStr%></b>&nbsp; - &nbsp;Draw</li><% 
                        }        
                    }
                    %></ul><%
                }
            }
            catch(Exception e){
               //Do something     
            }
            %>
            
            <h3>Your Record (W-L-T)</h3>
            <ul>
                <li><%=wins%>&nbsp;-&nbsp;<%=losses%>&nbsp;-&nbsp;<%=draws%></li>
            </ul>
            
                    
            <h2><a href="mainplayer.jsp">Current Games</a></h2>
            <h2><a href="offeredGames.jsp">Offered Games</a></h2>
          
             <div class="row">
                     <div class="col-lg-12 ">
                          <p>
                              <a href="completedGames.jsp"><button class="btn btn-primary" type="button" value="Refresh">Refresh</button></a>
                              <a href="../servlet/LoginServlet"><button class="btn btn-warning" type="button" value="Logout">Logout</button></a>
                         </p>
                     </div>
                </div>
            </div>
        </div>
            
    </body>
</html>

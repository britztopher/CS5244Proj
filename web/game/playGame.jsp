<%-- 
    Document   : playgame
    Created on : Jul 31, 2014, 5:37:09 PM
    Author     : christopherbritz
--%>

<%@page import="edu.vt.cs5244.Util"%>
<%@page import="edu.vt.cs5244.Player"%>
<%@page import="java.util.Map"%>
<%@page import="edu.vt.cs5244.GameCollection"%>
<%@page import="edu.vt.cs5244.Game"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.addHeader("Cache-control", "no-cache");%>
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
        <script>
            var xhr = new XMLHttpRequest();
            var count = 3;
            function xhrWorker() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        str = xhr.responseText;
                        console.log('RESPONSE: ', str)
                        if (str.match(/YES/) !== null) {
                            console.log('IN YES BLOCK')
                            document.getElementById('turnCheck').innerHTML='It\'s your turn; attempting to refresh page...';
                            location.reload(true);
                            return;
                        }else{
                            
                        }
                    } else {
                        document.getElementById('turnCheck').innerHTML='Problem getting status; try manual refresh';
                        return;
                    }
                    count = 3;
                    handleRefresh();
                }
            }
            function startTimer() {
                setTimeout(handleRefresh, 1000);
            }
            function handleRefresh() {
                if (xhr === null) {
                    return;
                }
                if (count > 0) {
                    document.getElementById('turnCheck').innerHTML='Still your opponent\'s turn; next check in ' + count + ' sec (<a href="playGame.jsp?gameId=<%=request.getParameter("gameId")%>&amp;auto=no">stop auto refresh</a>)';
                    count--;
                    startTimer();
                    return;
                }
                document.getElementById('turnCheck').innerHTML='Waiting for reply... (<a href="playGame.jsp?gameId=<%=request.getParameter("gameId")%>&amp;auto=no">stop auto refresh</a>)';
                xhr.onreadystatechange = xhrWorker;
                xhr.open('GET', 'checkTurn.jsp?gameId=<%=request.getParameter("gameId")%>', true);
                xhr.send(null);
            }
        </script>

    </head>
            <%  
            String gridDisplay = null;
            String gameId = request.getParameter("gameId");
            String playerOne = null;
            String playerTwo = null;
            String whosTurn = "";
            String turn = "";
            String scoreOne = "0";
            String scoreTwo = "0";
            Map<Player, Integer> scoreMap;
            
            
            try{
                Integer id = Integer.parseInt(gameId);
            
                GameCollection gameMap = (GameCollection)application.getAttribute("gameMap"); 
                Game game = gameMap.getGameMap().get(id);
                
                if(game!=null){
                    playerOne = game.getUserNameOne();
                    playerTwo = game.getUserNameTwo();
                        
                    if(playerOne.equals(user) || playerTwo.equals(user)){
                        turn = Util.parsePlayer(game.getTheDAB().getTurn());
                        scoreMap = game.getTheDAB().getScores();
                            
                        whosTurn = game.whosTurn();

                        if (game.whosTurn() == null) { // if no such message...
                            gridDisplay = game.getTheDAB().toString();
                        }else if(game.whosTurn().equals(user)){
                            gridDisplay = game.getTheDAB().toString("PlayGameServlet", "gameId", gameId);
                            
                        }else{
                            gridDisplay = game.getTheDAB().toString();
                            whosTurn="opponent's";
                        }%>
                           
                        <%
                        scoreOne = String.valueOf(scoreMap.get(Player.ONE));
                        scoreTwo = String.valueOf(scoreMap.get(Player.TWO));
                    }else{
                        gridDisplay = "Sorry but you are not allowed to Access this Game becuase you are not  a player in it.";    
                    }
                        
                }else{
                    gridDisplay = "No Grid to Display Because Game Does Not Exist for Game Id: "+gameId+"\n";
                }
               

            }catch(NumberFormatException nfe){
                //couldnt parse the gameid for some reason
            }
            
            
        %>
         
        <body>
        <h1>Hello <%=user%>!</h1>
        <h2>Game #<%=request.getParameter("gameId")%></h2>
        <%
            String message = request.getParameter("status");
            if ("edgeexists".equals(message)) {
                %>  <h2>Edge Already Drawn. Please Choose another Edge.</h2> <%
            } else if ("edgeDrawn".equals(message)){
              %>  <h2>Success! Edge Drawn</h2> <%
            }else if ("gameovr".equals(message)){
              %>  <h2>Game is over</h2> <%
            }else if ("edgeErr".equals(message)){
              %>  <h2>DRAW: Edge value must be selected from clickible grid.</h2> <%
            }else if ("edgenone".equals(message)){
              %>  <h2>DRAW: Edge value must be selected from grid above.</h2> <%
            }else if ("edgeoob".equals(message)){
              %>  <h2>DRAW: Location is Out of Bounds.</h2> <%
            }else if ("edgenfe".equals(message)){
              %>  <h2>DRAW: Row and Col values must both be numeric.</h2> <%
            }else if ("invldcmd".equals(message)){
              %>  <h2>Please select a Valid Command</h2> <%
            }else if ("gamenfe".equals(message)){
              %>  <h2>Please select a Valid Game Id</h2> <%
            }
        %>
        

         <%=gridDisplay%>
         <br/>
         <% if("ONE".equals(turn)){
            %>*<%
         }
         %>
         ONE (<%=playerOne%>)&nbsp; - &nbsp;<%=scoreOne%>
         <br/>
         <% if("TWO".equals(turn)){
            %>*<%
        }
        %>
        TWO (<%=playerTwo%>)&nbsp; - &nbsp;<%=scoreTwo%>
        <%
            if(playerOne == null){
                //show nothing
                
            }else if(turn.isEmpty()){
                %><h3>GAME IS OVER!!</h3><% 
            }else if(user.equals(whosTurn)){
                %><h3>It's <%=whosTurn%>'s turn</h3><%
            
            } %>
            
                <div id="turnCheck">
                    <a href="playGame.jsp?gameId=<%=gameId%>&amp;auto=no">Refresh</a> this page to check for a new move.
                 </div>  
   
        
        <h2><a href="mainplayer.jsp">Current Games</a></h2>
        <h2><a href="completedGames.jsp">Completed Games</a></h2>
        <h2><a href="offeredGames.jsp">Offered Games</a></h2>
        <a href="playGame.jsp">Refresh</a><br>
        <a href="../servlet/LoginServlet">Logout</a>
    </body>
</html>

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
        <link rel='stylesheet' href='../css/bootstrap.min.css' type='text/css'/>
        <link rel='stylesheet' href='../css/style.css' type='text/css'/>
        <title>Accept Page</title>
    </head>
    <body>
        <div class="row">
            <div class="col-lg-4 col-lg-offset-3">
                <h1>Welcome <%=user%>!</h1>
                <h2>Accept a Game</h2>
                <h2>Game #<%=request.getParameter("gameId")%></h2>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 col-lg-offset-3">

            <%  
               String gridDisplay = null;
               String gameOfferor = null;
               String gameId = request.getParameter("gameId");
               boolean isShown = true;

               GameCollection gameMap = (GameCollection)application.getAttribute("gameMap"); 
               try{

                   Integer id = Integer.parseInt(gameId);
                   Game game = gameMap.getGameMap().get(id);

                   gridDisplay = game.getTheDAB().toString();
                   gameOfferor = game.getOfferorUN();

               }catch(NullPointerException npe){

               }catch(NumberFormatException nfe){
                   response.sendRedirect("offeredGames.jsp");
                   gridDisplay = "Sorry but this game does not exist please return to offer games and try another.";
                   isShown = false;

               }
            %>

            <%=gridDisplay%>


            <% if(isShown) {
            %>         
               Game #<%=gameId%> (offered by <%=gameOfferor%>)
               <h3>Accept this game as:</h3>
               <br/>
               <ul>
                   <li><a href="servlet/edu.vt.cs5244.AcceptGameServlet?command=normal&gameId=<%=gameId%>">Normal</a>: You will be player TWO, and you will move next</li>
                   <li><a href="servlet/edu.vt.cs5244.AcceptGameServlet?command=reversed&gameId=<%=gameId%>">Reversed</a>: You will be player ONE, and the move above will become your first move</li>
               </ul><%
            }%>
            <br/>

            <h2><a href="mainplayer.jsp">Current Games</a></h2>
            <h2><a href="completedGames.jsp">Completed Games</a></h2>
            <h2><a href="offeredGames.jsp">Offered Games</a></h2>
            <div class="row">
                     <div class="col-lg-12 ">
                          <p>
                              <a href="acceptGame.jsp"><button class="btn btn-primary" type="button" value="Refresh">Refresh</button></a>
                              <a href="../servlet/LoginServlet"><button class="btn btn-warning" type="button" value="Logout">Logout</button></a>
                         </p>
                     </div>
             </div>
        </div>
        </div>
         
    </body>
</html>

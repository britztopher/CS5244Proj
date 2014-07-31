<%-- 
    Document   : startGame
    Created on : Jul 27, 2014, 10:14:46 PM
    Author     : christopherbritz
--%>

<%@page import="edu.vt.cs5244.util.ProjHtmlDAB"%>
<%@page import="edu.vt.cs5244.Player"%>
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
        <title>Offer a New Game</title>
    </head>
    <body>
        <h1>Welcome <%=user%>!</h1>
        <h2>Offer a New Game</h2>
        
        <%  
            Game game = (Game)session.getAttribute("game"); 
            String gridDisplay = "";
            if(game == null){
        %><h3>Grid Options</h3>
            <form action="servlet/edu.vt.cs5244.StartGameServlet">
                Please choose the game size: 
                <select name="size">
                    <option value="None">Select...</option>
                    <option value="2">2 x 2</option>
                    <option value="3">3 x 3</option>
                    <option value="4">4 x 4</option>
                    <option value="5">5 x 5</option>
                </select>
                <input type="submit" value="Go">
            </form>
        <%    
            }else if(game.getTheDAB().getTurn()==Player.ONE){
                 gridDisplay = game.getTheDAB().toString("StartGameServlet");
                 %><%=gridDisplay%>
                    <a href="servlet/edu.vt.cs5244.StartGameServlet?command=resetGame">Reset Game Grid</a><br/><%
            }else if(game.getTheDAB().getTurn()==Player.TWO){
                 gridDisplay = game.getTheDAB().toString();
                 %><%=gridDisplay%>

           
                <br/>
                <a href="servlet/edu.vt.cs5244.StartGameServlet?command=offerGame">Offer This Game</a><br/>
                <a href="servlet/edu.vt.cs5244.StartGameServlet?command=resetGame">Reset Game Grid</a><br/>
        
            <%
                 
            }else{
                %><a href="servlet/edu.vt.cs5244.StartGameServlet?command=resetGame">Reset Game Grid</a><br/><%
            }

        %>

        
            <%
                String message = request.getParameter("status");
                if ("drawnfe".equals(message)) {
                  %>  DRAW: Row and Col values must both be numeric. <%
                } else if ("drawsuccess".equals(message)) {
                  %>  Opponents may accept this as your first move, or take it as their own first move.  <%
                }else if("initMv".equals(message)){
                    %>Please Select an Initial Move on the Grid Above<%
                }else if("invalidCmd".equals(message)){
                    %>Please select a Valid Command<%
                }else {
                    message="";
                }
            %>  
           
        
        
        <h2><a href="mainplayer.jsp">Current Games</a></h2>
        <h2><a href="completedGames.jsp">Completed Games</a></h2>
        <h2><a href="offeredGames.jsp">Offered Games</a></h2>
        <a href="startGame.jsp">Refresh</a><br>
        <a href="servlet/edu.vt.cs5244.Login">Logout</a>
    </body>
</html>


<%-- 
    Document   : login.jsp
    Created on : Jul 24, 2014, 4:06:02 PM
    Author     : christopherbritz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <h1>Welcome</h1>
        <h2>Please Login or <a href="../registration/registration.jsp">register<a></h2>
        <form action="../servlet/LoginServlet">

                Username 		
                <input type="text" name="un"/><br> 
                Password
                <input type="password" name="pw"/>
                <p>
                    <input type="submit" value="submit">		
                    <input type="button" value="cancel">
                </p>
        </form>
        <%
            String message = request.getParameter("status");
            if ("loggedout".equals(message)) {
                %>  <h2>Successfully Logged  Out</h2> <%
            } else if ("regfirst".equals(message)){
              %>  <h2>You must register before you log in</h2> <%
            }else if ("invlduser".equals(message)){
              %>  <h2>Username is Invalid. Please Try Again.</h2> <%
            }else if ("unmatchpw".equals(message)){
              %>  <h2>Password does not match for the username entered.</h2> <%
            }
        %>
    </body>
</html>

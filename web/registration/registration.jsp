<%-- 
    Document   : registration
    Created on : Jul 27, 2014, 9:31:59 AM
    Author     : christopherbritz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Page</title>
    </head>
    <body>
        <h1>Registration</h1>
        <%
                    String sucessMsg = request.getParameter("success");
                    if ("yes".equals(sucessMsg)) {
                        %>  <h2>Registration Successful!</h2> <%
                    } else {
                      %>  <h2>Please Register to Create an Account</h2> <%
                    }
                %>
        
        
        <form action="../servlet/RegistServlet">

                Username 		
                <input type="text" name="un"/><br> 
                Password
                <input type="password" name="pw"/><br>
                Mobile Phone:
                <input type="tel" name="mobile"/>
                <p>
                    <input type="submit" value="submit">		
                    <input type="button" value="cancel">
                </p>
                
                <%
                    String message = request.getParameter("status");
                    if ("emptyField".equals(message)) {
                      %>  Username or Password Field is Blank <%
                    } else if ("unLength".equals(message)) {
                      %>  Username has to be longer than 3 but less than 16 characters long  <%
                    }
                %>
                
        </form>
    </body>
</html>

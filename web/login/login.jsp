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
    </body>
</html>

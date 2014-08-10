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
            <link rel='stylesheet' href='../css/bootstrap.min.css' type='text/css'/>
            <link rel='stylesheet' href='../css/style.css' type='text/css'/>
        <title>Login Page</title>
    </head>
    <body>
        
        <div class="row">
            <div class="col-lg-3 col-lg-offset-4">
                <h2>Please Login or <a href="../registration/registration.jsp">register<a></h2>
                <hr/>
            </div> 
            <div class="row">
            <div class="col-lg-3 col-lg-offset-4">
                <form action="../servlet/LoginServlet"> 		
                    <div class="input-group">  
                        <span class="input-group-addon">UserName:</span>
                        <input type="text" class="form-control" placeholder="username@createone.com" name="un">
                    </div>
                    <br/>
                    <div class="input-group">  
                        <span class="input-group-addon">Password:</span>
                        <input type="password" class="form-control" placeholder="mySecretPassword" name="pw">
                    </div>
                    <hr/>
                   <div class="row">
                        <div class="col-lg-12 col-lg-offset-4">
                              
                             <p>
                                 <input class="btn btn-primary" type="submit" value="Login"/> Or
                                <a href="../registration/registration.jsp"><button class="btn btn-warning" type="button" value="Register">Register</button></a>
                            </p>
                        </div>
                    </div>
                </form>
            </div>
          
            
        </div>
        <div class="row">
            <div class="col-lg-3 col-lg-offset-3">
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
            </div>
        </div>
    </body>
</html>

<%-- 
    Document   : registration
    Created on : Jul 27, 2014, 9:31:59 AM
    Author     : christopherbritz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.addHeader("Cache-control", "no-cache");%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' href='../css/bootstrap.min.css' type='text/css'/>
        <link rel='stylesheet' href='../css/style.css' type='text/css'/>
        <title>Registration Page</title>
    </head>
    <body>
        
        <div class="row">
            <div class="col-lg-4 col-lg-offset-3">
                <h1>Registration</h1>
            </div>
            <div class="row">
                <div class="col-lg-4 col-lg-offset-3">
                    <form action="../servlet/RegistServlet">

                        <%
                                String sucessMsg = request.getParameter("success");
                                if ("yes".equals(sucessMsg)) {
                                    %>  <h2>Registration Successful!</h2> 
                                        <a href="../login/login.jsp">Please login to begin<a/>
                                            <br/>OR<br/>
                                        <a href="../registration/register.jsp">Register another account<a/>
                                    <%
                                } else {
                                  %>  <h3>Please Register to Create an Account</h3> 
                                        <hr/>
                                        <div class="input-group">  
                                            <span class="input-group-addon">UserName:</span>
                                            <input type="text" class="form-control" placeholder="username@createone.com" name="un" value="<%=(session.getAttribute("un") == null ? "": session.getAttribute("un"))%>" size="16" maxlength="16">
                                        </div>	
                                        <br/>
                                        <div class="input-group">  
                                            <span class="input-group-addon">Password:</span>
                                            <input class="form-control" type="password" name="pw" value="<%=(session.getAttribute("pw") == null ? "" : session.getAttribute("pw"))%>" size="5" maxlength="5">
                                        </div>
                                        <br/>
                                        <div class="row">
                                            <div class="col-lg-4">
                                                <div class="input-group">  
                                                    <span class="input-group-addon">Phone Number:</span>
                                                    <input type="text" class="form-control" placeholder="999" name="phone1" value="<%=(session.getAttribute("phone1") == null ? "":session.getAttribute("phone1"))%>" size="3" maxlength="3"> 
                                                </div>
                                            </div>
                                            <div class="col-lg-2">
                                                <div class="input-group"> 
                                                    <input type="text" class="form-control" placeholder="999"name="phone2" value="<%=(session.getAttribute("phone2") == null ? "":session.getAttribute("phone2"))%>" size="3" maxlength="3"> 
                                                </div>
                                            </div>
                                            <div class="col-lg-2">
                                                <div class="input-group">  
                                                    <input type="text" class="form-control" placeholder="9999"name="phone3" value="<%=(session.getAttribute("phone3") == null ? "":session.getAttribute("phone3"))%>" size="4" maxlength="4">
                                                </div>
                                            </div>
                                            <br> 
                                                       
                                        </div>
                                        <hr/>
                                        
                                        <div class="row">
                                            <div class="col-lg-12 ">
                                                 <p>
                                                     <input class="btn btn-primary" type="submit" value="Register!"/> Or
                                                     <a href="../login/login.jsp"><button class="btn btn-warning" type="button" value="Register">Return to Login</button></a>
                                                </p>
                                            </div>
                                        </div>

                                  <%
                                }
                            %>

                    </form>
                </div>
            </div>        
        </div>
         <div class="row">
            <div class="col-lg-3 col-lg-offset-3">         
                <%
                    String message = request.getParameter("status");
                    if ("emptyField".equals(message)) {
                      %>  Username or Password Field is Blank <%
                    } else if ("unLength".equals(message)) {
                      %>  Username has to be longer than 3 but less than 16 characters long  <%
                    }else if ("invldun".equals(message)) {
                      %>  Username can only contain letters, numbers, and underscores.<%
                    }else if ("lengthpw".equals(message)) {
                      %>  Password has to be exactly 5 letters/numbers long.  <%
                    }else if ("phoneletsnums".equals(message)) {
                      %> Password must only use letters and digits and have at least 2 digits and 2 letters. <%
                    }else if ("unexists".equals(message)) {
                      %>  Username chosen already exists.  <%
                    }else if ("phonenums".equals(message)) {
                      %> Phone number contains non numeric fields.  <%
                    }else if ("phonelength".equals(message)) {
                      %>Phone number is not exactly 10 digits  <%
                    }else if ("phonefields".equals(message)) {
                      %>Please enter all phone number fields.  <%
                    }
                %>
            </div>
         </div>
    </body>
</html>

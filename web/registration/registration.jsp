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
        <title>Registration Page</title>
    </head>
    <body>
        <h1>Registration</h1>
        
        
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
                      %>  <h2>Please Register to Create an Account</h2> 
                            Username 		
                            <input type="text" value="<%=(session.getAttribute("un") == null ? "": session.getAttribute("un"))%>" name="un" size="16" maxlength="16"/><br> 
                            Password
                            <input type="password" value="<%=(session.getAttribute("pw") == null ? "" : session.getAttribute("pw"))%>" name="pw" size="5" maxlength="5"/><br>
                            Mobile Phone:
                            <input type="text" name="phone1" value="<%=(session.getAttribute("phone1") == null ? "":session.getAttribute("phone1"))%>" size="3" maxlength="3"> -
                            <input type="text" name="phone2" value="<%=(session.getAttribute("phone2") == null ? "":session.getAttribute("phone2"))%>" size="3" maxlength="3"> - 
                            <input type="text" name="phone3" value="<%=(session.getAttribute("phone3") == null ? "":session.getAttribute("phone3"))%>" size="4" maxlength="4"><br>

                            <p>
                                <input type="submit" value="Register!">	
                                <a href="../login/login.jsp">Return to Login</a>
                            </p>
                      
                      <%
                    }
                %>
              
        </form>
                 
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
    </body>
</html>

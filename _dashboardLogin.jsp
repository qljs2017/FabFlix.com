<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.io.*" %>
    <%@page import="java.sql.*" %>
    <%@page import="java.util.*" %>
    <%@page import="javax.servlet.*" %>
    


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>_dashboardLogin</title>

</head>
<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Employee Login</H1>
<center>
<FORM ACTION="/TomcatLogin/_dashboardLogin"
      METHOD="POST">
  Email Address: <INPUT TYPE="PASSWORD" NAME="email"><BR>

  Password     : <INPUT TYPE="PASSWORD" NAME="password"><BR>
  
    <INPUT TYPE="SUBMIT" VALUE="Login!">


  
  
  
<H2><%

if (request.getAttribute("emplogin") != null){
	out.print(request.getAttribute("emplogin"));
}



%></H2>



</FORM>
</center>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login</title>
<script src='https://www.google.com/recaptcha/api.js'></script>

</head>
<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Login</H1>
<center>
<FORM ACTION="/TomcatLogin/login"
      METHOD="POST">
  Email Address: <INPUT TYPE="PASSWORD" NAME="email"><BR>

  Password     : <INPUT TYPE="PASSWORD" NAME="password"><BR>
  
    <INPUT TYPE="SUBMIT" VALUE="Login!">
    		<div class="g-recaptcha" data-sitekey="6LcVXyEUAAAAANPWVc36Ks0DrtrcuQYJUM7aUtKv"></div>
  
<H2><% out.print(request.getAttribute("login")); %></H2>

</FORM>
</center>
</body>
</html>
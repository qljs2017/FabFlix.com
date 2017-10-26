<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.io.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
  <TITLE>browse</TITLE>
</HEAD>

<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Browse Movies</H1>

<FORM ACTION = "main.jsp" METHOD = "GET">
<input type="submit" name="co" value="Check Out!" style="float: right;">


<% 
	if (request.getParameter("co") != null){
		// go chekc out!
		request.getRequestDispatcher("checkout.jsp").forward(request, response);
	}




%>

</FORM>

<center>Please Choose:</center>
 
   
<center>
<FORM ACTION = "browse.jsp" METHOD = "GET">

    <INPUT TYPE="SUBMIT" NAME="bg" VALUE="Browse by Movie's Genre!">
    <INPUT TYPE="SUBMIT" NAME="bt" VALUE="Browse by Movie's Title!">
    
    
    
 
</FORM>
</center>
<% 


		response.setContentType("text/html");    // Response mime type


		if (request.getParameter("bg") != null){
	       // do something
			request.getRequestDispatcher("browseGenre.jsp").forward(request, response);


	       
		}
		else if (request.getParameter("bt") != null){
	       // do something
			request.getRequestDispatcher("browseTitle.jsp").forward(request, response);
		}  
	

%>




</BODY>
</HTML>


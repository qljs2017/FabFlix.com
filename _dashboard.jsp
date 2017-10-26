<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.io.*" %>
    <%@page import="java.sql.*" %>
    <%@page import="java.util.*" %>
    <%@page import="javax.servlet.*" %>
    



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
  <TITLE>_dashboard</TITLE>
</HEAD>

<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Dashboard</H1>

<center>
<H2><%



HttpSession e_session = request.getSession(true);

if (e_session.getAttribute("emp") != null){
	// go login!
	if (e_session.getAttribute("emp").equals("fake")){
		//out.println("fask emp");
		request.getRequestDispatcher("_dashboardLogin.jsp").forward(request, response);
	}
}else{
	//out.println("null emp");
	request.getRequestDispatcher("_dashboardLogin.jsp").forward(request, response);	
}

%></H2>
</center>
<center>Please Choose:</center>
 
   

<FORM ACTION = "_dashboard.jsp" METHOD = "GET">


  <CENTER>
    <INPUT TYPE="SUBMIT" NAME="insertstar" VALUE="Insert a New Star~!">
    <INPUT TYPE="SUBMIT" NAME="printmeta" VALUE="Print out Metadata~!">
    <INPUT TYPE="SUBMIT" NAME="addmovie" VALUE="Add a New Movie~!">
    
    
  </CENTER>
</FORM>

<% 


		response.setContentType("text/html");    // Response mime type

		
		
		if (request.getParameter("insertstar") != null){
	       // do something

	        request.getRequestDispatcher("_insertStar.jsp").forward(request, response);


	       
		}
		if (request.getParameter("printmeta") != null){
	       // do something
		//	out.println("go meta");
			request.getRequestDispatcher("_metadata.jsp").forward(request, response);
		}  
	
		
		if (request.getParameter("addmovie") != null){
		       // do something

		    request.getRequestDispatcher("_addmovie.jsp").forward(request, response);


		       
		}

%>




</BODY>
</HTML>


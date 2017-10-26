<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Confirmation</title>
</head>
<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Confirmation</H1>

<form ACTION = 'confirm.jsp' METHOD = 'GET'>


	<CENTER>

	<%
	
	if (request.getAttribute("conf") != null){
		out.println(request.getAttribute("conf"));	
	}
	
	if (request.getParameter("back") != null){
		
		request.getRequestDispatcher("main.jsp").forward(request, response);
	}
	
	
	%>
	
    <INPUT TYPE="SUBMIT" NAME="back" VALUE="Purchase More~!">
   
    
	</CENTER>


</form>
</body>
</html>
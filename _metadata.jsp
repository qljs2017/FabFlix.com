<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.io.*" %>
    <%@page import="java.sql.*" %>
    <%@page import="java.util.*" %>
    <%@page import="javax.servlet.*" %>
    



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
  <TITLE>_metadata</TITLE>
</HEAD>

<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Print Out Metadata</H1>

<%

	response.setContentType("text/html");    // Response mime type
	
	HttpSession e_session = request.getSession(true);

	if (e_session.getAttribute("emp") != null){
		// go login!
		if (e_session.getAttribute("emp").equals("fake")){
		//	out.println("fask emp");
			request.getRequestDispatcher("_dashboardLogin.jsp").forward(request, response);
		}
	}else{
	//	out.println("null emp");
		request.getRequestDispatcher("_dashboardLogin.jsp").forward(request, response);	
	}





	if (e_session.getAttribute("connection") == null){
		request.getRequestDispatcher("_dashboardLogin.jsp").forward(request, response);	
	}

	Connection connection = (Connection)e_session.getAttribute("connection");


	try{
		
		
		
		
		out.println("<div><h3>Print out the metadata of the database:</h3></div> ");
		
		
		
		out.println("<div> <h4> Table movies: </h4>");
		
		Statement select1 = connection.createStatement();
		ResultSet result1 = select1.executeQuery("select * from movies");
		
		ResultSetMetaData metadata1 = result1.getMetaData();
		
		// Print type of each attribute
		for (int i = 1; i <= metadata1.getColumnCount(); i++){
		    out.println("<p>Column: "+ metadata1.getColumnName(i) + " is " + metadata1.getColumnTypeName(i)+"</p>");
		}
		out.println("</div>");
									//////
		out.println("<div> <h4> Table stars: </h4>");
						//
		Statement select2 = connection.createStatement();
																//////
		ResultSet result2 = select2.executeQuery("select * from stars");
						//       ////       //
		ResultSetMetaData metadata2 = result2.getMetaData();
		
		// Print type of each attribute
									//
		for (int i = 1; i <= metadata2.getColumnCount(); i++){
		    out.println("<p>Column: "+ metadata2.getColumnName(i) + " is " + metadata2.getColumnTypeName(i)+"</p>");
											  //                                     //
		}
		out.println("</div>");
		
		
		out.println("<div> <h4> Table stars_in_movies: </h4>");
		
		Statement select3 = connection.createStatement();
		ResultSet result3 = select3.executeQuery("select * from stars_in_movies");
		
		ResultSetMetaData metadata3 = result3.getMetaData();
		
		// Print type of each attribute
		for (int i = 1; i <= metadata3.getColumnCount(); i++){
		    out.println("<p>Column: "+ metadata3.getColumnName(i) + " is " + metadata3.getColumnTypeName(i)+"</p>");
		}
		out.println("</div>");
		
		out.println("<div> <h4> Table genres: </h4>");
		
		Statement select4 = connection.createStatement();
		ResultSet result4 = select4.executeQuery("select * from genres");
		
		ResultSetMetaData metadata4 = result4.getMetaData();
		
		// Print type of each attribute
		for (int i = 1; i <= metadata4.getColumnCount(); i++){
		    out.println("<p>Column: "+ metadata4.getColumnName(i) + " is " + metadata4.getColumnTypeName(i)+"</p>");
		}
		out.println("</div>");
		
		
		out.println("<div> <h4> Table genres_in_movies: </h4>");
		
		Statement select5 = connection.createStatement();
		ResultSet result5 = select5.executeQuery("select * from genres_in_movies");
		
		ResultSetMetaData metadata5 = result5.getMetaData();
		
		// Print type of each attribute
		for (int i = 1; i <= metadata5.getColumnCount(); i++){
		    out.println("<p>Column: "+ metadata5.getColumnName(i) + " is " + metadata5.getColumnTypeName(i)+"</p>");
		}
		out.println("</div>");
		
		
		out.println("<div> <h4> Table customers: </h4>");
		
		Statement select6 = connection.createStatement();
		ResultSet result6 = select6.executeQuery("select * from customers");
		
		ResultSetMetaData metadata6 = result6.getMetaData();
		
		// Print type of each attribute
		for (int i = 1; i <= metadata6.getColumnCount(); i++){
		    out.println("<p>Column: "+ metadata6.getColumnName(i) + " is " + metadata6.getColumnTypeName(i)+"</p>");
		}
		out.println("</div>");
		
		out.println("<div> <h4> Table sales: </h4>");
		
		Statement select7 = connection.createStatement();
		ResultSet result7 = select7.executeQuery("select * from sales");
		
		ResultSetMetaData metadata7 = result7.getMetaData();
		
		// Print type of each attribute
		for (int i = 1; i <= metadata7.getColumnCount(); i++){
		    out.println("<p>Column: "+ metadata7.getColumnName(i) + " is " + metadata7.getColumnTypeName(i)+"</p>");
		}
		out.println("</div>");
		
		
		out.println("<div> <h4> Table creditcards: </h4>");
		
		Statement select8 = connection.createStatement();
		ResultSet result8 = select8.executeQuery("select * from creditcards");
		
		ResultSetMetaData metadata8 = result8.getMetaData();
		
		// Print type of each attribute
		for (int i = 1; i <= metadata8.getColumnCount(); i++){
		    out.println("<p>Column: "+ metadata8.getColumnName(i) + " is " + metadata8.getColumnTypeName(i)+"</p>");
		}
		out.println("</div>");
		/*
		
	
	
		out.println("\n\n  Table creditcards: \n");
		
		Statement select8 = connection.createStatement();
		ResultSet result8 = select8.executeQuery("select * from creditcards");
		
		ResultSetMetaData metadata8 = result8.getMetaData();
		
		// Print type of each attribute
		for (int i = 1; i <= metadata8.getColumnCount(); i++){
		    out.println("Column: "+ metadata1.getColumnName(i) + " is " + metadata8.getColumnTypeName(i));
		}
		*/
		//out.println("</center>");
	}catch(Exception e){
        out.println("\nError: Cannot Print Metadata! Plz Go Back to Dashboard.");
		//request.getRequestDispatcher("_dashboard.jsp").forward(request, response);
    }



%>



</BODY>
</HTML>


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
<title>title</title>
</head>
<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Title</H1>

<FORM ACTION = "title.jsp" METHOD = "GET">
<input type="submit" name="co" value="Check Out!" style="float: right;">

<% 
	if (request.getParameter("co") != null){
		// go chekc out!
		request.getRequestDispatcher("checkout.jsp").forward(request, response);
	}




%>

 	<CENTER>
 
<% 

	response.setContentType("text/html");    // Response mime type
	HttpSession c_session = request.getSession(true);
	
	try{
		Statement statement = ((Connection)c_session.getAttribute("connection")).createStatement();

		//out.println("Displaying all Movies of "+ gname +": "); 
		
		List<Integer> ml = new ArrayList<Integer>();
		String query = "select id from movies where title like '"+ request.getParameter("tc") +"%';";

		ResultSet rs = statement.executeQuery(query);	

		while(rs.next()){
			int mid = rs.getInt(1);
			ml.add(mid);
		}
		c_session.setAttribute("movielist", ml);
		response.sendRedirect("movieList.jsp");

	//	request.getRequestDispatcher("movieList.jsp").forward(request, response);
		//out.println("</td>");

	
	}catch (SQLException ex) {
		   while (ex != null) {
		         System.out.println ("SQL Exception:  " + ex.getMessage ());
		         ex = ex.getNextException ();
		     }  // end while
		   response.sendRedirect("login.jsp");
		  // end catch SQLException
	}catch(java.lang.Exception ex){
	   out.println("<HTML>" +
	               "<HEAD><TITLE>" +
	               "MovieDB: Error" +
	               "</TITLE></HEAD>\n<BODY>" +
	               "<P>SQL error in doGet: " +
	               ex.getMessage() + "</P></BODY></HTML>");
	   response.sendRedirect("login.jsp");
	}



/*
if (request.getParameter("gid") != null){
		out.println("ahhahahah -> "+request.getParameter("gid") );
	}else{
		out.println("xxxxxx" );
	}
*/
%>
</CENTER>
</FORM>
</body>
</html>
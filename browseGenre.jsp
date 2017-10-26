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
<title>browseGenre</title>
</head>

<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Browse Movies by Movie's Genre</H1>

<FORM ACTION = "main.jsp" METHOD = "GET">

<input type="submit" name="co" value="Check Out!" style="float: right;">

<% 
	if (request.getParameter("co") != null){
		// go chekc out!
		request.getRequestDispatcher("checkout.jsp").forward(request, response);
	}




%>

</FORM>


<center>
<FORM ACTION = "main.jsp" METHOD = "GET">
<table border=1 id="results">
<tr>

</tr>
<% 

	response.setContentType("text/html");    // Response mime type
	HttpSession c_session = request.getSession(true);
	
	try{
		Statement statement = ((Connection)c_session.getAttribute("connection")).createStatement();
		//Statement statement2 = ((Connection)c_session.getAttribute("connection")).createStatement();
		String query = "select * from genres;";
		
		ResultSet rs = statement.executeQuery(query);


		//out.println("<td>");
		int c = 0;
		while (rs.next()){
			String gn = rs.getString(2);
			int gid = rs.getInt(1);
			String tmp = "<h3><a href='genre.jsp?"+"gid="+gid+"&gname="+gn+"'>" + gn + "</a></h3>";	
			
			if (c == 0){
				c+= 1;
				tmp = "<tr><td> "+ tmp +" </td>";
			}else if(c == 5){
				c = 0;
				tmp = "<td> "+ tmp +" </td></tr>";
			}else{
				c+=1;
				tmp = "<td> "+ tmp +" </td>";
			}
			out.print(tmp);
			
		}
	//	out.println("</td>");
		
		
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
%>
</table>
</FORM>
</center>

</body>
</html>
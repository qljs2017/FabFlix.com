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
<title>browseTitle</title>
</head>

<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Browse Movies by Movie's Title</H1>

<FORM ACTION = "browseTitle.jsp" METHOD = "GET">
<input type="submit" name="co" value="Check Out!" style="float: right;">

<% 
	if (request.getParameter("co") != null){
		// go chekc out!
		request.getRequestDispatcher("checkout.jsp").forward(request, response);
	}




%>


<center>
<table border=1 id="results">
<tr>

</tr>





<% 

	response.setContentType("text/html");    // Response mime type
	HttpSession c_session = request.getSession(true);
	
	try{
		Statement statement = ((Connection)c_session.getAttribute("connection")).createStatement();
		Statement statement2 = ((Connection)c_session.getAttribute("connection")).createStatement();
	
		String query = "select distinct title from movies order by title asc;";
		
		ResultSet rs = statement.executeQuery(query);	
		
		List<Character> charCategory = new ArrayList<Character>();
	
		int c = 0;
		while(rs.next()){
			String tmp = "";
			
			char temp = rs.getString(1).charAt(0);
			
			if (!charCategory.contains(temp)){
				
				charCategory.add(temp);

				//out.print("<td>");
				
				
				tmp = "<h3><a href='title.jsp?"+"tc="+temp+"'>" + temp + "</a></h3>";
				
				//out.print("</td>");
				
				if (c == 0){
					c+= 1;
					tmp = "<tr><td> "+ tmp +" </td>";
				}else if(c == 10){
					c = 0;
					tmp = "<td> "+ tmp +" </td></tr>";
				}else{
					c+=1;
					tmp = "<td> "+ tmp +" </td>";
				}
				out.print(tmp);
			}
				
		}
		

		
		
		
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
</center>
</FORM>
</body>
</html>
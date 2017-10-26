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
<title>genre</title>
</head>
<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Genre</H1>

<FORM ACTION = "movieList.jsp" METHOD = "GET">
 
<input type="button" name="co" value="Check Out!" style="float: right;">

<% 
	if (request.getParameter("co") != null){
		// go chekc out!
		request.getRequestDispatcher("checkout.jsp").forward(request, response);
	


	}
	response.setContentType("text/html");    // Response mime type
	HttpSession c_session = request.getSession(true);
	
	try{

		//out.println("Displaying all Movies of "+ gname +": "); 
		
		int gi = Integer.parseInt(request.getParameter("gid"));
		String query = "select m.title, m.id from movies m " +  
				" inner join genres_in_movies gm on m.id = gm.movie_id " +
				" where gm.genre_id = ?;";
		PreparedStatement statement = ((Connection)c_session.getAttribute("connection")).prepareStatement(query);
		statement.setInt(1,gi);
		ResultSet rs = statement.executeQuery();

		//out.println("<td>");
		List<Integer> final_movie_id_list = new ArrayList<Integer>();

		while (rs.next()){
			String mtitle = rs.getString(1);
			int mid = rs.getInt(2);
			//out.println("<p><a href='movie.jsp?"+"movieid="+mid+"'>" + mtitle + "</a></p>" );		

			final_movie_id_list.add(mid);
			
		}
		c_session.setAttribute("movielist", final_movie_id_list);
		response.sendRedirect("movieList.jsp");

		//request.getRequestDispatcher("movieList.jsp").forward(request, response);
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
</FORM>
</body>
</html>
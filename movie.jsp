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
<title>movie</title>
</head>
<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Movie</H1>


<form ACTION = "movie.jsp" METHOD = "GET">


<input type="submit" name="co" value="Check Out!" style="float: right;">

<% 

	if (request.getParameter("co") != null){
		// go chekc out!
		request.getRequestDispatcher("checkout.jsp").forward(request, response);
	}




%>

	<CENTER>

		
	<table border=1 id="results">
	
	<tr>
	
	<td>ID</td>
	<td>Title</td>
	<td>Year</td>			
	<td>Director</td>		
	<td>Genres</td>
	<td>Poster</td>	
	<td>Stars</td>	
	<td>Trailer</td>		
	<td>Add To Cart</td>

			
			
	</tr>
	

<% 

	response.setContentType("text/html");    // Response mime type
	HttpSession c_session = request.getSession(true);
	
	/*
	synchronized(c_session) {
    	 HashMap<Integer,Integer> cart = (HashMap<Integer,Integer>)session.getAttribute("cart");
    	if (cart == null) {
    		cart = new HashMap<Integer,Integer>();
    		session.setAttribute("cart", cart);
    	}	
    }
	
	if (request.getParameter("add") != null){
		int mid = Integer.parseInt(request.getParameter("add"));

    	   
    	synchronized((HashMap<Integer,Integer>)session.getAttribute("cart")) {
    		if (((HashMap<Integer,Integer>)session.getAttribute("cart")).containsKey(mid)){
    			((HashMap<Integer,Integer>)session.getAttribute("cart")).put(mid,((HashMap<Integer,Integer>)session.getAttribute("cart")).get(mid)+1);
    		}else{
    			((HashMap<Integer,Integer>)session.getAttribute("cart")).put(mid,1);
    		}
    	}
    }
	
	
	/*
	if (request.getParameter("add") != null){
    	
    	//request.getRequestDispatcher("checkout.jsp").forward(request, response);

    			

    
    	String mt = request.getParameter("add");
    //	synchronized(c_session) {
	   	HashMap<String,Integer> cart = (HashMap<String,Integer>)c_session.getAttribute("cart");
    	if (cart == null) {
    		cart = new HashMap<String,Integer>();
    		c_session.setAttribute("cart", cart);
    	}


    		if (cart.containsKey(mt)){
    			cart.put(mt,cart.get(mt)+1);
	    		c_session.setAttribute("cart", cart);

    		}else{
    			cart.put(mt,1);
	    		c_session.setAttribute("cart", cart);

    		}
    	
	    
    	
    }
    */
	if (request.getParameter("add") != null){
		
		//request.getRequestDispatcher("checkout.jsp").forward(request, response);
	
				
	
	
		String mt = request.getParameter("add");
		HashMap<String,Integer> cart = (HashMap<String,Integer>)c_session.getAttribute("cart");
			
		if (cart.containsKey(mt)){
				cart.put(mt,cart.get(mt)+1);
	
		}else{
			cart.put(mt,1);
	
		}
		c_session.setAttribute("cart", cart);
		request.setAttribute("added", "Item Added into Cart~!");
		request.getRequestDispatcher("main.jsp").forward(request, response);
	
	}
	
	
	try{
		//Statement statement2 = ((Connection)c_session.getAttribute("connection")).createStatement();
		//Statement statement3 = ((Connection)c_session.getAttribute("connection")).createStatement();

		
		String query = "select * from movies " 
					+ " where id = ?;";
		PreparedStatement statement = ((Connection)c_session.getAttribute("connection")).prepareStatement(query);
		statement.setInt(1,Integer.parseInt(request.getParameter("movieid")));
		ResultSet rs = statement.executeQuery();

		while(rs.next()){
			int temp = rs.getInt(1);
	
			String t = rs.getString(2); 
			int y = rs.getInt(3);
			String d = rs.getString(4); 
			
			out.println("<tr>" +
                          "<td><p>" + temp + "</p></td>" +
                          "<td><p>" + t  + "</p></td>" +
                          "<td><p>" + y + "</p></td>" +
                          "<td><p>" + d + "</p></td>" 
                  );
			
			// get genres
			String q2 = " select g.name,g.id	from genres g " 
				+	" inner join genres_in_movies gm on g.id = gm.genre_id "
				+	" where gm.movie_id = ?; ";
			PreparedStatement statement2 = ((Connection)c_session.getAttribute("connection")).prepareStatement(q2);
			statement2.setInt(1,temp);
			
			out.println("<td>");
			ResultSet rs2 = statement2.executeQuery();
			while (rs2.next()){
				int gid = rs2.getInt(2);
				String gn = rs2.getString(1);
				out.println("<p><a href='genre.jsp?"+"gid="+gid+"&gname="+gn+"'>"+ rs2.getString(1) + "</a></p>" );
			
				
			}
			out.println("</td>");
			//
			//get poster
			out.println("<td>");
			out.println("<img src='"+ rs.getString(5) + "' width='100' height='150' alt='No Poster'/>");
			out.println("</td>");
			
			//
			// get stars
			String q3 = " SELECT s.first_name,s.last_name,s.id "+
					" from  stars s "+
					" inner join stars_in_movies sm on s.id = sm.star_id "+
					" where sm.movie_id = ?;";
			PreparedStatement statement3 = ((Connection)c_session.getAttribute("connection")).prepareStatement(q3);

			out.println("<td>");
			statement3.setInt(1,temp);
			ResultSet rs3 = statement3.executeQuery();
			while (rs3.next()){
				int sid = rs3.getInt(3);
				String sname = rs3.getString(1) + " " +rs3.getString(2);
				out.println("<p><a href='star.jsp?"+"sid="+sid+"'>" + sname + "</a></p>" );

			}
			out.println("</td>");
			//
			// get trailer
			out.println("<td>");
			out.println("<p><a href=" + rs.getString(6) + ">Trailer Link</a></p>");
			out.println("</td>");
			
			// add to cart

			out.println("<td><button type='submit' name='add' value='"+t+"'>Add to Cart!</button></td>");
			out.println("</tr>");

		}
		
		

	}catch (SQLException ex) {
		   while (ex != null) {
		         System.out.println ("SQL Exception:  " + ex.getMessage ());
		         ex = ex.getNextException ();
		     }  // end while
		  // end catch SQLException
		   response.sendRedirect("login.jsp");

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
	if (request.getParameter("movieid") != null){
		out.println("ahhahahah -> "+request.getParameter("movieid") );
	}else{
		out.println("xxxxxx" );
	}
	*/
%>
</table>
</CENTER>
</FORM>
</body>
</html>
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
<title>search</title>

</head>

<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Search Movies</H1>

<FORM ACTION = "movieList.jsp" METHOD = "GET">
<input type="submit" name="co" value="Check Out!" style="float: right;">

<% 
	if (request.getParameter("co") != null){
		// go chekc out!
		request.getRequestDispatcher("checkout.jsp").forward(request, response);
	}




%>

</FORM>

	<CENTER>

<FORM ACTION="search.jsp"
      METHOD = "GET">
  Title: <INPUT TYPE="TEXT" NAME="t"><BR>
  Year: <INPUT TYPE="TEXT" NAME="y"><BR>
  Director: <INPUT TYPE="TEXT" NAME="d"><BR>
  Star's First name: <INPUT TYPE="TEXT" NAME="fn"><BR>
  Star's Last name: <INPUT TYPE="TEXT" NAME="ln"><BR>
  
  <CENTER>
    <INPUT TYPE="SUBMIT" NAME = "search" VALUE="Search!">
  </CENTER>
</FORM>

</CENTER>

<% 


	if  (request.getParameter("search") != null){
	
		response.setContentType("text/html");    // Response mime type
	
	
	
		HttpSession c_session = request.getSession(true);
		List<Integer> final_movie_id_list = new ArrayList<Integer>();
	
		try
		{
			//Class.forName("org.gjt.mm.mysql.Driver");
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			
			
			// Declare our statement
			Statement statement = ((Connection)c_session.getAttribute("connection")).createStatement();
			
			String title = request.getParameter("t");
			String year = request.getParameter("y");
			String director = request.getParameter("d");
			String first = request.getParameter("fn");
			String last = request.getParameter("ln");

			
			
			
			if (title==null && year==null&& director==null && first==null && last ==null){
				//request.setAttribute("searchOptions","");
				out.print("Please Fill At Least One Field. ");
			}else{
				int a1=0;
				int a2=0;
				String query = "SELECT id from movies where ";
				int staronly = 1;
				
				if (!title.equals("")){
				 a1 = 1;
				 String temp = "title like '%" + title + "%' ";
				 query +=  temp;
				 staronly = 0;
				 
				}
				if (!year.equals("")){
				 	a2 = 1;
					if (a1 == 1){
					 String temp = "and year like '%" + year + "%'";
					 query +=  temp;
					 staronly = 0;
					}else{
						String temp = "year like '%" + year + "%'";
						 query +=  temp;
						 staronly = 0;
						
					}
				}
				if (!director.equals("")){
				 
					if (a2 == 1){
						 String temp = "and director like '%" + director + "%'";
						 query +=  temp;
						 staronly = 0;
					}else if(a1 == 1){
						 String temp = "and director like '%" + director + "%'";
						 query +=  temp;
						 staronly = 0;
						
					}else{
						String temp = "director like '%" + director + "%'";
						 query +=  temp;
						 staronly = 0;
						
					}
				
				}
				
				if (staronly == 0){
				 
				 query += ";";
				}else{
				 
				 query = "select id from movies;";
				}
				
				
				// Perform the query
				ResultSet rs = statement.executeQuery(query);
				
				List<Integer> movie_id_list = new ArrayList<Integer>();
				List<Integer> sm_id_list = new ArrayList<Integer>();
			
				
				while (rs.next()){
				 
				    movie_id_list.add(rs.getInt(1));
				   
				}
				
				int no_name = 0;
				
 				if (first.equals("")){
 					
 					if(last.equals("")){
 						no_name = 1;
 					}
 				}
				
 				
				if (no_name !=1){
					String q2 = "";
					
				    
				    q2 =" SELECT DISTINCT sm.movie_id from  stars_in_movies sm left join stars s "
								 + " on sm.star_id = s.id where s.first_name like '%" 
				    			 + first + "%' and s.last_name like '%" + last + "%';" ;
				    	
				    
					ResultSet rs2 = statement.executeQuery(q2);
					
					while (rs2.next()){
						int temp = rs2.getInt(1);
						for (int i=0; i < movie_id_list.size(); i++){
							if (temp == movie_id_list.get(i)){
								final_movie_id_list.add(temp);
							}
						}
					}
				    
				}else{
					for (int i =0; i < movie_id_list.size();i++){
						final_movie_id_list.add(movie_id_list.get(i));	
					}
				}
				
				c_session.setAttribute("movielist", final_movie_id_list);
				response.sendRedirect("movieList.jsp");
				//request.getRequestDispatcher("movieList.jsp").forward(request, response);
			}    
		
		}catch (SQLException ex) {
		   while (ex != null) {
		         System.out.println ("SQL Exception:  " + ex.getMessage ());
		         ex = ex.getNextException ();
		     }  // end while
		  // end catch SQLException
		   response.sendRedirect("login.jsp");

		}
		catch(java.lang.Exception ex){
		     out.println("<HTML>" +
		                 "<HEAD><TITLE>" +
		                 "MovieDB: Error" +
		                 "</TITLE></HEAD>\n<BODY>" +
		                 "<P>SQL error in doGet: " +
		                 ex.getMessage() + "</P></BODY></HTML>");
		     response.sendRedirect("login.jsp");
		}
		
	}

%>


</body>
</html>
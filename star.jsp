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
<title>star</title>
    <link rel="stylesheet" type="text/css" href="tooltipster/dist/css/tooltipster.bundle.min.css" />

    <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.0.min.js"></script>
    <script type="text/javascript" src="tooltipster/dist/js/tooltipster.bundle.min.js"></script>
 
<script>
        $(document).ready(function() {
            $('.tooltip').tooltipster({
            			delay: 200
            	
            });
        });
    </script>
</head>

</head>
<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Star</H1>

<FORM ACTION = "main.jsp" METHOD = "GET">
<input type="submit" name="co" value="Check Out!" style="float: right;">

<% 
	if (request.getParameter("co") != null){
		// go chekc out!
		request.getRequestDispatcher("checkout.jsp").forward(request, response);
	}




%>

</FORM>
	<CENTER>

	<table border=1 id="results">
	
	<tr>
	
	<td>ID</td>
	<td>Name</td>
	<td>Date of Birth</td>		
	<td>Picture</td>
	<td>Movies</td>	
		
			
	</tr>
<% 
String info ="";
HttpSession c_session = request.getSession(true);
List<Integer> list = new ArrayList<Integer>();

try{

String q22 = "select sm.movie_id from stars s left join stars_in_movies sm on s.id = sm.star_id where s.id = ?;";
PreparedStatement sta22 = ((Connection)c_session.getAttribute("connection")).prepareStatement(q22);
sta22.setInt(1,Integer.parseInt(request.getParameter("sid")));
ResultSet rss22 = sta22.executeQuery();

while (rss22.next()){
	list.add(rss22.getInt(1));
}
}catch (SQLException ex) {
	   while (ex != null) {
	         System.out.println ("SQL Exception:  " + ex.getMessage ());
	         ex = ex.getNextException ();
	     }  // end while
	  // end catch SQLException
	   //response.sendRedirect("login.jsp");

}catch(java.lang.Exception ex){
  out.println("<HTML>" +
              "<HEAD><TITLE>" +
              "MovieDB: Error" +
              "</TITLE></HEAD>\n<BODY>" +
              "<P>SQL error in doGet: " +
              ex.getMessage() + "</P></BODY></HTML>");
 // response.sendRedirect("login.jsp");
}
int size = list.size();

// saving m's info:
	Map<Integer,String> mmap = new HashMap<Integer, String>();
//					"<div><button type='submit' name='add2' value='"+  id  +"'>Add to Cart!</button></div>";

	for (int i =0; i <size;i++){
	
		try
		{
			
			
			
			
			//Class.forName("org.gjt.mm.mysql.Driver");
			//Class.forName("com.mysql.jdbc.Driver").newInstance();
			
			// Declare our statement
			//Statement statement3 = ((Connection)c_session.getAttribute("connection")).createStatement();
	
		//	out.println(start + " ---- " + (stop-start));
			String que = "select m.title, m.year, m.director, m.banner_url, m.trailer_url,m.id from movies as m where m.id = ?;" ;
			PreparedStatement sta = ((Connection)c_session.getAttribute("connection")).prepareStatement(que);

			sta.setInt(1, list.get(i));
			ResultSet rss = sta.executeQuery();
			
//"&lt;i&gt;
			String tp = "";
			while(rss.next()){
				//temp += "<img src=\""+ rs.getString(4)+ "\"/> \n\n";
				tp += "Title : " + rss.getString(1)+ " \n";
    			tp += "Year : " + rss.getString(2)+ " \n";
    			tp += "Director : " + rss.getString(3)+ " \n\n";
    			
    			tp += "Banner_url : " + rss.getString(4)+ " \n\n";
    			tp += "Trailer_url : " + rss.getString(5)+ " \n\n";
				//temp += "<div><button type='submit' name='add2' value='"+ list.get(i) +"'>Add to Cart!</button></div>";
				tp += "Stars : ";
					 //left join (select g.name, gim.movie_id from genres as g inner join genres_in_movies as gim on g.id = gim.genre_id ) as gm on gm.movie_id = m.id ;

				String qq = "select sm.first_name,sm.last_name from movies as m left join (select s.first_name, s.last_name, sim.movie_id from stars as s inner join stars_in_movies as sim on s.id = sim.star_id) as sm on sm.movie_id = m.id where m.id = "+rss.getInt(6)+";"; 
				Statement staq = ((Connection)c_session.getAttribute("connection")).createStatement();
				ResultSet rssq = staq.executeQuery(qq);
				int qi = 0;
				while(rssq.next()){
					if (qi == 0){
						tp+= rssq.getString(1) +" "+ rssq.getString(2) +"\n";
					}else{
					
						tp+=  "\t"+rssq.getString(1) +" "+ rssq.getString(2)+"\n";
					}
					qi=1;
				}
				tp += "\n";
				tp += "Genres : ";
				String qq1 = "select sm.name from movies as m  left join (select g.name, gim.movie_id from genres as g inner join genres_in_movies as gim on g.id = gim.genre_id ) as sm on sm.movie_id = m.id where m.id = ?;"; 

				PreparedStatement staq1 = ((Connection)c_session.getAttribute("connection")).prepareStatement(qq1);
				staq1.setInt(1,rss.getInt(6));
				ResultSet rssq1 = staq1.executeQuery();
				int qi1 = 0;
				while(rssq1.next()){
					if (qi1 == 0){
						tp+= rssq1.getString(1) +"\n";
					}else{
					
						tp+=  "\t\t"+rssq1.getString(1) +"\n";
					}
					qi1=1;
				}
				tp += "\n";
				
				
				//temp = StringEscapeUtils.escapeHtml(temp);
				mmap.put(list.get(i),tp);
			}
			
			
			
			
			
			
			
		}catch (SQLException ex) {
			   while (ex != null) {
			         System.out.println ("SQL Exception:  " + ex.getMessage ());
			         ex = ex.getNextException ();
			     }  // end while
			  // end catch SQLException
			   //response.sendRedirect("login.jsp");
	
		}catch(java.lang.Exception ex){
		     out.println("<HTML>" +
		                 "<HEAD><TITLE>" +
		                 "MovieDB: Error" +
		                 "</TITLE></HEAD>\n<BODY>" +
		                 "<P>SQL error in doGet: " +
		                 ex.getMessage() + "</P></BODY></HTML>");
		    // response.sendRedirect("login.jsp");
		}
			
		
		
	}



 

response.setContentType("text/html");    // Response mime type
//HttpSession c_session = request.getSession(true);

try{

	String query = "select * from stars  where id = ?;";
			
	PreparedStatement statement = ((Connection)c_session.getAttribute("connection")).prepareStatement(query);
	statement.setInt(1,Integer.parseInt(request.getParameter("sid")));

	ResultSet rs = statement.executeQuery();

	while(rs.next()){
		int temp = rs.getInt(1);
		String name = rs.getString(2) + rs.getString(3); 
		String dob = rs.getString(4);
		String pic = rs.getString(5); 
		
		out.println("<tr>" +
                      "<td>" + temp + "</td>" +
                      "<td>" + name + "</td>" +
                      "<td>" + dob  + "</td>" +
                      "<td><img src='"+ pic + "' width='100' height='150' alt='No Poster'/></td>" 
                      
        );
		
		String q2 = " select title,id from movies m " +
				" inner join stars_in_movies sm on m.id = sm.movie_id " +
				" where sm.star_id = ?;";
		PreparedStatement statement2 = ((Connection)c_session.getAttribute("connection")).prepareStatement(q2);
		statement2.setInt(1,temp);
		out.println("<td>");
		ResultSet rs2 = statement2.executeQuery();
		while (rs2.next()){
			int mid = rs2.getInt(2);
			String mtitle = rs2.getString(1);
			info = mmap.get(mid);
			out.println("<p><a href='movie.jsp?"+"movieid="+mid+"'  class='tooltip' title = '"+info+"' >" + mtitle + "</a></p>" );		
		}
		out.println("</td>");
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

/*
if (request.getParameter("sid") != null){
		out.println("ahhahahah -> "+request.getParameter("sid") );
	}else{
		out.println("xxxxxx" );
	}

*/
%>
</table>
</CENTER>
</body>
</html>
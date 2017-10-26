<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@page import="java.io.*" %>
    <%@page import="java.sql.*" %>
    <%@page import="java.util.*" %>
    <%@page import="javax.servlet.*" %>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
    
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>movieList</title>
  
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


<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Movie List</H1>



<FORM ACTION = "movieList.jsp" METHOD = "GET">
<input type="submit" name="co" value="Check Out!" style="float: right;">

<% 
	if (request.getParameter("co") != null){
		// go chekc out!
		request.getRequestDispatcher("checkout.jsp").forward(request, response);
	}


	String save = "movieList.jsp?";


%>
<input type="submit" name="prev" value="Prev Page" style="float: left;">
<input type="submit" name="next" value="Next Page" style="float: left;">


<center>

<h3>Choose Max Items Per Page: 

<select name="choosemax" id="choosemax">
<option value="5">5</option>
<option value="10">10</option>
<option value="20">20</option>
<option value="50">50</option>
<option value="100">100</option>
</select>
<input type="submit" name="setmax" value="Set!">

</h3>

 
  
<% 
String info ="";
response.setContentType("text/html");    // Response mime type
HttpSession c_session = request.getSession(true);
List<Integer> list = new ArrayList<Integer>();
int size = 0;
if(c_session.getAttribute("movielist")!=null){ 
list = (List<Integer>)c_session.getAttribute("movielist");
size = list.size();
}
// saving m's info:
	Map<Integer,String> mmap = new HashMap<Integer, String>();
//					"<div><button type='submit' name='add2' value='"+  id  +"'>Add to Cart!</button></div>";

	for (int i =0; i <size;i++){
	
		try
		{
			//Class.forName("org.gjt.mm.mysql.Driver");
			//Class.forName("com.mysql.jdbc.Driver").newInstance();
			
	
		//	out.println(start + " ---- " + (stop-start));
			String query = "select m.title, m.year, m.director, m.banner_url, m.trailer_url,m.id from movies as m where m.id =?;" ;
			PreparedStatement statement = ((Connection)c_session.getAttribute("connection")).prepareStatement(query);
			statement.setInt(1, list.get(i));
			ResultSet rs = statement.executeQuery();
//"&lt;i&gt;
			String temp = "";
			while(rs.next()){
				//temp += "<img src=\""+ rs.getString(4)+ "\"/> \n\n";
				temp += "Title      : " + rs.getString(1)+ " \n";
    			temp += "Year       : " + rs.getString(2)+ " \n";
    			temp += "Director   : " + rs.getString(3)+ " \n\n";
    			temp += "Banner_url : " + rs.getString(4)+ " \n\n";

    			temp += "Trailer_url: " + rs.getString(5)+ " \n\n";
				//temp += "<div><button type='submit' name='add2' value='"+ list.get(i) +"'>Add to Cart!</button></div>";
    			temp += "Stars : ";
				 //left join (select g.name, gim.movie_id from genres as g inner join genres_in_movies as gim on g.id = gim.genre_id ) as gm on gm.movie_id = m.id ;

			String qq = "select sm.first_name,sm.last_name from movies as m left join (select s.first_name, s.last_name, sim.movie_id from stars as s inner join stars_in_movies as sim on s.id = sim.star_id) as sm on sm.movie_id = m.id where m.id = "+rs.getInt(6)+";"; 
			PreparedStatement staq = ((Connection)c_session.getAttribute("connection")).prepareStatement(qq);
			staq.setInt(1,rs.getInt(6));
			ResultSet rssq = staq.executeQuery();
			int qi = 0;
			while(rssq.next()){
				if (qi == 0){
					temp+= rssq.getString(1) +" "+ rssq.getString(2) +"\n";
				}else{
				
					temp+=  "\t"+rssq.getString(1) +" "+ rssq.getString(2)+"\n";
				}
				qi=1;
			}
			temp += "\n";
			temp += "Genres : ";
			String qq1 = "select sm.name from movies as m  left join (select g.name, gim.movie_id from genres as g inner join genres_in_movies as gim on g.id = gim.genre_id ) as sm on sm.movie_id = m.id where m.id = ?;"; 

			PreparedStatement staq1 = ((Connection)c_session.getAttribute("connection")).prepareStatement(qq1);
			staq1.setInt(1,rs.getInt(6));
			ResultSet rssq1 = staq1.executeQuery();
			int qi1 = 0;
			while(rssq1.next()){
				if (qi1 == 0){
					temp+= rssq1.getString(1) +"\n";
				}else{
				
					temp+=  "\t\t"+rssq1.getString(1) +"\n";
				}
				qi1=1;
			}
			temp += "\n";
			
				//temp = StringEscapeUtils.escapeHtml(temp);
				mmap.put(list.get(i),temp);
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




%>
</center>
	
	<CENTER>

	
<table border=1 id="results">
	
	<tr>
	
	<td>ID</td>
	
	<td>
	<a href = 
		<%
		
		
		String taurl = "";
		if (request.getParameter("sort") == null){
			
			
	//		save += request.getQueryString();
			
			taurl = save + "&sort=titledsc";
			
		}else if (request.getParameter("sort").equals("yearasc")){
			
			taurl = save + "&sort=titleasc";
		}else if (request.getParameter("sort").equals("titleasc")){
			
	        taurl = save +"&sort=titledsc";
		}else if (request.getParameter("sort").equals("titledsc")){
			
	        taurl = save +"&sort=titleasc";
		}else if (request.getParameter("sort").equals("yeardsc")){
			
	        taurl = save +"&sort=titleasc";

		}
		/*
 		c_session.setAttribute("max",5);
 		c_session.setAttribute("startat",0);
 		
 		if (5 > size ){
 	    	c_session.setAttribute("stopat", size);
    	}
    	
    	c_session.setAttribute("stopat", 5);
*/
		out.print(taurl);
		
		
		%> 
	>Title</a></td> 
	<td><a href = 
		<% 
		
		
		String yaurl = "";
		if (request.getParameter("sort") == null){
			
		//	oldurl += request.getServletPath()+ "?"+request.getQueryString();
			yaurl = save + "&sort=yearasc";

		}else if (request.getParameter("sort").equals("titleasc")){
			yaurl = save +"&sort=yearasc";
			
		}else if (request.getParameter("sort").equals("yearasc")){
			yaurl = save  +"&sort=yeardsc";
			
		}else if (request.getParameter("sort").equals("yeardsc")){
			yaurl = save +"&sort=yearasc";
		}else if (request.getParameter("sort").equals("titledsc")){
			yaurl = save +"&sort=yearasc";
		
		}
		/*
		c_session.setAttribute("max",5);
 		c_session.setAttribute("startat",0);
 		
 		if (5 > size ){
 	    	c_session.setAttribute("stopat", size);
    	}
    	
    	c_session.setAttribute("stopat", 5);*/
		out.print(yaurl);
		
	%> 
	>Year</a></td> 
	<td>Director</td>		
	<td>Genres</td>
	<td>Stars</td>			
	<td>Add To Cart</td>
	
			
	</tr>
	


<% 



	//List<Integer> list = (List<Integer>)request.getAttribute("movielist");


//out.println(list.size());






	
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
	
	}else if (request.getParameter("add2") != null){
		
		//request.getRequestDispatcher("checkout.jsp").forward(request, response);
	
				
	
	
		String mt = request.getParameter("add2");
			HashMap<String,Integer> cart = (HashMap<String,Integer>)c_session.getAttribute("cart");
			if (cart.containsKey(mt)){
			cart.put(mt,cart.get(mt)+1);
	
		}else{
			cart.put(mt,1);
	
		}
		c_session.setAttribute("cart", cart);
		request.setAttribute("added", "Item Added into Cart~!");
		request.getRequestDispatcher("main.jsp").forward(request, response);
	
	}else{
		
		
		

		if (list!=null){
	
		    	/*
		    	synchronized(c_session) {
			   		HashMap<String,Integer> cart = (HashMap<String,Integer>)c_session.getAttribute("cart");
		    		if (cart == null) {
		    			cart = new HashMap<String,Integer>();
		    			c_session.setAttribute("cart", cart);
		    	
		
		  //			synchronized(cart) {
			    		if (cart.containsKey(mt)){
			    			cart.put(mt,cart.get(mt)+1);
				    		c_session.setAttribute("cart", cart);
		
			    		}else{
			    			cart.put(mt,1);
				    		c_session.setAttribute("cart", cart);
		
			    			}
		  				//}
		    		}	
		    	}
		    	*/
		    /*
		    if (request.getAttribute("size") == null){

		    	request.setAttribute("size",list.size()); 	
		    }
		    	*/

		 	if (c_session.getAttribute("max") == null){
		 	
		 	
		 		c_session.setAttribute("max",5);
		 	}
		   	
		 	if (c_session.getAttribute("startat") == null){

		   
		 		c_session.setAttribute("startat",0);
		 	}
		 	
		    if (c_session.getAttribute("stopat") == null){
				
		 		
		    	int tmp = (Integer)c_session.getAttribute("max") + (Integer)c_session.getAttribute("startat") ;
		    	if (tmp > size ){
		    		tmp = size;
		    	}
		    	
		    	c_session.setAttribute("stopat", tmp);

		    }
		    
		    if (request.getParameter("setmax") != null){
				c_session.setAttribute("max", Integer.parseInt(request.getParameter("choosemax")));
				int st = (Integer)c_session.getAttribute("startat");
			   	int sp = (Integer)c_session.getAttribute("startat") + Integer.parseInt(request.getParameter("choosemax"));
			   	if (sp <= size){
					c_session.setAttribute("stopat", sp);
			   	}else{
					c_session.setAttribute("stopat", size);
			   	}
			}
		    
		    
		    
		  //  int max = (Integer)request.getAttribute("max");
		   	int start = (Integer)c_session.getAttribute("startat");
		   	int stop = (Integer)c_session.getAttribute("stopat");
		   	int max = (Integer)c_session.getAttribute("max");
		   	
		   	
			

		   	
		   	
		   	/*
		   		if ((stop + max) > size){
		   			c_session.setAttribute("stopat", size);

		   		}else{
		   			c_session.setAttribute("stopat", (stop+max));
		   		}
		   	}
			
		   	max = (Integer)c_session.getAttribute("max");

		   	*/

		    
		   	if (request.getParameter("prev") != null){
		   		
		   		if((start - max) >= 0){
		   			start -= max;
		   			stop -= max;
		   		}else if (start > 1){
		   			
		   			stop = max;
		   			start = 0;
		   		}
		   		c_session.setAttribute("stopat", stop);
				c_session.setAttribute("startat", start);
		   	}
			if (request.getParameter("next") != null){
		   		
		   		if(stop < size){
		   			start = stop;
		   			if ((stop+max) > size){
		   				stop = size;
		   			}else{
		   				stop += max;
		   			}
		   		}
		   		c_session.setAttribute("stopat", stop);
				c_session.setAttribute("startat", start);
		   	}
			/*
			if (request.getParameter("setmax") != null){
		   		
		   		
		   		c_session.setAttribute("max",Integer.parseInt(request.getParameter("choosemax")));
		   		
		   		out.println(Integer.parseInt(request.getParameter("choosemax")));
		   		
		   	}
			start = (Integer)c_session.getAttribute("startat");
		   	stop = (Integer)c_session.getAttribute("stopat");
		   	max = (Integer)c_session.getAttribute("max");
			*/
			try
			{
				//Class.forName("org.gjt.mm.mysql.Driver");
				//Class.forName("com.mysql.jdbc.Driver").newInstance();
				
				// Declare our statement
				Statement statement = ((Connection)c_session.getAttribute("connection")).createStatement();
				Statement statement2 = ((Connection)c_session.getAttribute("connection")).createStatement();
				Statement statement3 = ((Connection)c_session.getAttribute("connection")).createStatement();
		
			//	out.println(start + " ---- " + (stop-start));
				String query = "select * from movies order by title asc ;";// limit "+ start+","+(stop-start)+";";
				
				
				
				if (request.getParameter("sort") != null){
					max = (Integer)c_session.getAttribute("max");
			 		c_session.setAttribute("startat",0);
			 		
			 		if (max > size ){
			 	    	c_session.setAttribute("stopat", size);
			    	}else{
			    	
			    		c_session.setAttribute("stopat", max);
			    	}
			    	start = (Integer)c_session.getAttribute("startat");
				   	stop = (Integer)c_session.getAttribute("stopat");
				 //  	max = (Integer)c_session.getAttribute("max");
					
					if(request.getParameter("sort").equals("titleasc")){
						
						query = "select * from movies order by title asc ;";//limit "+ start+","+(stop-start)+";";
				
					}else if (request.getParameter("sort").equals("yearasc")){
					
						query = "select * from movies order by year asc ;";//limit "+ start+","+(stop-start)+";";
					
					}else if (request.getParameter("sort").equals("yeardsc")){
					
						query = "select * from movies order by year desc ;";//limit "+ start+","+(stop-start)+";";
					
					}else if (request.getParameter("sort").equals("titledsc")){
					
						query = "select * from movies order by title desc ;"; //limit "+ start+","+(stop-start)+";";
					
					}
				}
			
				//
				//
				///
				/*
				if ((start+max) < size){
					start = start + max;
				}
				if ((stop + max) <= size){
					stop = stop+max;	
				}else{
					stop = size;
				}*/
				
				
				
				///
				//
				//
		
			
				ResultSet rs = statement.executeQuery(query);
				List<String> outlist = new ArrayList<String>();
				int xx = 0;
				while(rs.next()){
					xx+=1;
					int temp = rs.getInt(1);
				//	for (int i=0; i<list.size();i++){
					//	out.println("->> "+temp+" vs " + list.get(i));
					if (list.contains(temp)){
						String outline = "";
						String t = rs.getString(2); 
						int y = rs.getInt(3);
						String d = rs.getString(4); 
						info = mmap.get(temp);
						request.setAttribute("info", info);
		            	

						outline += "<tr>" +
	                            "<td>" + temp + "</td>" +
	                            "<td><a href='movie.jsp?"+"movieid="+temp+"'  class='tooltip' title = '"+info+"'   >" + t  + "</a></td>" +
	    	                 //   "<td><a href='movie.jsp?"+"movieid="+temp+"' class='tooltip'  title='#tooltip_content'   >" + t  + "</a></td>" +

	                            "<td>" + y + "</td>" +
	                            "<td>" + d + "</td>" ;
	                    
						
						// get genres
						String q2 = " select g.name	from genres g " 
							+	" inner join genres_in_movies gm on g.id = gm.genre_id "
							+	" where gm.movie_id = "+ temp +"; ";
						
						outline+="<td>";
						ResultSet rs2 = statement2.executeQuery(q2);
						while (rs2.next()){
							outline+="<p>" + rs2.getString(1) + "</p>";
							
						}
						outline += "</td>";
						//
						// get stars
						String q3 = " SELECT s.first_name,s.last_name,s.id "+
								" from  stars s "+
								" inner join stars_in_movies sm on s.id = sm.star_id "+
								" where sm.movie_id = "+ temp+ ";";
						
						outline+="<td>";
						ResultSet rs3 = statement3.executeQuery(q3);
						while (rs3.next()){
							int sid = rs3.getInt(3);
							String sname = rs3.getString(1) + " " +rs3.getString(2);
							outline+="<p><a href='star.jsp?"+"sid="+sid+"'>" + sname + "</a></p>" ;
	
						}
						outline += "</td>";
						//
						// Add to cart

						outline +="<td><button type='submit' name='add' value='"+t+"'>Add to Cart!</button></td>";
						outline +="</tr>";
						outlist.add(outline);
					}
				}
		
			//	out.println(xx + " --- "+ size+ " --- " +outlist.size()+ " --- ");
			
			//	out.println( "?? --- "+ start+ " --- " +stop+ " --- ");
				
				if(stop > outlist.size()){
					stop = outlist.size();
				}
				
				for(int i =start; i<stop;i++){
					//out.println( " --- "+ start+ " --- " +stop+ " --- ");
					out.println(outlist.get(i));
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
	}

%>

</table>
</CENTER>
</FORM>
</body>
</html>
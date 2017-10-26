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
<title>_addmovie</title>

</head>

<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Add a New Movie</H1>
<CENTER>
<FORM ACTION = "_addmovie.jsp" METHOD = "GET"> 


  Movie's title: <INPUT TYPE="TEXT" NAME="mt"><BR>
  Movie's year: <INPUT TYPE="TEXT" NAME="my"><BR>
  Movie's director: <INPUT TYPE="TEXT" NAME="md"><BR>
  Star's first name: <INPUT TYPE="TEXT" NAME="sf"><BR>
  Star's last name: <INPUT TYPE="TEXT" NAME="sl"><BR>
  Genre's name: <INPUT TYPE="TEXT" NAME="gn"><BR>


  <CENTER>
    <INPUT TYPE="SUBMIT" NAME = "addanewmovie" VALUE="Add!">
  </CENTER>
</FORM>

</CENTER>

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
	
	if  (request.getParameter("addanewmovie") != null){
		
		try{
			
			String mt = request.getParameter("mt");
			String my = request.getParameter("my");
			String md = request.getParameter("md");
			String sf = request.getParameter("sf");
			String sl = request.getParameter("sl");
			String gn = request.getParameter("gn");
			
			
			if(my.length()!=4){
				
				out.println("<center><div><h3> Invalid Inputs! Try Again~!</h3></div></center> ");
				

			}else{
			
			int bad = 0;
			for (int i=0; i<4; i++){
				
				
		    	if(my.charAt(i)<'0' || my.charAt(i)>'9'){
		    			bad = 1;
		    	}
		
			}
				
			if(bad == 0){
				
			List<String> temp = new ArrayList<String>();
			temp.add(mt);
			temp.add(my);
			temp.add(md);
			temp.add(sf);
			temp.add(sl);
			temp.add(gn);

			/*
			int good = 1;
			for (int i=0; i<6;i++){
				
			}*/
			if(temp.contains("") || temp.contains(" ")){
				
				out.println("<center><div><h3> Invalid Inputs(Empty Fields)! Try Again~!</h3></div></center> ");

			}else{
				
				
			
				
				
		 	String query = "{CALL add_movie(?,?,?,?,?,?)}";
		 	
		 	CallableStatement call = connection.prepareCall(query);
		 	
		 	call.setString(1, mt);
			call.setInt(2, Integer.parseInt(my));
			call.setString(3, md);
			call.setString(4, sf);
			call.setString(5, sl);
			call.setString(6, gn);

			ResultSet rs = call.executeQuery();
			
			
			while(rs.next()){
				
				out.println("<center><div><h3>"+ rs.getString("answer") +"</h3></div></center> ");
				
			}
			}
			}else{
				out.println("<center><div><h3> Invalid Inputs(Year)! Try Again~!</h3></div></center> ");

			}
			}
				
		
		}catch (SQLException ex) {
			
		   while (ex != null) {
		         out.println ("SQL Exception:  " + ex.getMessage ());
		         ex = ex.getNextException ();
		     }  // end while
		   //end catch SQLException
		  // response.sendRedirect("_dashboardLogin.jsp");

           // out.println("<center><h3>Add Failed! Error: Input Infomation Error! </h3></center>"); 

		}
		catch(java.lang.Exception ex){
		     out.println("<HTML>" +
		                 "<HEAD><TITLE>" +
		                 "MovieDB: Error" +
		                 "</TITLE></HEAD>\n<BODY>" +
		                 "<P>SQL error in doGet: " +
		                 ex.getMessage() + "</P></BODY></HTML>");
			   //response.sendRedirect("_dashboardLogin.jsp");
		}
		
	}

%>


</body>
</html>
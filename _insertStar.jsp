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
<title>_insertStar</title>

</head>

<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Insert a Star</H1>
<CENTER>
<FORM ACTION = "_insertStar.jsp" METHOD = "GET">
  Star's name: <INPUT TYPE="TEXT" NAME="n"><BR>
  
  <CENTER>
    <INPUT TYPE="SUBMIT" NAME = "insert" VALUE="Insert!">
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
	
	if  (request.getParameter("insert") != null){
		
		try{
			String name = request.getParameter("n");
			
			String[] fullname = name.split(" ");
            
            String first = "";
            String last = "";
            
            // Search by full name.
            if (fullname.length == 2){
                first = fullname[0];
                last = fullname[1];
            }else if (fullname.length == 1){
                last = fullname[0];
                first = "";
            }
            
            /*
          
            */
            
            String checkcommand = "select * from stars where first_name = ? and last_name = ? ;";
            PreparedStatement check= connection.prepareStatement(checkcommand);
    		check.setString(1,first);
    		check.setString(2,last);
            ResultSet checkres = check.executeQuery();
            int exist = 0;
            while(checkres.next()){
            	exist = 1;
            }
            
            String sqlCommand = " INSERT INTO stars(first_name,last_name) " + "VALUES ('"+first+"', '"+last+"');";

            if (!name.equals("")){
            	
            	if (exist == 0){
            		
		            Statement update = connection.createStatement();
		            int retID = update.executeUpdate(sqlCommand);
		            out.println("<center><h3>Successfully Inserted! </h3></center>"); 
            	}else{
            		
    	            out.println("<center><h3>Insertion Failed! Error: Star Exists! </h3></center>"); 

            	}
            	
            }else{
	            out.println("<center><h3>Insertion Failed! Error: No Name Entered! </h3></center>"); 

            }	
				
		
		}catch (SQLException ex) {
		   while (ex != null) {
		         System.out.println ("SQL Exception:  " + ex.getMessage ());
		         ex = ex.getNextException ();
		     }  // end while
		  // end catch SQLException
		   response.sendRedirect("_dashboardLogin.jsp");

		}
		catch(java.lang.Exception ex){
		     out.println("<HTML>" +
		                 "<HEAD><TITLE>" +
		                 "MovieDB: Error" +
		                 "</TITLE></HEAD>\n<BODY>" +
		                 "<P>SQL error in doGet: " +
		                 ex.getMessage() + "</P></BODY></HTML>");
			   response.sendRedirect("_dashboardLogin.jsp");
		}
		
	}

%>


</body>
</html>
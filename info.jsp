<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@page import="java.io.*" %>
    <%@page import="java.sql.*" %>
    <%@page import="java.util.*" %>
    <%@page import="javax.servlet.*" %>
    <%@page import="java.text.DateFormat" %>
    <%@page import="java.text.SimpleDateFormat" %>
  
    

 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Info</title>
</head>

<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Credit Card Information Check!</H1>


<form ACTION = "info.jsp" METHOD = "POST">
<center>
  First Name: <INPUT TYPE="TEXT" NAME="fn"><BR>

  Last Name : <INPUT TYPE="TEXT" NAME="ln"><BR>
  
  Credit card Number: <INPUT TYPE="TEXT" NAME="cn"><BR>
  
  Expiration Date: <INPUT TYPE="TEXT" NAME="ed"><BR>
  
    <INPUT TYPE="SUBMIT" name = "verify" VALUE="Submit!">
  </CENTER>

<% 
	if (request.getAttribute("conf")!= null){
		out.println(request.getAttribute("conf"));
	}


	response.setContentType("text/html");    // Response mime type
	HttpSession c_session = request.getSession(false);
	
	String fn = "";
	String ln = "";
	String cn = "";
	String ed = "";

	if (request.getParameter("verify") != null){
		fn = request.getParameter("fn");
		ln = request.getParameter("ln");
		cn = request.getParameter("cn");
		ed = request.getParameter("ed");

	
	
	try{
		Statement statement = ((Connection)c_session.getAttribute("connection")).createStatement();
		//Statement statement2 = ((Connection)c_session.getAttribute("connection")).createStatement();

		String query = "select * from creditcards;";
		
		ResultSet rs = statement.executeQuery(query);
		
		int pass = 0;
		while (rs.next()){
				
			if (rs.getString(1).equals(cn)){
				
				if (rs.getString(2).equals(fn)){
			
					if(rs.getString(3).equals(ln)){
					
						if (rs.getString(4).equals(ed)){
					
							pass = 1;
							break;
						}
					}
				}
			}
		}
		
		
		if (pass == 1){
			
			java.util.Date date  = new java.util.Date() ;

		    DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
		
			String sd = formatter.format(date);
			
			//out.print(sd);

			Map<String,Integer> cart = (HashMap<String,Integer>)c_session.getAttribute("cart");
			int cid = (Integer)c_session.getAttribute("cid");
			Iterator<Map.Entry<String, Integer>> entries = cart.entrySet().iterator();

			while (entries.hasNext()) {
				// title = entry.getKey();
				Map.Entry<String, Integer> entry = entries.next();
				
				String pq = "select id from movies where title = ?;";
				PreparedStatement statement2 = ((Connection)c_session.getAttribute("connection")).prepareStatement(pq);
				statement2.setInt(1,Integer.parseInt(entry.getKey()));

				ResultSet rs2 = statement2.executeQuery();
				
				int mid = 0;
				while(rs2.next()){
					mid = rs2.getInt(1);
					break;
				}
				//out.print(mid);

				
				for (int i=0; i<entry.getValue(); i++){
					Statement statement3 = ((Connection)c_session.getAttribute("connection")).createStatement();
					String insert = "INSERT INTO sales(customer_id, movie_id, sale_date) VALUES("
									+ cid + ", " + mid + ", '" + sd +"');";
					statement3.executeUpdate(insert);
				}
			}
			
			request.setAttribute("conf", "Purchase Successful~!");
			request.getRequestDispatcher("confirm.jsp").forward(request, response);

		}else{
			
			String msg ="Wrong Credit Card Information! Back to Cart! ";
			
			request.setAttribute("wrongcard", msg);
			request.getRequestDispatcher("checkout.jsp").forward(request, response);

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
}



%>

</form>
</body>
</html>
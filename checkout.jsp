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
<title>checkout</title>
</head>
<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Review Your Shopping Cart!</H1>


<form ACTION = 'checkout.jsp' METHOD = 'GET'>


<input type="submit" name="proceed" value="Proceed!" style="float: right;">

<% 
	int empty = 0;

	if (request.getParameter("proceed") != null){
		// go chekc out!
	//	if (empty!=0){
		request.getRequestDispatcher("info.jsp").forward(request, response);
		//}
	}



%>


<table border=1 id="results">
	
	<tr>
	
	<td>Movies</td>
	<td>Unit Price</td>
	<td>Current Quantity</td>
	<td>Change to Quantity</td>
	<td>Delete Item</td>
	
	
	</tr>



<% 
	response.setContentType("text/html");    // Response mime type
	HttpSession c_session = request.getSession(true);
	
	if (request.getParameter("delete") != null){
		
		String d_title = request.getParameter("delete");
		synchronized(c_session) {
			Map<String,Integer> cart = (HashMap<String,Integer>)c_session.getAttribute("cart");
			
			Iterator<Map.Entry<String, Integer>> entries = cart.entrySet().iterator();

			while (entries.hasNext()) {
	    		Map.Entry<String, Integer> entry = entries.next();
	    		if (d_title.equals(entry.getKey())){
	    			
				
					cart.put(entry.getKey(), 0);
					
	    		}
			}
			c_session.setAttribute("cart", cart);
		}
		
		
	}

	if (request.getParameter("update") != null){
		
		

		synchronized(c_session) {
			Map<String,Integer> cart = (HashMap<String,Integer>)c_session.getAttribute("cart");
			
			Iterator<Map.Entry<String, Integer>> entries = cart.entrySet().iterator();

			while (entries.hasNext()) {
	    		Map.Entry<String, Integer> entry = entries.next();
	    		if (!( request.getParameter(entry.getKey()) == null ||request.getParameter(entry.getKey()).equals("") )){
	    			
					int newQ = Integer.parseInt(request.getParameter(entry.getKey()));
					if (newQ != entry.getValue()){
						cart.put(entry.getKey(), newQ);
					}
	    		}
			}
			c_session.setAttribute("cart", cart);
		}
		
		
	}
	
	synchronized(c_session) {
		Map<String,Integer> cart = (HashMap<String,Integer>)c_session.getAttribute("cart");
		if (cart.isEmpty()){
			out.print("No Item!");
			empty =1;
		}else{
			
		/*if (cart == null) {
    		cart = new HashMap<String,Integer>();
    		session.setAttribute("cart", cart);
    	}*/	
    
	

		
		   // out.print("<tr>");
			Iterator<Map.Entry<String, Integer>> entries = cart.entrySet().iterator();
    		int item = 0;
			while (entries.hasNext()) {
				Map.Entry<String, Integer> entry = entries.next();
	   			if(entry.getValue() > 0){
	   				item += 1;
	   				String title = entry.getKey();
					out.print( "<tr>"
	   						+ "<td><p>" + entry.getKey() + "</p></td>"
	   						+   "<td><p>" + "10.00" + "</p></td>"
	   						+   "<td><p>" + entry.getValue() + "</p></td>"
							+ "<td> <INPUT TYPE='text' NAME='"+entry.getKey()+"'><BR></td>"
							+ "<td> <button type='submit' name='delete' value='"+entry.getKey()+"'>Delete</button></td></tr>"
							);
	   			}
	   		}
		    //out.print("</tr>");

			if(item == 0){
				out.println("No Item!");
				
			}
		}
	}
	
	
	
%>


</table>
<center>
<input type='submit' name='update' value="Update!">
</center>
</form>
<% 
	if (request.getAttribute("wrongcard") != null) {

		out.println(request.getAttribute("wrongcard"));

	}
%>
</body>
</html>
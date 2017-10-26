<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.io.*" %>
    <%@page import="java.sql.*" %>
    <%@page import="java.util.*" %>
    <%@page import="javax.servlet.*" %>
      <%@page import="javax.json.*" %>
      <%@page import="com.google.gson.Gson" %>
  
 



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
	<script type="text/javascript" 
			src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
	<script src="js/jquery.autocomplete.js"></script>  
	<style>
		input {
			font-size: 100%
		}
	</style>
</head>

	
	

  
  

<BODY BGCOLOR="#FDF5E6">
<H1 ALIGN="CENTER">Main Page</H1>

<FORM ACTION = "main.jsp" METHOD = "GET">

<center>
FullTextSearch: <input type="text" id="input" name="input"/>
	
	
	
	<script>
		$("#input").autocomplete("dropdown.jsp");
	</script>
</center>
 
   

<center>   <INPUT TYPE="SUBMIT" NAME="go" VALUE="Search!">
</center>
<CENTER>Please Choose:</CENTER>

<input type="submit" name="co" value="Check Out!" style="float: right;">

<% 
	if (request.getParameter("co") != null){
		// go chekc out!
		request.getRequestDispatcher("checkout.jsp").forward(request, response);
	}

if (request.getParameter("go") != null){
	//request.getRequestDispatcher("movieList.jsp").forward(request, response);

	//response.sendRedirect("movieList.jsp");

		//out.println("<div> gogogogogogogogogogogogoggogo </div>");

	
	if (request.getParameter("input") != null ){
		//if (!temp.equals("")){
		//	request.setAttribute("inputtitle", request.getParameter("input"));
		//	request.getRequestDispatcher("simples.jsp").forward(request, response);


		String loginUser = "mytestuser";
		String loginPasswd = "mypassword";
		String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
		
		response.setContentType("text/html");    // Response mime type
		
		
		
		String input = request.getParameter("input");
		
		//if (input == null || input.equals("")) {
		//	return;
		//}
		
		response.setContentType("text/html");
		
		String[] tokens = input.split("\\s+");
		
		int size = tokens.length;
		
		String query = " SELECT id, title FROM movies WHERE ";
		
		for(int i=0; i<size; i++){
			if (i == (size-1)){
			
				query += " match (title) against ('"+tokens[i]+"*' in boolean mode);";
			}else{
				//query += " title like '"+tokens[i]+"%'  AND ";
				query += " match (title) against ('"+tokens[i]+"*' in boolean mode) AND ";
			}
		}
		// c_session.setAttribute("q", query);	
		//out.println(query);
		//match (title) against ('b*' in boolean mode) AND MATCH (title) AGAINST ('c*' IN BOOLEAN MODE) ;
		
		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		
		   Connection dbcon = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
			Statement statement = dbcon.createStatement();
		//     out.println("<div>1</div>");
		
			ResultSet rs = statement.executeQuery(query);	
		//     out.println("<div>2</div>");
		
			List<String> titleList = new ArrayList<String>();
			List<Integer> idList = new ArrayList<Integer>();
		
		//    out.println("<div>3</div>");
		
			while(rs.next()){
				idList.add(rs.getInt(1));
				titleList.add(rs.getString(2));
			}
		//    out.println("<div>4</div>");
		
		//	c_session.setAttribute("movielist", idList);
		//    out.println("<div>5</div>");
		
		//	c_session.setAttribute("titleList", titleList);
		//   out.println("<div>6</div>");
		
		
		//	request.setAttribute("ids", idList);
		//   request.setAttribute("titles", titleList);
		//     request.getRequestDispatcher("movieList.jsp").forward(request,response);
		//	
//	 		if (titleList.size() == 0){
//	 			out.println("$false");
		
//	 		}
//	 		for (int i =0; i<titleList.size(); i++){
				
//	 			out.println(titleList.get(i));
//	 		}
			
			HttpSession c_session = request.getSession(true);
			c_session.setAttribute("movielist",idList);			

			//response.sendRedirect("movieList.jsp");
			request.getRequestDispatcher("movieList.jsp").forward(request, response);

		
		}catch (SQLException ex) {
			   while (ex != null) {
			         System.out.println ("SQL Exception:  " + ex.getMessage ());
			         ex = ex.getNextException ();
			     }  // end while
			 //  response.sendRedirect("main.jsp");
			  // end catch SQLException
		}catch(java.lang.Exception ex){
				System.out.println("<HTML>" +
		           "<HEAD><TITLE>" +
		           "MovieDB: Error" +
		           "</TITLE></HEAD>\n<BODY>" +
		           "<P>SQL error in doGet: " +
		           ex.getMessage() + "</P></BODY></HTML>");
			//	response.sendRedirect("login.jsp");
		}
		
		
		
		// PrintWriter out = res.getWriter();
		//  out.println(c.get(Calendar.HOUR) + ":" + c.get(Calendar.MINUTE) + ":" + c.get(Calendar.SECOND));
		
		//out.println("Hello World" + Calendar.getInstance().get(Calendar.SECOND));
		

	}
	

}
%>
<div>
<center>

    <INPUT TYPE="SUBMIT" NAME="s" VALUE="Searching Movies!">
    <INPUT TYPE="SUBMIT" NAME="b" VALUE="Browsing Movies!">
    
   
    
  

	</CENTER></div>


</form>

<body>

<script language="javascript" type="text/javascript">


/*
//Browser Support Code
function ajaxFunction(){
	var ajaxRequest;  // The variable that makes Ajax possible!
	var dropdown = document.getElementById('dropdown');
	var inp = document.getElementById('inp');
	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	} catch (e){
		// Internet Explorer Browsers
		try{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e){
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function(){
		if(ajaxRequest.readyState == 4){
			//document.myForm.time.value = ajaxRequest.responseText;
			
			var opt =  document.createElement('option');
			opt.value = ajaxRequest.responseText;
			dropdown.appendChild(opt);
			
		}
	}
	ajaxRequest.open("GET", "/TomcatLogin/AjaxSearch", true);
	ajaxRequest.send(null);
}

/*



<form name='myForm'>
<div><input type='text' onChange="ajaxFunction();" name='title' list = "dropdown" id= "inp"/> <br/>
<datalist id = "dropdown">

</datalist>
<input type='submit' name="ss" value ="Search!" /></div>
</form>


*/





</script>


<% 
		//PrintWriter out = response.getWriter();


		response.setContentType("text/html");    // Response mime type

		if(request.getAttribute("added") != null){
			out.print("<center>");

			out.println(request.getAttribute("added"));
			out.print("</center>");

		}
		
		if (request.getParameter("s") != null){
	       // do something
			request.getRequestDispatcher("search.jsp").forward(request, response);


	       
		}
		else if (request.getParameter("b") != null){
	       // do something
			request.getRequestDispatcher("browse.jsp").forward(request, response);
		}
		
		

%>





</BODY>
</HTML>


<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
    <%@page import="java.io.*" %>
    <%@page import="java.sql.*" %>
    <%@page import="java.util.*" %>
    <%@page import="javax.servlet.*" %>
      <%@page import="javax.json.*" %>
      <%@page import="com.google.gson.Gson" %>
<%

	
	String loginUser = "mytestuser";
	String loginPasswd = "mypassword";
	String loginUrl = "jdbc:mysql://localhost:3306/moviedb";
	
	response.setContentType("text/html");    // Response mime type
	
	
	
	String input = request.getParameter("q");
	
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
	//	response.sendRedirect("movieList.jsp");
// 		if (titleList.size() == 0){
// 			out.println("$false");
	
// 		}
// 		for (int i =0; i<titleList.size(); i++){
			
// 			out.println(titleList.get(i));
// 		}
		//HttpSession c_session = request.getSession(true);
	//	c_session.setAttribute("movielist",idList);	
		
		
	
		Iterator<String> iterator = titleList.iterator();
		while(iterator.hasNext()) {
			String option = (String)iterator.next();
			out.println(option);
		}
		
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
	




%>
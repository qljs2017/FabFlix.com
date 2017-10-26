<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
 
<%
String input = request.getParameter("input");
response.setContentType("text/html");

String[] tokens = input.split("\\s+");

int size = tokens.length;

String query = " SELECT id, title FROM movies WHERE ";

for(int i=0; i<size; i++){
	if (i == (size-1)){
	
		query += " match (title) against ('"+tokens[i]+"*' in boolean mode);";
	}else{
		
		query += " match (title) against ('"+tokens[i]+"*' in boolean mode) AND ";
	}
}
		

//match (title) against ('b*' in boolean mode) AND MATCH (title) AGAINST ('c*' IN BOOLEAN MODE) ;
HttpSession c_session = request.getSession(true);

try{
	Statement statement = ((Connection)c_session.getAttribute("connection")).createStatement();
	ResultSet rs = statement.executeQuery(query);	
	List<String> titleList = new ArrayList<String>();
	
	while(rs.next()){
		titleList.add(rs.getString(2));
	}
	//c_session.setAttribute("movielist", titleList);

    //request.setAttribute("titleList", titleList);
    //request.getRequestDispatcher("simples.jsp").forward(request,response);

	 //jQuery related start
     String que = (String)request.getParameter("q");
 
     int cnt=1;
     for(int j=0;j<titleList.size();j++)
     {      
    	 
            out.print(titleList.get(j)+"\n");
            if(cnt>=5)// 5=How many results have to show while we are typing(auto suggestions)
              break;
             cnt++;
          
     }
    //jQuery related end

}catch (SQLException ex) {
	   while (ex != null) {
	         System.out.println ("SQL Exception:  " + ex.getMessage ());
	         ex = ex.getNextException ();
	     }  // end while
	   response.sendRedirect("login.jsp");
	  // end catch SQLException
}catch(java.lang.Exception ex){
		System.out.println("<HTML>" +
            "<HEAD><TITLE>" +
            "MovieDB: Error" +
            "</TITLE></HEAD>\n<BODY>" +
            "<P>SQL error in doGet: " +
            ex.getMessage() + "</P></BODY></HTML>");
		response.sendRedirect("login.jsp");
}

 
   
 

 

 
%>
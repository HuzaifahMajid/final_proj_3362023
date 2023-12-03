<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Credential check Page</title>
</head>
<body>
	<%
	try {
		String userType = request.getParameter("userType");
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		//get connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();

		//making string for query
		String query = "SELECT * FROM account WHERE username= '" + username + "' AND password= '" + password + "'"+ " And userType = '" + userType+"'";
		//rs object to help execute query method
		ResultSet rs = stmt.executeQuery(query);

		//if we get back values from db
		if (rs.next()) {
			
			//give session to user
			session.setAttribute("username", username);
			session.setAttribute("userType",userType);
			// print out session + welcome msg
			out.print("welcome " + username);
			out.print("you have "+ userType+ " privaleges");
			
			response.sendRedirect("Login_success.jsp");
			
			//if no results from db
		} else {
			out.print("fail");
			response.sendRedirect("Login_fail.jsp");
		}

		//close connections
		rs.close();
		stmt.close();
		con.close();
	} catch (Exception ex) {
		out.print(ex);
	}
	%>

</body>
</html>
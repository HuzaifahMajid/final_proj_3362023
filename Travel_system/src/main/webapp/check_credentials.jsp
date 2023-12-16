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
 		if (userType == null) {
	    userType = "newcustomer";
 }
		
     
		//get connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		

		if (userType.equals("customer") || userType.equals("admin")|| userType.equals("customerrep")){
			//making string for query
			String query = "SELECT * FROM account WHERE username= ? AND password= ? AND userType = ?";
			//prepare statement
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, userType);
			//execute query
			ResultSet rs = pstmt.executeQuery();

			//if we get back values from db
			if (rs.next()) {
				
				//give session to user
				session.setAttribute("username", username);
				session.setAttribute("userType",userType);
				// print out session + welcome msg
				out.print("welcome " + username);
				out.print("you have "+ userType+ " privaleges");
				rs.close();
				pstmt.close();
				con.close();
				response.sendRedirect("Login_success.jsp");
				
				//if no results from db
			} else {
				rs.close();
				pstmt.close();
				con.close();
				out.print("fail");
				response.sendRedirect("Login_fail.jsp");
			}
		} else if(userType.equals("newcustomer")) {

			//make string for adding entry to database 
            String query = "INSERT INTO account (username, password,userType) VALUES (?, ?,?)";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, "customer");

			// execute the query
			int result = pstmt.executeUpdate();
			if (result > 0) {
				pstmt.close();
				con.close();
				session.setAttribute("username", username);
				session.setAttribute("userType","customer");
				response.sendRedirect("Login_success.jsp");

			}else{
				pstmt.close();
				con.close();
				out.print("failed to create new account");
                response.sendRedirect("Login_fail.jsp");
			}

			 	
	}
		//close connections
		
		con.close();
	} catch (Exception ex) {
		out.print(ex);
	}
	%>

</body>
</html>
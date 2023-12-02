<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome Page</title>
</head>
<body>
	<div>
		<center>
			<h2>Welcome to the Travel System</h2>
			<p>Please log in to access the system
			<p>
		</center>
	</div>

	<div>
		<center>

			<form action="check_credentials.jsp" method="post">
				<label>Select User Type: </label><br></br>
				 
				 <input type="radio"
					name="userType" value="admin" required> Admin <br></br>
					 
					 <input
					type="radio" name="userType" value="customerrep" required>
				Customer Representative <br></br>
				
				 <input type="radio"
					name="userType" value="customer" required> Customer <br></br>



				<label for="username"> Username: </label> <input name="username"
					type="text" id="username" maxlength="20" required> <label
					for="password"> Password: </label> <input name="password"
					type="password" id="password" maxlength="50" required> <input
					type="submit" value="submit">
			</form>
		</center>
	</div>



</body>
</html>
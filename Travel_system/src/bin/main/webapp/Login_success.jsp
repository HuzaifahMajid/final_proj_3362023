<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>logged in</title>
</head>
<body>

<%String sessionID = String.valueOf(session.getAttribute("username"));
String userType = String.valueOf(session.getAttribute("userType"));
%>

	<h2>Congratulations, <%=sessionID%> ! you are now logged in with <%=userType%> privileges</h2> <br></br>
	<h2>Welcome to your home page</h2>


	<form action="book_a_flight.jsp" method="post">
		<button type="submit">Book Now</button>
	</form>
	<form action="user_portfolio.jsp" method="post">
		<button type="submit">Account History</button>
	</form>


	<form action="welcome_page.jsp" method="post">
		<button type="submit">Log-out</button>
	</form>

</body>
</html>
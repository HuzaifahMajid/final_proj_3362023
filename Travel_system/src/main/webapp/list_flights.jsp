<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flights</title>
</head>



<body>
<!-- get all request parameters from book_a_flight.jsp to use them for sql search query 
if the parameter is not present in the request we set it to null -->

<%
String fromAirport = request.getParameter("fromAirport");
String toAirport = request.getParameter("toAirport");
String travelDates = request.getParameter("travelDates");
String returnDates = request.getParameter("returnDates");
String flightType = request.getParameter("flightType");
String flexibility = request.getParameter("flexibility");


String price = request.getParameter("price");
String takeOffTime = request.getParameter("takeOffTime");
String landingTime = request.getParameter("landingTime");
String numberOfStops = request.getParameter("numberOfStops");
String airline = request.getParameter("airline");

//print all
out.println(fromAirport);
out.println(toAirport);
out.println(travelDates);
out.println(returnDates);
out.println(flightType);
out.println(flexibility);

out.println(price);
out.println(takeOffTime);
out.println(landingTime);
out.println(numberOfStops);
out.println(airline);


%>

</body>
</html>
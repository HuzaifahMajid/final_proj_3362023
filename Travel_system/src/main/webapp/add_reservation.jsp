<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>adding reservation to db</title>
</head>
<body>

<script>

</script>
<% 

//session.setAttribute("ticketnumber","5");
String ticketType = request.getParameter("ticketType");
    String passengerFirstName = request.getParameter("passengerFirstName");
    String passengerLastName = request.getParameter("passengerLastName");
    String seatNumber = request.getParameter("seatNumber");
    String flightType = String.valueOf(session.getAttribute("flightType"));
    //int flightNumber = Integer.parseInt(request.getParameter("flightNumber"));

    
    
    
    if ("roundTrip".equals(flightType) ){
    	session.setAttribute("fromAirport", String.valueOf(session.getAttribute("toAirport")));
    	session.setAttribute("toAirport", String.valueOf(session.getAttribute("fromAirport")));
    	session.setAttribute("flightType", "oneWay");
    	response.sendRedirect("list_flights.jsp");
    }else{
    	response.sendRedirect("user_portfolio.jsp");

    }
    
    
%>
	
	
</body>
</html>
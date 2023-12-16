<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Flight Reservation</title>
</head>
<body>

<h2>Ticket Booking Details</h2>
<%     boolean roundTrip = "true".equals(request.getAttribute("roundtrip")); // Check if roundTrip attribute is true
 		if (roundTrip) {
out.println(roundTrip); }else{
	out.print("fuck you");
}
%>
<form id = "reservation_details" action="submitTicketDetails" method="post">
    <label for="ticketType">Ticket Type:</label><br>
    <input type="radio" id="businessClass" name="ticketType" value="Business Class" required>
    <label for="businessClass">Business Class</label>
    <input type="radio" id="firstClass" name="ticketType" value="First Class">
    <label for="firstClass">First Class</label>
    <input type="radio" id="economyClass" name="ticketType" value="Economy Class">
    <label for="economyClass">Economy Class</label><br>

    <label for="passengerFirstName">Passenger First Name:</label><br>
    <input type="text" id="passengerFirstName" name="passengerFirstName" required><br>
    
    <label for="passengerLastName">Passenger Last Name:</label><br>
    <input type="text" id="passengerLastName" name="passengerLastName" required><br>
    
    <label for="seatNumber">Seat Number:</label><br>
    <select id="seatNumber" name="seatNumber">
        <!-- Populate this dropdown dynamically with available seat numbers from the database -->
        <!-- Example options -->
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <!-- Add more options as needed -->
    </select><br><br>
    
    <input type="submit" value="Pay and Reserve!">
    
</form>

</body>
</html>

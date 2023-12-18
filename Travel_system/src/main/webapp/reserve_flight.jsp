<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Flight Reservation</title>
</head>
<body>

<script>
console.log('FLIGHTTYPE Attribute: <%= String.valueOf(session.getAttribute("flightType")) %>');
console.log('FROMAIRPORT Attribute: <%= String.valueOf(session.getAttribute("fromAirport")) %>');
console.log('TOAIRPORT Attribute: <%= String.valueOf(session.getAttribute("toAirport")) %>');
console.log('RETURNDATES Attribute: <%= String.valueOf(session.getAttribute("returnDates")) %>');
console.log('TICEKTNUMBER Attribute: <%= String.valueOf(session.getAttribute("ticektnumber")) %>');

 
   function redirectToReturnFlights() {
       // Redirect to the list_flights.jsp with return dates set as travel dates
       var form = document.getElementById("reservation_details");
       form.action = "list_flights.jsp";
       form.submit();
   }
    
    </script>

<h2>Ticket Booking Details</h2>



<form id="reservation_details" action="add_reservation.jsp" method="post">
    <label for="ticketType">Ticket Type:</label><br>
    <input type="radio" id="businessClass" name="ticketType" value="Business" required>
    <label for="businessClass">Business Class</label>
    <input type="radio" id="firstClass" name="ticketType" value="First">
    <label for="firstClass">First Class</label>
    <input type="radio" id="economyClass" name="ticketType" value="Economy">
    <label for="economyClass">Economy Class</label><br>

    <label for="passengerFirstName">Passenger First Name:</label><br>
    <input type="text" id="passengerFirstName" name="passengerFirstName" required><br>
    
    <label for="passengerLastName">Passenger Last Name:</label><br>
    <input type="text" id="passengerLastName" name="passengerLastName" required><br>
    
    <label for="seatNumber">Seat Number:</label><br>
    <select id="seatNumber" name="seatNumber" required >
    <option value="">Select a seat</option>
    </select><br><br> 

	<script>
	    // Set the total number of seats
	    var totalSeats = 100; // Change this number based on your requirement
	
	    // Get the dropdown element
	    var dropdown = document.getElementById('seatNumber');
	
	    // Populate the dropdown with seat numbers
	    for(var i = 1; i <= totalSeats; i++) {
	        // Create a new option element
	        var option = document.createElement('option');
	        option.value = i;
	        option.text = 'Seat' + i;
	
	        // Append the option to the dropdown
	        dropdown.appendChild(option);
	    }
	</script>
    
    <input type="submit" value="Pay and Reserve!">
    <% 
        // Check if the flight type is round trip
        if ("roundTrip".equals(session.getAttribute("flightType"))) {
        	
    %>			
            <input type="button" value="Search Return Flights" onclick="redirectToReturnFlights()">
    <%
        }
    %>
</form>

</body>
</html>

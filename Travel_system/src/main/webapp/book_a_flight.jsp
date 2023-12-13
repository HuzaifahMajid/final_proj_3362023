<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flight Booking</title>
<script>
        function showReturnDate() {
            var oneWay = document.getElementById("oneWay");
            var roundTrip = document.getElementById("roundTrip");
            var returnDates = document.getElementById("returnDates");
            
            if (oneWay.checked) {
                returnDates.style.display = "none";
            } else if (roundTrip.checked) {
                returnDates.style.display = "block";
            }
        }
        
        
        // JavaScript to toggle the visibility of the returnDates field based on user input
        document.getElementById('travelDates').addEventListener('input', function() {
            var returnDatesInput = document.getElementById('returnDates');
            returnDatesInput.style.display = this.value ? 'block' : 'none';
        });
        
        //validate return date is after travel date
        function validateDates() {
            var travelDate = new Date(document.getElementById('travelDates').value);
            var returnDate = new Date(document.getElementById('returnDates').value);

            if (returnDate < travelDate) {
                alert('Return date must be after the travel date.');
                return false; // Prevent form submission
            }

            return true; // Allow form submission
        }
        
        
    
    </script>
</head>
<body>

<!-- make a form to get flight details from user. such as departure airport, destination airport, travel dates, one way or round trip, flexibile with dates or not-->

<h1>Flight Reservation</h1> 
    <form action="list_flights.jsp" method="post" onsubmit="return validateDates()">
        <label for="fromAirport">From Airport:</label>
        <input type="text" id="fromAirport" name="fromAirport" required>
        <br>
        <label for="toAirport">To Airport:</label>
        <input type="text" id="toAirport" name="toAirport" required>
        <br>
        <label for="travelDates">Travel Dates:</label>
        <input type="date" id="travelDates" name="travelDates" required>
        <br>
        <label for="returnDates">Return Dates:</label>
        <input type="date" id="returnDates" name="returnDates" style="display: none;">
        <br>
        
        <%
        
        %>
        <label for="flightType">Flight Type:</label>
        <input type="radio" id="oneWay" name="flightType" value="oneWay" onchange="showReturnDate()">
        <label for="oneWay">One Way</label>
        <input type="radio" id="roundTrip" name="flightType" value="roundTrip" onchange="showReturnDate()">
        <label for="roundTrip">Round Trip</label>
        <br>
        <label for="flexibility">Flexibility (+/- 3 days):</label>
        <input type="checkbox" id="flexibility" name="flexibility">
        <br>
        <input type="submit" value="Submit">
    </form>
<!-- make a new form that is activated by a check box "filter flights" , -->
<form action="list_flights.jsp" method="post">
    <input type="checkbox" id="filterFlights" name="filterFlights">
    <label for="filterFlights">Filter Flights</label>
    <br>
<!--add labels and get input from users for filtering for flights by different criteria like price, take-off-time, -->
    <label for="price">Price:</label>
    <input type="text" id="price" name="price">
    <br>
    <label for="takeOffTime">Take Off Time:</label>
    <input type="time" id="takeOffTime" name="takeOffTime">
    <br>
    <!--landing-times,number-of-stops,and airline  -->
    <label for="landingTime">Landing Time:</label>
    <input type="time" id="landingTime" name="landingTime">
    <br>
    <label for="numberOfStops">Number Of Stops:</label>
    <input type="text" id="numberOfStops" name="numberOfStops">
    <br>
    <label for="airline">Airline:</label>
    <input type="text" id="airline" name="airline">
    <br>
</form>




</body>
</html>
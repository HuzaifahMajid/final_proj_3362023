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
    </script>
</head>
<body>

<!-- make a form to get flight details from user. such as departure airport, destination airport, travel dates, one way or round trip, flexibile with dates or not-->

<h1>Flight Reservation</h1>
    <form action="list_flights.jsp" method="post">
        <label for="fromAirport">From Airport:</label>
        <input type="text" id="fromAirport" name="fromAirport">
        <br>
        <label for="toAirport">To Airport:</label>
        <input type="text" id="toAirport" name="toAirport">
        <br>
        <label for="travelDates">Travel Dates:</label>
        <input type="date" id="travelDates" name="travelDates">
        <br>
        <label for="returnDates">Return Dates:</label>
        <input type="date" id="returnDates" name="returnDates" style="display: none;">
        <br>
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

</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flights</title>
<script>
    function sortTable(columnName, sortOrder) {
        var table, rows, switching, i, x, y, shouldSwitch;
        table = document.querySelector(".sortable");
        
        switching = true;
        while (switching) {
            switching = false;
            rows = table.rows;

            for (i = 1; i < rows.length - 1; i++) {

                shouldSwitch = false;
                
                var cindex;
                switch(columnName){
                case 'DepartureTime':
                	cindex = 3;
                	break;
                case 'ArrivalTime':
                	cindex = 5;
                	break;
               	case 'Duration':
                   	cindex = 7;
                   	break;
               	case 'price':
                	cindex = 8;
                	break;
                }
                x = rows[i].cells[cindex].innerText;
                y = rows[i + 1].cells[cindex].innerText;

                if ((sortOrder === 'asc' && x.localeCompare(y) > 0) || (sortOrder === 'desc' && x.localeCompare(y) < 0)) {
                    shouldSwitch = true;
                    break;
                }
            }

            if (shouldSwitch) {
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                switching = true;
            }
        }
    }
    
    
    
 /*    document.getElementById('priceSorting').addEventListener('change', function() {
        sortTable('price',this.value);
    }); */
</script>
</head>


<body>
<%
try {
	boolean RT = false;
	// Get request parameters
	String fromAirport = request.getParameter("fromAirport");
	String toAirport = request.getParameter("toAirport");
	String travelDates = request.getParameter("travelDates");
	String flightType = request.getParameter("flightType");
	if ("roundTrip".equals(request.getParameter("flightType"))){
		//set parameter so i can retrieve it on next page
		request.setAttribute("roundtrip", "true");
		String returnDates = request.getParameter("returnDates");
		request.setAttribute("returnDates", returnDates);

	}
	String landingTime = request.getParameter("landingTime");
	String takeoffTime = request.getParameter("takeoffTime");
	String airline = request.getParameter("airline");
	String price = request.getParameter("price");
	String numberOfStops = request.getParameter("numberOfStops");
	boolean flexible = "on".equals(request.getParameter("flexibility"));

	// Query parameters
	StringBuilder sqlQuery = new StringBuilder("SELECT * FROM flight WHERE ");
	//remove traveldete insert from here
	sqlQuery.append("DepartureAirportID = ? AND DestinationAirportID = ? ");
	
	if (!flexible) {
		sqlQuery.append("AND date(DepartureTime) = ? ");
	}else{
		sqlQuery.append("AND DATE(DepartureTime) BETWEEN DATE_SUB(?, INTERVAL 3 DAY) AND DATE_ADD(?, INTERVAL 3 DAY) ");

	}
			
	// Optional filtering conditions
	if (landingTime != null && !landingTime.isEmpty()) {
		sqlQuery.append("AND TIME(ArrivalTime) <= ? ");
	}

	if (takeoffTime != null && !takeoffTime.isEmpty()) {
		sqlQuery.append("AND TIME(DepartureTime) <= ? ");
	}

	

	if (airline != null && !airline.isEmpty()) {
		sqlQuery.append("AND AirlineID = ? ");
	}

	if (price != null && !price.isEmpty()) {
		sqlQuery.append("AND Price <= ? ");
	}

	if (numberOfStops != null && !numberOfStops.isEmpty()) {
		sqlQuery.append("AND numberofStops < ? ");
	}
	

	// Prepare the SQL query
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	PreparedStatement preparedStatement = con.prepareStatement(sqlQuery.toString());
	
	// Set parameter values
	int parameterIndex = 1;
	
	preparedStatement.setString(parameterIndex++, fromAirport);
	preparedStatement.setString(parameterIndex++, toAirport);
	
	if (!flexible){
		preparedStatement.setString(parameterIndex++, travelDates);
	}else{
		preparedStatement.setString(parameterIndex++, travelDates);
		
		preparedStatement.setString(parameterIndex++, travelDates);
	}

	if (landingTime != null && !landingTime.isEmpty()) {
		preparedStatement.setString(parameterIndex++, landingTime);
	}

	if (takeoffTime != null && !takeoffTime.isEmpty()) {
		preparedStatement.setString(parameterIndex++, takeoffTime);
	}


	if (airline != null && !airline.isEmpty()) {
		preparedStatement.setString(parameterIndex++, airline);
	}

	if (price != null && !price.isEmpty()) {
		preparedStatement.setString(parameterIndex++, price);
	}

	if (numberOfStops != null && !numberOfStops.isEmpty()) {
		preparedStatement.setString(parameterIndex++, numberOfStops);
	}
	
// Execute the query and process the result set
ResultSet resultSet = preparedStatement.executeQuery();
%>


<!--  now iterate through the result set and print each row in a user friendly table
 -->
<h2>Available Flights</h2>
<form action="reserve_flight.jsp" method="post">

	<table border="5" class= "sortable">
		<tr>
			<th>Select</th>
			<th>Flight Number</th>
			<th>Departure Airport</th>
			<th>
			<select id = "takeoffSorting" onchange = "sortTable('DepartureTime',this.value)">
			<option value = "asc">ASC</option>
			<option value = "desc">DESC</option>
			</select>
			<a href="#" onclick = "sortTable('DepartureTime', document.getElementById('takeoffSorting').value)"></a>  Take off Time</th>
			
			
			<th>Arrival Airport</th>
			<th>
    <select id="landingSorting" onchange="sortTable('ArrivalTime', this.value)">
        <option value="asc">ASC</option>
        <option value="desc">DESC</option>
    </select>
    <a href="#" onclick="sortTable('ArrivalTime', document.getElementById('landingSorting').value)"></a> Landing Time
</th>
			<th>Stops</th>
			<th>
    <select id="durationSort" onchange="sortTable('duration', this.value)">
        <option value="asc">ASC</option>
        <option value="desc">DESC</option>
    </select>
    <a href="#" onclick="sortTable('duration', document.getElementById('durationSort').value)"></a> Duration
</th>

			<th>
    <select id="priceSorting" onchange="sortTable('price', this.value)">
        <option value="asc">ASC</option>
        <option value="desc">DESC</option>
    </select>
    <a href="#" onclick="sortTable('price', document.getElementById('priceSorting').value)"></a> Price
</th>

		</tr>

		<%
			while (resultSet.next()) {
		%>
			
		<tr>
			<td>
				<input type="radio" required name="flight" value="<%= resultSet.getString("flightNumber") %>" id="<%= resultSet.getString("flightNumber") %>">
			</td>
			<td><center><%= resultSet.getString("flightNumber") %></center></td>
			<td><center><%= resultSet.getString("DepartureAirportID") %></center></td>
			<td><center><%= resultSet.getString("DepartureTime") %></center></td>
			<td><center><%= resultSet.getString("DestinationAirportID") %></center></td>
			<td><center><%= resultSet.getString("ArrivalTime") %></center></td>
			<td><center><%= resultSet.getString("numberOfStops") %></center></td>
			    <td>
        <%
            LocalDateTime departureTime = resultSet.getTimestamp("DepartureTime").toLocalDateTime();
            LocalDateTime arrivalTime = resultSet.getTimestamp("ArrivalTime").toLocalDateTime();

            Duration duration = Duration.between(departureTime, arrivalTime);
            long hours = duration.toHours();
            long minutes = duration.toMinutes() % 60;

            String formattedDuration = String.format("%02d:%02d", hours, minutes);
        %>
        <center><%= formattedDuration %></center>
    </td>
				<td><%= resultSet.getBigDecimal("price") %></td>
		</tr>

		<%
			}
		%>

	</table>

	<p>
		<input type="submit" value="Submit">
	</p>

</form>

</body>
</html>
<% 

con.close();
}catch(Exception e){
	out.println(e);
}
%>

</body>
</html>
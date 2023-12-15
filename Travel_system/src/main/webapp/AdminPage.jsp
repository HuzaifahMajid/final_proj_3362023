<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Page</title>
 <script>
        function showOption(selectedValue) {
            var allOptions = document.getElementsByClassName('admin-option');
            for (var i = 0; i < allOptions.length; i++) {
                allOptions[i].style.display = 'none';
            }
            if (selectedValue) {
                document.getElementById(selectedValue).style.display = 'block';
                showReservationsListFields(selectedValue);
            }
        }
        function showReservationsListFields(selectedValue) {
            var flightNumberField = document.getElementById('flightNumberField');
            var customerNameField = document.getElementById('customerNameField');
           
            flightNumberField.style.display = 'none';
            customerNameField.style.display = 'none';

            if (selectedValue === 'reservationsList') {
                var listType = document.getElementById('listType').value;
                if (listType === 'specificFlight') {
                    flightNumberField.style.display = 'block';
                } else if (listType === 'specificCustomer') {
                    customerNameField.style.display = 'block';
                }
            }
        }
    </script>
</head>
<body>

	<% 
    Connection con = null;
    try {
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();
        
    } catch (Exception e) {
        out.println("Database connection error: " + e.getMessage());
        e.printStackTrace();
    }

    
    %>

    <h2>Admin Dashboard</h2>

    <label for="adminAction">Select an Action:</label>
    <select name="adminAction" id="adminAction" onchange="showOption(this.value)">
        <option value="">--Select an Option--</option>
        <option value="AED_CustomerRep_Customer">Manage Customer Representative or Customer Accounts</option>
        <option value="salesReport">Obtain Sales Report for a Particular Month</option>
        <option value="reservationsList">Produce a List of Reservations</option>
        <option value="revenueSummary">Produce Revenue Summary</option>
        <option value="topCustomer">Determine Top Revenue Generating Customer</option>
        <option value ="MostActiveFlights">Produce List of Active Flights</option>
    </select>
    
    <div id= "AED_CustomerRep_Customer" class= "admin-option" style="display:none;">
    
    
    	<label for= "selectAction">Select Option:</label>
    	<
    	
    
    </div>

    <!-- Hidden sections for each admin option -->
    <div id="salesReport" class="admin-option" style="display:none;">
        <!-- Form or content for sales report -->
        <p>Sales report content goes here...</p>
    </div>

    <div id="reservationsList" class="admin-option" style="display:none;">
        <h3>Produce a List of Reservations</h3>
        <form action="AdminPage.jsp" method="post">
            <label for="listType">Select List Type:</label>
            <select name="listType" id="listType" onchange="showReservationsListFields('reservationsList')">
                <option value="allByFlight">All Reservations by Flight Number</option>
                <option value="allByCustomer">All Reservations by Customer Name</option>
                <option value="specificFlight">Specific Flight Number</option>
                <option value="specificCustomer">Specific Customer Name</option>
            </select>

            <div id="flightNumberField" style="display: none;">
                <label for="flightNumber">Flight Number:</label>
                <input type="text" name="flightNumber" id="flightNumber">
            </div>

            <div id="customerNameField" style="display: none;">
                <label for="customerName">Customer Name:</label>
                <input type="text" name="customerName" id="customerName">
            </div>

            <input type="submit" value="Search">
        </form>
		<% 
		String listType = request.getParameter("listType");

		if (listType != null && listType.equals("allByFlight")) {
    		PreparedStatement pstmt = null;
    		ResultSet rs = null;
    		try {
    			String query = "SELECT r.FlightNumber, r.ID, a.username, r.SeatNumber, r.TicketClass, r.TicketFare, r.PurchaseDateTime, r.BookingFee "
    		             + "FROM reservation r "
    		             + "JOIN account a ON r.ID = a.AccountID "
    		             + "ORDER BY r.FlightNumber;";
        		pstmt = con.prepareStatement(query);
        		rs = pstmt.executeQuery();
        		%>
        		<table border="1">
            		<tr>
                		<th>Flight Number</th>
                		<th>AccountID</th>
                		<th>Customer Name</th>
                		<th>Seat Number</th>
                		<th>Ticket Class</th>
                		<th>Ticket Fare</th>
                		<th>Purchase Date</th>
                		<th>Booking Fee</th>
                		
            		</tr>
            		<% while (rs.next()) { %>
                		<tr>
                    		<td><%= rs.getString("FlightNumber") %></td>
                    		<td><%= rs.getString("ID") %></td>
                    		<td><%= rs.getString("username") %></td>
                    		<td><%= rs.getString("SeatNumber") %></td>
                    		<td><%= rs.getString("TicketClass") %></td>
                    		<td><%= rs.getString("TicketFare") %></td>
                    		<td><%= rs.getString("PurchaseDateTime") %></td>
                    		<td><%= rs.getString("BookingFee") %></td>
                    		
                		</tr>
            		<% } %>
        		</table>
        		<%
    			} catch (SQLException e) {
        			out.println("SQL Exception: " + e.getMessage());
        			e.printStackTrace();
    			} finally {
        			if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        			if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    			}
			}
		%>
    </div>

    <div id="revenueSummary" class="admin-option" style="display:none;">
        <!-- Form or content for revenue summary -->
        <p>Revenue summary content goes here...</p>
    </div>

    <div id="topCustomer" class="admin-option" style="display:none;">
        <!-- Form or content for top customer -->
        <p>Top customer content goes here...</p>
    </div>
    
    <div id="MostActiveFlights" class= "admin-option" style= "display:none;">
    	<% 
    		ResultSet rs = null;
    		PreparedStatement pstmt= null;
    		try {
    			
    			String query = "SELECT FlightNumber, COUNT(*) AS TicketsSold "+
								"FROM reservation "+
								"GROUP BY FlightNumber "+
								"ORDER BY TicketsSold DESC;";
				pstmt = con.prepareStatement(query);
				rs = pstmt.executeQuery();   														
		%>
    	
    		<table border = "1">
    			<tr>
    				<th>Flight Number</th>
    				<th>Tickets Sold</th>	
    			</tr>
    			
    			
    	<% 
    		while (rs.next()) {    	
    	%>	
    			    	
    			<tr>
    				<td><%= rs.getString("FlightNumber") %></td>
    				<td><%= rs.getInt("TicketsSold") %></td>    			
    			</tr>	
    			
    	<% 	
    		
    		} 
    	
    	%>    		
    		</table>
    		
    	
       	
    	<%
    		} catch (SQLException e) {
    		    // Handle SQL exceptions
    		    out.println("SQL Exception: " + e.getMessage());
    		} finally {
    			if (rs != null) try { rs.close();} catch (SQLException e) {e.printStackTrace();}
    			if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    		}
    	
    	
    	%>
    	
    </div>
    
	<% 
    // Close the database connection at the end of the page
    if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    %>
    
</body>
</html>
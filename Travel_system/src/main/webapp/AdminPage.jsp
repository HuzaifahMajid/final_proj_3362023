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
    
   <script>
    function showInfoFields(selectedValue) {
    	
    	document.getElementById('addInfoFields').style.display = 'none';
    	document.getElementById('deleteInfoFields').style.display = 'none';
    	document.getElementById('editInfoFields').style.display = 'none';
       
		var actionTypeField = document.getElementById('actionType');
        // Show input fields when "selectedValue" is selected
        if (selectedValue === 'AddInfo') {
            document.getElementById('addInfoFields').style.display = 'block';
            actionTypeField.value = 'AddInfo';
        }
        
        else if (selectedValue === 'DeleteInfo'){
        	document.getElementById('deleteInfoFields').style.display = 'block';
        	actionTypeField.value= 'DeleteInfo';
        }
        
        else if (selectedValue === 'EditInfo'){
        	document.getElementById('editInfoFields').style.display = 'block';
        	actionTypeField.value = 'EditInfo';
        }
        else{
        	actionTypeField.value='';
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
    	<% 
    		PreparedStatement AEDpstmt = null;
		    ResultSet AEDrs = null;
		    try {
		        String query = "SELECT AccountID, username, userType FROM account WHERE userType IN ('customerrep', 'customer') ORDER BY userType, username;";
		        AEDpstmt = con.prepareStatement(query);
		        AEDrs = AEDpstmt.executeQuery();
		    %>
		    <table border="1">
		        <tr>
		            <th>Account ID</th>
		            <th>Username</th>
		            <th>User Type</th>
		        </tr>
		        <% while (AEDrs.next()) { %>
		            <tr>
		                <td><%= AEDrs.getInt("AccountID") %></td>
		                <td><%= AEDrs.getString("username") %></td>
		                <td><%= AEDrs.getString("userType") %></td>
		            </tr>
		        <% } %>
		    </table>
		    <% 
		    } catch (SQLException e) {
		        out.println("SQL Exception: " + e.getMessage());
		        e.printStackTrace();
		    } finally {
		        if (AEDrs != null) try { AEDrs.close(); } catch (SQLException e) { e.printStackTrace(); }
		        if (AEDpstmt != null) try { AEDpstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
		    }
    	%>
    	
    	
    	
    	<form action= "AdminPage.jsp" method= "post">
	    	<label for= "selectAction">Select Option:</label>
	    		<select name= "selectAction" id= "selectAction" onchange="showInfoFields(this.value)">
	    			<option value= "">Select Action</option>
	    			<option value= "AddInfo">Add Information</option>
	    			<option value= "DeleteInfo">Delete Information</option>
	    			<option value= "EditInfo">Edit Information</option>
	    		</select>
	    	
	    	<input type= "hidden" name = "actionType" id= "actionType" value= "">
	    	
	    	<div id="addInfoFields" style="display:none;">	    		
	    		<label for= "Username">New Username:</label>
	        	<input type="text" name="Username" id="Username">
	        	<label for= "Password">Password:</label>
	        	<input type="text" name="Password" id="Password">
	        	<label for= "AccountType">Account Type (customerrep or customer):</label>
	        	<input type="text" name="AccountType" id="AccountType">
	        	
	    	</div>
	    	
	    	<div id="deleteInfoFields" style="display:none;">	    		
	    		<label for= "Username">Current Username:</label>
	        	<input type="text" name="Username" id="Username">
	        	<label for= "AccountID">Account ID:</label>
	        	<input type="text" name="AccountID" id="AccountID">
	        	
	    	</div>
	    	
	    	<div id="editInfoFields" style="display:none;">	    		
	    		<label for= "AccountID">AccountID:</label>
	        	<input type="text" name="AccountID" id="AccountID">
	        	<label for= "NewUser">New or Current Username:</label>
	        	<input type="text" name="NewUser" id="NewUser">
	        	<label for= "NewPass">New or Current password:</label>
	        	<input type="text" name="NewPass" id="NewPass">
	        	
	    	</div>
	    		<input type="submit" value="Submit">
	    </form>
	    <%
	    	String actionType= request.getParameter("actionType");
		    if ("AddInfo".equals(actionType)) {
		        // Logic for adding information
		        String username = request.getParameter("Username");
		        String password = request.getParameter("Password");
		        String userType = request.getParameter("AccountType");
	
		        try {
		            String addQuery = "INSERT INTO account (username, password, userType) VALUES (?, ?, ?);";
		            PreparedStatement addStmt = con.prepareStatement(addQuery);
		            addStmt.setString(1, username);
		            addStmt.setString(2, password);
		            addStmt.setString(3, userType);
	
		            int addedRows = addStmt.executeUpdate();
		            if (addedRows > 0) {
		                out.println("<p style='color:green;'>Customer added successfully.</p>");
		            } else {
		                out.println("<p style='color:red;'>Failed to add customer.</p>");
		            }
		            addStmt.close();
		        } catch (SQLException e) {
		            out.println("<p style='color:red;'>SQL Error: " + e.getMessage() + "</p>");
		            e.printStackTrace();
		        }
		    } else if ("DeleteInfo".equals(actionType)) {
		        // Logic for deleting information
		        String username = request.getParameter("Username");
		        String accountID = request.getParameter("AccountID");
	
		        try {
		            String deleteQuery = "DELETE FROM account WHERE AccountID = ? AND username = ?;";
		            PreparedStatement deleteStmt = con.prepareStatement(deleteQuery);
		            deleteStmt.setInt(1, Integer.parseInt(accountID));
		            deleteStmt.setString(2, username);
	
		            int deletedRows = deleteStmt.executeUpdate();
		            if (deletedRows > 0) {
		                out.println("<p style='color:green;'>Customer deleted successfully.</p>");
		            } else {
		                out.println("<p style='color:red;'>Failed to delete customer.</p>");
		            }
		            deleteStmt.close();
		        } catch (SQLException e) {
		            out.println("<p style='color:red;'>SQL Error: " + e.getMessage() + "</p>");
		            e.printStackTrace();
		        }
		    } else if ("EditInfo".equals(actionType)) {
		        // Logic for editing information
		        String accountID = request.getParameter("AccountID");
		        String newUser = request.getParameter("NewUser");
		        String newPass = request.getParameter("NewPass");
	
		        try {
		            String editQuery = "UPDATE account SET username = ?, password = ? WHERE AccountID = ?;";
		            PreparedStatement editStmt = con.prepareStatement(editQuery);
		            editStmt.setString(1, newUser);
		            editStmt.setString(2, newPass);
		            editStmt.setInt(3, Integer.parseInt(accountID));
	
		            int updatedRows = editStmt.executeUpdate();
		            if (updatedRows > 0) {
		                out.println("<p style='color:green;'>Customer information updated successfully.</p>");
		            } else {
		                out.println("<p style='color:red;'>Failed to update customer information.</p>");
		            }
		            editStmt.close();
		        } catch (SQLException e) {
		            out.println("<p style='color:red;'>SQL Error: " + e.getMessage() + "</p>");
		            e.printStackTrace();
		        }
		    }
	    
	    %>
	    
    </div>

    <!-- Hidden sections for each admin option -->
    <div id="salesReport" class="admin-option" style="display:none;">
    
        <form action="AdminPage.jsp" method="post">
        <label for="selectMonth">Select Month:</label>
        <select name="selectMonth" id="selectMonth">
            <option value="">--Select Month--</option>
            <option value="01">January</option>
            <option value="02">February</option>
            <option value="03">March</option>
            <option value="04">April</option>
            <option value="05">May</option>
            <option value="06">June</option>
            <option value="07">July</option>
            <option value="08">August</option>
            <option value="09">September</option>
            <option value="10">October</option>
            <option value="11">November</option>
            <option value="12">December</option>
        </select>
        <input type="submit" value="Generate Report">
    	</form>

	    <%
	        String selectedMonth = request.getParameter("selectMonth");
	        if (selectedMonth != null && !selectedMonth.isEmpty()) {
	            // SQL query to fetch sales data for the selected month
	            String query = "SELECT " +
                       "YEAR(r.PurchaseDateTime) AS SaleYear, " +
                       "MONTH(r.PurchaseDateTime) AS SaleMonth, " +
                       "SUM(r.TicketFare) AS TotalSales " +
                       "FROM reservation r " +
                       "WHERE MONTHNAME(r.PurchaseDateTime) = ? " +
                       "GROUP BY YEAR(r.PurchaseDateTime), MONTH(r.PurchaseDateTime)";

	
	            PreparedStatement pstmt = null;
	            ResultSet rs = null;
	
	            try {
	                pstmt = con.prepareStatement(query);
	                pstmt.setString(1, selectedMonth);
	                rs = pstmt.executeQuery();
	
	                // Display the sales report in a table
	                %><table border="1"><%
	                		 %><tr><th>Year</th><th>Month</th><th>Total Sales</th></tr><%
	                while (rs.next()) {
	                	%><tr><%
	                    %><td><%= rs.getString("SaleYear") %></td><%
	                    %><td><%= rs.getString("SaleMonth") %></td><%
	                    %><td><%= rs.getDouble("TotalSales") %></td><%
	                    %></tr><%
	                }
	                %></table><%
	            } catch (SQLException e) {
	                out.println("SQL Exception: " + e.getMessage());
	            } finally {
	                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
	                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
	            }
	        }
	    %>
	    
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
			else if ("allByCustomer".equals(listType)) {
			    PreparedStatement pstmt = null;
			    ResultSet rs = null;
			    try {
			        String query = "SELECT r.FlightNumber, r.ID, a.username, r.SeatNumber, r.TicketClass, r.TicketFare, r.PurchaseDateTime, r.BookingFee "
			                     + "FROM reservation r "
			                     + "JOIN account a ON r.ID = a.AccountID "
			                     + "ORDER BY a.username;";
			        pstmt = con.prepareStatement(query);
			        rs = pstmt.executeQuery();
			        %>
			        <table border="1">
			            <tr>
			                <th>Flight Number</th>
			                <th>Account ID</th>
			                <th>Customer Name</th>
			                <th>Seat Number</th>
			                <th>Ticket Class</th>
			                <th>Ticket Fare</th>
			                <th>Purchase Date</th>
			                <th>Booking Fee</th>
			            </tr>
			            <% while (rs.next()) { %>
			                <tr>
			                    <td><%= rs.getInt("FlightNumber") %></td>
			                    <td><%= rs.getInt("ID") %></td>
			                    <td><%= rs.getString("username") %></td>
			                    <td><%= rs.getString("SeatNumber") %></td>
			                    <td><%= rs.getString("TicketClass") %></td>
			                    <td><%= rs.getDouble("TicketFare") %></td>
			                    <td><%= rs.getTimestamp("PurchaseDateTime") %></td>
			                    <td><%= rs.getDouble("BookingFee") %></td>
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
	
			// Handle reservations for a specific flight number
			else if ("specificFlight".equals(listType)) {
				String flightNumber = request.getParameter("flightNumber");
			    PreparedStatement pstmt = null;
			    ResultSet rs = null;
			    try {
			        String query = "SELECT r.FlightNumber, r.ID, a.username, r.SeatNumber, r.TicketClass, r.TicketFare, r.PurchaseDateTime, r.BookingFee "
			                     + "FROM reservation r "
			                     + "JOIN account a ON r.ID = a.AccountID "
			                     + "WHERE r.FlightNumber = ? "
			                     + "ORDER BY a.username;";
			        pstmt = con.prepareStatement(query);
			        pstmt.setString(1, flightNumber);
			        rs = pstmt.executeQuery();
			        %>
			        <table border="1">
			            <tr>
			                <th>Flight Number</th>
			                <th>Account ID</th>
			                <th>Customer Name</th>
			                <th>Seat Number</th>
			                <th>Ticket Class</th>
			                <th>Ticket Fare</th>
			                <th>Purchase Date</th>
			                <th>Booking Fee</th>
			            </tr>
			            <% while (rs.next()) { %>
			                <tr>
			                    <td><%= rs.getInt("FlightNumber") %></td>
			                    <td><%= rs.getInt("ID") %></td>
			                    <td><%= rs.getString("username") %></td>
			                    <td><%= rs.getString("SeatNumber") %></td>
			                    <td><%= rs.getString("TicketClass") %></td>
			                    <td><%= rs.getDouble("TicketFare") %></td>
			                    <td><%= rs.getTimestamp("PurchaseDateTime") %></td>
			                    <td><%= rs.getDouble("BookingFee") %></td>
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
	
			// Handle reservations for a specific customer name
			else if ("specificCustomer".equals(listType)) {
				String customerName = request.getParameter("customerName");
			    PreparedStatement pstmt = null;
			    ResultSet rs = null;
			    try {
			        String query = "SELECT r.FlightNumber, r.ID, a.username, r.SeatNumber, r.TicketClass, r.TicketFare, r.PurchaseDateTime, r.BookingFee "
			                     + "FROM reservation r "
			                     + "JOIN account a ON r.ID = a.AccountID "
			                     + "WHERE a.username = ? "
			                     + "ORDER BY r.PurchaseDateTime DESC;";
			        pstmt = con.prepareStatement(query);
			        pstmt.setString(1, customerName);
			        rs = pstmt.executeQuery();
			        %>
			        <table border="1">
			            <tr>
			                <th>Flight Number</th>
			                <th>Account ID</th>
			                <th>Customer Name</th>
			                <th>Seat Number</th>
			                <th>Ticket Class</th>
			                <th>Ticket Fare</th>
			                <th>Purchase Date</th>
			                <th>Booking Fee</th>
			            </tr>
			            <% while (rs.next()) { %>
			                <tr>
			                    <td><%= rs.getInt("FlightNumber") %></td>
			                    <td><%= rs.getInt("ID") %></td>
			                    <td><%= rs.getString("username") %></td>
			                    <td><%= rs.getString("SeatNumber") %></td>
			                    <td><%= rs.getString("TicketClass") %></td>
			                    <td><%= rs.getDouble("TicketFare") %></td>
			                    <td><%= rs.getTimestamp("PurchaseDateTime") %></td>
			                    <td><%= rs.getDouble("BookingFee") %></td>
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
	        <h3>Produce Revenue Summary</h3>
	    <form action="AdminPage.jsp" method="post">
	        <label for="revenueType">Select Type:</label>
	        <select name="revenueType" id="revenueType">
	            <option value="flight">Flight</option>
	            <option value="airline">Airline</option>
	            <option value="customer">Customer</option>
	        </select>
	        <label for="identifier">Identifier (Flight Number/Airline ID/Customer Name):</label>
	        <input type="text" name="identifier" id="identifier">
	        <input type="submit" value="Get Summary">
	    </form>
	
	    <%
	    String revenueType = request.getParameter("revenueType");
	    String identifier = request.getParameter("identifier");
	
	    if (revenueType != null && identifier != null && !identifier.isEmpty()) {
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        try {
	            String query = "";
	            if ("flight".equals(revenueType)) {
	                query = "SELECT FlightNumber, SUM(TicketFare) AS TotalRevenue FROM reservation WHERE FlightNumber = ? GROUP BY FlightNumber;";
	            } else if ("airline".equals(revenueType)) {
	                query = "SELECT AirlineID, SUM(TicketFare) AS TotalRevenue FROM reservation JOIN flight ON reservation.FlightNumber = flight.FlightNumber WHERE AirlineID = ? GROUP BY AirlineID;";
	            } else if ("customer".equals(revenueType)) {
	                query = "SELECT a.username, SUM(r.TicketFare) AS TotalRevenue FROM reservation r JOIN account a ON r.ID = a.AccountID WHERE a.username = ? GROUP BY a.username;";
	            }
	            pstmt = con.prepareStatement(query);
	            pstmt.setString(1, identifier);
	            rs = pstmt.executeQuery();
	    %>
	    <table border="1">
	        <tr>
	            <th>Identifier</th>
	            <th>Total Revenue</th>
	        </tr>
	        <% while (rs.next()) { %>
	            <tr>
	                <td><%= rs.getString(1) %></td> <!-- First column in result set (FlightNumber, AirlineID, or username) -->
	                <td><%= rs.getDouble("TotalRevenue") %></td>
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

    <div id="topCustomer" class="admin-option" style="display:none;">
       	<% 
    		ResultSet topCust = null;
    		PreparedStatement pstmtCust= null;
    		try {
    			
    			String query = "SELECT "+
    				    "a.username, "+
    				    "SUM(r.TicketFare) AS TotalRevenue "+
    				"FROM "+
    				    "reservation r "+
    				"JOIN "+
    				    "account a ON r.ID = a.AccountID "+
    				"GROUP BY "+
    				    "a.AccountID "+
    				"ORDER BY "+
    				    "TotalRevenue DESC LIMIT 1;";
				pstmtCust = con.prepareStatement(query);
				topCust = pstmtCust.executeQuery();   														
		%>
    	
    		<table border = "1">
    			<tr>
    				<th>Customer</th>
    				<th>Total Revenue</th>	
    			</tr>
    			
    			
    	<% 
    		while (topCust.next()) {    	
    	%>	
    			    	
    			<tr>
    				<td><%= topCust.getString("username") %></td>
    				<td><%= topCust.getInt("TotalRevenue") %></td>    			
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
    			if (topCust != null) try { topCust.close();} catch (SQLException e) {e.printStackTrace();}
    			if (pstmtCust != null) try { pstmtCust.close(); } catch (SQLException e) { e.printStackTrace(); }
    		}
    	
    	
    	%>
    	
    	
    </div>
    
    <div id="MostActiveFlights" class= "admin-option" style= "display:none;">
    	<% 
    		ResultSet rs = null;
    		PreparedStatement pstmt= null;
    		try {
    			
    			String query = "SELECT "+
    				    "f.FlightNumber, "+
    				    "COUNT(r.ReservationID) AS TicketsSold "+
    				"FROM "+
    				    "flight f "+
    				"JOIN "+
    				    "reservation r ON f.FlightNumber = r.FlightNumber "+
    				"WHERE "+
    				    "f.DepartureTime > NOW() "+
    				"GROUP BY "+
    				    "f.FlightNumber "+
    				"ORDER BY "+
    				    "TicketsSold DESC; ";
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User portfolio</title>
</head>
<body>
	<%
	Connection con = null;
    try {
        String username = (String) session.getAttribute("username");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();
        

        String query = "SELECT reservation.*, flight.ArrivalTime, " +
                "CASE WHEN flight.ArrivalTime < NOW() THEN 'Past' " +
                "ELSE 'Upcoming' END AS ReservationStatus " +
                "FROM reservation " +
                "JOIN flight ON reservation.FlightNumber = flight.FlightNumber " +
                "WHERE reservation.ID = (SELECT AccountID FROM account WHERE username = ?) " +
                "ORDER BY flight.ArrivalTime DESC;";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, username);

        ResultSet rs = pstmt.executeQuery();
        Date today = new Date();
        %>
        <h2>Upcoming Reservations</h2>
        <table border="1">
            <tr>
                <th>Reservation ID</th>
                <th>Flight Number</th>
                <th>Seat Number</th>
                <th>Ticket Class</th>
                <th>Ticket Fare</th>
                <th>Purchase Date</th>
                <th>Booking Fee</th>
            </tr>
            <% while (rs.next()) {
            	if ("Upcoming".equals(rs.getString("ReservationStatus"))) { %>
                <tr>
                    <td><%= rs.getInt("ReservationID") %></td>
                    <td><%= rs.getInt("FlightNumber") %></td>
                    <td><%= rs.getString("SeatNumber") %></td>
                    <td><%= rs.getString("TicketClass") %></td>
                    <td><%= rs.getDouble("TicketFare") %></td>
                    <td><%= rs.getTimestamp("PurchaseDateTime") %></td>
                    <td><%= rs.getDouble("BookingFee") %></td>
                </tr>
            <% }
        }
        rs.beforeFirst(); // Reset ResultSet for the next iteration
        %>
    </table>

    <h2>Past Reservations</h2>
    <table border="1">
        <tr>
            <th>Reservation ID</th>
            <th>Flight Number</th>
            <th>Seat Number</th>
            <th>Ticket Class</th>
            <th>Ticket Fare</th>
            <th>Purchase Date</th>
            <th>Booking Fee</th>
        </tr>
        <% while (rs.next()) {
            if ("Past".equals(rs.getString("ReservationStatus"))) { %>
                <tr>
                    <td><%= rs.getInt("ReservationID") %></td>
                    <td><%= rs.getInt("FlightNumber") %></td>
                    <td><%= rs.getString("SeatNumber") %></td>
                    <td><%= rs.getString("TicketClass") %></td>
                    <td><%= rs.getDouble("TicketFare") %></td>
                    <td><%= rs.getTimestamp("PurchaseDateTime") %></td>
                    <td><%= rs.getDouble("BookingFee") %></td>
                </tr>
            <% }
        } %>
    </table>
    <% 
        rs.close();
        pstmt.close();
    } catch (Exception ex) {
        out.print("An error occurred: " + ex.getMessage());
        ex.printStackTrace();
    } finally {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                out.print("Error closing connection: " + e.getMessage());
            }
        }
    }
    %>
</body>
</html>
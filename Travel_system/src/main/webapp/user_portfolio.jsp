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

        String query = "SELECT * FROM reservation WHERE ID = (SELECT AccountID FROM account WHERE username = ?)";
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
                Timestamp purchaseDateTime = rs.getTimestamp("PurchaseDateTime");
                String ticketClass = rs.getString("TicketClass");
                if (purchaseDateTime.after(today)) { %>
                    <tr>
                        <td><%= rs.getInt("ReservationID") %></td>
                        <td><%= rs.getInt("FlightNumber") %></td>
                        <td><%= rs.getString("SeatNumber") %></td>
                        <td><%= ticketClass %></td>
                        <td><%= rs.getDouble("TicketFare") %></td>
                        <td><%= purchaseDateTime %></td>
                        <td><%= rs.getDouble("BookingFee") %></td>
                        <td>
                            <% if ("business".equals(ticketClass) || "first".equals(ticketClass)) { %>
                                <form action="CancelReservationServlet" method="post">
                                    <input type="hidden" name="reservationId" value="<%= rs.getInt("ReservationID") %>" />
                                    <input type="submit" value="Cancel Reservation" />
                                </form>
                            <% } %>
                        </td>
                    </tr>
            <%  }
            }
            rs.beforeFirst(); // Reset ResultSet to the beginning %>
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
                Timestamp purchaseDateTime = rs.getTimestamp("PurchaseDateTime");
                if (purchaseDateTime.before(today)) { %>
                    <tr>
                        <td><%= rs.getInt("ReservationID") %></td>
                        <td><%= rs.getInt("FlightNumber") %></td>
                        <td><%= rs.getString("SeatNumber") %></td>
                        <td><%= rs.getString("TicketClass") %></td>
                        <td><%= rs.getDouble("TicketFare") %></td>
                        <td><%= purchaseDateTime %></td>
                        <td><%= rs.getDouble("BookingFee") %></td>
                    </tr>
            <%  }
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
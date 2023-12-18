<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>logged in</title>
</head>
<body>

<script>

<%String sessionID = String.valueOf(session.getAttribute("username"));
String userType = String.valueOf(session.getAttribute("userType"));
String password = String.valueOf(session.getAttribute("password"));
String username= sessionID;



ApplicationDB db = new ApplicationDB();
Connection con = db.getConnection();
Statement stmt = con.createStatement();

String getAccountID = "SELECT * FROM account WHERE username = ? AND password = ? ;";
PreparedStatement pstmt_second = con.prepareStatement(getAccountID);
pstmt_second.setString(1, sessionID);
pstmt_second.setString(2, password);
ResultSet resultSet = pstmt_second.executeQuery();

if (resultSet.next()) {
    int accountID = resultSet.getInt("AccountID");
    session.setAttribute("accountID",accountID);

}else{
    session.setAttribute("accountID","no result from query");

}
out.println("console.log('AccountID Attribute: " + session.getAttribute("accountID") + "');");
out.println("console.log('USERNAME Attribute: " + session.getAttribute("username") + "');");
out.println("console.log('PASSWORD Attribute: " + session.getAttribute("password") + "');");


%>
</script>



	<h2>Congratulations, <%=sessionID%> ! you are now logged in with <%=userType%> privileges</h2> <br></br>
	<h2>Welcome to your home page</h2>

	
	<% if ("admin".equals(userType)) { %>
        <form action="AdminPage.jsp" method="post">
            <button type="submit">Manage Report</button>
        </form>
    <% } else if ("customer".equals(userType)){ %>
        <form action="user_portfolio.jsp" method="post">
            <button type="submit">Account History</button>
            		<button type="submit" formaction="book_a_flight.jsp">Book Now</button>
            
			<button type="submit" formaction="ask_question.jsp">Ask a Question</button>
            <button type="submit" formaction="view_all_questions.jsp">View All Questions</button>
            
        </form>
    <% } else if("customerrep".equals(userType)){
    	%><form action="customer_rep.jsp" method="post">
        <button type="submit">Manage bookings</button>
        		<button type="submit" formaction="book_a_flight.jsp">Book Now</button>
        
        <button type="submit" formaction="view_all_questions.jsp">View and Answer All Questions</button>
    </form>
    	<% 
    }
%>

	<form action="welcome_page.jsp" method="post">
		<button type="submit">Log-out</button>
	</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding question to DB </title>
</head>
<body>

<%
// Get the account ID from the session
int accountID = (int) session.getAttribute("accountID");

out.println(accountID);
// Retrieve other form parameters
String questionText = request.getParameter("question");
out.println(questionText);

// Your database connection code here
ApplicationDB db = new ApplicationDB();
Connection con = db.getConnection();


try {
    // Your SQL query to insert the question into the database
    String sql = "INSERT INTO questionanswer (CustomerID, Question) VALUES (?, ?)";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, accountID);
    pstmt.setString(2, questionText);

    // Execute the query
    int rowsAffected = pstmt.executeUpdate();

    // Handle the result as needed
    if (rowsAffected > 0) {
        out.println("Question submitted successfully!");
        response.sendRedirect("Login_success.jsp");
    } else {
        out.println("Error submitting the question.");
        response.sendRedirect("ask_question.jsp");

    }
    pstmt.close();
} catch (SQLException e) {
    // Handle SQL exceptions
    e.printStackTrace();
} finally {
    con.close();
    
}
%>


</body>
</html>
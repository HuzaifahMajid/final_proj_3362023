<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add answer to DB </title>
</head>
<body>
<%
    try {
        // Retrieve the question ID and answer from the form
        String qaIDString = request.getParameter("qaID");
        String answer = request.getParameter("answer");

        // Validate if the qaIDString is not null and is a valid integer
        if (qaIDString != null && qaIDString.matches("\\d+")) {
            int qaID = Integer.parseInt(qaIDString);

            // Insert the answer into the database
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            String addAnswerQuery = "UPDATE questionanswer SET Answer = ? WHERE QAID = ?";
            PreparedStatement pstmt = con.prepareStatement(addAnswerQuery);
            pstmt.setString(1, answer);
            pstmt.setInt(2, qaID);

            // Execute the update
            int rowsAffected = pstmt.executeUpdate();

            // Check if the update was successful
            if (rowsAffected > 0) {
%>

                <h2>Answer Added Successfully</h2>
                <p>The answer has been added to the selected question.</p>
                <p><a href="view_all_questions.jsp">Go back to View All Questions</a></p>

<%
            } else {
%>

                <h2>Error Adding Answer</h2>
                <p>There was an error adding the answer. Please try again.</p>

<%
            }
            pstmt.close();
            con.close();
        } else {
%>

            <h2>Error: Invalid or Missing Question ID</h2>
            <p>The question ID is not valid or missing.</p>

<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>



</body>
</html>
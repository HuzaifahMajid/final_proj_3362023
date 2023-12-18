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

<%
    String userType = (String) session.getAttribute("userType");

    // Check if the user is a customer rep
    if (userType != null && userType.equals("customerrep")) {
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();

            // Retrieve the selected question ID from the previous page
            String selectedQuestionID = request.getParameter("selectedQuestion");

            // Validate if the selectedQuestionID is not null and is a valid integer
            if (selectedQuestionID != null && selectedQuestionID.matches("\\d+")) {
                int qaID = Integer.parseInt(selectedQuestionID);

                // Retrieve the details of the selected question
                String getSelectedQuestionQuery = "SELECT * FROM questionanswer WHERE QAID = ?";
                PreparedStatement pstmt = con.prepareStatement(getSelectedQuestionQuery);
                pstmt.setInt(1, qaID);
                ResultSet selectedQuestionResultSet = pstmt.executeQuery();

                // Check if the selected question exists
                if (selectedQuestionResultSet.next()) {
                    String selectedQuestion = selectedQuestionResultSet.getString("Question");
%>

                    <h2>Selected Question</h2>
                    <p><strong>Question:</strong> <%=selectedQuestion%></p>

                    <form action="add_answer.jsp" method="post">
                        <input type="hidden" name="qaID" value="<%=qaID%>">
                        <label for="answer">Answer:</label>
                        <textarea id="answer" name="answer" rows="4" cols="50" required></textarea>
                        <br>
                        <input type="submit" value="Submit Answer">
                    </form>

<%
                } else {
%>

                    <p>Error: Selected question not found.</p>

<%
                }
                selectedQuestionResultSet.close();
                pstmt.close();
            } else {
%>

                <p>Error: Invalid or missing question ID.</p>

<%
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
%>

    <p>Error: Access denied. This page is only accessible to customer representatives.</p>

<%
    }
%>

</body>
</html>
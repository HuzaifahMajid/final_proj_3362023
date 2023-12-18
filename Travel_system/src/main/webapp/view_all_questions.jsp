<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>view all questions </title>
</head>
<body>

<%
    String userType = (String) session.getAttribute("userType");

    try {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement stmt = con.createStatement();

        // Retrieve all questions
        String getAllQuestionsQuery = "SELECT * FROM questionanswer";
        ResultSet questionsResultSet = stmt.executeQuery(getAllQuestionsQuery);
%>

        <h2>All Questions</h2>

        <form action="#" method="get">
            <label for="searchBox">Search: </label>
            <input type="text" id="searchBox" name="searchBox">
            <input type="submit" value="Search">
        </form>

        <%
            // Handle search logic here and display the filtered questions
            String searchTerm = request.getParameter("searchBox");
            List<String> filteredQuestions = new ArrayList<>();

            while (questionsResultSet.next()) {
                String question = questionsResultSet.getString("Question");
                

                // Check if the question contains the search term
                if (searchTerm == null || question.toLowerCase().contains(searchTerm.toLowerCase())) {
                    filteredQuestions.add(question);
                }
            }

            // Display the filtered questions
            if (filteredQuestions.isEmpty()) {
        %>
                <p>No matching questions found.</p>
        <%
            } else {
        %>
                <table border="1">
                    <tr>
                        <th>Question</th>
                    </tr>

                    <%
                        for (String question : filteredQuestions) {
                    %>
                            <tr>
                                <td><%=question%></td>
                            </tr>
                    <%
                        }
                    %>
                </table>
        <%
            }
            questionsResultSet.close();
        %>

<%
        // If the user is a customer rep, show the answer form
        if (userType != null && userType.equals("customerrep")) {
%>

            <form action="customer_rep.jsp" method="post">
                <h2>All Questions (Customer Rep)</h2>
                <table border="1">
                    <tr>
                        <th>Select</th>
                        <th>Question</th>
                    </tr>

                    <%
                        questionsResultSet = stmt.executeQuery(getAllQuestionsQuery);

                        while (questionsResultSet.next()) {
                            int qaID = questionsResultSet.getInt("QAID");
                            String question = questionsResultSet.getString("Question");
                    %>
                            <tr>
                                <td><input type="radio" name="selectedQuestion" value="<%=qaID%>"></td>
                                <td><%=question%></td>
                            </tr>
                    <%
                        }
                        questionsResultSet.close();
                    %>
                </table>
                <br>
                <input type="submit" value="Answer Selected Question">
            </form>

<%
        }

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>
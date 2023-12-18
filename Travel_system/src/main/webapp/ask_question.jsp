<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ask a Question</title>
</head>
<body>

  <form action="add_question.jsp" method="post">
        <label for="question">Question:</label>
        <textarea id="question" name="question" rows="4" cols="50" required></textarea>
        <br>
        <input type="submit" value="Submit Question">
    </form>

</body>
</html>
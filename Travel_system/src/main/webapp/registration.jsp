<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Registration</title>
</head>
<body>

 <h2>Customer Registration</h2>
    <form action="check_credentials.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br>
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>
        
        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required><br>

        <input type="submit" value="Register">
    </form>
    
    <!--  sql code to add customer account to database-->
    
  


</body>
</html>
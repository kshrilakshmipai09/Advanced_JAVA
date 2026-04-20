<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome</title>
</head>
<body>

<%
String name = request.getParameter("uname");

// Store in session
session.setAttribute("user", name);

// Set session expiry to 1 minute
session.setMaxInactiveInterval(60);
%>

<h2>Hello <%= name %>!</h2>

<a href="second.jsp">Click here to check session</a>

</body>
</html>

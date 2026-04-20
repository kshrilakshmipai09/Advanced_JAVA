<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Result Page</title>
</head>
<body>

    <h2>Student Result</h2>

    <%
        String rollno = (String) request.getAttribute("rollno");
        String name = (String) request.getAttribute("name");
        int[] marks = (int[]) request.getAttribute("marks");
        Double average = (Double) request.getAttribute("average");
        String result = (String) request.getAttribute("result");
        String message = (String) request.getAttribute("message");
    %>

    <% if (message != null && !message.isEmpty()) { %>
        <h3 style="color:red;"><%= message %></h3>
    <% } else { %>

        Roll No: <%= rollno %><br><br>
        Name: <%= name %><br><br>

        <h3>Marks:</h3>
        Sub1: <%= marks[0] %><br>
        Sub2: <%= marks[1] %><br>
        Sub3: <%= marks[2] %><br>
        Sub4: <%= marks[3] %><br>
        Sub5: <%= marks[4] %><br><br>

        Average: <%= average %><br><br>
        Result: <b><%= result %></b><br><br>

    <% } %>

    <a href="index.jsp">Go Back</a>

</body>
</html>

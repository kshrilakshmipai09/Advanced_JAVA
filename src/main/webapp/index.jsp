<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Cookie List Management</title>

<style>
body {
    font-family: Arial;
    margin: 40px;
}

.container {
    width: 500px;
}

input {
    padding: 5px;
    margin: 5px 0;
    width: 200px;
}

button {
    padding: 6px 10px;
}

table {
    border-collapse: collapse;
    width: 100%;
    margin-top: 10px;
}

th, td {
    border: 1px solid #ccc;
    padding: 8px;
}

th {
    background-color: #eee;
}

.note {
    color: gray;
    font-size: 13px;
}
</style>

<!-- remove this -->
<script>
let isTyping = false;

document.addEventListener("input", function() {
    isTyping = true;
});

setInterval(function() {
    if (!isTyping) {
        window.location.reload();
    }
    isTyping = false;
}, 3000);
</script>

</head>

<body>

<div class="container">

<h3>Set New Cookie</h3>

<form action="setCookie.jsp" method="post">

<label>Cookie Name:</label><br>
<input type="text" name="cookieName" required><br>

<label>Domain:</label><br>
<input type="text" name="domain" required><br>

<label>Max Age (seconds):</label><br>
<input type="number" name="maxAge" value="60" required><br><br>

<input type="submit" value="Add Cookie">

</form>

<hr>

<h3>List of Active Cookies</h3>
<p class="note">List updates automatically when cookies expire</p>

<table>
<tr>
    <th>Cookie Name</th>
    <th>Domain</th>
    <th>Max Age (seconds)</th>
</tr>

<%
List<Map<String, String>> cookieList =
    (List<Map<String, String>>) session.getAttribute("cookieList");

long currentTime = System.currentTimeMillis() / 1000;

if (cookieList != null) {

    Iterator<Map<String, String>> iterator = cookieList.iterator();

    while (iterator.hasNext()) {
        Map<String, String> c = iterator.next();

        long setTime = Long.parseLong(c.get("setTime"));
        int maxAge = Integer.parseInt(c.get("maxAge"));

        if (currentTime > setTime + maxAge) {
            iterator.remove();
        }
    }

    session.setAttribute("cookieList", cookieList);
}

if (cookieList != null && !cookieList.isEmpty()) {
    for (Map<String, String> c : cookieList) {
%>

<tr>
    <td><%= c.get("name") %></td>
    <td><%= c.get("domain") %></td>
    <td><%= c.get("maxAge") %></td>
</tr>

<%
    }
} else {
%>

<tr>
    <td colspan="3" align="center">No active cookies</td>
</tr>

<%
}
%>

</table>

</div>

</body>
</html>
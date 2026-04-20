<%@ page import="java.util.*" %>

<%
String name = request.getParameter("cookieName");
String domain = request.getParameter("domain");
String maxAgeStr = request.getParameter("maxAge");

int maxAge = Integer.parseInt(maxAgeStr);

// Get existing list
List<Map<String, String>> cookieList =
    (List<Map<String, String>>) session.getAttribute("cookieList");

if (cookieList == null) {
    cookieList = new ArrayList<>();
}

// Create new cookie data
Map<String, String> cookie = new HashMap<>();
cookie.put("name", name);
cookie.put("domain", domain);
cookie.put("maxAge", maxAgeStr);
cookie.put("setTime", String.valueOf(System.currentTimeMillis() / 1000));

// Add to list
cookieList.add(cookie);

// Save back to session
session.setAttribute("cookieList", cookieList);

// Redirect back
response.sendRedirect("index.jsp");
%>
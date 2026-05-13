<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Database Connection Test</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .success { color: green; font-size: 18px; }
        .error { color: red; font-size: 18px; }
    </style>
</head>
<body>
    <h2>🧪 Database Connection Test</h2>
    
    <%
        String url = "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        String user = "root";
        String pass = "password";   // Change this if your password is different

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, pass);
            
            out.println("<h3 class='success'>✅ Database Connection SUCCESSFUL!</h3>");
            out.println("<p>Connected to: <b>hospitaldb</b></p>");
            
            // Check if Patients table exists
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SHOW TABLES LIKE 'Patients'");
            if(rs.next()) {
                out.println("<p>✅ Table <b>Patients</b> exists.</p>");
            } else {
                out.println("<p style='color:orange'>⚠️ Table Patients does not exist.</p>");
            }
            
            con.close();
            
        } catch (Exception e) {
            out.println("<h3 class='error'>❌ Connection FAILED!</h3>");
            out.println("<pre>" + e.getMessage() + "</pre>");
        }
    %>
    
    <br>
    <a href="patientadd.jsp">Go to Add Patient</a> | 
    <a href="patientdisplay.jsp">View Patients</a>
</body>
</html>
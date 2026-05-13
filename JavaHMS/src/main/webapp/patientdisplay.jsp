<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.HospitalDAO, com.model.Patient, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Patients - Hospital Management</title>
    <link rel="stylesheet" href="style.css?v=2" type="text/css">
   
    <style>
        body { background: linear-gradient(135deg, #bae6fd 0%, #e0f2fe 100%); }
        table { border-collapse: collapse; width: 100%; background: white; margin-bottom: 30px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background: linear-gradient(135deg, #14b8a6, #0f766e); color: white; }
        .deleted-table th { background: linear-gradient(135deg, #ef4444, #b91c1c); }
        .success { color: green; font-weight: bold; background-color: #d4edda; padding: 10px; border-radius: 5px; margin: 10px 0; }
        .error { color: red; font-weight: bold; }
    </style>
</head>
<body>
    <h2>All Patients</h2>
    <a href="index.jsp">Home</a> |
    <a href="patientadd.jsp">Add New Patient</a><br><br>

    <%
        HospitalDAO dao = new HospitalDAO();
        List<Patient> patients = dao.getAllPatients();
        
        // Show deletion success message
        String deletedId = request.getParameter("deletedId");
        String deletedName = request.getParameter("deletedName");
        if(deletedId != null && deletedName != null) { 
    %>
        <p class="success">
            ✅ Patient <strong><%= deletedName %></strong> (ID: <%= deletedId %>) has been moved to Deleted Records.
        </p>
    <% } %>

    <h3>Active Patients</h3>
    <p>Total Active Patients: <%= patients.size() %></p>

    <% if(patients.isEmpty()) { %>
        <p class="error">No active patients found.</p>
    <% } else { %>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Admission Date</th>
                <th>Ailment</th>
                <th>Doctor</th>
                <th>Actions</th>
            </tr>
            <% for(Patient p : patients) { %>
            <tr>
                <td><%= p.getPatientID() %></td>
                <td><%= p.getPatientName() %></td>
                <td><%= p.getAge() %></td>
                <td><%= p.getGender() %></td>
                <td><%= p.getAdmissionDate() %></td>
                <td><%= p.getAilment() %></td>
                <td><%= p.getAssignedDoctor() %></td>
                <td>
                    <a href="patientupdate.jsp?id=<%= p.getPatientID() %>">Edit</a> |
                    <a href="DeletePatientServlet?id=<%= p.getPatientID() %>" 
                       onclick="return confirm('Move this patient to Deleted Records?')">Delete</a>
                </td>
            </tr>
            <% } %>
        </table>
    <% } %>

    <%-- ==================== DELETED RECORDS SECTION ==================== --%>
    <%
        List<Patient> deletedPatients = dao.getAllDeletedPatients();   // You need this method
    %>

    <h3 style="color: #ef4444; margin-top: 40px;">Deleted Records</h3>
    <p>Total Deleted Records: <%= deletedPatients.size() %></p>

    <% if(deletedPatients.isEmpty()) { %>
        <p>No deleted records yet.</p>
    <% } else { %>
        <table class="deleted-table">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Admission Date</th>
                <th>Ailment</th>
                <th>Doctor</th>
                <th>Deleted On</th>
            </tr>
            <% for(Patient p : deletedPatients) { %>
            <tr>
                <td><%= p.getPatientID() %></td>
                <td><%= p.getPatientName() %></td>
                <td><%= p.getAge() %></td>
                <td><%= p.getGender() %></td>
                <td><%= p.getAdmissionDate() %></td>
                <td><%= p.getAilment() %></td>
                <td><%= p.getAssignedDoctor() %></td>
               <td><%= (p.getDeletedDate() != null) ? p.getDeletedDate().toString().substring(0, 19) : "N/A" %></td>
            </tr>
            <% } %>
        </table>
    <% } %>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.HospitalDAO, com.model.Patient, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Page Title</title>
    <link rel="stylesheet" href="style.css">
</head>
<head>
    <meta charset="UTF-8">
    <title>Report Results</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background-color: #f0f0f0; }
        .success { color: green; }
        .no-data { color: orange; font-style: italic; }
    </style>
</head>
<body>
    <h2>Report Results</h2>
    <a href="reports.jsp">← Back to Reports</a> |
    <a href="patientdisplay.jsp">View All Patients</a><br><br>

    <%
        HospitalDAO dao = new HospitalDAO();
        List<Patient> patients = null;
        String reportType = (String) request.getAttribute("reportType");
        String title = "";

        if ("dateRange".equals(reportType)) {
            String fromDate = (String) request.getAttribute("fromDate");
             String toDate = (String) request.getAttribute("toDate");
            patients = dao.getPatientsByDateRange(fromDate, toDate);
            title = "Patients Admitted from " + fromDate + " to " + toDate;

        } else if ("ailment".equals(reportType)) {
            String ailment = (String) request.getAttribute("ailment");
            patients = dao.getPatientsByAilment(ailment);
            title = "Patients with Ailment: " + ailment;

        } else if ("doctor".equals(reportType)) {
            String doctor = (String) request.getAttribute("doctor");
            patients = dao.getPatientsByDoctor(doctor);
            title = "Patients Assigned to Doctor: " + doctor;
        }
    %>

    <h3><%= title %></h3>

    <!-- Print Button Added Here -->
    <button onclick="window.print()" style="padding: 8px 16px; font-size: 16px; margin-bottom: 15px; cursor: pointer;">
        🖨 Print Report
    </button>

    <% if(patients != null && !patients.isEmpty()) { %>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Admission Date</th>
                <th>Ailment</th>
                <th>Doctor</th>
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
            </tr>
            <% } %>
        </table>
        <p class="success"><b>Total Records: <%= patients.size() %></b></p>
    <% } else { %>
        <p class="no-data">No records found for this criteria.</p>
    <% } %>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.HospitalDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Page Title</title>
    <link rel="stylesheet" href="style.css">
</head>
<head>
    <title>Add New Patient</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        input, select { padding: 10px; margin: 8px 0; width: 350px; }
        .btn {
            padding: 12px 20px;
            margin: 10px 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .add-btn { background-color: #28a745; color: white; }
        .home-btn { background-color: #6c757d; color: white; }
        .success { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
    </style>
</head>
<body>
    <h2>Add New Patient</h2>

    <%
        HospitalDAO dao = new HospitalDAO();
        int nextPatientId = dao.getNextPatientId();
    %>

    <!-- Added Patient ID Display -->
    <p><strong>Patient ID:</strong> 
        <input type="text" value="<%= nextPatientId %>" 
               style="font-size: 18px; font-weight: bold; color: #0066cc; width: 150px; background-color: #f0f8ff;" 
               readonly>
        <small>(Auto-generated)</small>
    </p>

    <%
        String status = request.getParameter("status");
        if("success".equals(status)) { %>
            <p class="success">✅ Patient Added Successfully!</p>
    <% } else if("failed".equals(status)) { %>
            <p class="error">❌ Failed to add patient. Please check database.</p>
    <% } %>

    <form action="AddPatientServlet" method="post" onsubmit="return validateForm()">
        Patient Name: <input type="text" name="patientName" id="patientName"
                           placeholder="Enter only letters" required><br>
       
        Age: <input type="number" name="age" required><br>
       
        Gender:
        <select name="gender" required>
            <option value="">Select Gender</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
        </select><br>

        Admission Date: <input type="date" name="admissionDate" required><br>

        Ailment / Disease:
        <select name="ailment" required>
            <option value="">Select Ailment</option>
            <option value="Fever">Fever</option>
            <option value="Diabetes">Diabetes</option>
            <option value="Hypertension">Hypertension</option>
            <option value="COVID-19">COVID-19</option>
            <option value="Asthma">Asthma</option>
            <option value="Heart Disease">Heart Disease</option>
            <option value="Other">Other</option>
        </select><br>

        Assigned Doctor:
        <select name="assignedDoctor" required>
            <option value="">Select Doctor</option>
            <option value="Dr. Sharma">Dr. Sharma</option>
            <option value="Dr. Patel">Dr. Patel</option>
            <option value="Dr. Gupta">Dr. Gupta</option>
            <option value="Dr. Singh">Dr. Singh</option>
            <option value="Dr. Reddy">Dr. Reddy</option>
            <option value="Dr. Khan">Dr. Khan</option>
            <option value="Other">Other</option>
        </select><br><br>

        <input type="submit" value="Add Patient" class="btn add-btn">
        <a href="index.jsp" class="btn home-btn">Back to Home</a>
    </form>

    <script>
        function validateForm() {
            var name = document.getElementById("patientName").value.trim();
            var nameRegex = /^[a-zA-Z\s]+$/; // Only letters and spaces

            if (!nameRegex.test(name)) {
                alert("❌ Patient Name should contain only characters (A-Z, a-z) and spaces. No numbers or special characters allowed.");
                return false;
             }
            return true;
        }
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.HospitalDAO, com.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Page Title</title>
    <link rel="stylesheet" href="style.css">
</head>
<head>
    <meta charset="UTF-8">
    <title>Update Patient</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        input, select { padding: 10px; margin: 8px 0; width: 350px; }
        .container { max-width: 600px; margin: auto; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Update Patient Details</h2>
        <a href="patientdisplay.jsp">← Back to Patient List</a><br><br>

        <%
            String idParam = request.getParameter("id");
            if(idParam == null || idParam.isEmpty()) {
                out.println("<h3 style='color:red'>Error: Patient ID not found!</h3>");
            } else {
                int id = Integer.parseInt(idParam);
                HospitalDAO dao = new HospitalDAO();
                Patient p = dao.getPatientById(id);
                
                if(p != null) {
        %>
        <form action="UpdatePatientServlet" method="post">
            <input type="hidden" name="patientID" value="<%= p.getPatientID() %>">

            Patient Name: <input type="text" name="patientName" value="<%= p.getPatientName() %>" required><br>
            Age: <input type="number" name="age" value="<%= p.getAge() %>" required><br>
            Gender: <input type="text" name="gender" value="<%= p.getGender() %>" required><br>
            Admission Date: <input type="date" name="admissionDate" value="<%= p.getAdmissionDate() %>" required><br>

            Ailment:
            <select name="ailment" required>
                <option value="<%= p.getAilment() %>" selected><%= p.getAilment() %></option>
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
                <option value="<%= p.getAssignedDoctor() %>" selected><%= p.getAssignedDoctor() %></option>
                <option value="Dr. Sharma">Dr. Sharma</option>
                <option value="Dr. Patel">Dr. Patel</option>
                <option value="Dr. Gupta">Dr. Gupta</option>
                <option value="Dr. Singh">Dr. Singh</option>
                <option value="Dr. Reddy">Dr. Reddy</option>
                <option value="Dr. Khan">Dr. Khan</option>
                <option value="Other">Other</option>
            </select><br><br>

            <input type="submit" value="Update Patient">
        </form>
        <%
                } else {
                    out.println("<h3 style='color:red'>Patient not found with ID: " + id + "</h3>");
                }
            }
        %>
    </div>
</body>
</html>
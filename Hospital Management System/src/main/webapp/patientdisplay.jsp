<%@ page import="com.model.Patient" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dao.HospitalDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Patients - Hospital Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1300px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #17a2b8, #138496);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h2 {
            font-size: 2em;
            margin-bottom: 10px;
        }
        
        .stats-bar {
            background: #e9ecef;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .stat-badge {
            background: #17a2b8;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 600;
        }
        
        .btn-back {
            background: #6c757d;
            color: white;
            padding: 8px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
        }
        
        .btn-refresh {
            background: #28a745;
            color: white;
            padding: 8px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
        }
        
        .table-container {
            padding: 30px;
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }
        
        th {
            padding: 15px;
            text-align: left;
        }
        
        td {
            padding: 12px 15px;
            border-bottom: 1px solid #e9ecef;
        }
        
        tbody tr:hover {
            background: #f8f9fa;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px;
            color: #6c757d;
        }
        
        .empty-state-icon {
            font-size: 4em;
            margin-bottom: 20px;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            margin: 20px;
            border-radius: 8px;
            border-left: 4px solid #dc3545;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            margin: 20px;
            border-radius: 8px;
            border-left: 4px solid #28a745;
        }
        
        .btn-add {
            background: #28a745;
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
        }
        
        .action-buttons {
            display: flex;
            gap: 40px;
            align-items: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>📋 Patient Records</h2>
            <p>Complete list of all registered patients</p>
        </div>
        
        <div class="stats-bar">
            <div class="action-buttons">
                <div class="stat-badge" id="patientCount">
                    Loading...
                </div>
                <button class="btn-add" onclick="location.href='patientadd.jsp'">➕ Add New Patient</button>
            </div>
            <div>
                <button class="btn-refresh" onclick="location.href='DisplayPatientsServlet'">🔄 Refresh</button>
                <button class="btn-back" onclick="location.href='index.jsp'">← Dashboard</button>
            </div>
        </div>
        
        <div class="table-container">
            <%
                // Fetch patients if not already in request
                List<Patient> patients = (List<Patient>) request.getAttribute("patients");
                
                // If null, fetch directly from DAO
                if (patients == null) {
                    try {
                        HospitalDAO dao = new HospitalDAO();
                        patients = dao.getAllPatients();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<div class='error-message'>❌ Database Error: " + e.getMessage() + "</div>");
                    }
                }
                
                if (patients != null && !patients.isEmpty()) {
            %>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Admission Date</th>
                            <th>Ailment</th>
                            <th>Assigned Doctor</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Patient p : patients) { %>
                            <tr>
                                <td><strong><%= p.getPatientId() %></strong></td>
                                <td><%= p.getPatientName() %></td>
                                <td><%= p.getAge() %></td>
                                <td><%= p.getGender() %></td>
                                <td><%= p.getFormattedDate() %></td>
                                <td><%= p.getAilment() %></td>
                                <td><%= p.getAssignedDoctor() %></td>
                                <td>
                                    <button onclick="location.href='UpdatePatientServlet?id=<%= p.getPatientId() %>'" 
                                            style="background:#ffc107; border:none; padding:5px 10px; border-radius:5px; cursor:pointer;">✏️</button>
                                    <button onclick="if(confirm('Delete?')) location.href='DeletePatientServlet?id=<%= p.getPatientId() %>'" 
                                            style="background:#dc3545; color:white; border:none; padding:5px 10px; border-radius:5px; cursor:pointer;">🗑️</button>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                <script>
                    document.getElementById('patientCount').innerHTML = 'Total Patients: <%= patients.size() %>';
                </script>
            <% 
                } else { 
            %>
                <div class="empty-state">
                    <div class="empty-state-icon">📭</div>
                    <h3>No Patients Found</h3>
                    <p>Click "Add New Patient" to register your first patient</p>
                    <button class="btn-add" onclick="location.href='patientadd.jsp'" style="margin-top: 20px;">➕ Add New Patient</button>
                </div>
                <script>
                    document.getElementById('patientCount').innerHTML = 'Total Patients: 0';
                </script>
            <% 
                } 
            %>
        </div>
    </div>
</body>
</html>
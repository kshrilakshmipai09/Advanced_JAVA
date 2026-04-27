<%@ page import="com.model.Patient" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Results - Hospital Management</title>
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
            animation: slideIn 0.5s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .header {
            background: linear-gradient(135deg, #6f42c1, #764ba2);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h2 {
            font-size: 2em;
            margin-bottom: 10px;
        }
        
        .report-info {
            background: #f8f9fa;
            padding: 20px 30px;
            border-bottom: 1px solid #dee2e6;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .report-title-box {
            flex: 1;
        }
        
        .report-title-box h3 {
            color: #333;
            font-size: 1.3em;
            margin-bottom: 5px;
        }
        
        .report-title-box p {
            color: #6c757d;
            font-size: 0.9em;
        }
        
        .stats-badge {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 10px 25px;
            border-radius: 30px;
            text-align: center;
        }
        
        .stats-badge .count {
            font-size: 2em;
            font-weight: bold;
        }
        
        .stats-badge .label {
            font-size: 0.8em;
            opacity: 0.9;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        
        .btn-print, .btn-back, .btn-export {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-print {
            background: #17a2b8;
            color: white;
        }
        
        .btn-export {
            background: #28a745;
            color: white;
        }
        
        .btn-back {
            background: #6c757d;
            color: white;
        }
        
        .btn-print:hover, .btn-export:hover, .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .table-container {
            padding: 30px;
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        
        thead {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }
        
        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            white-space: nowrap;
        }
        
        td {
            padding: 12px 15px;
            border-bottom: 1px solid #e9ecef;
        }
        
        tbody tr:hover {
            background: #f8f9fa;
            transition: background 0.3s;
        }
        
        .message-container {
            padding: 40px;
            text-align: center;
        }
        
        .warning-message {
            background: #fff3cd;
            color: #856404;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #ffc107;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #dc3545;
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
        
        .footer {
            background: #f8f9fa;
            padding: 15px 30px;
            text-align: center;
            color: #6c757d;
            font-size: 0.85em;
            border-top: 1px solid #dee2e6;
        }
        
        @media print {
            body {
                background: white;
                padding: 0;
            }
            .action-buttons, .btn-print, .btn-back, .btn-export, .footer {
                display: none;
            }
            .container {
                box-shadow: none;
                border-radius: 0;
            }
            .stats-badge {
                background: #28a745;
            }
        }
        
        @media (max-width: 768px) {
            .report-info {
                flex-direction: column;
                text-align: center;
            }
            
            .action-buttons {
                width: 100%;
                justify-content: center;
            }
            
            th, td {
                padding: 8px 10px;
                font-size: 12px;
            }
        }
        
        .gender-male {
            background: #e3f2fd;
        }
        
        .gender-female {
            background: #fce4ec;
        }
        
        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        
        .badge-male {
            background: #2196F3;
            color: white;
        }
        
        .badge-female {
            background: #e91e63;
            color: white;
        }
        
        .badge-other {
            background: #9e9e9e;
            color: white;
        }
    </style>
    <script>
        function printReport() {
            window.print();
        }
        
        function exportToCSV() {
            var table = document.getElementById("reportTable");
            var rows = table.querySelectorAll("tr");
            var csv = [];
            
            for (var i = 0; i < rows.length; i++) {
                var row = [], cols = rows[i].querySelectorAll("td, th");
                for (var j = 0; j < cols.length; j++) {
                    var text = cols[j].innerText.replace(/,/g, '');
                    row.push('"' + text + '"');
                }
                csv.push(row.join(","));
            }
            
            var csvFile = new Blob([csv.join("\n")], {type: "text/csv"});
            var downloadLink = document.createElement("a");
            downloadLink.download = "hospital_report.csv";
            downloadLink.href = URL.createObjectURL(csvFile);
            downloadLink.click();
        }
        
        function filterTable() {
            var input = document.getElementById("searchInput");
            var filter = input.value.toUpperCase();
            var table = document.getElementById("reportTable");
            var tr = table.getElementsByTagName("tr");
            
            for (var i = 1; i < tr.length; i++) {
                var td = tr[i].getElementsByTagName("td");
                var found = false;
                for (var j = 0; j < td.length; j++) {
                    if (td[j]) {
                        var textValue = td[j].textContent || td[j].innerText;
                        if (textValue.toUpperCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }
                tr[i].style.display = found ? "" : "none";
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>📊 Report Results</h2>
            <p>Generated from Hospital Management System</p>
        </div>
        
        <% 
            String error = (String) request.getAttribute("error");
            String message = (String) request.getAttribute("message");
            List<Patient> patients = (List<Patient>) request.getAttribute("patients");
            String reportTitle = (String) request.getAttribute("reportTitle");
            Integer patientCount = (Integer) request.getAttribute("patientCount");
            
            if (error != null) { 
        %>
            <div class="message-container">
                <div class="error-message">
                    <strong>❌ Error!</strong><br>
                    <%= error %>
                </div>
                <button class="btn-back" onclick="location.href='reports.jsp'" style="margin-top: 20px;">← Back to Reports</button>
            </div>
        <% } else if (message != null) { %>
            <div class="message-container">
                <div class="warning-message">
                    <strong>⚠️ No Records Found</strong><br>
                    <%= message %>
                </div>
                <button class="btn-back" onclick="location.href='reports.jsp'" style="margin-top: 20px;">← Back to Reports</button>
            </div>
        <% } else if (patients != null && !patients.isEmpty()) { %>
            <div class="report-info">
                <div class="report-title-box">
                    <h3>📋 <%= reportTitle %></h3>
                    <p>Generated on: <%= new java.util.Date() %></p>
                </div>
                <div class="stats-badge">
                    <div class="count"><%= patientCount %></div>
                    <div class="label">Total Patients</div>
                </div>
                <div class="action-buttons">
                    <input type="text" id="searchInput" onkeyup="filterTable()" 
                           placeholder="🔍 Filter results..." 
                           style="padding: 8px 15px; border: 1px solid #ddd; border-radius: 20px; width: 200px;">
                    <button class="btn-export" onclick="exportToCSV()">📎 Export CSV</button>
                    <button class="btn-print" onclick="printReport()">🖨️ Print</button>
                    <button class="btn-back" onclick="location.href='reports.jsp'">← New Report</button>
                </div>
            </div>
            
            <div class="table-container">
                <table id="reportTable">
                    <thead>
                        <tr>
                            <th>Patient ID</th>
                            <th>Patient Name</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Admission Date</th>
                            <th>Ailment</th>
                            <th>Assigned Doctor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Patient p : patients) { 
                            String genderClass = "";
                            String genderBadge = "";
                            if ("Male".equals(p.getGender())) {
                                genderClass = "gender-male";
                                genderBadge = "badge-male";
                            } else if ("Female".equals(p.getGender())) {
                                genderClass = "gender-female";
                                genderBadge = "badge-female";
                            } else {
                                genderBadge = "badge-other";
                            }
                        %>
                            <tr class="<%= genderClass %>">
                                <td><strong><%= p.getPatientId() %></strong></td>
                                <td><%= p.getPatientName() %></td>
                                <td><%= p.getAge() %> yrs</td>
                                <td>
                                    <span class="badge <%= genderBadge %>"><%= p.getGender() %></span>
                                </td>
                                <td><%= p.getFormattedDate() %></td>
                                <td><%= p.getAilment() %></td>
                                <td><%= p.getAssignedDoctor() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            
            <div class="footer">
                <p>This report is generated automatically by Hospital Management System. For any queries, contact administrator.</p>
            </div>
        <% } else { %>
            <div class="message-container">
                <div class="empty-state">
                    <div class="empty-state-icon">📭</div>
                    <h3>No Data Available</h3>
                    <p>Unable to generate report. Please check your criteria and try again.</p>
                    <button class="btn-back" onclick="location.href='reports.jsp'" style="margin-top: 20px;">← Back to Reports</button>
                </div>
            </div>
        <% } %>
    </div>
</body>
</html>
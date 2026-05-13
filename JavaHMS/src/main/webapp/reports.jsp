<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Page Title</title>
    <link rel="stylesheet" href="style.css">
</head>
<head>
    <title>Hospital Reports</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .form-container { max-width: 600px; margin: 0 auto; }
        select, input { padding: 10px; margin: 8px 0; width: 100%; }
        .btn { 
            padding: 12px 25px; 
            background: #007bff; 
            color: white; 
            border: none; 
            border-radius: 5px; 
            cursor: pointer; 
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>📊 Hospital Reports</h2>
        <a href="index.jsp">Home</a> | 
        <a href="patientdisplay.jsp">View Patients</a><br><br>

        <form action="ReportCriteriaServlet" method="post">
            <label><strong>Select Report Type:</strong></label><br><br>
            
            <input type="radio" name="reportType" value="dateRange" id="dateRange"> 
            Patients Admitted in Date Range<br><br>
            
            <input type="radio" name="reportType" value="ailment" id="ailment"> 
            Patients with Specific Ailment<br><br>
            
            <input type="radio" name="reportType" value="doctor" id="doctor" checked> 
            Patients Assigned to Specific Doctor<br><br>

            <div id="dynamicCriteria">
                <!-- Default: Doctor Dropdown -->
                <label>Doctor Name:</label>
                <select name="doctor" required>
                    <option value="">Select Doctor</option>
                    <option value="Dr. Sharma">Dr. Sharma</option>
                    <option value="Dr. Patel">Dr. Patel</option>
                    <option value="Dr. Gupta">Dr. Gupta</option>
                    <option value="Dr. Singh">Dr. Singh</option>
                    <option value="Dr. Reddy">Dr. Reddy</option>
                    <option value="Dr. Khan">Dr. Khan</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <br>
            <input type="submit" value="Generate Report" class="btn">
        </form>
    </div>

    <script>
        document.querySelectorAll('input[name="reportType"]').forEach(radio => {
            radio.addEventListener('change', function() {
                let div = document.getElementById('dynamicCriteria');
                
                if (this.value === "dateRange") {
                    div.innerHTML = `
                        <label>From Date:</label>
                        <input type="date" name="fromDate" required><br><br>
                        <label>To Date:</label>
                        <input type="date" name="toDate" required>
                    `;
                } 
                else if (this.value === "ailment") {
                    div.innerHTML = `
                        <label>Ailment / Disease:</label>
                        <select name="ailment" required>
                            <option value="">Select Ailment</option>
                            <option value="Fever">Fever</option>
                            <option value="Diabetes">Diabetes</option>
                            <option value="Hypertension">Hypertension</option>
                            <option value="COVID-19">COVID-19</option>
                            <option value="Asthma">Asthma</option>
                            <option value="Heart Disease">Heart Disease</option>
                            <option value="Arthritis">Arthritis</option>
                            <option value="Other">Other</option>
                        </select>
                    `;
                } 
                else if (this.value === "doctor") {
                    div.innerHTML = `
                        <label>Doctor Name:</label>
                        <select name="doctor" required>
                            <option value="">Select Doctor</option>
                            <option value="Dr. Sharma">Dr. Sharma</option>
                            <option value="Dr. Patel">Dr. Patel</option>
                            <option value="Dr. Gupta">Dr. Gupta</option>
                            <option value="Dr. Singh">Dr. Singh</option>
                            <option value="Dr. Reddy">Dr. Reddy</option>
                            <option value="Dr. Khan">Dr. Khan</option>
                            <option value="Other">Other</option>
                        </select>
                    `;
                }
            });
        });
    </script>
</body>
</html>
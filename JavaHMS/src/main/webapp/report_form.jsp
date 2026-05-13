<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Page Title</title>
    <link rel="stylesheet" href="style.css">
</head>
<head>
    <meta charset="UTF-8">
    <title>Generate Reports</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f9f9f9;
        }
        h2 {
            color: #333;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }
        input[type="text"], input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="radio"] {
            margin-right: 8px;
        }
        input[type="submit"] {
            margin-top: 25px;
            padding: 12px 25px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>📊 Generate Patient Reports</h2>
        <a href="index.jsp">Home</a> | 
        <a href="patientdisplay.jsp">View All Patients</a><br><br>

        <form action="ReportCriteriaServlet" method="post">
            
            <label>Select Report Type:</label><br><br>
            
            <input type="radio" name="reportType" value="dateRange" id="dateRange" required>
            <label for="dateRange">Patients Admitted in a Date Range</label><br><br>
            
            <input type="radio" name="reportType" value="ailment" id="ailment">
            <label for="ailment">Patients with Specific Ailment</label><br><br>
            
            <input type="radio" name="reportType" value="doctor" id="doctor">
            <label for="doctor">Patients Assigned to Specific Doctor</label><br><br>

            <hr>
            
            <!-- Dynamic Criteria will be loaded here -->
            <div id="dynamicCriteria"></div>

            <input type="submit" value="Generate Report">
        </form>
    </div>

    <script>
        // JavaScript to show relevant input fields based on selection
        document.querySelectorAll('input[name="reportType"]').forEach((radio) => {
            radio.addEventListener('change', function() {
                let criteriaDiv = document.getElementById('dynamicCriteria');
                
                if (this.value === "dateRange") {
                    criteriaDiv.innerHTML = `
                        <label>From Date:</label>
                        <input type="date" name="fromDate" required><br><br>
                        
                        <label>To Date:</label>
                        <input type="date" name="toDate" required>
                    `;
                } 
                else if (this.value === "ailment") {
                    criteriaDiv.innerHTML = `
                        <label>Ailment / Disease:</label>
                        <input type="text" name="ailment" placeholder="e.g. Fever, Diabetes, COVID-19" required>
                    `;
                } 
                else if (this.value === "doctor") {
                    criteriaDiv.innerHTML = `
                        <label>Doctor Name:</label>
                        <input type="text" name="doctor" placeholder="e.g. Dr. Sharma" required>
                    `;
                }
            });
        });
    </script>
</body>
</html>
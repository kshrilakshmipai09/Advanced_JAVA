<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Criteria - Hospital Management</title>
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
            max-width: 800px;
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
        
        .form-container {
            padding: 40px;
        }
        
        .report-type {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        
        .type-btn {
            flex: 1;
            padding: 15px;
            background: #f8f9fa;
            border: 2px solid #dee2e6;
            border-radius: 10px;
            cursor: pointer;
            text-align: center;
            transition: all 0.3s;
        }
        
        .type-btn:hover {
            border-color: #6f42c1;
            background: #f3f0ff;
        }
        
        .type-btn.active {
            background: linear-gradient(135deg, #6f42c1, #764ba2);
            color: white;
            border-color: #6f42c1;
        }
        
        .report-form {
            display: none;
            animation: fadeIn 0.3s ease-out;
        }
        
        .report-form.active {
            display: block;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
        }
        
        input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
        }
        
        input:focus {
            outline: none;
            border-color: #6f42c1;
            box-shadow: 0 0 0 3px rgba(111,66,193,0.1);
        }
        
        .btn-generate {
            background: linear-gradient(135deg, #6f42c1, #764ba2);
            color: white;
            padding: 14px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: transform 0.2s;
        }
        
        .btn-generate:hover {
            transform: translateY(-2px);
        }
        
        .btn-back {
            background: #6c757d;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 15px;
            width: 100%;
            transition: background 0.3s;
        }
        
        .btn-back:hover {
            background: #5a6268;
        }
        
        .info-box {
            background: #e7f3ff;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #2196F3;
        }
        
        @media (max-width: 768px) {
            .report-type {
                flex-direction: column;
            }
        }
    </style>
    <script>
        function showReport(type) {
            // Update button active states
            document.querySelectorAll('.type-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            document.getElementById('btn-' + type).classList.add('active');
            
            // Show corresponding form
            document.querySelectorAll('.report-form').forEach(form => {
                form.classList.remove('active');
            });
            document.getElementById('form-' + type).classList.add('active');
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>📊 Generate Custom Report</h2>
            <p>Select report type and enter criteria</p>
        </div>
        
        <div class="form-container">
            <div class="info-box">
                💡 <strong>Available Reports:</strong><br>
                • Date Range: Find patients admitted between two dates<br>
                • Ailment: Find patients with specific medical conditions<br>
                • Doctor: Find patients assigned to a particular doctor
            </div>
            
            <div class="report-type">
                <div class="type-btn active" id="btn-dateRange" onclick="showReport('dateRange')">
                    📅 Date Range
                </div>
                <div class="type-btn" id="btn-ailment" onclick="showReport('ailment')">
                    🏥 Ailment
                </div>
                <div class="type-btn" id="btn-doctor" onclick="showReport('doctor')">
                    👨‍⚕️ Doctor
                </div>
            </div>
            
            <!-- Date Range Form -->
            <div id="form-dateRange" class="report-form active">
                <form action="ReportCriteriaServlet" method="post">
                    <input type="hidden" name="action" value="dateRange">
                    <div class="form-group">
                        <label>Start Date</label>
                        <input type="date" name="startDate" required>
                    </div>
                    <div class="form-group">
                        <label>End Date</label>
                        <input type="date" name="endDate" required>
                    </div>
                    <button type="submit" class="btn-generate">Generate Report →</button>
                </form>
            </div>
            
            <!-- Ailment Form -->
            <div id="form-ailment" class="report-form">
                <form action="ReportCriteriaServlet" method="post">
                    <input type="hidden" name="action" value="ailment">
                    <div class="form-group">
                        <label>Ailment / Disease Name</label>
                        <input type="text" name="ailment" required 
                               placeholder="e.g., Diabetes, Hypertension, Fracture">
                    </div>
                    <button type="submit" class="btn-generate">Generate Report →</button>
                </form>
            </div>
            
            <!-- Doctor Form -->
            <div id="form-doctor" class="report-form">
                <form action="ReportCriteriaServlet" method="post">
                    <input type="hidden" name="action" value="doctor">
                    <div class="form-group">
                        <label>Doctor Name</label>
                        <input type="text" name="doctor" required 
                               placeholder="e.g., Dr. Smith, Dr. Johnson">
                    </div>
                    <button type="submit" class="btn-generate">Generate Report →</button>
                </form>
            </div>
            
            <button class="btn-back" onclick="location.href='index.jsp'">← Back to Dashboard</button>
        </div>
    </div>
</body>
</html>
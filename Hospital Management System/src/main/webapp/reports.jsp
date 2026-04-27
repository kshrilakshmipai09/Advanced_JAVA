<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reports - Hospital Management</title>
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
            max-width: 1200px;
            margin: 0 auto;
            animation: fadeIn 0.5s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .header {
            text-align: center;
            color: white;
            padding: 40px 0;
        }
        
        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        
        .reports-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            padding: 20px 0;
        }
        
        .report-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            transition: transform 0.3s;
        }
        
        .report-card:hover {
            transform: translateY(-5px);
        }
        
        .report-icon {
            font-size: 3em;
            margin-bottom: 15px;
        }
        
        .report-title {
            font-size: 1.5em;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 3px solid;
        }
        
        .date-title { border-bottom-color: #28a745; }
        .ailment-title { border-bottom-color: #17a2b8; }
        .doctor-title { border-bottom-color: #6f42c1; }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
        }
        
        input, select {
            width: 100%;
            padding: 10px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn-generate {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
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
            margin-top: 30px;
            width: 200px;
            transition: background 0.3s;
        }
        
        .btn-back:hover {
            background: #5a6268;
        }
        
        .button-container {
            text-align: center;
        }
        
        @media (max-width: 768px) {
            .reports-grid {
                grid-template-columns: 1fr;
            }
        }
        
        .info-note {
            background: #e7f3ff;
            border-left: 4px solid #2196F3;
            padding: 15px;
            margin-top: 30px;
            border-radius: 8px;
            color: #084298;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Generate Reports</h1>
            <p>Create customized reports based on your criteria</p>
        </div>
        
        <div class="reports-grid">
            <!-- Date Range Report -->
            <div class="report-card">
                <div class="report-icon">📅</div>
                <div class="report-title date-title">Date Range Report</div>
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
            
            <!-- Ailment Report -->
            <div class="report-card">
                <div class="report-icon">🏥</div>
                <div class="report-title ailment-title">Ailment Report</div>
                <form action="ReportCriteriaServlet" method="post">
                    <input type="hidden" name="action" value="ailment">
                    <div class="form-group">
                        <label>Ailment / Disease</label>
                        <input type="text" name="ailment" required 
                               placeholder="e.g., Diabetes, Cardiac Issues, Fever">
                    </div>
                    <button type="submit" class="btn-generate">Generate Report →</button>
                </form>
            </div>
            
            <!-- Doctor Report -->
            <div class="report-card">
                <div class="report-icon">👨‍⚕️</div>
                <div class="report-title doctor-title">Doctor Report</div>
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
        </div>
        
        <div class="info-note">
            💡 <strong>Tip:</strong> You can search using partial matches. For example, entering "Dr." will show patients assigned to all doctors.
        </div>
        
        <div class="button-container">
            <button class="btn-back" onclick="location.href='index.jsp'">← Back to Dashboard</button>
        </div>
    </div>
</body>
</html>
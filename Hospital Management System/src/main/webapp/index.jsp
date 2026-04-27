<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System</title>
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
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            text-align: center;
            padding: 40px 0;
            color: white;
            animation: fadeInDown 0.8s ease-out;
        }
        
        .header h1 {
            font-size: 3em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }
        
        .header p {
            font-size: 1.2em;
            opacity: 0.9;
        }
        
        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            padding: 20px 0;
        }
        
        .card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            animation: fadeInUp 0.6s ease-out;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }
        
        .card-icon {
            font-size: 3.5em;
            margin-bottom: 15px;
        }
        
        .card h3 {
            color: #333;
            margin-bottom: 10px;
            font-size: 1.5em;
        }
        
        .card p {
            color: #666;
            line-height: 1.6;
            font-size: 0.95em;
        }
        
        .card-add { border-top: 5px solid #28a745; }
        .card-update { border-top: 5px solid #ffc107; }
        .card-delete { border-top: 5px solid #dc3545; }
        .card-display { border-top: 5px solid #17a2b8; }
        .card-reports { border-top: 5px solid #6f42c1; }
        
        .footer {
            text-align: center;
            padding: 30px;
            color: white;
            margin-top: 40px;
        }
        
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .stats {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        
        .stat-box {
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            padding: 15px 25px;
            border-radius: 10px;
            color: white;
            text-align: center;
        }
        
        @media (max-width: 768px) {
            .header h1 { font-size: 2em; }
            .dashboard { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏥 Hospital Management System</h1>
            <p>Efficiently manage patient records, appointments, and reports</p>
            <div class="stats">
                <div class="stat-box">
                    <h3>📋 Patient Management</h3>
                    <small>Add, Update, Delete, View</small>
                </div>
                <div class="stat-box">
                    <h3>📊 Reports</h3>
                    <small>Date Range, Ailment, Doctor</small>
                </div>
            </div>
        </div>
        
        <div class="dashboard">
            <div class="card card-add" onclick="location.href='patientadd.jsp'">
                <div class="card-icon">➕</div>
                <h3>Add Patient</h3>
                <p>Register new patients into the system with complete medical details</p>
            </div>
            
            <div class="card card-update" onclick="location.href='patientupdate.jsp'">
                <div class="card-icon">✏️</div>
                <h3>Update Patient</h3>
                <p>Modify existing patient information and medical records</p>
            </div>
            
            <div class="card card-delete" onclick="location.href='patientdelete.jsp'">
                <div class="card-icon">🗑️</div>
                <h3>Delete Patient</h3>
                <p>Remove patient records from the database</p>
            </div>
            
            <div class="card card-display" onclick="location.href='DisplayPatientsServlet'">
                <div class="card-icon">📋</div>
                <h3>Display Patients</h3>
                <p>View all registered patients with complete details</p>
            </div>
            
            <div class="card card-reports" onclick="location.href='reports.jsp'">
                <div class="card-icon">📊</div>
                <h3>Generate Reports</h3>
                <p>Create custom reports based on date, ailment, or doctor</p>
            </div>
        </div>
        
        <div class="footer">
            <p>© 2024 Hospital Management System | Secure & Reliable</p>
        </div>
    </div>
</body>
</html>
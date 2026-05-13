<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hospital Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            background-image: url('images/hospital-bg.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: Arial, sans-serif;
            overflow: hidden;
        }

        .content-box {
            background: rgba(255, 255, 255, 0.50);   
            backdrop-filter: blur(10px);
            padding: 60px 90px;
            border-radius: 25px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.25);
            text-align: center;
            max-width: 850px;
            border: 1px solid rgba(255,255,255,0.4);
        }

        h1 {
            font-size: 46px;
            color: #0f172a;                    /* Dark color */
            margin-bottom: 55px;
            text-shadow: 0 4px 15px rgba(0, 0, 0, 0.4),
                         0 0 20px rgba(15, 23, 42, 0.6);   /* Strong highlight */
            font-weight: bold;
            letter-spacing: 1px;
        }

        .btn {
            display: inline-block;
            margin: 12px;
            padding: 16px 40px;
            font-size: 18px;
            font-weight: bold;
            text-decoration: none;
            color: white;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.25);
            transition: all 0.3s;
        }

        .btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.3);
        }

        .btn-add    { background: linear-gradient(135deg, #14b8a6, #0f766e); }
        .btn-view   { background: linear-gradient(135deg, #0ea5e9, #1e40af); }
        .btn-report { background: linear-gradient(135deg, #8b5cf6, #6d28d9); }
    </style>
</head>
<body>

    <div class="content-box">
        <h1>🏥 Hospital Management System</h1>
        
        <a href="patientadd.jsp" class="btn btn-add">➕ Add New Patient</a>
        <a href="patientdisplay.jsp" class="btn btn-view">👥 View All Patients</a>
        <a href="reports.jsp" class="btn btn-report">📊 Generate Reports</a>
    </div>

</body>
</html>
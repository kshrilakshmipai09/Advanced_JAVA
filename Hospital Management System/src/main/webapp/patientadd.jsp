<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Patient - Hospital Management</title>
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
            max-width: 600px;
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
            background: linear-gradient(135deg, #28a745, #20c997);
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
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
        }
        
        input, select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
        }
        
        input:focus, select:focus {
            outline: none;
            border-color: #28a745;
            box-shadow: 0 0 0 3px rgba(40,167,69,0.1);
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #28a745, #20c997);
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
        
        .btn-submit:hover {
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
        
        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            animation: slideDown 0.3s ease-out;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .required:after {
            content: " *";
            color: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>➕ Add New Patient</h2>
            <p>Enter patient details to register in the system</p>
        </div>
        
        <div class="form-container">
            <% if(request.getAttribute("message") != null) { %>
                <div class="message <%= request.getAttribute("messageType") %>">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
            
            <form action="AddPatientServlet" method="post">
                <div class="form-group">
                    <label class="required">Patient ID</label>
                    <input type="number" name="patientId" required placeholder="Enter unique patient ID">
                </div>
                
                <div class="form-group">
                    <label class="required">Patient Name</label>
                    <input type="text" name="patientName" required placeholder="Enter full name">
                </div>
                
                <div class="form-group">
                    <label class="required">Age</label>
                    <input type="number" name="age" required min="0" max="150" placeholder="Enter age">
                </div>
                
                <div class="form-group">
                    <label class="required">Gender</label>
                    <select name="gender" required>
                        <option value="">Select Gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="required">Admission Date</label>
                    <input type="date" name="admissionDate" required>
                </div>
                
                <div class="form-group">
                    <label class="required">Ailment</label>
                    <input type="text" name="ailment" required placeholder="Enter medical condition">
                </div>
                
                <div class="form-group">
                    <label class="required">Assigned Doctor</label>
                    <input type="text" name="assignedDoctor" required placeholder="Enter doctor's name">
                </div>
                
                <button type="submit" class="btn-submit">Register Patient</button>
                <button type="button" class="btn-back" onclick="location.href='index.jsp'">Back to Dashboard</button>
            </form>
        </div>
    </div>
</body>
</html>
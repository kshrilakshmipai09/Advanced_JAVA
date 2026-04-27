<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Patient - Hospital Management</title>
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
            max-width: 500px;
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
            background: linear-gradient(135deg, #dc3545, #c82333);
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
        
        .warning-box {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .warning-icon {
            font-size: 2em;
        }
        
        .warning-text {
            color: #856404;
            font-size: 0.95em;
        }
        
        .form-group {
            margin-bottom: 25px;
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
            border-color: #dc3545;
            box-shadow: 0 0 0 3px rgba(220,53,69,0.1);
        }
        
        .btn-delete {
            background: linear-gradient(135deg, #dc3545, #c82333);
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
        
        .btn-delete:hover {
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
        
        .patient-preview {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
        
        .patient-preview.show {
            display: block;
            animation: fadeIn 0.3s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        .preview-title {
            font-weight: 600;
            color: #495057;
            margin-bottom: 10px;
            padding-bottom: 5px;
            border-bottom: 2px solid #dee2e6;
        }
        
        .preview-detail {
            padding: 5px 0;
            color: #6c757d;
        }
        
        .preview-detail strong {
            color: #495057;
            width: 120px;
            display: inline-block;
        }
    </style>
    <script>
        function previewPatient() {
            var patientId = document.getElementById("patientId").value;
            if (patientId) {
                // You can add AJAX here to fetch patient details
                // For now, just show the preview box
                document.getElementById("patientPreview").classList.add("show");
            } else {
                document.getElementById("patientPreview").classList.remove("show");
            }
        }
        
        function confirmDelete() {
            return confirm("⚠️ WARNING: Are you sure you want to delete this patient record?\n\nThis action cannot be undone!");
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>🗑️ Delete Patient Record</h2>
            <p>Permanently remove patient from database</p>
        </div>
        
        <div class="form-container">
            <% if(request.getAttribute("message") != null) { %>
                <div class="message <%= request.getAttribute("messageType") %>">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
            
            <div class="warning-box">
                <div class="warning-icon">⚠️</div>
                <div class="warning-text">
                    <strong>Warning:</strong> This action is irreversible. Deleted patient records cannot be recovered.
                </div>
            </div>
            
            <form action="DeletePatientServlet" method="post" onsubmit="return confirmDelete()">
                <div class="form-group">
                    <label>Enter Patient ID to Delete *</label>
                    <input type="number" name="patientId" id="patientId" required 
                           placeholder="Enter patient ID" onkeyup="previewPatient()">
                </div>
                
                <div id="patientPreview" class="patient-preview">
                    <div class="preview-title">📋 Patient Information</div>
                    <div class="preview-detail"><strong>Name:</strong> <span id="previewName">-</span></div>
                    <div class="preview-detail"><strong>Age:</strong> <span id="previewAge">-</span></div>
                    <div class="preview-detail"><strong>Doctor:</strong> <span id="previewDoctor">-</span></div>
                </div>
                
                <button type="submit" class="btn-delete">🗑️ Delete Patient Permanently</button>
                <button type="button" class="btn-back" onclick="location.href='index.jsp'">← Back to Dashboard</button>
            </form>
        </div>
    </div>
    
    <script>
        // You can implement AJAX to fetch patient details here
        // This is a placeholder for the preview functionality
        document.getElementById("patientId").addEventListener("change", function() {
            var id = this.value;
            if (id) {
                // Simulate preview (in real implementation, fetch from server)
                document.getElementById("previewName").innerText = "Loading...";
                document.getElementById("previewAge").innerText = "Loading...";
                document.getElementById("previewDoctor").innerText = "Loading...";
            }
        });
    </script>
</body>
</html>
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
    <title>Delete Patient</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f9f9f9;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        h2 {
            color: #d9534f;
        }
        input[type="number"] {
            width: 100%;
            padding: 12px;
            margin: 15px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        input[type="submit"] {
            padding: 12px 30px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #c82333;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>🗑 Delete Patient Record</h2>
        
        <form action="DeletePatientServlet" method="post" onsubmit="return confirmDelete()">
            <label><strong>Enter Patient ID to Delete:</strong></label><br>
            <input type="number" name="patientID" placeholder="Enter Patient ID" required autofocus>
            <br><br>
            <input type="submit" value="Delete Patient">
        </form>

        <a href="patientdisplay.jsp" class="back-link">← Back to Patient List</a>
    </div>

    <script>
        function confirmDelete() {
            return confirm("⚠️ Are you sure you want to delete this patient record?\n\nThis action cannot be undone!");
        }
    </script>
</body>
</html>